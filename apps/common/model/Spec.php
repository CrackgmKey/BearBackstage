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
use think\Model;
use think\Session;
use think\Request;

class Spec extends Model {
	
	
	public function getSpec($pid = 0,$cate_id = 0,$product_id = 0,$pagenum = 0,$order = 'sort asc',$num=''){
		
		$where['pid']=$pid;
		if($cate_id){
			$where['cate_id']=$cate_id;
		} else {
			unset($where['cate_id']);
		}
		if($pagenum){
			$d=self::where($where)->order($order)->limit($num)->paginate($pagenum);
			$page = $d->render();
			$datas['page']=$page;
		} else {
			$d=self::where($where)->order($order)->limit($num)->select();
			$datas['page']='';
		}
		if($product_id){
			$spec_main=Product::where(['id'=>$product_id])->value('spec_main');
			if($spec_main){
				$spec_main=unserialize($spec_main);
				foreach($d as $k=>$v){
					if(!in_array($v->id,$spec_main)){
						unset($d[$k]);
					}
				}
			} else {
				$d=[];
			}
		}
		$datas['data']=$d;
		return $datas;
	}
	 // 定义关联方法
    public function getNavName()
    {
        // 用户HAS ONE档案关联
        return $this->hasOne('Nav','id','cate_id');
    }
	
}