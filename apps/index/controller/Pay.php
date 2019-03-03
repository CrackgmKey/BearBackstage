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
use app\common\model\Orders;
use app\admin\model\User;

class Pay extends IndexBase
{
	
    public function pay_alipay(){
		$oid=$this->request->param('oid');
		$order=Orders::get($oid);
		$params['subject']=$order->name.'的订单费用';
		$params['total_amount']=$order->total_price+$order->delivery_fee;
		$params['out_trade_no']=$order['sn'];
		
		\alipay\Pagepay::pay($params);
		
    }
	
	public function pay_wap_alipay(){
		$oid=$this->request->param('oid');
		$order=Orders::get($oid);
		$params['subject']=$order->name.'的订单费用';
		$params['total_amount']=$order->total_price+$order->delivery_fee;
		$params['out_trade_no']=$order['sn'];
		
		\alipay\Wappay::pay($params);
		
    }
	
	public function pay_wxpay(){
		if (request()->isMobile()) {
			if(is_weixin()){
				$params=[
					'out_trade_no' => input('post.orderid/s','','trim,strip_tags'),
					'total_fee' => input('post.total_fee/f',0,'trim,strip_tags')*100,//订单金额，单位为分，如果你的订单是100元那么此处应该为 100*100
					'time_start' => date("YmdHis"),//交易开始时间
					'time_expire' => date("YmdHis", time() + 604800),//一周过期
					'goods_tag' => '在线缴纳商品费用',
					'notify_url' => request()->domain().url('index/pay/weixin_notify'),
					//'notify_url' => 'http://demo3.74cms.net/dy/index.php/index/pay/weixin_notify',
					//'trade_type' => 'MWEB',//H5页面支付
					'trade_type' => 'JSAPI',
					'openId' => '',
					'product_id' => rand(1,999999),
					//'redirect_url' => request()->domain().url('index/pay/index')//支付完成后返回的页面
					'redirect_url' =>''
				];
				$result=\wxpay\JsapiPay::getPayUrl($params, $redirect_url);
			} else {
				$params=[
					'out_trade_no' => input('post.orderid/s','','trim,strip_tags'),
					'total_fee' => input('post.total_fee/f',0,'trim,strip_tags')*100,//订单金额，单位为分，如果你的订单是100元那么此处应该为 100*100
					'time_start' => date("YmdHis"),//交易开始时间
					'time_expire' => date("YmdHis", time() + 604800),//一周过期
					'goods_tag' => '在线缴纳商品费用',
					'notify_url' => request()->domain().url('index/pay/weixin_notify'),
					//'notify_url' => 'http://demo3.74cms.net/dy/index.php/index/pay/weixin_notify',
					//'trade_type' => 'MWEB',//H5页面支付
					'trade_type' => 'MWEB',
					'openId' => '',
					'product_id' => rand(1,999999),
					//'redirect_url' => request()->domain().url('index/pay/index')//支付完成后返回的页面
					'redirect_url' =>''
				];
				$result=\wxpay\WapPay::getPayParams($params);
			}
		}
		return $result;
		
	}
	
	public function listen($oid=''){
		$pay_status=Orders::where(['sn'=>$oid])->value('pay_status');
		if($pay_status){
			return json('SUCCESS');
		} else {
			return json('FALSE');
		}
		
	}
	
	
	public function ali_return_url(){
		$data=$this->request->param();
		
		$this->assign('data',$data);
		return $this->fetch('user/ali_return_url');
	}
	
	
	
	
	
	
	
}
