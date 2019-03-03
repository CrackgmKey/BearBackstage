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
use app\admin\model\Admingroup as AgModel;
use app\admin\model\Adminclass;
use app\admin\model\Adminnode;

class Admingroup extends AdminBase
{
	
	
    public function index(){
		
		
		$datas=AgModel::paginate($this->gl_config['admin_page_num']);
		if(!empty($datas)){
			foreach($datas as $key=>$v){
				$d=$v->getData();
				$datas[$key]['mod_url']=url('admin/admingroup/mod','id='.$d['id']);
				$datas[$key]['del_url']=url('admin/admingroup/del','id='.$d['id']);
			}
		}
		$this->assign("datas",$datas);
        return $this->fetch();
    }
	

	public function add(Request $request){
		
		
		if($request->isPost()){
			$agModel=new AgModel();
			$data['name']=$request->post('name');
			$data['auth']=serialize($request->post('auth/a'));
			$res=$agModel->save($data);
			if($res!==false){
				$this->success("添加管理员分组成功",url('admin/admingroup/index'));
			} else {
				$this->error("添加管理员分组失败");
			}
		} else {
			$class_datas=Adminclass::all();
			$node_datas=Adminnode::all();
			$this->assign("class_datas",$class_datas);
			$this->assign("node_datas",$node_datas);
			return $this->fetch();
		}
		
		
	}
	
	public function del($id = ''){
		$Model=new AgModel();
		parent::dels($id,$Model);
	}
	
	public function mod($id = ''){
		if($this->request->isPost()){
			$agModel=new AgModel();
			$data['id']=$this->request->post('id');
			$data['name']=$this->request->post('name');
			$data['auth']=serialize($this->request->post('auth/a'));
			$res=$agModel->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑管理员分组成功");
			} else {
				$this->error("编辑管理员分组失败");
			}
		} else {
			$agModel=new AgModel();
			$m=$agModel::get($id);
			$data=$m->getData();
			$data['auth']=unserialize($data['auth']);
			$class_datas=Adminclass::all();
			$node_datas=Adminnode::all();
			$this->assign("class_datas",$class_datas);
			$this->assign("node_datas",$node_datas);
			$this->assign("data",$data);
			$this->assign("auths",$data['auth']);
			return $this->fetch();
		}
		
		
	}
}
