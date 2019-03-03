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
use app\admin\model\Admingroup;
use app\admin\model\Adminlog;
use app\admin\model\Admin as AdminModel;
use think\Request;

class Admin extends Model {
	
	protected $type       = [
        'login_time' => 'timestamp:Y-m-d',
    ];
	
	public function getGroup(){
		return $this->hasOne('Admingroup','id','group_id');
	}
	/**
     * 用户登录
     * @param string $adm_name 用户名
     * @param string $password 密码
     * @param bool $rememberme 记住登录
     * @return bool|mixed
     */
	public function login($adm_name = '',$password = ''){
		$adm_name = trim($adm_name);
        $password = trim($password);
		$map['adm_name']=$adm_name;
		$map['adm_password']=$password;
		$group=new AdminGroup;
        $admin = self::get($map);
		
		if(!empty($admin)) {
			$admin['group_info']=$group->getInfo($admin['group_id']);
			
            Session::set('adm_id',$admin['id'],'admin');
			Session::set('adm_name',$admin['adm_name'],'admin');
			Session::set('avatar',$admin['avatar'],'admin');
			Session::set('group_id',$admin['group_id'],'admin');
			Session::set('group_cn',$admin['group_info']['name'],'admin');
			
			$dataSign['id']=$admin['id'];
			$dataSign['adm_name']=$admin['adm_name'];
			Session::set('admin_user_sign', $this->dataSign($dataSign),'admin');
			AdminModel::update(['id'=>$admin['id'],'login_ip'=>request()->ip(),'login_time'=>time()]);
			
			$adminlog=new Adminlog;
			$data['admin_id']=$admin['id'];
			$data['log_time']=time();
			$data['log_ip']=request()->ip();
			$adminlog->save($data);
			return $admin['id'];
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
        $user = self::where('id', Session::get('adm_id','admin'))->find();
		$dataSign['id']=$user['id'];
		$dataSign['adm_name']=$user['adm_name'];
        if(isset($user)){
            return Session::get('admin_user_sign','admin') == $this->dataSign($dataSign) ? $user->getData() : false;
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
	
}