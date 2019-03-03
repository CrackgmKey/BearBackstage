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

class Hotword extends Validate
{
	
	
    // 验证规则
    protected $rule = [
        ['keyword', 'require', '未填写关键字名称'],
		['type', 'require', '请选择所属栏目'],
		['times', 'number', '搜索次数必须为数字'],
    ];
	
	protected $batch=false;
     
}
