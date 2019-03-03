<?php
// +----------------------------------------------------------------------
// | Leesuntech [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.leesuntech.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 李文 <15919572@qq.com>
// +----------------------------------------------------------------------

namespace app\index\controller;
use app\index\controller\IndexBase;
use app\common\model\Appraise as AppraiseModel;
use app\admin\model\User;
use think\Session;

class Appraise extends IndexBase
{
	protected function _initialize(){
		parent::_initialize();
		$user=new User;
		if(!$user->isLogin()){
			
			if($this->request->isAjax()){
				return json('noLogin');
			} else {
				$this->redirect('index/user/login');
			}
		} 
	}
	
	public function index(){
		
		return $this->fetch('user/myappraise');
	}
	
	public function publish($pid=''){
		$user=new User;
		if(!$user->isLogin()){
			if($this->request->isAjax()){
				return json('noLogin');
			} else {
				$this->redirect('index/user/login');
			}
		}
		$this->assign('pid',$pid);
		return $this->fetch('user/publishAppraise');
	}
	
	public function mod($id=''){
		$data=AppraiseModel::get($id);
		$this->assign('id',$id);
		$this->assign('data',$data);
		return $this->fetch('user/modappraise');
		
	}
	
	public function modAppraise($id=''){
		$model=new AppraiseModel;
		$data=$this->request->param();
		$data['content_time']=time();
		$num=$model->where(['id'=>$data['id']])->value('mod_appraise_num');
		
		if($num>=$this->gl_config['mod_appraise']){
			$msg['code']=2;
			$msg['msg']='您已超出修改评价次数';
			return json($msg);
		}
		$res=$model->isUpdate(true)->save($data);
		$msg=[];
		
		if($res!=false){
			$model->where(['id'=>$data['id']])->setInc('mod_appraise_num');
			$msg['code']=1;
			$msg['msg']='回复成功';
		} else {
			$msg['code']=2;
			$msg['msg']='回复成功';
		}
		return json($msg);
	}
	public function add(){
		$post=$this->request->param();
		$d=db('appraisetimes')->where(['pid'=>$post['pid'],'uid'=>$post['uid']])->find();
		$msg['code']=0;
		$msg['mess']='';
		if($d['times']<=0){
			$data['code']=4;
			$data['mess']='已评价';
			return json($data);
		} elseif(!$d['times']) {
			$data['code']=5;
			$data['mess']='未购买';
			return json($data);
		}
		
		$post['content_time']=time();
		$post['reply_time']="";
		$post['mod_appraise_num']=0;
		$appraise=new AppraiseModel;
		$res=$appraise->save($post);
		if($res!=false){
			db('appraisetimes')->where(['id'=>$d['id']])->setDec('times');
			$data['code']=1;
			$data['mess']='评价成功';
			return json($data);
		} else {
			$data['code']=2;
			$data['mess']='评价失败';
			return json($data);
		}
	}
}
