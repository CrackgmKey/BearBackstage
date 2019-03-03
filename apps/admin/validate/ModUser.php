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

class ModUser extends Validate
{
	
	
    // 验证规则
    protected $rule = [
        ['user_name', 'require|min:5|unique:user', '未填写会员名称|会员名称不能短于5个字符|名称已注册'],
        ['group_id', 'require', '请选择会员分组'],
		['email', 'requireWith:email|email|unique:user', '|邮箱格式不正确|邮箱已注册'],
		['phone', 'requireWith:phone|checkMobile', '|手机号码格式不正确'],
		['score', 'requireWith:score|number', '|积分必须为数字'],
		['account', 'requireWith:account|number', '|余额必须为数字'],
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
