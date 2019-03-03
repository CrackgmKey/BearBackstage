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
use think\paginator\driver\Bootstrap;


class Invalid extends AdminBase
{
	private $fileArr=array();
	private $path;
	
	public function _initialize(){
		parent::_initialize();
		$this->path=str_replace("\\","/",LS_ROOT.'public/uploads');
	}
	
    public function index(){
		
		$page = input("get.page");
		$listRows = $this->gl_config['admin_page_num'];
		$datas=\files\Simfile::getSubDir($this->path);
		$total=count($datas);
		
		if (isset($page) && null !== $page) {
            $currentPage = $page; // 当前页
            $startnum = ($page-1)*$listRows; // limit 起始位置
        } else {
            $currentPage = 1;
            $startnum = 0;
        }
		
		$datas=array_slice($datas,$startnum,$listRows);
		
        //此处为分页的处理
        $bootstrap = Bootstrap::make($datas, $listRows, $currentPage,  $total, false, ['path' => url('Invalid/index')]);
		foreach($datas as $k=>$v){
			
			$datas[$k]=array('name'=>basename($v));
			$sub=\files\Simfile::getSubFile(str_replace("\\","/",$v));
			
			if($sub){
				
				foreach($sub as $sk=>$sv){
					$extension = strtolower(pathinfo($sv, PATHINFO_EXTENSION));
					if(in_array($extension, ['gif', 'jpg', 'jpeg', 'bmp', 'png'])){
						$datas[$k]['sub'][$sk]['is_pic']=1;
					} else {
						$datas[$k]['sub'][$sk]['is_pic']=0;
					}
					$datas[$k]['sub'][$sk]['pic']=$this->request->root().'/public/uploads'.str_replace($this->path,'',str_replace("\\","/",$sv));
					$datas[$k]['sub'][$sk]['id']=str_replace("\\","/",$sv);
					$datas[$k]['sub'][$sk]['name']=basename($sv);
					$datas[$k]['sub'][$sk]['size']=\files\Simfile::getAutoSize(filesize($sv));
					$datas[$k]['sub'][$sk]['date']=date('Y-m-d',fileatime($sv));
					$datas[$k]['sub'][$sk]['del_url']=url('admin/invalid/del',array('id'=>$datas[$k]['sub'][$sk]['name'],'folder'=>basename($v)));
					$this->fileArr[basename($v)][$sk]=str_replace("\\","/",$sv);
				}
				$datas[$k]['is_sub']=1;
				$datas[$k]['size']=\files\Simfile::getAutoSize(\files\Simfile::getDirSize($v));
				$datas[$k]['date']=date('Y-m-d',fileatime($v));
			} else {
				$datas[$k]['is_sub']=0;
				$datas[$k]['size']=0;
				$datas[$k]['date']=date('Y-m-d',fileatime($v));
				$datas[$k]['sub']='';
			}
			
		}
		$this->assign([
            'datas' => $bootstrap,
            'count' => $total,
            'bootstrap' => $bootstrap->render(),
        ]);
		$this->assign("datas",$datas);
        return $this->fetch();
    }
	
	public function del($folder = '',$id = ''){
		
		if(empty($id) || $id==''){
			$this->error("未选择操作项");
		}
		if(is_array($id)){
			
			foreach($id as $k=>$v){
				$file=$this->path.'/'.$v;
				
				$result=\files\Simfile::delete($file);
				if(!$result){
					$this->error("删除失败");
				}
				$res=true;
			}
			
		} else {
			$file=$this->path.'/'.$folder.'/'.$id;
			$res=\files\Simfile::delete($file);
		}
		if($res!==false){
			$this->success("删除成功");
		} else {
			$this->error("删除失败");
		}
	}
	
	function clearCache(){
		$folder=str_replace('/','\\',LS_ROOT.'\runtime');
		
		$res=\files\Simfile::delete($folder);
		if($res!==false){
			return 1;
		} else {
			return 0;
		}
		
	}
	
	
}
