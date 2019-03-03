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
use app\admin\model\Code as CodeModel;
use think\Request;
use think\Config;
use think\Db;

class Code extends AdminBase
{
	
	
    public function index($id = ''){
		
		$code=new CodeModel;
		$index_theme=Config::get('index_theme');
		$current_dir=$id!=''?$id:"tpl";
		$list=$code->html_list($index_theme,$current_dir);
		
		if($current_dir=='tpl'){
			foreach($list as $k=>$v){
				foreach($v as $sk=>$sv){
					$list[$k][$sk]['url']=url('admin/code/mod',array('file'=>$sv['file'],'dir'=>$k,'current_dir'=>$current_dir));
				}
			}
		} else {
			foreach($list as $k=>$v){
				$list[$k]['url']=url('admin/code/mod',array('file'=>$v['file'],'dir'=>'index','current_dir'=>$current_dir));
			}
		}
		
		
		$dir=$code->html_dir();
		$res_dir_list=$code->res_dir();
		foreach($res_dir_list as $k=>$v){
			$arr[$k]['url']=url("admin/code/index",'id='.$k);
			$arr[$k]['name']=$v;
		}
		$current_name=$res_dir_list[$current_dir];
		//echo "<pre>";print_r($list);
		$this->assign("dir",$dir);
		$this->assign("res_dir_list",$arr);
		$this->assign("current_dir",$current_dir);
		$this->assign("current_name",$current_name);
		$this->assign("datas",$list);
        return $this->fetch();
    }
	
	
	public function mod(Request $request){
		$code=new CodeModel;
		$index_theme=Config::get('index_theme');
		$path=$code->getPath();
		if($this->request->isPost()){
			$data=$request->param();
			
			if($data['current_dir']=="tpl"){
				$filename=$path['html_path'].$index_theme."/".$data['dir']."/".$data['name'];
			} else {
				$filename=$path['style_path'].$index_theme."/".$data['current_dir']."/".$data['name'];
			}
			
			if(!$handle = @fopen($filename, 'wb')){
				$this->error("打开目标模版文件失败，请检查模版目录的权限",1);
			}
			if(fwrite($handle, $data['tpl_content']) === false){
				$this->error('写入目标 $file 失败,请检查读写权限',1);
			}
			fclose($handle);
			$this->success("编辑成功!");
			
		} else {
			$data=$request->param();
			
			
			if($data['current_dir']=="tpl"){
				$filename=$path['html_path'].$index_theme."/".$data['dir']."/".$data['file'];
			} else {
				$filename=$path['style_path'].$index_theme."/".$data['current_dir']."/".$data['file'];
			}
			
			
			if (substr($filename,-4)!=".tpl" && substr($filename,-4)!=".css" && substr($filename,-3)!=".js") {
				$this->error("打开文件出错,只能打开tpl,css,js文件!");
			}
			if(substr($filename,-4)==".tpl"){
				$mixedMode='htmlmixed';
			} else if(substr($filename,-4)==".css"){
				$mixedMode='css';
			} else {
				$mixedMode='javascript';
			}
			
			if(!$handle = @fopen($filename, 'rb')){
				$this->error("打开文件出错!");
			}
			$tpl['content'] = fread($handle, filesize($filename));
			$tpl['content'] = htmlentities($tpl['content'], ENT_QUOTES, "UTF-8");
			$tpl['name']=$data['file'];
			$tpl['dir']=$data['dir'];
			$tpl['current_dir']=$data['current_dir'];
			fclose($handle);
			$this->assign('mixedMode',$mixedMode);
			$this->assign('tpl',$tpl);
			$this->assign('backUrl',url('admin/code/index','id='.$tpl['current_dir']));
			return $this->fetch();
		}
		
	}
}
