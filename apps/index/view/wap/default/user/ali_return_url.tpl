<!DOCTYPE html> 
<html>
<head>
	<title>支付成功</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=device-dpi" />
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<link rel="stylesheet" type="text/css" href="__WAP__/css/common.css" />
	<link rel="stylesheet" type="text/css" href="__WAP__/css/user.css" />
	<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="__WAP__/js/common.js"></script>
	
	
	<script>
	
		$(document).ready(function(){
			$("#back").on('click',function(){
				window.location.href="{:url('index/user/index')}";
			})
		});
	</script>
</head>
<body>

{include file="public/head" /}
<section>
	
	<div class="success-box">
		
	</div>
	<div class="success-info">
		<div class="title">您已成功支付：&yen;{$data.total_amount}</div>
		<div class="sn">订单号：{$data.out_trade_no}</div>
		<div class="btn" id="back">返回会员中心</div>
	</div>
	
	<div class="clear"></div>
</section>

{include file="public/foot" /}

</body>
</html>