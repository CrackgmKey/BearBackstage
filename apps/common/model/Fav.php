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


class Fav extends Model {
	
	
	public function getNewsfav($uid = '',$pagenum = 0,$order = 'id desc'){
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
			if($v->getNew){
				$d[$key]['new']=$v->getNew;
				$mid=Nav::where(['id'=>$v->getNew['cate']])->value('module_id');
				$d[$key]['url']=url('index/news/article',array('id'=>$v->getNew['id'],'pid'=>$v->getNew['cate'],'mid'=>$mid));
				$d[$key]['del_url']=url('index/fav/newdel','id='.$v->id);
				$d[$key]['create_time']=date('Y-m-d H:i:s',$v->getNew['create_time']);
			} else {
				$d[$key]['new']['name']='已无此资讯';
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
	 
	public function getNew()
    {
        // 用户HAS ONE档案关联
		if($this->hasOne('News','id','article_id')){
			return $this->hasOne('News','id','article_id');
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