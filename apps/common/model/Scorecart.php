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

use app\common\model\Product;
use app\common\model\Spec;
use think\Model;
use think\Session;
use think\Request;

class Scorecart extends Model {
	
	public function getCart($uid = '',$pagenum = 0,$order = 'sort asc'){
		if($uid){
			$where['uid']=$uid;
		}
		
		if(!$uid){
			$where='';
		}
		if($pagenum){
			$d=self::where($where)->order($order)->paginate($pagenum);
			$page = $d->render();
			$datas['page']=$page;
		} else {
			$d=self::where($where)->order($order)->select();
			
		}
		
		foreach($d as $k=>$v){
			$data[$k]=$v->getData();
			
			$data[$k]['del_url']=url('index/cart/delscore',array('id'=>$v['id']));
			$product=Product::get($v['pid']);
			$data[$k]['pro']=$product;
			
			
			
			
		}
		if(empty($data)){
			$data=[];
		}
		$datas['data']=$data;
		return $datas;
	}
}