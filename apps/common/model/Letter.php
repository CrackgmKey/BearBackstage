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

class Letter extends Model {
	
	protected $type       = [
        'create_time' => 'timestamp:Y-m-d',
    ];
	public function getLetter($map = [],$pagenum = 0,$order = 'create_time desc'){
		if(!empty($map)){
			if(!$map['user_id']){
				unset($map['user_id']);
			}
			if(is_null($map['is_new'])){
				unset($map['is_new']);
			}
			$where=$map;
		} else {
			$where='';
		}
		if($pagenum){
			$d=self::where($where)->order($order)->paginate($pagenum);
			$page = $d->render();
			$datas['page']=$page;
		} else {
			$d=self::where($where)->order($order)->select();
			
		}
		foreach($d as $key=>$v){
			
			$d[$key]['del_url']=url('index/letter/del','id='.$v['id']);
			$d[$key]['det_url']=url('index/letter/detail','id='.$v['id']);
			$d[$key]['rep_url']=url('index/letter/reply','id='.$v['from_id']);
			if($v->getUserInfoFrom){
				$d[$key]['user_name_from']=$v->getUserInfoFrom->user_name;
				$d[$key]['photo_from']=$v->getUserInfoFrom->photo;
			} else {
				$d[$key]['user_name_from']='已无此用户';
			}
			
			
			if($v->getUserInfo){
				$d[$key]['user_name']=$v->getUserInfo->user_name;
				$d[$key]['photo']=$v->getUserInfo->photo;
			} else {
				$d[$key]['user_name']='已无此用户';
			}
			
			
		}
		$datas['data']=$d;
		return $datas;
	}
	public function getUserInfoFrom()
    {
        // 用户HAS ONE档案关联
		if($this->hasOne('app\admin\model\User','id','from_id')){
			return $this->hasOne('app\admin\model\User','id','from_id');
		} else {
			return false;
		}
    }
	public function getUserInfo()
    {
        // 用户HAS ONE档案关联
		if($this->hasOne('app\admin\model\User','id','user_id')){
			return $this->hasOne('app\admin\model\User','id','user_id');
		} else {
			return false;
		}
    }
	
}