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
namespace app\admin\Validate;

use think\Validate;

class Brand extends Validate
{
	
	
    // 验证规则
    protected $rule = [
        ['name', 'require|min:4', '未填写品牌名称|品牌名称不能短于2个字'],
        ['cate_id', 'require', '请选择所属栏目'],
		['sort', 'require|number', '排序不能为空|排序必须为数字'],
    ];

     
}
