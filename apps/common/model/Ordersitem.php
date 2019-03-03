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

class Ordersitem extends Model {
	
	
	
	 
	public function getItems($where = '',$pagenum = 0,$order = 'id desc'){
		
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
	
	public function getProduct()
    {
        // 用户HAS ONE档案关联
        
		if($this->hasOne('app\common\model\Product','id','pid')){
			return $this->hasOne('app\common\model\Product','id','pid');
		} else {
			return false;
		}
    }
}