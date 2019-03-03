<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=7">
<title>{$config.site_name}</title>
<meta name="keywords" content="{$config.key_word}" />
<meta name="description" content="{$config.description}" />
<meta name="author" content="" />
<meta name="copyright" content="leesuntech.com" />
<link rel="shortcut icon" href="__ROOT____UPLOADS__/{$config.favicon}" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/common.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/pay.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>

<script>
$(function(){
	
	
	$("#close").click(function(){
		//closeWindows();
		window.location.href="{:url('index/user/index')}";
	})
	
});

function closeWindows() {
	var userAgent = navigator.userAgent;
	if (userAgent.indexOf("Firefox") != -1
	|| userAgent.indexOf("Chrome") != -1) {
	close();//直接调用JQUERY close方法关闭
	} else {
	window.opener = null;
	window.open("", "_self");
	window.close();
}
};
</script>
</head>

<body>
{include file="public/header" /}
<div class="success_box">
	<div class="icon"></div>
	<div class="title">您已成功支付&yen;{$data.total_amount}</div>
	<div class="sn">订单号：{$data.out_trade_no}</div>
	<div class="btn"><button class="layui-btn layui-btn-lg layui-btn-normal" style="width:200px;" id="close">返回会员中心</button></div>
</div>

{include file="public/footer" /}
</body>
</html>
