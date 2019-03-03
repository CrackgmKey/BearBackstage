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
use app\admin\model\User as UserModel;
use app\admin\model\Group;

class User extends AdminBase
{
	protected $beforeActionList = [
       
        'checkUploadDir'  =>  ['only'=>'add,mod'],    //add,mod方法执行前先执行checkUploadDir方法
    ];
	public function _initialize(){
		parent::_initialize();
		
		$Model=new Group;
		$groupDatas=$Model->getGroup(0);
		$group_arr=[];
		foreach($groupDatas['data'] as $k=>$v){
			$group_arr[$k]=$v->getData();
			$group_arr[$k]['go_url']=url('admin/user/index','id='.$v['id']);
			$sub=$Model->getGroup($group_arr[$k]['id']);
			if($sub['data']){
				foreach($sub['data'] as $sk=>$sv){
					$group_arr[$k]['sub'][$sk]=$sv->getData();
					$group_arr[$k]['sub'][$sk]['go_url']=url('admin/user/index','id='.$sv['id']);
				}
				$group_arr[$k]['has_sub']=1;
			} else {
				$group_arr[$k]['has_sub']=0;
				$group_arr[$k]['sub']=[];
			}
		}
		$this->assign("groupDatas",$group_arr);
	}
	
    public function index($id = ''){

		if($id){
			$where='group_id='.$id;
			$m=Group::get($id);
			$currentData=$m->getData();
			$this->assign("currentName",$currentData['name']);
			
		} else {
			$where='';
			$this->assign("currentName","请选择");
		}
		
		if($this->request->param('key')){
			
			$where['user_name|email|phone']=array('like','%'.$this->request->param('key').'%');
		} else {
			if($this->request->param('dateRange')){
				$range=explode(' - ',$this->request->param('dateRange'));
				$where['reg_time']=['between time',$range];
			}
		}
		$datas=UserModel::order('reg_time desc')->where($where)->paginate($this->gl_config['admin_page_num']);
		
		foreach($datas as $key=>$v){
			if($v->log_time){
				$v->log_time=date('Y-m-d',$v->log_time);
			}
			$datas[$key]['mod_url']=url('admin/user/mod','id='.$v['id']);
			$datas[$key]['del_url']=url('admin/user/del','id='.$v['id']);
			$datas[$key]['man_url']=url('admin/user/manager','id='.$v['id']);
			
			if($v->getGroupName){
				$datas[$key]['groupname']=$v->getGroupName->name;
			} else {
				$datas[$key]['groupname']='<span style="color:red">已无此分组</span>';
			}
			
			
		}
		$this->assign("dateRange",$this->request->param('dateRange'));
		$this->assign("datas",$datas);
		
        return $this->fetch();
    }
	
	
	public function manager($id = ''){
		$userInfo=UserModel::get($id);
		$model=new UserModel;
		if($uid=$model->login($userInfo['user_name'],$userInfo['password'])){
			$this->redirect('index/user/index');
		}
	}
	
	
	public function changeAudit(Request $request){
		$id=$request->get('id');
		
		$Model=UserModel::get($id);
		$d=$Model->getData();
		$data['audit']=$d['audit']==1?0:1;
		$res=$Model->save($data);
		
		if($res!==false){
			
			exit("{$data['audit']}");
		} else {
			exit("err");
		}
	}
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			
			 // 数据验证
			$result = $this->validate($data,'ModUser');
			if (true !== $result) {
				$this->error($result);
			}
			$up_dir=date("Ymd",time())."/";
			$photo = $this->request->file('photo');
			if (!empty($photo)) {
				$info = $photo->rule("get_rand")->validate(['size'=>$this->gl_config['upload_size'],'ext'=>'jpg,png,gif'])->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
				if($info){
					$data['photo']=$up_dir.$info->getFilename();
				} else {
					$this->error($photo->getError());
				}
			}
			$Model=new UserModel;
			if($data['password']){
				$data['password']=md5($data['password']);
			} else {
				unset($data['password']);
			}
			
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑成功",url('admin/user/index'));
			} else {
				$this->getError();
			}
		} else {
			
			$dataModel=UserModel::get($id);
			$data=$dataModel->getData();
			if($dataModel->getGroupName){
				$data['group_cn']=$dataModel->getGroupName->name;
			} else {
				$data['group_cn']='已无此分类';
			}
			
			$this->assign("data",$data);
			return $this->fetch();
		}
	}
	public function add(Request $request){
		
		if($this->request->isPost()){
		
			$data=$request->post();
			 // 数据验证
			$result = $this->validate($data,'User');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new UserModel;
			$data['password']=md5($data['password']);
			$data['reg_time']=time();
			$data['ran_code']=get_rand();
			$data['audit']=0;
			$up_dir=date("Ymd",time())."/";
			$photo = $request->file('photo');
			if (!empty($photo)) {
				$info = $photo->rule("get_rand")->validate(['size'=>$this->gl_config['upload_size'],'ext'=>'jpg,png,gif'])->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
				if($info){
					$data['photo']=$up_dir.$info->getFilename();
				} else {
					$this->error($photo->getError());
				}
			}
			
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加成功",url('admin/user/index'));
			} else {
				$this->error("添加失败");
			}
		} else {
			
			return $this->fetch();
		}
		
	}
	
	public function batchset($id = '',$audit){
		if(empty($id) || $id==''){
			$this->error("未选择操作项");
		}
		$Model=new UserModel;
		if(is_array($id)){
			$ids=implode(",",$id);
			$map['id']=array('in',$ids);
			$res=UserModel::where($map)->update(['audit'=>$audit]);
		} else {
			$res=UserModel::where('id='.$id)->update(['audit'=>$audit]);
		}
		if($res!==false){
			$this->success("设置成功");
		} else {
			$this->error("设置失败");
		}
	}
	
	public function del($id = ''){
		$Model=new UserModel();
		parent::dels($id,$Model);
	}
	
	
	
}
