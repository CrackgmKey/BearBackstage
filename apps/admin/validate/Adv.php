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

class Adv extends Validate
{
	
	
    // 验证规则
    protected $rule = [
        ['name', 'require', '未填写广告名称'],
        ['cate', 'require', '请选择所属分类'],
		['url', 'require', '请填写广告链接'],
		['sort', 'require|number', '排序不能为空|排序必须为数字'],
    ];

     
}
