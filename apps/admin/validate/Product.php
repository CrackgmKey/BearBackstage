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

class Product extends Validate
{
	
	
    // 验证规则
    protected $rule = [
        ['name', 'require', '未填写商品名称'],
        ['serial_no', 'alphaNum', '商品货号只能为字母或数字'],
		['cate_id', 'require', '请选择商品分类'],
		['origin_price', 'require|number', '请填写商品原价|价格必须为数字'],
		['current_price', 'require|number', '请填写商品现价|价格必须为数字'],
		['inventory', 'require|number', '请填写商品库存|库存必须为数字'],
		['delivery_fee', 'require|number', '请填写商品运费|运费必须为数字'],
		['brief', 'require', '请填写商品详情'],
		['specifications', 'require', '请填写规格详情'],
		['sort', 'require|number', '排序不能为空|排序必须为数字'],
    ];

     
}
