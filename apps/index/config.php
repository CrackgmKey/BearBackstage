<?php
//配置文件
if (request()->isMobile()) {
	$is_wap='wap/';
} else {
	$is_wap='';
}
return [
	'captcha'  => [
		// 字体大小
		'fontSize' => 20,
		// 验证码长度（位数）
		'length'   => 3,
		'imageH' => 41,
		'imageW' => 130,
	],
	'view_replace_str'       => [
       '__COMMON__' => '/public/static/common',
       '__INDEX__' => '/public/static/index/'.config('index_theme'),
	   '__WAP__' => request()->root().'/public/static/wap/'.config('index_theme'),
	   '__UPLOADS__' => '/public/uploads',
	   '__PUBLIC__' => '/public',
    ],
	
	 'template'               => [
        // 模板引擎类型 支持 php think 支持扩展
		'view_suffix'  => 'tpl',
		'taglib_pre_load'     =>    'app\common\taglib\Leesun',
        'view_path'    => APP_PATH . request()->module() . '/view/'.config('index_theme').'/',
    ],
	'http_exception_template'    =>  [
		// 定义404错误的重定向页面地址
		404 =>  APP_PATH . 'index' . DS . 'view/'.config('index_theme').'/public/404.tpl',
		// 还可以定义其它的HTTP status
		401 =>  APP_PATH . 'index' . DS . 'view/'.config('index_theme').'/public/401.tpl',
	],
	'dispatch_success_tmpl'  => APP_PATH . 'index' . DS . 'view/'.$is_wap.config('index_theme').'/public/dispatch.tpl',
    'dispatch_error_tmpl'    => APP_PATH . 'index' . DS . 'view/'.$is_wap.config('index_theme').'/public/dispatch.tpl',
	
];