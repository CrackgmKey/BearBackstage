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
use app\common\controller\Base;
use think\Validate;
use think\Session;
use think\Db;
use app\common\model\Orders;
use app\common\model\Exam;
use app\admin\model\User;


class Notifyurl extends Base
{
	
    public function alipay(){
		$params=$this->request->param();
		$result=\alipay\Notify::check($params);
		
		
		if($result){
			Orders::where(['sn'=>$params['out_trade_no']])->update(['pay_status'=>1,'pay_time'=>time()]);
			$orderData=Orders::get(['sn'=>$params['out_trade_no']]);
			$items=db('ordersitem')->where(['oid'=>$orderData->id])->select();
			foreach($items as $k=>$v){
				$adata[$k]['pid']=$v['pid'];
				$adata[$k]['uid']=$orderData->uid;
				$adata[$k]['times']=1;
			}
			db('appraisetimes')->insertAll($adata);
		}
		
    }
	
	public function wxpay(){
		$notify = new \wxpay\Notify();  
		$notify->Handle();
	}
	
}
