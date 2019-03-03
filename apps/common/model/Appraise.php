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
use app\common\model\Nav;
use think\Model;
use think\Session;
use think\Request;

class Appraise extends Model {
	
	protected $type       = [
        'content_time' => 'timestamp:Y-m-d',
		
    ];
	
	public function getAppraise($where = '',$pagenum = 0,$order = 'id desc',$num=''){
		foreach($where as $k=>$v){
			if(!$v && $k!='is_reply'){
				unset($where[$k]);
			} elseif($k=='is_reply' && is_null($v)){
				unset($where[$k]);
			}
		}
		
		if($pagenum){
			$d=self::where($where)->order($order)->limit($num)->paginate($pagenum);
			$page = $d->render();
			$datas['page']=$page;
		} else {
			$d=self::where($where)->order($order)->limit($num)->select();
			$datas['page']='';
		}
		
		foreach($d as $key=>$v){
			
			
			if($v->getProduct){
				$d[$key]['product']=$v->getProduct;
				$mid=Nav::where(['id'=>$v->getProduct['cate_id']])->value('module_id');
				$d[$key]['url']=url('index/product/show',array('id'=>$v->getProduct['id'],'pid'=>$v->getProduct['cate_id'],'mid'=>$mid));
				$d[$key]['mod_url']=url('index/appraise/mod','id='.$v->id);
			} else {
				$d[$key]['product']['name']='已无此商品';
			}
			if($v->reply_time){
				$v->reply_time=date('Y-m-d',$v->reply_time);
				
			}
			
			switch($d[$key]['level']){
				case 1:
					$d[$key]['level_cn']="好评";
				break;
				case 2:
					$d[$key]['level_cn']="中评";
				break;
				case 3:
					$d[$key]['level_cn']="差评";
				break;
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