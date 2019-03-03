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

class ModUser extends Validate
{
	
	
    // 验证规则
    protected $rule = [
        ['user_name', 'requireWith:user_name|min:5|unique:user', '|会员名称不能短于5个字符|名称已注册'],
		['password', 'requireWith:password|length:6,16', '|密码长度为6－16位'],
		['email', 'email|unique:user', '邮箱格式不正确|邮箱已注册'],
		['phone', 'requireWith:phone|checkMobile', '|手机号码格式不正确'],
		
    ];
	protected $batch = true;
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
