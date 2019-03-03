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


class Addons extends AdminBase
{
	private $fileArr=array();
	private $path;
	
	public function _initialize(){
		parent::_initialize();
		$this->path=str_replace("\\","/",LS_ROOT.'addons');
	}
	
    public function index(){
		
		$page = input("get.page");
		$listRows = $this->gl_config['admin_page_num'];
		$datas=scandir( $this->path );
		unset($datas[0]);unset($datas[1]);
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
        $bootstrap = Bootstrap::make($datas, $listRows, $currentPage,  $total, false, ['path' => url('Addons/index')]);
		
		if($datas){
			foreach($datas as $k=>$v){
				$name=basename($v);
				$obj=$this->getInstance($name);
				$map=$obj->info;
				unset($map['status']);
				$id=db('addons')->where($obj->info)->value('id');
				if($obj->checkInfo()){
					$d[$k]['title']=$obj->info['title'];
					$d[$k]['description']=$obj->info['description'];
					$d[$k]['status']=$obj->info['status'];
					$d[$k]['version']=$obj->info['version'];
					$d[$k]['author']=$obj->info['author'];
					$d[$k]['is_install']=$id?true:false;
					$d[$k]['ins_url']=url('admin/addons/install',['name'=>$name]);
					$d[$k]['uni_url']=url('admin/addons/uninstall',['name'=>$name]);
				} else {
					unset($datas[$k]);
					
				}
			}
			
		} else {
			$d=[];
		}
		
		if(!isset($d)){
			$d=[];
		}
		
		//dump($obj->info);
		//dump(hook('temphook'));
		$this->assign([
            'datas' => $bootstrap,
            'count' => $total,
            'bootstrap' => $bootstrap->render(),
        ]);
		$this->assign("datas",$d);
        return $this->fetch();
    }
	
	public function install($name=''){
		$obj=$this->getInstance($name);
		$res=$obj->install();
		if($res){
			$this->success('安装成功');
		} else {
			$this->error('安装失败');
		}
	}
	
	public function uninstall($name=''){
		$obj=$this->getInstance($name);
		$res=$obj->uninstall();
		if($res){
			$this->success('卸载成功');
		} else {
			$this->error('卸载失败');
		}
	}
	
	 protected function getInstance($file)
    {
        $class = "\\addons\\{$file}\\" . ucfirst($file);
        if (class_exists($class)) {
            return new $class;
        }
        return false;
    }
	
	
}
