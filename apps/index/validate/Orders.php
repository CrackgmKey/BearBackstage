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
namespace app\index\Validate;

use think\Validate;

class Orders extends Validate
{
	
	
    // 验证规则
    protected $rule = [
        ['sdistrict', 'require', '请选择地区'],
        ['address', 'require', '请填写收货地址'],
		['name', 'require|chs', '请填写姓名|姓名须为中文'],
		['tel', 'require', '未填写联系电话'],
    ];
	protected $batch = true;
	
    
	
	
}
