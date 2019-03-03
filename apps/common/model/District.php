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

class District extends Model {
	
	
	public function getDistrict($map = '',$pagenum = 0,$order = 'sort asc'){
		
		if(!is_null($map['id'])){
			unset($map['pid']);
			$datas=self::get($map['id']);
			return $datas;
		}  elseif(!is_null($map['pid'])){
			unset($map['id']);
			if($pagenum){
				$d=self::where($map)->order($order)->paginate($pagenum);
				$page = $d->render();
				$datas['page']=$page;
			} else {
				$d=self::where($map)->order($order)->select();
				
			}
			
			$datas['data']=$d;
			return $datas;
		} 
		
	}
	
	
}