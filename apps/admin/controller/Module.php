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
use app\admin\model\Module as ModuleModel;
use app\admin\model\Group;


class Module extends AdminBase
{
	
	
    public function index(){
		
		$Model=new ModuleModel();
		$datas=$Model->order('sort asc')->paginate($this->gl_config['admin_page_num']);
		
		foreach($datas as $key=>$v){
			$d=$v->getData();
			
			$datas[$key]['mod_url']=url('admin/module/mod','id='.$d['id']);
			$datas[$key]['del_url']=url('admin/module/del','id='.$d['id']);
			
		}
		
		$this->assign("datas",$datas);
        return $this->fetch();
    }
	
	public function batchSort(){
		
		$Model=new ModuleModel();
		parent::batchSorts($Model);
		
	}
	
	
	public function mod($id = ''){
		$Model=new ModuleModel();
		if($this->request->isPost()){
			$input=$this->request->post();
			
			 // 数据验证
			$result = $this->validate($input,'Module');
			if (true !== $result) {
				$this->error($result);
			}
			$data['id']=$this->request->post('id');
			$data['name']=$this->request->post('name');
			$data['classname']=$this->request->post('classname');
			$data['is_user_pub']=$this->request->post('is_user_pub');
			$data['sort']=$this->request->post('sort');
			$data['type']=$this->request->post('type');
			
			
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑模块成功");
			} else {
				$this->error($this->getError());
			}
		} else {
			$data=$Model->append(['type'])->where('id='.$id)->find();
			$t=$data->getData();
			$data->type_id=$t['type'];
			$this->assign("data",$data);
			return $this->fetch();
		}
	}
	public function add(Request $request){
		
		if($this->request->isPost()){
		
			$input=$request->post();
			 // 数据验证
			$result = $this->validate($input,'Module');
			if (true !== $result) {
				$this->error($result);
			}
			
			$Model=new ModuleModel;
			
			$data['name']=$request->post('name');
			$data['classname']=$request->post('classname');
			$data['is_user_pub']=$request->post('is_user_pub');
			$data['sort']=$request->post('sort');
			$data['type']=$request->post('type');
			
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加模块成功","admin\module\index");
			} else {
				$this->error("添加模块失败");
			}
		} else {
			
			$main_lists=Group::get(function($query){
				$query->where('pid',0)->order('sort','asc');
			});
			
			$sub_lists=Group::get(function($query){
				$query->where('pid <> 0')->order('sort','asc');
			});
			
			$m = ModuleModel::get(function($query){
				$query->order('id','desc');
			});
			if($m){
				$data=$m->getData();
				$data['sort']+=1;
			} else {
				$data=[];
				$data['sort']=1;
			}
			$this->assign("main_lists",$main_lists);
			$this->assign("sub_lists",$sub_lists);
			$this->assign("max_sort",$data['sort']);
			return $this->fetch();
		}
		
	}
	public function del($id = ''){
		$Model=new ModuleModel();
		parent::dels($id,$Model);
	}
	
}
