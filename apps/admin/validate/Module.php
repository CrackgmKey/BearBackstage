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

class Module extends Validate
{
	
	
    // 验证规则
    protected $rule = [
        ['name', 'require|chs', '未填写分组名称|分组名称只能为汉字'],
        ['classname', 'require|alpha', '请填写分类名称|分类名称只能为半角字母'],
		['type', 'require', '请选择模块类型'],
		['sort', 'require|number', '请填写模块排序|排序只能为数字'],
    ];

     
}
