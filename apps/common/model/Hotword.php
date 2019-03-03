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

class Hotword extends Model {
	
	
	
	public function getHotword($type = '',$pagenum = 0,$order = 'id desc'){
		if($type){
			$where['type']=$type;
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
		
		$controller='';
		foreach($d as $k=>$v){
			$arr=$v->toArray();
			switch($arr['type']){
				case 1:
					$controller='product';
				break;
				case 2:
					$controller='news';
				break;
				case 4:
					$controller='score';
				break;
			}
			
			$d[$k]['url']=url('index/'.$controller.'/search',array('keywords'=>urlencode($v['keyword'])));
		}
		$datas['data']=$d;
		return $datas;
	}
	
}