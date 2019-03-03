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
use app\admin\model\Admin as AdminModel;
use app\admin\model\Admingroup;

class Admin extends AdminBase
{
	
	
    public function index(){
		
		$admingroup=new Admingroup();
		$datas=AdminModel::paginate($this->gl_config['admin_page_num']);
		
		foreach($datas as $key=>$v){
			$d=$v->getData();
			$agd=$admingroup::get($d['group_id']);
			$datas[$key]['mod_url']=url('admin/admin/mod','id='.$d['id']);
			$datas[$key]['del_url']=url('admin/admin/del','id='.$d['id']);
			$datas[$key]['group_cn']=$agd['name'];
		}
		
		$this->assign("datas",$datas);
        return $this->fetch();
    }
	public function changeDefault(Request $request){
		$id=$request->get('id');
		Db::name('admin')->where('is_default', 1)->update(['is_default' => "0"]);
		$adminModel=AdminModel::get($id);
		$d=$adminModel->getData();
		$data['is_default']=$d['is_default']?0:1;
		$res=$adminModel->save($data);
		
		if($res!==false){
			
			response("success");
		} else {
			response("err");
		}
	}
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$input=$this->request->post();
			if(!$input['adm_password'] && !$input['password_confirm']){
				
			}
			 // 数据验证
			$result = $this->validate($input,'Admin');
			if (true !== $result) {
				$this->error($result);
			}
			
			$up_dir=date("Ymd",time())."/";
			$avatar = $this->request->file('avatar');
			if (!empty($avatar)) {
				$info = $avatar->rule("get_rand")->validate(['size'=>$this->gl_config['upload_size'],'ext'=>'jpg,png,gif'])->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
				if($info){
					$data['avatar']=$up_dir.$info->getFilename();
				} else {
					$this->error($avatar->getError());
				}
			}
			
			
			$Model=new AdminModel();
			$data['id']=$this->request->post('id');
			$data['adm_name']=$this->request->post('adm_name');
			$data['group_id']=$this->request->post('group_id');
			$data['adm_password']=md5($this->request->post('adm_password'));
			
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑管理员成功");
			} else {
				$this->error($this->getError());
			}
		} else {
			$data=AdminModel::get($id);
			$group_datas=Admingroup::all();
			$agd=Admingroup::get($data['group_id']);
			$data['group_cn']=$agd['name'];
			$this->assign("group_datas",$group_datas);
			$this->assign("data",$data);
			return $this->fetch();
		}
	}
	public function add(Request $request){
		
		if($this->request->isPost()){
		
			$input=$request->post();
			 // 数据验证
			$result = $this->validate($input,'Admin');
			if (true !== $result) {
				$this->error($result);
			}
			
			$Model=new AdminModel;
			
			$up_dir=date("Ymd",time())."/";
			$avatar = $request->file('avatar');
			if (!empty($avatar)) {
				$info = $avatar->rule("get_rand")->validate(['size'=>$this->gl_config['upload_size'],'ext'=>'jpg,png,gif'])->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
				if($info){
					$data['avatar']=$up_dir.$info->getFilename();
				} else {
					$this->error($avatar->getError());
				}
			}
			
			$data['adm_name']=$request->post('adm_name');
			$data['group_id']=$request->post('group_id');
			$data['adm_password']=md5($request->post('adm_password'));
			
			
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加管理员成功","admin\admin\index");
			} else {
				$this->error("添加管理员失败");
			}
		} else {
			$group_datas=Admingroup::all();
			$this->assign("group_datas",$group_datas);
			return $this->fetch();
		}
		
	}
	public function del($id = ''){
		
		$Model=new AdminModel();
		if(is_array($id)){
			foreach($id as $v){
				$is_default=$Model->where(['id'=>$v])->value('is_default');
				if($is_default){
					$this->error("不能删除默认管理员");
				}
			}
		} else {
			$is_default=$Model->where(['id'=>$id])->value('is_default');
			if($is_default){
				$this->error("不能删除默认管理员");
			}
		}
		
		parent::dels($id,$Model);
	}
	
}
