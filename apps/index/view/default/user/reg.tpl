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
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/unslider.min.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script>
$(function(){
	$(".agreement-box ul li:nth-child(3n)").css('margin-right','0');
	$("#button_1").click(function(){
		if($("#agreement").is(':checked')){
			$(".con_1").hide();
			$(".con_2").show();
			$(".tit ul li").removeClass('cur');
			$("#m2").addClass('cur');
		} else {
			layui.use(['layer'], function(){
				layer.msg('同意协议后再继续',{icon: 2});
			});
		}
	})
	
	$("#member_center").click(function(){
		window.location.href="{:url('index/user/index')}";
	})
	
	$("#regBut").on("click",function(){
		var user_name=$("#user_name").val();
		var password=$("#password").val();
		var confirm_pass=$("#confirm_pass").val();
		var signature=$("#signature").val();
		var email=$("#email").val();
		var phone=$("#phone").val();
		var address=$("#address").val();
		
		$.post("{:url('index/user/reg')}",{user_name:user_name,password:password,confirm_pass:confirm_pass,signature:signature,email:email,phone:phone,address:address},function(d){
				
				
			if(d=='1'){
				 /*layui.use(['layer'], function(){
					var index=layer.alert('恭喜您注册成功', {
					  skin: 'layui-layer-lan'
					   ,closeBtn: 0
					   ,anim: 1 //动画类型
					   ,yes: function(layero){
						layer.close(index);
						window.location.href="{:url('index/user/index')}";
					  }
					});
				});*/
				$(".con_1").hide();
				$(".con_2").hide();
				$(".con_3").show();
				$(".tit ul li").removeClass('cur');
				$("#m3").addClass('cur');
				$("#user_name_text").text(user_name);
				
			} else if(d=='2'){
				layui.use(['layer'], function(){
					layer.msg('注册失败', {time: 3000, icon:2});
				});
			} else{
				layui.use(['layer'], function(){
					for(x in d){
						layer.tips(d[x], '#'+x,{tips: [2,'#8E0000'],tipsMore: true});
					}
					
				});
			}
		})
	})
	
});
</script>
</head>

<body>
{include file="public/header" /}

<div class="web_body">
	<div class="agreement-box">
		<div class="tit">
			<ul>
				<li class="cur" id="m1">注册协议</li>
				<li id="m2">填写信息</li>
				<li id="m3">注册成功</li>
				<div class="clear"></div>
			</ul>
		</div>
		<div class="con con_1" >
			<div class="box dgrey_l">
				{$config.agreement}
			</div>
			<div class="box" style="color:orange">
				<label><input  type="checkbox" name="agreement" id="agreement" value="1" checked="checked">我已阅读并同意</label>
			</div>
			<div class="box">
				<div class="button" id="button_1">下一步</div>
			</div>
		</div>
		
		<div class="con con_2" style="display:none;">
			<form  id="reg_form" action="{:url('index/user/reg')}" method="post">
			<div class="reg-box">
				<ul>
					<li><span style="width:80px;">用户名：</span><span><input type="text" class="input_box" id="user_name" name="user_name" /></span></li>
					<li><span style="width:80px;">密码：</span><span><input type="password" class="input_box" name="password" id="password" /></span></li>
					<li><span style="width:80px;">确认密码：</span><span><input type="password" class="input_box" name="confirm_pass" id="confirm_pass" /></span></li>
					<li><span style="width:80px;">签名：</span><span><input type="text" class="input_box" name="signature" id="signature"/></span></li>
					<li><span style="width:80px;">邮箱：</span><span><input type="text" class="input_box" name="email" id="email"/></span></li>
					<li><span style="width:80px;">手机：</span><span><input type="text" class="input_box" name="phone" id="phone"/></span></li>
					<li><span style="width:80px;">地址：</span><span><input type="text" class="input_box" name="address" id="address" /></span></li>
					<li><span style="margin-left:90px;"><input type="button" id="regBut" class="sub_button"  value="注 册" /></span></li>
				</ul>
			</div>
			
		   </form>
		</div>
		
		<div class="con con_3" style="display:none;">
			<div class="box">
				<div class="success">
					尊敬的<span id="user_name_text"></span>，您已成功注册成为会员!
				</div>
			</div>
			<div class="box">
				<div class="button" id="member_center">进入会员中心</div>
			</div>
		</div>
		
	</div>
</div>

{include file="public/footer" /}


</body>
</html>
