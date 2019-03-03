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


class Config extends Model {
	
	
	 protected function getWaterPositionAttr($v){
        $water_position = [0 => '随机位置', 1 => '顶端居左', 2 => '顶端居中', 3 => '顶端居右', 4 => '中部居左', 5 => '中部居中', 6 => '中部居右', 7 => '底端居左', 8 => '底端居中', 9 => '底端居右'];
        return $water_position[$v];
     }
	
	
}