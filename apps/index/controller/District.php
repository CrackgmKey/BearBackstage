<?php
// +----------------------------------------------------------------------
// | Leesuntech [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.leesuntech.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 李文 <15919572@qq.com>
// +----------------------------------------------------------------------

namespace app\index\controller;
use app\index\controller\IndexBase;
use app\common\model\District as DistrictModel;
use app\admin\model\User;
use think\Session;

class District extends IndexBase
{
	function ajaxDistrict($id=''){
		
		$sdistrict=DistrictModel::all(['pid'=>$id]);
		
		foreach($sdistrict as $k=>$v){
			$target[$v['id']]=$v['district_name'];
		}
		return json($target);
	}
}
