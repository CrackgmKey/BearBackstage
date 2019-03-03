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

use app\common\controller\Base;
use app\admin\model\Admin;
use think\captcha\Captcha;
use think\Request;
use think\Db;
use think\Session;
use think\config;

class Login extends Base
{
    public function index(){
		if(Session::has('adm_id','admin')){
			$this->redirect('admin/index/index');
		}
		
		
        return $this->fetch();
    }
	
	public function getCaptcha($id = "")
    {
        $captcha = new Captcha((array)Config::get('captcha'));
        return $captcha->entry($id);
    }
	
	public function login(Request $request){
		$adm_name=$request->post('adm_name');
		$adm_password=md5($request->post('adm_password'));
		$code=$request->post('code');
		
		$admin=new Admin;
		$captcha = new Captcha();
		if (!$captcha->check($code)) {
            $this->error('验证码错误');
        } 
		
		
		if($admin->login($adm_name,$adm_password)){
			
			$this->success('登陆成功!');
		} else {
			$this->error('用户或密码错误，登陆失败!');
		}
	}
	
	public function logout(){
		Session::clear('admin');
		$this->redirect('admin/index/index');
	}
	
}
