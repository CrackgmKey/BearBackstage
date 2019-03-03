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
use app\admin\model\User;
use app\common\model\Product;
use app\common\model\Nav;
use app\common\model\Spec;
use app\common\model\Cart as CartModel;
use app\common\model\Scorecart;
use think\Config;

class Cart extends IndexBase
{
	protected function _initialize(){
		parent::_initialize();
		$user=new User;
		if(!$user->isLogin()){
			$this->redirect('index/user/login');
		} 
	}
	
    public function index()
    {
		$total_price=0;
		$delivery_fee=0;
		
		$cartDatas=CartModel::all(['uid'=>$this->uid]);
		
		foreach($cartDatas as $k=>$v){
			
			$product=Product::get($v['pid']);
			$total_price+=$v['price']*$v['amount'];
			$delivery_fee+=$product->delivery_fee;
			
			
		}
		//dump(Config::get('alipay'));
		$this->assign("cartDatas",$cartDatas);
		$this->assign("total_price",$total_price);
		$this->assign("delivery_fee",$delivery_fee);
		$this->assign("payable",$total_price+$delivery_fee);
		
		return $this->fetch('user/cart');
    }
	
	public function scoreIndex()
    {
		$total_price=0;
		$delivery_fee=0;
		
		$cartDatas=Scorecart::all(['uid'=>$this->uid]);
		
		foreach($cartDatas as $k=>$v){
			
			$product=Product::get($v['pid']);
			$total_price+=$v['score']*$v['amount'];
			$delivery_fee+=$product->delivery_fee;
			
			
		}
		//dump(Config::get('alipay'));
		$this->assign("cartDatas",$cartDatas);
		$this->assign("total_price",$total_price);
		$this->assign("delivery_fee",$delivery_fee);
		$this->assign("payable",$total_price+$delivery_fee);
		
		return $this->fetch('user/scorecart');
    }
	
	public function del($id=''){
		$model=new CartModel;
		$res=$model->where(['id'=>$id])->delete();
		if($res!=false){
			$this->success('删除成功!');
		} else {
			$this->error('删除失败');
		}
	}
	
	public function delscore($id=''){
		$model=new Scorecart;
		$res=$model->where(['id'=>$id])->delete();
		if($res!=false){
			$this->success('删除成功!');
		} else {
			$this->error('删除失败');
		}
	}
	
	public function addCart(){
		$data=$this->request->param();
		$data['add_time']=time();
		if($data['specs']!=0){
			$data['specs'] = substr($data['specs'],0,strlen($data['specs'])-1); 
		} else {
			$data['specs']=0;
		}
		$model=new CartModel;
		$id=$model->where(['pid'=>$data['pid'],'uid'=>$data['uid']])->value('id');
		
		
		if($id){
			$data['id']=$id;
			$status=true;
		} else {
			$status=false;
		}
		
		$res=$model->isUpdate($status)->save($data);
		if($res){
			return true;
		} else {
			return false;
		}
	}
	
	public function addScoreCart(){
		$data=$this->request->param();
		$data['add_time']=time();
		
		
		$id=db('scorecart')->where(['pid'=>$data['pid'],'uid'=>$data['uid']])->value('id');
		
		if($id){
			$data['id']=$id;
			$res=db('scorecart')->update($data);
		} else {
			$res=db('scorecart')->insert($data);
		}
		
		
		if($res){
			return true;
		} else {
			return false;
		}
	}
	
}
