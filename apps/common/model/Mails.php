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

namespace app\common\model;
use app\admin\model\User;
use think\Model;
use think\Session;
use think\Validate;

class Mails extends Model {
	
	public function sendByRules($uid,$code='',$password=''){
		$data=db('mailrules')->where(['code'=>$code])->field('name,template')->find();
		$sitename=db('config')->where(['id'=>1])->value('site_name');
		$userData=User::where(['id'=>$uid])->find();
		$labels=array('{$sitename}'=>$sitename,'{$domain}'=>request()->domain(),'{$username}'=>$userData->user_name,'{$password}'=>$password,'{$score}'=>$userData->score,'{$address}'=>$userData->address);
		foreach($labels as $k=>$v){
			$msg=str_replace($k,$v,$msg);
		}
		
		$res = $this->send([
			'email'  => $userData->email,
			'subject'  => $data['name'].'提醒',
			'message'  => $msg,
			'fromname'  => '管理员',
		]);
		
	}
	public function send($data=[])
	{
		$validate = new Validate([
			['email','require|email','邮箱输入错误|邮箱输入错误'],
			['subject','require','请输入邮件标题'],
			['message','require','请输入邮件内容'],
		]);
		if (!$validate->check($data)) {
			return $validate->getError();
		}
		$config = self::get(1);
		vendor('phpmailer.phpmailer');
		$phpmailer = new \phpmailer(); //实例化
		$phpmailer->Host		=	$config['mail_host']; //smtp服务器的名称（这里以QQ邮箱为例）
		$phpmailer->SMTPAuth 	= 	TRUE; //启用smtp认证
		$phpmailer->Username 	= 	$config['user_name']; //你的邮箱名
		$phpmailer->Password 	= 	$config['password']; //邮箱密码
		$phpmailer->From 		= 	$config['user_name']; //发件人地址（也就是你的邮箱地址）
		$phpmailer->FromName 	=	$data['fromname']; //发件人姓名
		$phpmailer->CharSet		=	'utf-8'; //设置邮件编码
		$phpmailer->Subject 	=	$data['subject']; //邮件主题
		$phpmailer->Body 		=	$data['message']; //邮件内容
		$phpmailer->AltBody 	=	"text/html"; //邮件正文不支持HTML的备用显示
		$phpmailer->WordWrap 	=	50; //设置每行字符长度
		$phpmailer->IsSMTP(true);	 // 启用SMTP
		$phpmailer->IsHTML(true); 	// 是否HTML格式邮件
		$phpmailer->AddAddress($data['email']);
		$status = $phpmailer->Send();
		return true;
	}
}