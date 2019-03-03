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
use think\Session;
use app\common\model\Orders as OrdersModel;
use app\common\model\Ordersitem;
use app\common\model\Spec;
use app\common\model\District;
use app\common\model\Express;
use app\common\model\Payment;

class Orders extends AdminBase
{
	
    public function index($id = 0){
		
		$model=new OrdersModel;
		$param=[];
		$param['payment_id']=$this->request->param('payment_id')?$this->request->param('payment_id'):0;
		
		
		if($this->request->param('dateRange')){
			$param['dateRange']=$this->request->param('dateRange');
		}
		$currentPayName="请选择支付方式";
		
		if($this->request->param('sn')){
			
			$param['sn']=$this->request->param('sn');
			unset($param['payment_id']);
		} else {
			if($this->request->param('dateRange')){
				Session::set('dateRange',$this->request->param('dateRange'),'admin');
				unset($param['payment_id']);
			}else {
				if($this->request->isPost()){
					if(!$this->request->param('dateRange')){
						Session::delete('dateRange','admin');
					}
				}
				if($param['payment_id']){
					switch($param['payment_id']){
						case 1:
							$currentPayName="支付宝";
						break;
						case 2:
							$currentPayName="微信支付";
						break;
						case 3:
							$currentPayName="货到付款";
						break;
						case 4:
							$currentPayName="积分兑换";
							unset($param['payment_id']);
							$param['type']=4;
						break;
					}
				} else {
					
					unset($param['payment_id']);
				}
			}
			
		}
		if(Session::get('dateRange','admin')){
			$range=explode(' - ',Session::get('dateRange','admin'));
			$param['dateRange']=$range;
		}
		
		
		$datas=$model->getOrders($param,$this->gl_config['admin_page_num']);
		$arr=array();
		
		foreach($datas['data'] as $key=>$v){
			
			$d=$v->getData();
			$d['det_url']=url('admin/orders/detail','id='.$d['id']);
			$d['del_url']=url('admin/orders/del','id='.$d['id']);
			
			$d['pay_price']=$v['total_price']+$v['delivery_fee'];
			$d['pay_status_cn']=$v->pay_status;
			$d['delivery_status_cn']=$v->delivery_status;
			$d['order_status_cn']=$v->order_status;
			if($v->pay_time){
				$d['pay_time_cn']='<span style="color:green">'.date('Y-m-d',$v->pay_time).'</span>';
			} else {
				$d['pay_time_cn']='<span style="color:red">暂无</span>';
			}
			if($v->getUser){
				$d['user_name']=$v->getUser->user_name;
			} else {
				$d['user_name']='<span style="color:red">已无此用户</span>';
			}
			if($d['type']==1){
				if($v->getPayment){
					$d['payment_name']=$v->getPayment->byname;
				} else {
					$d['payment_name']='<span style="color:red">已无此支付方式</span>';
				}
			} elseif($d['type']==4){
				$d['payment_name']='<span style="color:green">积分兑换</span>';
			}
			
			$arr[]=$d;
			
		} 
		$this->assign("currentPayName",$currentPayName);
		$this->assign("dateRange",$this->request->param('dateRange')?$this->request->param('dateRange'):Session::get('dateRange','admin'));
		$this->assign("page",$datas['page']);
		$this->assign("datas",$arr);
        return $this->fetch();
    }
	
	public function deliver($id=''){
		
		if($this->request->isPost()){
			$data=$this->request->param();
			$data['delivery_status']=1;
			$data['delivery_time']=time();
			$res=OrdersModel::update($data);
			if($res!=false){
				$this->success('发货成功');
			} else {
				$this->error('发货失败');
			}
		} else {
			$data=OrdersModel::get($id);
			$data->pay_price=$data->total_price+$data->delivery_fee;
			if($data['type']==1){
				$data->payment_cn=Payment::where(['id'=>$data->payment_id])->value('byname');
			} elseif($data['type']==4){
				$data->payment_cn='<span style="color:green">积分兑换</span>';
			}
			if($data['type']==4){
				$data['total_price']=intval($data['total_price']);
			}
			$expressDatas=Express::all();
			$this->assign("expressDatas",$expressDatas);
			$this->assign("data",$data);
			return $this->fetch();
		}
	}
	
	public function offpay($id=''){
		
		$data=$this->request->param();
		$data['pay_status']=1;
		$data['pay_time']=time();
		$res=OrdersModel::update($data);
		if($res!=false){
			$this->success('提交成功');
		} else {
			$this->error('提交失败');
		}
	}
	
	public function detail($id = ''){
		$dataModel=OrdersModel::get($id);
		$data=$dataModel->getData();
		if($dataModel->getUser){
			$user=$dataModel->getUser->getData();
			$data['is_user']=true;
		} else {
			$user='<span style="color:red">已无此用户</span>';
			$data['is_user']=false;
		}
		
		if($data['pay_time']){
			$data['pay_time_cn']='<span style="color:green">'.date('Y-m-d',$data['pay_time']).'</span>';
		} else {
			$data['pay_time_cn']='<span style="color:red">暂无</span>';
		}
		$data['create_time_cn']='<span style="color:green">'.date('Y-m-d',$data['create_time']).'</span>';
		
		
		if($data['payment_id']==3){
			if($data['delivery_status']==0){
				$url=url('admin/orders/deliver','id='.$id);
				$data['opt_cn']="&nbsp;<input type='button' class='input-button' url='{$url}' id='deliver' value='发货'>";
			} elseif($data['delivery_status']==1){
				$data['opt_cn']='<span style="color:green;margin-left:20px">已发货</span>';
			} elseif($data['delivery_status']==2){
				if($data['pay_status']==0){
					$url=url('admin/orders/offpay','id='.$id);
					$data['opt_cn']='<span style="color:green;margin-left:20px">已收货</span>';
					$data['opt_cn'].="&nbsp;&nbsp;<input type='button' class='input-button' url='{$url}' id='offpay' value='确认支付'>";
				} else if($data['pay_status']==1){
					$data['opt_cn']='<span style="color:green;margin-left:20px">交易成功</span>';
				}
			}
			
		} else {
			if($data['pay_status']==1 && $data['delivery_status']==0){
				$url=url('admin/orders/deliver','id='.$id);
				$data['opt_cn']="&nbsp;<input type='button' class='input-button' url='{$url}' id='deliver' value='发货'>";
			} elseif($data['pay_status']==1 && $data['delivery_status']==1){
				$data['opt_cn']='<span style="color:green;margin-left:20px">已发货</span>';
			} else {
				$data['opt_cn']='';
			}
		}
		
		if($data['type']==4){
			$data['total_price']=intval($data['total_price']);
		}
		
		$items=Ordersitem::all(['oid'=>$id]);
		$product=[];
		foreach($items as $k=>$v){
			$d=$v->getData();
			if($v->getProduct){
				$product[$k]['name']=$v->getProduct->name;
				$product[$k]['thumb']=$v->getProduct->thumb;
				if($data['type']==1){
					$product[$k]['price']=$d['price'];
				} elseif($data['type']==4){
					$product[$k]['price']=intval($d['price']);
				}
				$product[$k]['amount']=$d['amount'];
			} else {
				$product[$k]['name']='<span style="color:red">已无此商品</span>';
			}
			$specs=explode(',',$v->specs);
			$specs_str='';
			foreach($specs as $sv){
				$specs_str.=Spec::where(['id'=>$sv])->value('name').'/';
			}
			$data['specs'][$k]=$specs_str;
		}
		$disModel=new District;
		$district=$disModel->getDistrict(['id'=>$data['district']]);
		$sdistrict=$disModel->getDistrict(['id'=>$data['sdistrict']]);
		if($district){
			$data['district_cn']=$district->district_name;
		} else {
			$data['district_cn']='';
		}
		if($sdistrict){
			$data['sdistrict_cn']=$sdistrict->district_name;
		} else {
			$data['sdistrict_cn']='';
		}
		$data['pay_price']=$data['total_price']+$data['delivery_fee'];
		
		if($data['payment_id']==3){
			$data['pay_status_cn']='货到付款';
		} elseif($data['payment_id']==4){
			$data['pay_status_cn']='积分兑换';
		} else {
			$data['pay_status_cn']=$dataModel->pay_status;
		}
		
		$data['delivery_status_cn']=$dataModel->delivery_status;
		$data['order_status_cn']=$dataModel->order_status;
		$data['express_cn']=Express::where(['id'=>$data['express_id']])->value('name');
		$data['delivery_time']=date('Y-m-d H:i:s',$data['delivery_time']);
		$this->assign("product",$product);
		$this->assign("user",$user);
		$this->assign("data",$data);
		return $this->fetch();
	}
	
	
	
	
	
	public function del($id = ''){
		$Model=new OrdersModel();
		parent::dels($id,$Model);
	}
	
	
	
}
