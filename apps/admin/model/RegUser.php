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

namespace app\admin\model;

use think\Model;
use think\Session;


class User extends Model {
	
	protected $type       = [
        'reg_time' => 'timestamp:Y-m-d',
		
    ];
	
	/**
     * 用户登录
     * @param string $adm_name 用户名
     * @param string $password 密码
     * @param bool $rememberme 记住登录
     * @return bool|mixed
     */
	public function login($user_name = '',$password = ''){
		$user_name = trim($user_name);
        $password = trim($password);
		$map['user_name']=$user_name;
		$map['password']=$password;
		
        $user = self::get($map);
		
		if(!empty($user)) {
			
            Session::set('uid',$user['id'],'index');
			Session::set('user_name',$user['user_name'],'index');
			Session::set('photo',$user['photo'],'index');
			
			
			$dataSign['id']=$user['id'];
			$dataSign['user_name']=$user['user_name'];
			Session::set('index_user_sign', $this->dataSign($dataSign),'index');
			
			$model=new Userlog;
			$data['uid']=$user['id'];
			$data['log_time']=time();
			$data['log_ip']=request()->ip();
			$model->save($data);
			return $user['id'];
        }
        return false;
	}
	
	
	 /**
     * 判断是否登录
     * @author 李文 <15919572@qq.com>
     * @return bool|array
     */
    public function isLogin() 
    {
        $user = self::where('id', Session::get('uid','index'))->find();
		
		$dataSign['id']=$user['id'];
		$dataSign['user_name']=$user['user_name'];
        if(isset($user)){
            return Session::get('index_user_sign','index') == $this->dataSign($dataSign) ? $user->getData() : false;
        }
        return false;
    }
	
	/**
     * 数据签名认证
     * @param array $data 被认证的数据
     * @return string 签名
     */
    public function dataSign($data = [])
    {
        if (!is_array($data)) {
            $data = (array) $data;
        }
        ksort($data);
        $code = http_build_query($data);
        $sign = sha1($code);
        return $sign;
    }
	
	 // 定义关联方法
    public function getGroupName()
    {
        // 用户HAS ONE档案关联
		if($this->hasOne('Group','id','group_id')){
			return $this->hasOne('Group','id','group_id');
		} else {
			return false;
		}
       
    }
	
}