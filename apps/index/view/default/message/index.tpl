<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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

$(document).ready(function(){
	
	
	$("#captcha_img").on("click",function(){
		var ts = Date.parse(new Date())/1000;
		$(this).attr("src",'{:url("index/user/getCaptcha")}');
	})
	function message(){
		var title=$("#title").val();
		var content=$("#content").val();
		var captcha=$("#captcha").val();
		
		$.post("{Leesun:url name='message_add' /}",{title:title,content:content,captcha:captcha},function(d){
				
			var ts = Date.parse(new Date())/1000;
			$("#captcha_img").attr("src",'{:url("index/user/getCaptcha")}');
			if(d=='1'){
				 layui.use(['layer'], function(){
					var index=layer.alert('恭喜您反馈成功！', {
					  skin: 'layui-layer-molv'
					   ,closeBtn: 0
					   ,anim: 1 //动画类型
					   ,yes: function(layero){
						layer.close(index);
						window.location.href="{Leesun:url name='message' /}";
					  }
					});
				});
				
				
			} else if(d=='2'){
				layui.use(['layer'], function(){
					layer.msg('验证码错误', {time: 3000, icon:2});
				});
			}  else if(d=='3'){
				layui.use(['layer'], function(){
					layer.msg('提交失败', {time: 3000, icon:2,anim: 2});
				});
			} else{
				layui.use(['layer'], function(){
					for(x in d){
						layer.tips(d[x], '#'+x,{tips: [2,'#8E0000'],tipsMore: true});
					}
					
				});
			}
		})
	}
	$("#add").on("click",function(){
		message();
	})
});

</script>
</head>

<body>
<body>
{include file="public/header" /}

<div class="web_body">
	<div class="agreement-box">
		<div class="tit">
			<ul>
				<li class="cur">意见反馈</li>
				
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="con">
			<form  id="add_form" action="{Leesun:url name='message_add' /}" method="post">
			<table width="650" border="0" cellspacing="0" cellpadding="10">
				  <tr>
					<td width="25%" align="right">标题：</td>
					<td width="75%"><input type="text" class="input_box" id="title" style="width:500px" name="title"   /></td>
				  </tr>
				 <tr>
					<td width="25%" align="right">内容：</td>
					<td width="75%"><textarea name="content" id="content" cols="30" rows="20" class="input_box" style="height:300px;width:500px" ></textarea></td>
				  </tr>
				 <tr>
					<td width="25%" align="right">验证码：</td>
					<td width="75%"><div class="left"><input type="text" class="input_box" id="captcha" name="captcha"  style="width:190px;"  /></div><div class="code"><img src="{:url('index/user/getCaptcha')}" id="captcha_img"></div></td>
				  </tr>
				  <tr>
					<td align="left"></td>
					<td><input type="button" class="sub_button" id="add"  value="提交"/></td>
				  </tr>
            </table>
		   </form>
		</div>
	</div>
</div>

{include file="public/footer" /}


</body>
</html>
