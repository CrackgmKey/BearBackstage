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
use app\common\model\Lottery as LotteryModel;
use app\admin\model\User;
use think\Session;

class Lottery extends IndexBase
{
	private $classname='';
	
	protected function _initialize(){
		parent::_initialize();
		$user=new User;
		if($user->isLogin()){
			$this->uid=Session::get('uid','index');
		} else {
			$this->redirect('index/user/login');
		}
	}
    public function index()
    {
		$lotteryData=LotteryModel::get(1);
		$items=db('lotteryitem')->where(['pid'=>$lotteryData->id])->order('sort asc')->select();
		$this->assign("items",$items);
		return $this->fetch('user/mylottery');
    }
	
	public function mod(){
		$data=$this->request->post();
		$result=db('lotterywin')->update($data);
		if(false !== $result){
			return json("1");
		} else {
			return json("2");
		}
	}
		
	public function getResult(){
		$sort=str_replace('$','',$this->request->param('sort'));
		
		$item=db('lotteryitem')->where(['sort'=>$sort])->find();
		
		$lotterywinData=db('lotterywin')->where(['item_id'=>$item['id']])->find();
		$this->assign("lotterywinData",$lotterywinData);
		if($item['win']){
			return $this->fetch("user/winlottery");
		} else {
			return $this->fetch("user/loselottery");
		}
	}
	
	public function getLottery(){
			$rotation=$this->request->param('rotation');
			$lottery_score=$this->request->param('lottery_score');
			
			$lotteryData=LotteryModel::get(1);
			$items=db('lotteryitem')->where(['pid'=>$lotteryData->id])->select();
			$start=0;
			
			$score=$this->userInfo['score']-$lottery_score;
			if($score<0){
				return json("not enough");
			}
			if($lotteryData['total']<=0){
				return json("total not enough");
			}
			db('user')->where('id', $this->uid)->setDec('score', $lottery_score);
			$data=array();
			$model=new LotteryModel;
			foreach($items as $k=>$v){
				$items[$k]['start']=0;
				$items[$k]['end']=0;
				$items[$k]['start']+=$start;
				$items[$k]['percent']=intval($v['percent']/100*360);
				$start=$start+$items[$k]['percent'];
				$items[$k]['end']+=$start;
				if($rotation>$items[$k]['start'] && $rotation<$items[$k]['end']){
					if($v['win']){
						$p['pid']=$v['pid'];
						$p['uid']=$this->uid;
						$p['item_id']=$v['id'];
						$p['tel']=$this->userInfo['phone'];
						$p['address']=$this->userInfo['address'];
						$p['create_time']=time();
						db('lotterywin')->insert($p);
						
						
						$model->where('id', 1)->setDec('total',1);
						
					}
					return json($v['sort']);
				}
			}
			
	}
}
