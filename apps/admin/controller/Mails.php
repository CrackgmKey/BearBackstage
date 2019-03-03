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
use app\common\model\Mails as MailsModel;



class Mails extends AdminBase
{
	
	
    public function index(){
		
		$data=MailsModel::get(1);
		$this->assign("data",$data);
        return $this->fetch();
    }
	
	public function mod(Request $request){
		$Model=new MailsModel();
		$input=$request->post();
		$res=$Model->isUpdate(true)->save($input);
		if($res!==false){
			$this->success("编辑成功");
		} else {
			$this->error($this->getError());
		}
	}
	
	public function test(){
		if($this->request->isPost()){
			$input=$this->request->post();
			$result = $this->validate($input,'Mails');
			if (true !== $result) {
				$this->error($result);
			}
			
			$Model=MailsModel::get(1);
			$config=$Model->getData();
			
			
			$fromname='Author';
			$subject='邮件发送测试';
			$content='恭喜你，邮件测试成功。';
			
			$res = $Model->send([
				'email'  => $input['email'],
				'subject'  => $subject,
				'message'  => $content,
				'fromname'  => $fromname,
			]);
			if($res){
				$this->success("发送成功");
			} else {
				$this->error($res);
			}
		} else {
			return $this->fetch();
		}
	}
	
}
