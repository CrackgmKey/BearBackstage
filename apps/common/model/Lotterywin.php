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

class Lotterywin extends Model {
	
	
	protected $type       = [
        'create_time' => 'timestamp:Y-m-d',
    ];
	
	
	
	public function getLotterywin($pid = '',$uid = '',$pagenum = 0,$order = 'id desc'){
		$where="";
		if($pid){
			$where['pid']=$pid;
		} 
		if($uid){
			$where['uid']=$uid;
		}
		
		if($pagenum){
			$d=self::where($where)->order($order)->paginate($pagenum);
			$page = $d->render();
			$datas['page']=$page;
		} else {
			$d=self::where($where)->order($order)->select();
			
		}
		foreach($d as $key=>$v){
			
			
			if($v->getItemName){
				$d[$key]['item_name']=$v->getItemName['name'];
			} else {
				$d[$key]['item_name']='已无此奖项';
			}
			
		} 
		
		$datas['data']=$d;
		return $datas;
	}
	
	 // 定义关联方法
    public function getUserName()
    {
        // 用户HAS ONE档案关联
		if($this->hasOne('app\admin\model\User','id','uid')){
			return $this->hasOne('app\admin\model\User','id','uid');
		} else {
			return false;
		}
       
    }
	
	 // 定义关联方法
    public function getItemName()
    {
        // 用户HAS ONE档案关联
		if($this->hasOne('app\common\model\Lotteryitem','id','item_id')){
			return $this->hasOne('app\common\model\Lotteryitem','id','item_id');
		} else {
			return false;
		}
       
    }
	
}