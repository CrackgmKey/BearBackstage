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
use app\common\model\Sms as SmsModel;



class Sms extends AdminBase
{
	
	
    public function index(){
		
		$data=SmsModel::get(1);
		$this->assign("data",$data);

        return $this->fetch();
    }
	
	public function mod(Request $request){
		$Model=new SmsModel();
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
			$result = $this->validate($input,'Sms');
			if (true !== $result) {
				$this->error($result);
			}
			
			$Model=new SmsModel;
			$res=$Model->send([
				'param'  => ['code'=>'554321','product'=>'【尚考】'],
				'mobile'  => $input['mobile'],
				'template'  => 'SMS_61170116',
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
