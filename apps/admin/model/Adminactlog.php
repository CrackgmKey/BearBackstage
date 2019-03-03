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

namespace app\admin\model;

use think\Model;
use think\Session;


class Adminactlog extends Model {
	
	protected $type       = [
        'act_time' => 'timestamp:Y-m-d H:i:s',
    ];
	
	public function addLog($data = ''){
		$data['act_time']=time();
		$this->data=$data;
		$res=$this->save();
	}
	
}