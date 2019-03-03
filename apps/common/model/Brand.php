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

class Brand extends Model {
	
	
	public function getBrand($pid = '',$pagenum = 0,$order = 'sort asc',$num = '',$id = ''){
		if($pid){
			$where['cate_id']=$pid;
		} else {
			$where='';
		}
		if($pagenum){
			$d=self::where($where)->order($order)->limit($num)->paginate($pagenum);
			$page = $d->render();
			$datas['page']=$page;
		} else {
			$d=self::where($where)->order($order)->limit($num)->select();
			
		}
		
		foreach($d as $k=>$v){
			$nav=Nav::get($v['cate_id']);
			if($nav){
				if(request()->param('sort')){
					$url=url('index/product/lists',array('id'=>$nav->id,'pid'=>$nav->pid,'mid'=>$nav->module_id,'brand'=>$v['id'],'sort'=>request()->param('sort')));
				} else {
					$url=url('index/product/lists',array('id'=>$nav->id,'pid'=>$nav->pid,'mid'=>$nav->module_id,'brand'=>$v['id']));
				}
				$d[$k]['url']=$url;
			} else {
				$d[$k]['url']='';
			}
			
			if($id==$v['id']){
				$d[$k]['selected']=true;
			} else {
				$d[$k]['selected']=false;
			}
			if(!$v['is_qiniu']){
				
				if($v['img']){
					$d[$k]['img']=Request::instance()->root().'/public/uploads/'.$v['img'];
				}
			} else {
				if(strpos($v['img'],'http://')){
					$d[$k]['img']=$v['img'];
				} else{
					$d[$k]['img']='http://'.$v['img'];
				}
				
			}
		}
		$datas['data']=$d;
		return $datas;
	}
	 // 定义关联方法
    public function getNavName()
    {
        // 用户HAS ONE档案关联
		if($this->hasOne('Nav','id','cate_id')){
			return $this->hasOne('Nav','id','cate_id');
		} else {
			return false;
		}
    }
	
}