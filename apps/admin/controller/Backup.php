<?php
// +----------------------------------------------------------------------
// | Leesuntech [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.leesuntech.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 李文 < 15919572@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\controller;

use app\admin\controller\AdminBase;

use think\Request;
use think\Db;
use think\Config;
use app\admin\model\Backup as BackupModel;
use think\paginator\driver\Bootstrap;

class Backup extends AdminBase
{
	
	private $prefix='';
	private $path;
	
	
	public function _initialize(){
		 parent::_initialize();
		$this->path=str_replace("\\","/",LS_ROOT.'public/backup');
		$this->prefix=Config::get('database.prefix');
	}
	
    public function index(){
		$datas=Db::query('show tables');
		$name="Tables_in_".config('database.database');
		foreach($datas as $k=>$v){
			$arr[$k]['name']=$v[$name];
			$db=Db::query("select concat(round(sum(DATA_LENGTH/1024),2), ' KB') as dbsize,CREATE_TIME as addtime,ENGINE as engine from  information_schema.TABLES where  table_name='".$v[$name]."'");
			$data_free=Db::query("SHOW TABLE STATUS LIKE '".$v[$name]."'");
			
			$arr[$k]['size']=$db[0]['dbsize'];
			$arr[$k]['addtime']=$db[0]['addtime'];
			$arr[$k]['engine']=$db[0]['engine'];
			$arr[$k]['data_free']=\files\Simfile::getAutoSize($data_free[0]['Data_free']);
			$arr[$k]['opt_url']=url('admin/backup/optimize','id='.$v[$name]);
			$arr[$k]['rep_url']=url('admin/backup/repair','id='.$v[$name]);
		}
		//echo "<pre>";print_r($arr);
		$this->assign("name",$name);
		$this->assign("datas",$arr);
        return $this->fetch();
    }
	
	public function lists(){
		$datas=array();
		$page = input("get.page");
		$listRows = $this->gl_config['admin_page_num'];
		$filelist=\files\Simfile::getSubFile($this->path);
		$total=count($filelist);
		if (isset($page) && null !== $page) {
            $currentPage = $page; // 当前页
            $startnum = ($page-1)*$listRows; // limit 起始位置
        } else {
            $currentPage = 1;
            $startnum = 0;
        }
		
		$filelist=array_slice($filelist,$startnum,$listRows);
		
        //此处为分页的处理
        $bootstrap = Bootstrap::make($filelist, $listRows, $currentPage,  $total, false, ['path' => url('Backup/lists')]);
		
		foreach($filelist as $key=>$var){
			$datas[$key]['file']=basename($var);
			$datas[$key]['size']=\files\Simfile::getAutoSize(filesize($var));
			$datas[$key]['time']=date("Y-m-d H:i:s",filemtime($var));
			$datas[$key]['res_url']=url('admin/backup/restore','id='.basename($var));
			$datas[$key]['del_url']=url('admin/backup/del','id='.basename($var));
		}
		
		$this->assign([
            'datas' => $bootstrap,
            'count' => $total,
            'bootstrap' => $bootstrap->render(),
        ]);
		$this->assign("datas",$datas);
		return $this->fetch();
	}
	
	public function optimize($id = ''){
		if(!$id) $this->error("请选择优化项目");
		if(is_array($id)){
			
			$sqlstr=implode(",",$id);
			$res=Db::execute("OPTIMIZE TABLE $sqlstr ");
			
		} else {
			$res=Db::execute("OPTIMIZE TABLE $id ");
		}
		if($res!==false){
			$this->success("优化成功");
		} else {
			$this->error("优化失败");
		}
	}
	
	public function repair($id=''){
		if(!$id) $this->error("请选择修复项目");
		if(is_array($id)){
			$sqlstr=implode(",",$id);
			$res=Db::execute("REPAIR TABLE $sqlstr ");
		} else {
			$res=Db::execute("REPAIR TABLE $id ");
		}
		if($res!==false){
			$this->success("修复成功");
		} else {
			$this->error("修复失败");
		}
	}
	
	public function restore($id = ''){
		$filename=$this->path."/".$id;
		$backup=new BackupModel;
		$handle=@fopen($filename,"rb");
		$head=@fread($handle,70);
		fclose($handle);
		$arr=$backup->getSqlInfo($head);
		
		$status="";
		if(strpos($arr['cms_ver'],"update")){
			$status="update";
		} 
		$sql=$backup->removeComments(file_get_contents($filename));
		$sql = trim($sql);
		$sql = str_replace("\r", '', $sql);
		$segmentSql = explode(";\n", $sql);
		
		foreach($segmentSql as $var){
			if($var!=''){
				if($status=="update"){
					$var = str_replace('update_',$this->prefix, $var);
				}
				
				Db::execute(trim($var, " \r\n;"));
				
			}
			
		}
		
		$data['info']="还原数据成功!";
		$data['res']=true;
		$this->success($data['info']);
		
	}
	
	
	
	
	
	public function doBackup($id = ''){
		$backup=new BackupModel;
		if(!$id) $this->error("请选择备份项目");
		$add_time = date("Y-m-d H:i:s");
		$sql="";
		$sql.="--Version:".Config::get('version')."\r\n".
			  
			  "--Create time:".$add_time."\r\n";
		$tabname=$backup->getTablesName($this->prefix);
		foreach($id as $var){
			$sql.= "DROP TABLE IF EXISTS `".$var."`;\r\n";
			$row_struct=Db::query("show create table {$var}"); 
			$sql.= $row_struct[0]['Create Table'].";\r\n";
			$row_data=$backup->getTablesData($var);
			if(!count($row_data)){
				return false;
			} else {
				foreach((array)$row_data[1] as $var_data){
					$sql_data= "INSERT INTO `{$var}` VALUES (";
					foreach($var_data as $row){
						$sql_data.="'".addslashes($row)."',";
					}
					$sql_data=substr($sql_data,0,-1);  //删除最后一个逗号
					$sql_data.= ");\r\n";
					$sql.=$sql_data;
				}
			}
		}
		$target_sql=LS_ROOT."public/backup/".time().".sql"; 
		$res=\files\Simfile::write($target_sql,$sql);
		if($res!==false){
			$this->success("备份成功");
		} else {
			$this->error("备份失败");
		}
		
	}
	
	public function del($id=''){
		if(!$id) $this->error("请选择删除项目");
		if(is_array($id)){
			
			$n=count($id);
			$num=0;
			foreach($id as $v){
				$res=\files\Simfile::delete($this->path.'/'.$v);
				if($res){
					$num++;
				}
			}
			if($n==$num){
				$res=true;
			} else {
				$res=false;
			}
		} else {
			$res=\files\Simfile::delete($this->path.'/'.$id);
		}
		if($res!==false){
			$this->success("删除成功");
		} else {
			$this->error("删除失败");
		}
	}
	
	
	
	
	
	
}
