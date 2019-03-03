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

class Sms extends Validate
{
	
	
  
	// 验证规则
    protected $rule = [
        ['mobile', 'require', '请填写测试手机号码'],
        ['mobile', 'checkMobile', '手机号码格式不正确'],
        
    ];
	
	protected function checkMobile($value, $rule)
    {
        $result = preg_match('/^1[3|4|5|7|8][0-9]\d{4,8}' . $rule . '$/', $value);
        if (!$result) {
            return '手机号码格式不正确';
        } else {
            return true;
        }
    }
     
}
