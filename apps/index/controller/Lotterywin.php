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
use app\common\model\Lotterywin as LotterywinModel;
use app\admin\model\User;
use think\Session;

class Lotterywin extends IndexBase
{
	private $classname='';
	
	protected function _initialize(){
		parent::_initialize();
		$user=new User;
		if($user->isLogin()){
			$this->uid=Session::get('uid','index');
		} else {
			$this->redirect('index/user/login');
		}
	}
    public function index()
    {
		
		return $this->fetch('user/mylotterywin');
    }
	
	
}
