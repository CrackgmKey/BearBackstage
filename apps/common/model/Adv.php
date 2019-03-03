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

class Adv extends Model {
	
	public function getAdv($pid = '',$pagenum = 0,$order = 'sort asc',$num=''){
		if($pid){
			$where['cate']=$pid;
		}
		
		if(!$pid){
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
			if(!$v['is_qiniu']){
				if($v['pic']){
					$d[$k]['pic']=Request::instance()->root().'/public/uploads/'.$v['pic'];
				}
				
			} else {
				if(strpos($v['pic'],'http://')){
					$d[$k]['pic']=$v['pic'];
				} else{
					$d[$k]['pic']='http://'.$v['pic'];
				}
				
			}
		}
		
		$datas['data']=$d;
		return $datas;
	}
	 // 定义关联方法
    public function getCateName()
    {
        // 用户HAS ONE档案关联
		if($this->hasOne('app\admin\model\Acate','id','cate')){
			return $this->hasOne('app\admin\model\Acate','id','cate');
		} else {
			return false;
		}
    }
}