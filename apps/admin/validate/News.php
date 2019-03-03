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

class News extends Validate
{
	
	
    // 验证规则
    protected $rule = [
        ['title', 'require|min:3', '未填写新闻标题|新闻标题不能短于3个字符'],
        ['cate', 'require', '请选择所属栏目'],
		['content', 'require', '请填写新闻内容'],
		['sort', 'require|number', '排序不能为空|排序必须为数字'],
    ];

     
}
