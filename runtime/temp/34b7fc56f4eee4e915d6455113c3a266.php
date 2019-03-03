<?php if (!defined('THINK_PATH')) exit(); /*a:1:{s:50:"D:\phpStudy\WWW\yg/apps/admin\view\login\index.tpl";i:1529587209;}*/ ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>后台登陆</title>

<link href="/yg/public/static/common/css/global.css" rel="stylesheet" type="text/css" />
<link href="/yg/public/static/admin/css/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/yg/public/static/common/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/yg/public/static/common/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="/yg/public/static/common/js/jquery.rotate.min.js"></script>
<script type="text/javascript">
if (window != top)     
top.location.href = location.href; 

$(document).ready(function() {
	var rotation2 = function (){
	   $("#logo").rotate({
		  angle:0, 
		  animateTo:360, 
		  duration: 6000,
		  callback: rotation2,
		  easing: function (x,t,b,c,d){        // t: current time, b: begInnIng value, c: change In value, d: duration
			  return c*(t/d)+b;
		  }
	   });
	}
	rotation2();
	
	$("#captcha").on("click",function(){
		var ts = Date.parse(new Date())/1000;
		
		$(this).attr("src",'<?php echo url("admin/login/getCaptcha","seed='+ts+'"); ?>');
	})
	
});

</script>
</head>
<body>

<form action="<?php echo url("admin/login/login"); ?>" enctype="multipart/form-data" name="form1" method='post'>
<div id="log-box">
	<div class="top-box">
		<div class="logo"><img src="/yg/public/static/admin/images/logo.png" id="logo"></div>
		<div class="title">
			
			<h1 style="margin-right:80px;">乐尚商城</h1>
			<h1>管理登录</h1>
			<div class="clear"></div>
		</div>
	</div>
	<div class="body-box">
		<div class="input-bar">
			<div class="user"><input type="text" name="adm_name" class="input" placeholder="Username"/></div>
		</div>
		<div class="input-bar">
			<div class="pass"><input type="password" name="adm_password" class="input" placeholder="Password"/></div>
		</div>
		<div class="vcode-box">
			<div class="v-input-h">
				<div class="vcode"><input type="text" name="code" class="input" onkeyup="if (this.value != this.value.toUpperCase())
this.value=this.value.toUpperCase();" style="width:150px;"></div>
			</div>
			<div class="v-input-b"></div>
			<div class="v-img"><img id="captcha" src="<?php echo url("admin/login/getCaptcha"); ?>"></div>
			<div class="clear"></div>
		</div>
		<div class="submit-box"><input type="submit" value="登&nbsp;&nbsp;&nbsp;陆" class="login-button"/></div>
	</div>
	<div class="bottom-box"></div>
</div>
</form>
</body>
</html>