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

use think\Model;
use think\Session;
use think\Request;
use app\common\model\Payment;

class Orders extends Model {
	
	
	protected function getPayStatusAttr($v){
        $pay_status = [0 => '未支付', 1 => '支付成功', 2 => '支付失败'];
        return $pay_status[$v];
    }
	protected function getDeliveryStatusAttr($v){
        $delivery_status = [0 => '未发货', 1 => '已发货', 2 => '已收货'];
        return $delivery_status[$v];
    }
	protected function getOrderStatusAttr($v){
        $order_status = [0 => '交易中', 1 => '交易成功', 2 => '已退款', 3 => '已退货', 4 => '已退款，已退货', 5 => '交易失败'];
        return $order_status[$v];
    }
	 
	public function getOrders($param = '',$pagenum = 0,$order = 'id desc'){
		
		if($param){
			foreach($param as $k=>$v){
				
				switch($k){
					case 'sn':
						$where['sn']=array('like','%'.$param['sn'].'%');
					break;
					case 'dateRange':
						
						$where['pay_time']=['between time',$param['dateRange']];
					break;
					case 'uid':
						$where['uid']=$param['uid'];
					break;
					case 'pay_status':
						if(!is_null($param['pay_status'])){
							$where['pay_status']=$param['pay_status'];
						}
					break;
					case 'order_status':
						if(!is_null($param['order_status'])){
							$where['order_status']=$param['order_status'];
						}
					break;
					case 'payment_id':
						if(!is_null($param['payment_id'])){
							if($param['payment_id']==4){
								$where['type']=4;
							} else {
								$where['payment_id']=$param['payment_id'];
							}
						}
					break;
					case 'order_sn':
						if(!is_null($param['order_sn'])){
							$where['sn']=array('like','%'.$param['order_sn'].'%');
						}
					break;
					case 'type':
						if($param['type']!='0'){
							$where['type']=$param['type'];
						}
					break;
				}
			}
		} else {
			$where='';
		}
		
		if($pagenum){
			$d=self::where($where)->order($order)->paginate($pagenum);
			$page = $d->render();
			$datas['page']=$page;
			
		} else {
			$d=self::where($where)->order($order)->select();
			$datas['page']='';
		}
		
		foreach($d as $key=>$v){
			$data=$v->getData();
			$d[$key]['det_url']=url('index/orders/detail','id='.$v['id']);
			$d[$key]['pay_price']=$v['total_price']+$v['delivery_fee'];
			$html='';
			switch($data['type']){
				case 1:
					$d[$key]['symbol']='&yen;';
				break;
				case 4:
					$d[$key]['symbol']=db('config')->where(['id'=>1])->value('score_name');
				break;
			}
			
			switch($data['type']){
				case 1:
					$d[$key]['payment_cn']=Payment::where(['id'=>$v['payment_id']])->value('byname');
				break;
				case 4:
					$d[$key]['payment_cn']='<i style="color:green">积分兑换</i>';
				break;
			}
			switch($data['pay_status']){
				case 0:
					$d[$key]['pay_status_cn']='<i style="color:#F30">未支付</i>';
				break;
				case 1:
					$d[$key]['pay_status_cn']='<i style="color:green">支付成功</i>';
					
				break;
				case 2:
					$d[$key]['pay_status_cn']='<i style="color:red">支付失败</i>';
				break;
			}
			switch($data['order_status']){
				case 0:
					$d[$key]['order_status_cn']='<i style="color:#F30">交易中</i>';
					
					if($data['payment_id']==3){
						if($data['delivery_status']==1){
							$html.="<input type='button' style='padding:0px 15px' url='".url("index/orders/takeDelivery","id=".$data['id'])."' id='take' value='收货'>";
						}
					} else {
						if($data['pay_status']==1 && $data['delivery_status']==1){
							$html.="<input type='button' style='padding:0px 15px' url='".url("index/orders/takeDelivery","id=".$data['id'])."' id='take' value='收货'>";
						}
					}
					
				break;
				case 5:
					$d[$key]['order_status_cn']='<i style="color:#F30">交易失败</i>';
				break;
				case 1:
					$d[$key]['order_status_cn']='<i style="color:green">交易成功</i>';
				break;
				case 2:
					$d[$key]['order_status_cn']='<i style="color:red">已退款</i>';
				break;
				case 3:
					$d[$key]['order_status_cn']='<i style="color:red">已退货</i>';
				break;
				case 4:
					$d[$key]['order_status_cn']='<i style="color:red">已退款，已退货</i>';
				break;
				
			}
			$d[$key]['status_cn']=$html;
		}
		$datas['data']=$d;
		return $datas;
	}
	 // 定义关联方法
    
	
	public function getUser()
    {
        // 用户HAS ONE档案关联
        
		if($this->hasOne('app\admin\model\User','id','uid')){
			return $this->hasOne('app\admin\model\User','id','uid');
		} else {
			return false;
		}
    }
	
	public function getPayment()
    {
        // 用户HAS ONE档案关联
        
		if($this->hasOne('app\common\model\Payment','id','payment_id')){
			return $this->hasOne('app\common\model\Payment','id','payment_id');
		} else {
			return false;
		}
    }
}