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
use app\common\model\Orders;
use think\Model;
use think\Session;
use think\Request;

class Payment extends Model {
	
	
	
	public function getPayment($pagenum = 0,$order = 'sort asc'){
		$where='';
		if($pagenum){
			$d=self::where($where)->order($order)->paginate($pagenum);
			$page = $d->render();
			$datas['page']=$page;
		} else {
			$d=self::where($where)->order($order)->select();
			
		}
		
		
		$datas['data']=$d;
		return $datas;
	}
	
	public function pay_wxpay($id = ''){
		
		$order=Orders::get($id);
		$params['body']=$order->name.'的订单费用';
		$params['total_fee']=$order->total_price+$order->delivery_fee;
		$params['out_trade_no']=$order->sn;
		$params['product_id']=$id;
		return \wxpay\NativePay::getPayImage($params,300,300);
		
    }
	
}