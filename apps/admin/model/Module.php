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


class Module extends Model {
	
	protected function getTypeAttr($v){
        $type_cn = [1 => '普通商品', 2 => '新闻资讯', 4 => '积分商品'];
        return $type_cn[$v];
    }
}