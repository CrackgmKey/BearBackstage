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
use app\admin\model\Message as MessModel;
use think\Validate;
use think\captcha\Captcha;

class Message extends IndexBase
{
	
    public function index()
    {
		return $this->fetch();
    }
	
	
	
	public function add()
    {
		if($this->request->isPost()){
			$data=$this->request->post();
		
			$rule = [
				'title'  => 'require',
				'content'   => 'require',
				'captcha' => 'require',
			];

			$msg = [
				'title.require' => '请填写标题',
				'content.require'     => '请填写内容',
				'captcha.require'   => '请填写验证码',
			];
			$validate = new Validate($rule, $msg);
			$result   = $validate->batch()->check($data);
			if(!$result){
				return json($validate->getError());
			}
			$captcha = new Captcha();
			if (!$captcha->check($data['captcha'])) {
			   return json('2');
			}
			unset($data['captcha']);
			$model=new MessModel;
			$data['create_time']=time();
			$res=$model->save($data);
			if($res!==false){
				return json('1');
			} else {
				return json('3');
			}
			
		} else {
			return $this->fetch();
		}
    }
}
