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

class Lottery extends Validate
{
	
	
    // 验证规则
    protected $rule = [
        ['name', 'require', '未填写抽奖名称'],
		['total', 'require|number', '请选择所属栏目|奖品数量必须为数字'],
		['category', 'require', '请选择抽奖类型'],
    ];
	
	protected $batch=false;
     
}
