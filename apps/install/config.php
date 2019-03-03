<?php
//配置文件
return [
	'view_replace_str'       => [
	   '__ADMIN__' => '/public/static/admin',
	   '__COMMON__' => '/public/static/common',
	   '__PUBLIC__' => '/public/static',
    ],
	'dispatch_success_tmpl'  => APP_PATH . 'admin' . DS . 'view/public/dispatch.tpl',
    'dispatch_error_tmpl'    => APP_PATH . 'admin' . DS . 'view/public/dispatch.tpl'
];