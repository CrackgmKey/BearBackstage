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

class News extends Model {
	
	
	
	public function getNews($pid = '',$pagenum = 0,$order = 'sort asc',$num='',$keywords=''){
		$where='';
		if($pid){
			$where['cate']=$pid;
		}
		if($keywords && !$num){
			$where['title|description|content']=array('like','%'.trim($keywords).'%');
		} 
		
		if($pagenum){
			$d=self::where($where)->order($order)->paginate($pagenum);
			$page = $d->render();
			$datas['page']=$page;
		} else {
			$d=self::where($where)->order($order)->limit($num)->select();
			$datas['page']='';
		}
		
		foreach($d as $k=>$v){
			$mid=Nav::where(['id'=>$v['cate']])->value('module_id');
			$d[$k]['url']=url('index/news/article',array('id'=>$v['id'],'pid'=>$v['cate'],'mid'=>$mid));
			$d[$k]['commentNum']=db('comment')->where(['article_id'=>$v['id']])->count();
			$d[$k]['create_time']=date("Y-m-d",$v['create_time']);
			if(!$v['is_qiniu']){
				if($v['thumb']){
					$d[$k]['thumb']=Request::instance()->root().'/public/uploads/'.$v['thumb'];
				}
				
			} else {
				if(strpos($v['thumb'],'http://')){
					$d[$k]['thumb']=$v['thumb'];
				} else{
					$d[$k]['thumb']='http://'.$v['thumb'];
				}
				
			}
		}
		
		$datas['data']=$d;
		return $datas;
	}
	
	public function getNews_1($id = ''){
		$d=self::where(['id'=>$id])->find();
		$d=$d->getData();
		$d['commentNum']=db('comment')->where(['article_id'=>$id])->count();
		$d['m_cate']=Nav::where(['id'=>$d['cate']])->value('pid');
		$d['isFav']=db('fav')->where(['article_id'=>$id,'user_id'=>Session::get('uid','index')])->value('id');
		$d['create_time']=date("Y-m-d",$d['create_time']);
		if($d['update_time']){
			$d['update_time']=date("Y-m-d",$d['update_time']);
		}
		if(!$d['is_qiniu']){
			if($d['thumb']){
				$d['thumb']=Request::instance()->root().'/public/uploads/'.$v['thumb'];
			}
			
		} else {
			if(strpos($d['thumb'],'http://')){
				$d['thumb']=$d['thumb'];
			} else{
				$d['thumb']='http://'.$d['thumb'];
			}
			
		}
		return $d;
	}
	
	 // 定义关联方法
    public function getNavName()
    {
        // 用户HAS ONE档案关联
		if($this->hasOne('Nav','id','cate')){
			return $this->hasOne('Nav','id','cate');
		} else {
			return false;
		}
    }
	
	
}