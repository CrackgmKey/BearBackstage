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
use app\common\model\Nav as NavModel;
use app\admin\model\Module;

class Nav extends AdminBase
{
	
	
    public function index(){
		
		$navmodel=new NavModel;
		$datas=$navmodel->getNav(0,0,$this->gl_config['admin_page_num']);
		$arr=[];
		foreach($datas['data'] as $key=>$v){
			$d=$v->getData();
			$d['mod_url']=url('admin/nav/mod','id='.$d['id']);
			$d['del_url']=url('admin/nav/del','id='.$d['id']);
			$arr[]=$d;
		}
		foreach($arr as $k=>$v){
			
			$subdata=$navmodel->getNav($v['id']);
			if($subdata['data']){
				foreach($subdata['data'] as $sk=>$sv){
					$d=$sv->getData();
					$d['mod_url']=url('admin/nav/mod','id='.$d['id']);
					$d['del_url']=url('admin/nav/del','id='.$d['id']);
					$arr[$k]['sub'][]=$d;
				}
				$arr[$k]['is_sub']=1;
			} else {
				
				$arr[$k]['is_sub']=0;
			}
			
		}
		
		$this->assign("page",$datas['page']);
		$this->assign("datas",$arr);
        return $this->fetch();
    }
	
	public function changeDisplay(Request $request){
		$id=$request->get('id');
		
		$navModel=NavModel::get($id);
		$d=$navModel->getData();
		$data['display']=$d['display']?0:1;
		$res=$navModel->save($data);
		
		if($res!==false){
			
			exit("{$data['display']}");
		} else {
			exit("err");
		}
	}
	
	public function batchSort(){
		
		$Model=new NavModel();
		parent::batchSorts($Model);
 		
	}
	
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			
			 // 数据验证
			$result = $this->validate($data,'Nav');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new NavModel;
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑导航成功",url('admin/nav/index'));
			} else {
				$this->error($this->getError());
			}
		} else {
			
			$dataModel=NavModel::get($id);
			$data=$dataModel->getData();

			$navmodel=new NavModel;
			$navdatas=$navmodel->getNav(0);
			foreach($navdatas['data'] as $key=>$v){
				$d=$v->getData();
				$arr[]=$d;
			}
			
			$moduledatas=Module::all();
			$moduledata=Module::get($data['module_id']);
			
			if($data['pid']){
				$current=NavModel::get($data['pid'])->getData();
				$data['currentName']=$current['name'];
			} else {
				$data['currentName']='顶级栏目';
			}
			
			
			
			$data['module_name']=$moduledata['name'];
			//echo "<pre>";print_r($data);
			$this->assign("moduledatas",$moduledatas);
			$this->assign("navdatas",$arr);
			$this->assign("data",$data);
			return $this->fetch();
		}
	}
	public function add(Request $request){
		
		if($this->request->isPost()){
		
			$data=$request->post();
			 // 数据验证
			$result = $this->validate($data,'Nav');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new NavModel;
			
			$module=new Module;
			$data['type']=$module->where(['id'=>$data['module_id']])->value('type');
			
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加导航成功",url('admin/nav/index'));
			} else {
				$this->error("添加导航失败");
			}
		} else {
			$navmodel=new NavModel;
			
			$navdatas=$navmodel->getNav(0);
			$moduledatas=Module::all();
			$maxsort=NavModel::order('sort desc')->value('sort');
			if($navdatas['data']){
				foreach($navdatas['data'] as $key=>$v){
					$d=$v->getData();
					$arr[]=$d;
				}
			} else {
				$arr=[];
			}
			
			$this->assign("moduledatas",$moduledatas);
			$this->assign("navdatas",$arr);
			$this->assign("maxsort",$maxsort+1);
			return $this->fetch();
		}
		
	}
	
	public function del($id = ''){
		$Model=new NavModel();
		parent::dels($id,$Model);
	}
	
	
	
}
