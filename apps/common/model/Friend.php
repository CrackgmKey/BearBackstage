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

class Friend extends Model {
	
	public function check($f_id,$u_id,$verify=0){
		if(!$verify){//查找是否已发送过好友请求
			return $this->where(array("friend_id"=>$f_id,"user_id"=>$u_id))->count();
			
		} else {//查找是否已是好友
			$v1=$this->where(array("friend_id"=>$f_id,"user_id"=>$u_id,"verify"=>1))->count();
			$v2=$this->where(array("friend_id"=>$u_id,"user_id"=>$f_id,"verify"=>1))->count();
			if($v1 || $v2){
				return true;
			} else {
				return false;
			}
		}
	}	
	
	public function getFriend($uid = '',$verify='',$pagenum = 0,$order = 'id desc'){
		$where['friend_id']=$uid;
		if(is_numeric($verify)){
			$where['verify']=$verify;
		}
		if($pagenum){
			$d=self::where($where)->order($order)->paginate($pagenum);
			$page = $d->render();
			$datas['page']=$page;
		} else {
			$d=self::where($where)->order($order)->select();
			$datas['page']='';
		}
		
		foreach($d as $key=>$v){
			if($v->addtime){
				$v->addtime=date('Y-m-d H:i:s',$v->addtime);
			}
			if($v->getUser){
				$d[$key]['friend_info']=$v->getUser;
				$d[$key]['url']=url('index/letter/privateLetter',array('user_id'=>$v['user_id']));
				$d[$key]['det_url']=url('index/friend/detail','id='.$v->id);
				$d[$key]['del_url']=url('index/friend/del','id='.$v->id);
			} else {
				$d[$key]['friend_info']['user_name']='已无此用户';
			}
			
		}
		
		$datas['data']=$d;
		return $datas;
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