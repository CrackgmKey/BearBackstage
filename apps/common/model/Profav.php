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


class Profav extends Model {
	
	
	public function getProfav($uid = '',$pagenum = 0,$order = 'id desc'){
		$where['user_id']=$uid;
		if($pagenum){
			$d=self::where($where)->order($order)->paginate($pagenum);
			$page = $d->render();
			$datas['page']=$page;
		} else {
			$d=self::where($where)->order($order)->select();
			$datas['page']='';
		}
		foreach($d as $key=>$v){
			if($v->getProduct){
				$d[$key]['product']=$v->getProduct;
				$mid=Nav::where(['id'=>$v->getProduct['cate_id']])->value('module_id');
				$type=Nav::where(['id'=>$v->getProduct['cate_id']])->value('type');
				switch($type){
					case 1:
						$symbol='&yen;';
						$d[$key]['url']=url('index/product/show',array('id'=>$v->getProduct['id'],'pid'=>$v->getProduct['cate_id'],'mid'=>$mid));
					break;
					case 4:
						$symbol=db('config')->where(['id'=>1])->value('score_name');
						$d[$key]['url']=url('index/score/show',array('id'=>$v->getProduct['id'],'pid'=>$v->getProduct['cate_id'],'mid'=>$mid));
						$d[$key]['product']['origin_price']=intval($d[$key]['product']['origin_price']);
						$d[$key]['product']['current_price']=intval($d[$key]['product']['current_price']);
					break;
				}
				$d[$key]['symbol']=$symbol;
				
				
				$d[$key]['del_url']=url('index/fav/del','id='.$v->id);
			} else {
				$d[$key]['product']['name']='已无此商品';
			}
			if($v->getUser){
				$d[$key]['user']=$v->getUser;
			} else {
				$d[$key]['user']['user_name']='已无此用户';
			}
		}
		$datas['data']=$d;
		return $datas;
	}
	 
	public function getProduct()
    {
        // 用户HAS ONE档案关联
		if($this->hasOne('Product','id','pid')){
			return $this->hasOne('Product','id','pid');
		} else {
			return false;
		}
        
    }
	
	public function getUser()
    {
        // 用户HAS ONE档案关联
        
		if($this->hasOne('app\admin\model\User','id','user_id')){
			return $this->hasOne('app\admin\model\User','id','user_id');
		} else {
			return false;
		}
    }
}