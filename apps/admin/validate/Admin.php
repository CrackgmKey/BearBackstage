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

class Admin extends Validate
{
	
	
    // 验证规则
    protected $rule = [
        ['adm_name', 'require|min:5|unique:admin', '未填写管理员名称|管理员名称不能短于5个字符|管理员名称已存在'],
        ['group_id', 'require', '请选择管理员分组'],
		['adm_password', 'require|length:6,16|confirm:password_confirm', '请填写密码|密码长度为6－16位|两次输入密码不一致'],
		
    ];

     
}
