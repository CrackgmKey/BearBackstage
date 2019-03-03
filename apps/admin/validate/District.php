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

class District extends Validate
{
	
	
    // 验证规则
    protected $rule = [
        ['district_name', 'require', '未填写地区名称'],
        ['pid', 'require', '请选择所属地区'],
		['sort', 'require|number', '排序不能为空|排序必须是数字'],
		
    ];

     
}
