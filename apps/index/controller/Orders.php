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
use app\common\model\Orders as OrdersModel;
use app\common\model\Ordersitem;
use app\common\model\Cart;
use app\admin\model\User;
use app\common\model\Payment;
use app\common\model\Express;
use think\Validate;
use think\Session;

class Orders extends IndexBase
{
	protected function _initialize(){
		parent::_initialize();
		$user=new User;
		if($user->isLogin()){
			$this->uid=Session::get('uid','index');
		} else {
			$this->redirect('index/user/login');
		}
	}
	
	public function index($id=''){
		$data=OrdersModel::get($id);
		$data->payment_cn=Payment::where(['id'=>$data->payment_id])->value('byname');
		$data->price=$data['total_price']+$data['delivery_fee'];
		if($data->payment_id==2){
			$model=new Payment;
			$img=$model->pay_wxpay($id);
			if(is_weixin()){
				$is_weixin='1';
			} else {
				$is_weixin='2';
			}
			$params=[
				'body'=>'商品费用',
				'out_trade_no' => $data->sn,
				'total_fee' => $data->price*100,//订单金额，单位为分，如果你的订单是100元那么此处应该为 100*100
				'time_start' => date("YmdHis"),//交易开始时间
				'time_expire' => date("YmdHis", time() + 604800),//一周过期
				'goods_tag' => '在线缴纳商品费用',
				
				
				'trade_type' => 'JSAPI',
				'openId' => '',
				'product_id' => rand(1,999999),
				//'redirect_url' => request()->domain().url('index/pay/index')//支付完成后返回的页面
				'redirect_url' =>''
			];
			
			$jsapiData=\wxpay\JsapiPay::getPayParams($params);
			
			$this->assign("jsapiData",$jsapiData);	
			$this->assign("is_weixin",$is_weixin);
			$this->assign('img',$img);
		} else {
			$this->assign("is_weixin",0);
			$this->assign('img','');
			$this->assign("jsapiData",'');	
		}
		
		$this->assign('order',$data);
		return $this->fetch('user/orders');
	}
	
	
	public function myOrders(){
		$param=$this->request->get();
		
		return $this->fetch('user/myorders');
	}
	
	public function detail($id=''){
		
		$html='';
		$data=OrdersModel::get($id);
		$d=$data->getData();
		switch($d['order_status']){
			case 5://未结单，正在交易状态
				if($data['pay_status']==1){
					if($data['delivery_status']==0){
						
						$html.="<span style='color:red'>未发货</span>";
						
					}elseif ($data['delivery_status']==1){
						$html.="<span style='color:green'>已发货</span>";
					}else{
						$data['status_cn']="<span style='color:red'>已收货</span>";
					}
					
				} else{
					
					if($data['payment_id']==3){
						if($data['delivery_status']==0){
							$html.="<span style='color:red'>未发货</span>";
						}elseif ($data['delivery_status']==1){
							$html.="<span style='color:green'>已发货</span>";
						}else{
							$data['status_cn']="<span style='color:red'>已收货</span>";
						}
					} elseif($data['payment_id']==2){
						$html.="<span style='color:red'>未付款</span>";
						$html.='<span style="position:relative"><img alt="扫码支付" src="http://paysdk.weixin.qq.com/example/qrcode.php?data='.$payLinks.'" style="width:150px;height:150px;position:absolute;top:-20px;right:-380px;"/></span>';
					} else {
						$html.="<span style='color:red'>未付款</span>";
						$html.="&nbsp;<input type='button' url='".$payLinks."' id='pay' value='付款'>";
					}
				}
			break;
			case 5:
				$html.="<span style='color:red'>交易失败</span>&nbsp;&nbsp;";
				$html.="关闭原因:".$data['reason'];
			break;
			case 0:
				$html.="<span style='color:green'>交易中</span>&nbsp;";
				if($d['payment_id']==3){
					if($d['delivery_status']==1){
						$html.="<input type='button' style='padding:0px 15px' url='".url("index/orders/takeDelivery","id=".$d['id'])."' id='take' value='收货'>";
					}
				} else {
					if($d['pay_status']==1 && $d['delivery_status']==1){
						$html.="<input type='button' style='padding:0px 15px' url='".url("index/orders/takeDelivery","id=".$d['id'])."' id='take' value='收货'>";
					}
				}
				
				
			break;
			case 1:
				$html.="<span style='color:green'>交易成功</span>";
			break;
			case 2:
				$data['status_cn']="<span style='color:green'>已退款</span>";
			break;
			case 3:
				$data['status_cn']="<span style='color:green'>已退货</span>";
			break;
			case 4:
				$data['status_cn']="<span style='color:green'>已退款，已退货</span>";
			break;
		}
		if($data['pay_time']){
			$data['pay_time']=date("Y-m-d H:i:s",$data['pay_time']);
		}
		if($data['delivery_time']){
			$data['delivery_time']=date("Y-m-d H:i:s",$data['delivery_time']);
		}
		$data['pay_price']=$data['total_price']+$data['delivery_fee'];
		$data['status_cn']=$html;
		$data->express_cn=Express::where(['id'=>$data['express_id']])->value('name');
		
		switch($data['type']){
			case 1:
				$symbol='&yen;';
			break;
			case 4:
				$symbol=db('config')->where(['id'=>1])->value('score_name');
				$data['total_price']=intval($data['total_price']);
			break;
		}
		$data['symbol']=$symbol;
		$this->assign('data',$data);
		$this->assign('d',$d);
		return $this->fetch('user/ordershow');
	}
	
	public function takeDelivery($id=''){
		
		$data['id']=$id;
		$data['delivery_status']=2;
		$data['order_status']=1;
		$msg=[];
		$res=OrdersModel::update($data);
		$this->addAppraise($id);
		if($res!=false){
			
			$msg['code']=1;
			$msg['msg']='收货成功';
		} else {
			$msg['code']=2;
			$msg['msg']='收货失败';
		}
		return json($msg);
	}
	
	private function addAppraise($oid){
		$datas=Ordersitem::all(['oid'=>$oid]);
		$upDatas=[];
		
		foreach($datas as $k=>$v){
			$upDatas[$k]['pid']=$v->pid;
			$upDatas[$k]['uid']=$this->uid;
			$upDatas[$k]['times']=1;
		}
		//dump($upDatas);die;
		db('appraisetimes')->insertAll($upDatas);
		
	}
	
    public function add()
    {
		$data=$this->request->param();
		
		$is_token=Validate::token('__token__','',['__token__'=>$data['__token__']]);
		if($is_token){
			$model=new OrdersModel;
			$data['sn']=$this->build_order_no();
			$data['create_time']=time();
			$data['type']=1;
			$res=$model->allowField(true)->save($data);
			
			foreach($data['pid'] as $k=>$v){
				$item[$k]['pid']=$v;
				$item[$k]['oid']=$model->id;
				$item[$k]['amount']=$data['amount'][$v];
				$item[$k]['price']=$data['price'][$v];
				$item[$k]['specs']=$data['specs'][$v];
				$item[$k]['uid']=intval($data['uid']);
			}
			$res1=Ordersitem::insertAll($item);
			if($res!=false && $res1!=false){
				foreach($data['cart_id'] as $v){
					Cart::where(['id'=>$v])->delete();
				}
				$this->redirect('index/orders/index','id='.$model->id);
			} else {
				$this->error('订单添加失败');
			}
		} else {
			$this->error('不能重复提交订单');
		}
		
    }
	public function addScore()
    {
		$data=$this->request->param();
		
		$is_token=Validate::token('__token__','',['__token__'=>$data['__token__']]);
		if($is_token){
			$total_price=0;
			foreach($data['pid'] as $k=>$v){
				$total_price+=$data['price'][$v];
			}
			$userScore=User::where(['id'=>$data['uid']])->value('score');
			if($userScore<$total_price){
				$symbol=db('config')->where(['id'=>1])->value('score_name');
				$this->error('您的'.$symbol.'不足');
			}
			$model=new OrdersModel;
			$data['sn']=$this->build_order_no();
			$data['create_time']=time();
			$data['pay_status']=1;
			$data['pay_time']=time();
			$data['type']=4;
			$data['total_price']=$total_price;
			$res=$model->allowField(true)->save($data);
			foreach($data['pid'] as $k=>$v){
				$item[$k]['pid']=$v;
				$item[$k]['oid']=$model->id;
				$item[$k]['amount']=$data['amount'][$v];
				$item[$k]['price']=$data['price'][$v];
				$item[$k]['uid']=intval($data['uid']);
			}
			$res1=Ordersitem::insertAll($item);
			User::where('id',$data['uid'])->setDec('score',$total_price);
			if($res!=false && $res1!=false){
				foreach($data['cart_id'] as $v){
					db('scorecart')->where(['id'=>$v])->delete();
				}
				$this->success('积分兑换商品成功！');
			} else {
				$this->error('订单添加失败');
			}
		} else {
			$this->error('不能重复提交订单');
		}
		
    }
	
	private function build_order_no(){
		return date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
	}
	
	public function checkInput(){
		$data=$this->request->param();
		$result = $this->validate($data,'Orders');
		if(is_array($result)){
			return json($result);
		} 
		return json('1');
	}
	
	
}
