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
use app\common\model\Spec as SpecModel;
use app\common\model\Nav;

class Spec extends AdminBase
{
	
	public function _initialize(){
		parent::_initialize();
		
		$navModel=new Nav;
		$navDatas=$navModel->getNav(0,1);
		$nav_arr=[];
		
		foreach($navDatas['data'] as $k=>$v){
			$nav_arr[$k]=$v->getData();
			$nav_arr[$k]['go_url']=url('admin/spec/index','id='.$v['id']);
			$sub=$navModel->getNav($nav_arr[$k]['id'],1);
			if($sub['data']){
				foreach($sub['data'] as $sk=>$sv){
					$nav_arr[$k]['sub'][$sk]=$sv->getData();
					$nav_arr[$k]['sub'][$sk]['go_url']=url('admin/spec/index','id='.$sv['id']);
				}
				$nav_arr[$k]['has_sub']=1;
			} else {
				$nav_arr[$k]['has_sub']=0;
				$nav_arr[$k]['sub']=[];
			}
		}
		$this->assign("navDatas",$nav_arr);
	}
	
    public function index($id = 0){
		
		$model=new SpecModel;
		$datas=$model->getSpec(0,$id,0,$this->gl_config['admin_page_num']);
		$arr=array();
		
		if($id){
			$m=Nav::get($id);
			$currentData=$m->getData();
			$this->assign("currentName",$currentData['name']);
		} else {
			$this->assign("currentName","请选择");
		}
		
		foreach($datas['data'] as $k=>$v){
			$d=$v->getData();
			$d['mod_url']=url('admin/spec/mod','id='.$d['id']);
			$d['del_url']=url('admin/spec/del','id='.$d['id']);
			
			$sub=$model->getSpec($d['id'],0);
			if($sub['data']){
				foreach($sub['data'] as $sk=>$sv){
					$d['sub'][$sk]=$sv->getData();
					$d['sub'][$sk]['mod_url']=url('admin/spec/mod','id='.$sv['id']);
					$d['sub'][$sk]['del_url']=url('admin/spec/del','id='.$sv['id']);
				}
				$d['is_sub']=1;
			} else {
				$d['is_sub']=0;
				$d['sub']=[];
			}
			
			if($v->getNavName){
				$d['classname']=$v->getNavName->name;
			} else {
				$d['classname']='';
			}
			$arr[]=$d;
			
		} 
		
		$this->assign("page",$datas['page']);
		$this->assign("datas",$arr);
        return $this->fetch();
    }
	
	public function batchSort(){
		
		$Model=new SpecModel();
		parent::batchSorts($Model);
 		
	}
	
	
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			
			 // 数据验证
			$result = $this->validate($data,'Spec');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new SpecModel;
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑成功",url('admin/spec/index'));
			} else {
				$this->getError();
			}
		} else {
			
			$Model=new SpecModel;
			$dataModel=SpecModel::get($id);
			$data=$dataModel->getData();
			
			if($data['pid']){
				$pdataModel=SpecModel::get($data['pid']);
				$data['specname']=$pdataModel->name;
			} else {
				$data['specname']='顶级栏目';
			}
			
			if($dataModel->getNavName){
				$data['cate_cn']=$dataModel->getNavName->name;
			} else {
				$data['cate_cn']='';
			}
			$main=$Model->getSpec(0,0);
			$main=collection($main['data'])->toArray();
			$this->assign("main",$main);
			$this->assign("data",$data);
			return $this->fetch();
		}
	}
	public function add(Request $request){
		
		if($this->request->isPost()){
		
			$data=$request->post();
			 // 数据验证
			$result = $this->validate($data,'Spec');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new SpecModel;
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加成功",url('admin/spec/index'));
			} else {
				$this->error("添加失败");
			}
		} else {
			$Model=new SpecModel;
			$main=$Model->getSpec(0,0);
			$main=collection($main['data'])->toArray();
			
			$maxsort=SpecModel::order('sort desc')->value('sort');
			$this->assign("main",$main);
			$this->assign("maxsort",$maxsort+1);
			return $this->fetch();
		}
		
	}
	
	public function del($id = ''){
		$Model=new SpecModel();
		parent::dels($id,$Model);
	}
	
	
	
}
