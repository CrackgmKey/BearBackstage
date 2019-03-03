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
use app\admin\model\User;
use app\common\model\Profav;
use app\common\model\Fav as NewsFav;
use think\Session;

class Fav extends IndexBase
{
	protected function _initialize(){
		parent::_initialize();
		$user=new User;
		if($user->isLogin()){
			$this->uid=Session::get('uid','index');
		} else {
			$this->redirect('index/user/login');
		}
	}
	
	public function profav(){
		
		return $this->fetch('user/myfavpro');
	}
	
	
	public function newsfav(){
		
		return $this->fetch('user/myfavnews');
	}
	
	public function newdel($id=''){
		$res=NewsFav::where(['id'=>$id])->delete();
		$msg=[];
		if($res!=false){
			$msg['msg']='删除成功';
			$msg['code']=1;
			
		} else {
			$msg['msg']='删除失败';
			$msg['code']=2;
		}
		return json($msg);
	}
	
	public function del($id=''){
		$res=Profav::where(['id'=>$id])->delete();
		$msg=[];
		if($res!=false){
			$msg['msg']='删除成功';
			$msg['code']=1;
			
		} else {
			$msg['msg']='删除失败';
			$msg['code']=2;
		}
		return json($msg);
	}
	
	public function question(){
		$data=$this->request->param();
		$data['q_time']=time();
		$res=ConsultModel::insert($data);
		if($res!=false){
			return json('1');
		} else {
			return json('2');
		}
	}
}
