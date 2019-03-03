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
use app\common\model\Comment as CommentModel;
use app\admin\model\User;
use think\Session;

class Comment extends IndexBase
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
	
	public function index(){
		
		return $this->fetch('user/mycomment');
	}
	
	
	
	public function del($id=''){
		$res=CommentModel::where(['id'=>$id])->delete();
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
	
	
}
