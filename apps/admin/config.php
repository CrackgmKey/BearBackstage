<?php
//配置文件
return [
	'captcha'  => [
		// 字体大小
		'fontSize' => 20,
		// 验证码长度（位数）
		'length'   => 3,
		'imageH' => 48,
		'imageW' => 115,
	],
	'view_replace_str'       => [
       '__COMMON__' => '/public/static/common',
       '__ADMIN__' => '/public/static/admin',
	   '__UPLOADS__' => '/public/uploads',
	   '__PUBLIC__' => '/public',
    ],
	'dispatch_success_tmpl'  => APP_PATH . 'admin' . DS . 'view/public/dispatch.tpl',
    'dispatch_error_tmpl'    => APP_PATH . 'admin' . DS . 'view/public/dispatch.tpl',
	'pathinfo_depr' => '/',
];