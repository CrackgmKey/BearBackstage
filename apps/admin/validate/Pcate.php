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

class Pcate extends Validate
{
	
	
    // 验证规则
    protected $rule = [
        ['name', 'require', '未填写单页名称'],
        ['content', 'require', '请填写单页内容'],
		['sort', 'require|number', '请选择所属栏目|排序必须是数字'],
		
    ];

     
}
