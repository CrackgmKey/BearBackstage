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

class Link extends Validate
{
	
	
    // 验证规则
    protected $rule = [
        ['name', 'require', '未填写链接名称'],
		['url', 'require|url', '请填写链接地址|请填写正确的链接'],
		['sort', 'require|number', '排序不能为空|排序必须为数字'],
    ];

     
}
