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
use app\common\model\Nav;
use app\common\model\Orders;
use app\common\model\Ordersitem;
use app\common\model\Appraise;
use app\admin\model\Productspec;


class Product extends Model {
	
	
	public function getProduct($param=[],$pagenum = 0,$order = 'sort asc',$num =''){
	
		if($param['pid']){
			$nav=Nav::get($param['pid']);
			
			if($nav->pid){
				$where['cate_id']=$param['pid'];
			} else{
				$allData=Nav::where(['pid'=>$nav->id])->column('id');
				$allData[]=$nav->id;
				
				$where['cate_id']=['in',$allData];
			}
		}
		
		
		
		if($param['bid']){
			$where['brand_id']=$param['bid'];
		}
		if($param['recommend']){
			$where['is_recommend']=$param['recommend'];
		}
		if($param['status']){
			$where['status']=$param['status'];
		}
		
		if(!is_null($param['keywords']) && !$num){
			$where['p.name|brief|specifications']=array('like','%'.trim($param['keywords']).'%');
		} 
		
		$order='p.'.$order;
		
		if(!$param['pid'] && !$param['bid'] && !$param['recommend'] && !$param['status'] && !$param['keywords']){
			$where='';
		}
		
		if(isset($param['type'])){
			$where['n.type']=$param['type'];
		} 
		
		if($pagenum){
			$d=self::alias('p')->join('nav n','n.id=p.cate_id','left')->field('p.*,n.type')->where($where)->order($order)->limit($num)->paginate($pagenum);
			$page = $d->render();
			$datas['page']=$page;
		} else {
			
			$d=self::alias('p')->join('nav n','n.id=p.cate_id','left')->field('p.*,n.type')->where($where)->order($order)->limit($num)->select();
			$datas['page']='';
		}
		//dump(self::getLastSql());die;
		foreach($d as $k=>$v){
			$mid=Nav::where(['id'=>$v['cate_id']])->value('module_id');
			$type=Nav::where(['id'=>$v['cate_id']])->value('type');
			
			
			switch($type){
				case 1:
					$symbol='&yen;';
					$d[$k]['url']=url('index/product/show',array('id'=>$v['id'],'pid'=>$v['cate_id'],'mid'=>$mid));
				break;
				case 4:
					$symbol=db('config')->where(['id'=>1])->value('score_name');
					$d[$k]['origin_price']=intval($v['origin_price']);
					$d[$k]['current_price']=intval($v['current_price']);
					$d[$k]['url']=url('index/score/show',array('id'=>$v['id'],'pid'=>$v['cate_id'],'mid'=>$mid));
				break;
			}
			$d[$k]['symbol']=$symbol;
			
		}
		
		$datas['data']=$d;
		return $datas;
	}
	
	public function getProduct_1($id = ''){
		$d=self::where(['id'=>$id])->find();
		$d=$d->getData();
		
		$type=Nav::where(['id'=>$d['cate_id']])->value('type');
		switch($type){
			case 1:
				$symbol='&yen;';
			break;
			case 4:
				$symbol=db('config')->where(['id'=>1])->value('score_name');
				$d['origin_price']=intval($d['origin_price']);
				$d['current_price']=intval($d['current_price']);
			break;
		}
		$d['symbol']=$symbol;
		$specs=Productspec::where(['pid'=>$d['id']])->select();
		$d['success_orders_num']=$this->successOrdersNum($id);
		$d['appraise_num']=Appraise::where(['pid'=>$d['id']])->count();
		$d['good_num']=$this->levelNum($d['id'],1);
		$d['middle_num']=$this->levelNum($d['id'],2);
		$d['bad_num']=$this->levelNum($d['id'],3);
		if($d['appraise_num']){
			$d['good_per']=floor($d['good_num']/$d['appraise_num']*100);
		} else {
			$d['good_per']=0;
		}
		if($d['appraise_num']){
			$d['middle_per']=floor($d['middle_num']/$d['appraise_num']*100);
		} else {
			$d['middle_per']=0;
		}
		if($d['appraise_num']){
			$d['bad_per']=floor($d['bad_num']/$d['appraise_num']*100);
		} else {
			$d['bad_per']=0;
		}
		
		$d['least_per']=100-$d['good_per'];
		if($specs){
			foreach($specs as $k=>$v){
				$spec=unserialize($v->specs);
				$d['spec'][$k]=$spec;
				$d['spec'][$k]['id']=$v->id;
				$d['spec'][$k]['img']=$v->img;
				if(!$v['is_qiniu']){
					if($v['img']){
						$d['spec'][$k]['img']=Request::instance()->root().'/public/uploads/'.$v['img'];
					}
					
				} else {
					if(strpos($v['img'],'http://')){
						$d['spec'][$k]['img']=$v['img'];
					} else{
						$d['spec'][$k]['img']='http://'.$v['img'];
					}
					
				}
			}
		} else {
			$d['spec']=[];
		}
		
		$d['add_time']=date("Y-m-d H:i",$d['add_time']);
		
		if(!$d['is_qiniu']){
			if($d['img']){
				$d['img']=Request::instance()->root().'/public/uploads/'.$d['img'];
			}
			
		} else {
			if(strpos($d['img'],'http://')){
				$d['img']=$d['img'];
			} else{
				$d['img']='http://'.$d['img'];
			}
			
		}
		return $d;
	}
	
	private function levelNum($pid,$level){
		return Appraise::where(['pid'=>$pid,"level"=>$level])->count();
	}
	
	private function successOrdersNum($pid){
		$num=0;
		$datas=Ordersitem::all(["pid"=>$pid]);
		foreach($datas as $k=>$v){
			$n=Orders::where(["id"=>$v['oid'],"order_status"=>1])->count();
			if($n){
				$num++;
			}
		}
		return $num;
	}
	
	 // 定义关联方法
    public function getNavName()
    {
        // 用户HAS ONE档案关联
		if($this->hasOne('Nav','id','cate_id')){
			return $this->hasOne('Nav','id','cate_id');
		} else {
			return false;
		}
       
    }
	
	 public function getBrandName()
    {
        // 用户HAS ONE档案关联
		if($this->hasOne('Brand','id','brand_id')){
			return $this->hasOne('Brand','id','brand_id');
		} else {
			return false;
		}
    }
	
}