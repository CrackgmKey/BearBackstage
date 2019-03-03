<!DOCTYPE html> 
<html>
<head>
	<title>{$config.site_name}-会员登陆</title>
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
			$("#logBut").on("click",function(){
				var username=$("#username_log").val();
				var password=$("#password_log").val();
				if(username!='' && password!=''){
					$.post("{Leesun:url name='ajaxLogin' /}",{user_name:username,password:password},function(d){
						if(d=='1'){
							window.location.href="{Leesun:url name='user' /}";
						} else if(d=='3'){
							layer.open({
								content: '用户名或密码错误'
								,skin: 'footer'
							  });
						} else {
							var msg='';
							for(x in d){
								msg+=d[x];
							}
							layer.open({
								content: msg
								,skin: 'msg'
								,time: 2 //2秒后自动关闭
							  });
						}
					},'json')
				} else {
					layer.open({
						content: '请填写账号，密码'
						,skin: 'footer'
					  });
				}
				
			})
		  
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
				<div class="input"><input type="text" name="username" id="username_log" placeholder="邮箱 或 用户名"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="t">密码：</div>
				<div class="input"><input type="password" name="password" id="password_log"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="t"></div>
				<div class="input"><input type="submit" value="提交" class="but" id="logBut" style="background:#ff0000;color:#fff;border:0;"></div>
			</li>
		</ul>
	</div>
	
</section>
{include file="public/foot" /}

</body>
</html>