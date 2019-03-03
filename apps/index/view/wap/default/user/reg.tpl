<!DOCTYPE html> 
<html>
<head>
	<title>{$config.site_name}-会员注册</title>
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
			
		  
		});
	</script>
</head>
<body>

{include file="public/head" /}
<section>
	<div class="logo" style="background:url(__ROOT____UPLOADS__/{$config.logo}) center center no-repeat;"></div>
	
	<div class="input-box">
		<ul>
			<li>
				<div class="t">用户名：</div>
				<div class="input"><input type="text" class="input_box" id="user_name" name="user_name" placeholder="用户名须为4-16位的中英文字母"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="t">密码：</div>
				<div class="input"><input type="password" name="password" id="password"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="t">确认密码：</div>
				<div class="input"><input type="password" name="confirm_pass" id="confirm_pass"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="t">签名：</div>
				<div class="input"><input type="text" name="signature" id="signature"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="t">邮箱：</div>
				<div class="input"><input type="text" name="email" id="email"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="t">电话：</div>
				<div class="input"><input type="text" name="phone" id="phone"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="t">地址：</div>
				<div class="input"><input type="text" name="address" id="address"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="t"></div>
				<div class="input"><input type="submit" value="注册" class="but" id="regBut" style="background:#ff0000;color:#fff;border:0;"></div>
			</li>
		</ul>
		<div class="clear"></div>
	</div>
	
</section>
{include file="public/foot" /}

</body>
</html>