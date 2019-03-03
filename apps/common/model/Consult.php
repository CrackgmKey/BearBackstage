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

class Consult extends Model {
	
	protected $type       = [
        //'q_time' => 'timestamp:Y-m-d',
		//'a_time' => 'timestamp:Y-m-d',
    ];
	
	public function getConsult($where = '',$pagenum = 0,$order = 'id desc'){
		
		foreach($where as $k=>$v){
			if(!$v && $k!='is_reply' && $k!='verify'){
				unset($where[$k]);
			} elseif($k=='is_reply' && is_null($v)){
				unset($where[$k]);
			} elseif($k=='verify' && is_null($v)){
				unset($where[$k]);
			} 
		}
		/*
		if($where['is_reply']==3){
			unset($where['is_reply']);
		}*/
		if($pagenum){
			$d=self::where($where)->order($order)->paginate($pagenum);
			$page = $d->render();
			$datas['page']=$page;
		} else {
			$d=self::where($where)->order($order)->select();
			$datas['page']='';
		}
		//dump(self::getLastSql());
		foreach($d as $key=>$v){
			
			if($v->q_time){
				$v->q_time=date('Y-m-d H:i:s',$v->q_time);
				
			}
			if($v->a_time){
				$v->a_time=date('Y-m-d H:i:s',$v->a_time);
				
			}
			if($v->getProduct){
				$d[$key]['product']=$v->getProduct;
				$mid=Nav::where(['id'=>$v->getProduct['cate_id']])->value('module_id');
				$d[$key]['url']=url('index/product/show',array('id'=>$v->getProduct['id'],'pid'=>$v->getProduct['cate_id'],'mid'=>$mid));
				$d[$key]['mod_url']=url('index/consult/mod','id='.$v->id);
				$d[$key]['del_url']=url('index/consult/del','id='.$v->id);
			} else {
				$d[$key]['product']['name']='已无此商品';
			}
			
			
			if($v->getUser){
				$d[$key]['user']=$v->getUser;
			} else {
				$d[$key]['user']['user_name']='已无此用户';
			}
			if($v->admin_id){
				if($v->getAdmin){
					$d[$key]['admin']=$v->getAdmin;
				} else {
					$d[$key]['admin']['adm_name']='已无此用户';
					$d[$key]['admin']['avatar']='';
				}
			} else {
				$d[$key]['admin']='';
				
			}
			
			
		}
		
		
		$datas['data']=$d;
		return $datas;
	}
	 // 定义关联方法
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
        
		if($this->hasOne('app\admin\model\User','id','uid')){
			return $this->hasOne('app\admin\model\User','id','uid');
		} else {
			return false;
		}
    }
	
	public function getAdmin()
    {
        // 用户HAS ONE档案关联
        
		if($this->hasOne('app\admin\model\Admin','id','admin_id')){
			return $this->hasOne('app\admin\model\Admin','id','admin_id');
		} else {
			return false;
		}
    }
	
}