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
use app\common\model\Nav;
use app\common\model\News;

class Comment extends Model {
	
	protected $type       = [
        'create_time' => 'timestamp:Y-m-d',
    ];
	public function getComment($where = '',$pagenum = 0,$order = 'create_time desc',$num=''){
		
		foreach($where as $k=>$v){
			if(!$v){
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
			
			$news=News::get($v['article_id']);
			$mid=Nav::where(['id'=>$news['id']])->value('module_id');
			$d[$key]['news_url']=url('index/news/article',array('id'=>$news['id'],'pid'=>$news['cate'],'mid'=>$mid));
			$d[$key]['url']=url('index/letter/privateLetter',array('user_id'=>$v['user_id']));
			$d[$key]['del_url']=url('index/comment/del',array('id'=>$v['id']));
			$d[$key]['friend_url']=url('index/friend/index',array('user_id'=>$v['user_id']));
			if($v->getNewsName){
				$d[$key]['news']=$v->getNewsName;
			}
			
			
			if($v->getUserInfo){
				$d[$key]['user']=$v->getUserInfo;
			} else {
				$d[$key]['user']['user_name']='已无此用户';
			}
			
			
			
		}
		
		$datas['data']=$d;
		return $datas;
	}
	 // 定义关联方法
    public function getNewsName()
    {
        // 用户HAS ONE档案关联
		if($this->hasOne('News','id','article_id')){
			return $this->hasOne('News','id','article_id');
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