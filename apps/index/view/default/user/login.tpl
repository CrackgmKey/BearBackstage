<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=7">
<title>{$config.site_name}</title>
<meta name="keywords" content="{$config.key_word}" />
<meta name="description" content="{$config.description}" />
<meta name="author" content="乐尚商城" />
<meta name="copyright" content="leesuntech.com" />

<link rel="shortcut icon" href="__ROOT____UPLOADS__/{$config.favicon}" />

<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/common.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/layout.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/user.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script>
$(function(){
	$("#user_name").focus(function(){
		$(this).val("");
	});
	
	$("#captcha_img").on("click",function(){
		var ts = Date.parse(new Date())/1000;
		$(this).attr("src",'{:url("index/user/getCaptcha")}');
	})
	
	
	function login(){
		var user_name=$("#user_name").val();
		var password=$("#password").val();
		var captcha=$("#captcha").val();
		
		$.post("{Leesun:url name='login' /}",{user_name:user_name,password:password,captcha:captcha},function(d){
				
			var ts = Date.parse(new Date())/1000;
			$("#captcha_img").attr("src",'{:url("index/user/getCaptcha","seed='+ts+'")}');
			if(d=='1'){
				 layui.use(['layer'], function(){
					var index=layer.alert('恭喜您登陆成功', {
					  skin: 'layui-layer-molv'
					   ,closeBtn: 0
					   ,anim: 1 //动画类型
					   ,yes: function(layero){
						layer.close(index);
						window.location.href="{Leesun:url name='user' /}";
					  }
					});
				});
				
				
			} else if(d=='2'){
				layui.use(['layer'], function(){
					layer.msg('验证码错误', {time: 3000, icon:2});
				});
			} else if(d=='3'){
				layui.use(['layer'], function(){
					layer.msg('用户名或密码错误', {time: 3000, icon:2,anim: 2});
				});
			}else{
				layui.use(['layer'], function(){
					for(x in d){
						layer.tips(d[x], '#'+x,{tips: [2,'#8E0000'],tipsMore: true});
					}
					
				});
			}
		})
	}
	$("#logBut").on("click",function(){
		login();
	})
	
	document.onkeydown = function(e){ 
    var ev = document.all ? window.event : e;
    if(ev.keyCode==13) {

         login();

     }
	}	
	
});
</script>
</head>

<body>
{include file="public/header" /}

<div class="login-bg">
	<div class="web_body">
		<div class="left">
			<div class="logo"></div>
		</div>
		<div class="right">
			<div class="log-box">
				<div class="tit">
					<ul>
						<li style="background:#464b54;color:#fff">会</li>
						<li style="background:#fffeb3;color:#5e5e5e">员</li>
						<li style="background:#9f0000;color:#fff">登</li>
						<li style="background:#b3f0ff;color:#5e5e5e">陆</li>
					</ul>
				</div>
				<form enctype="multipart/form-data" name="form1" id="log_form" action="{Leesun:url name='login' /}" method="post">
				<div class="inp">
					<ul>
						<li>
							<div class="input-box">
								<div class="icon_1"></div>
								<div class="input"><input type="text" name="user_name" id="user_name" placeholder="邮箱/用户名"/></div>
							</div>
						</li>
						<li>
							<div class="input-box">
								<div class="icon_2"></div>
								<div class="input"><input type="password" name="password" id="password" /></div>
							</div>
						</li>
						<li>
							<div class="input-box" style="float:left;width:160px;">
								<div class="icon_2"></div>
								<div class="input" style="width:100px"><input type="text" name="captcha" id="captcha" style="width:100px" /></div>
							</div>
							<div class="img" ><img id="captcha_img" src="{:url('index/user/getCaptcha')}"></div>
							<div class="clear"></div>
						</li>
						<li>
							<div class="input-but" id="logBut">
								登陆
							</div>
						</li>
						<li class="dgrey_l"><a href="{Leesun:url name='getPass' /}">忘记密码?</a></li>
					</ul>
				</div>
				</form>
			</div>
		</div>
		<div class="clear"></div>
	</div>
</div>

{include file="public/footer" /}


</body>
</html>
