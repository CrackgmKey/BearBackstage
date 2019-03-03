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
<link href="__ROOT____INDEX__/css/jquery.Jcrop.css" type="text/css" rel="Stylesheet" media="screen">
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/common.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/layout.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/user.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.Jcrop.min.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jQuery.UtrialAvatarCutter.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>


</head>

<body>
{include file="public/header" /}
<div class="web_body">
	
	{include file="user/left" /}
	<div class="right">
		
		<div class="box">
			<div class="title-box">
				<div class="tit">编辑头像</div>
				<div class="icon"></div>
			</div>
		</div>
		
		<div class="box">
			<div id="picture_original" class="img">
				<img src="__ROOT____UPLOADS__/{$userInfo.photo}" id="img"  />
			</div>
			<div class="left">
				<div id="picture_140"></div>
				<div id="save_btn">确定</div>
			</div>
		</div>
		<input type="hidden" id="photo" value="{$userInfo.photo}">
		
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>
{include file="public/footer" /}
<script type="text/javascript">



var cutter = new jQuery.UtrialAvatarCutter(
	{
		//主图片所在容器ID
		content : "picture_original",
		
		//缩略图配置,ID:所在容器ID;width,height:缩略图大小
		purviews : [{id:"picture_140",width:140,height:140},{id:"picture_50",width:50,height:50},{id:"picture_30",width:30,height:30}],
		
		//选择器默认大小
		selector : {width:140,height:140},
		cropattrs : {boxWidth: 700, boxHeight: 700}
	}
);
$(window).load(function(){
	cutter.init();
	
	//确定按钮动作
	$("#save_btn").click(
		function(){
			var datas = cutter.submit();
			var photo=$("#photo").val();
			$.getJSON("{:url('index/user/modLogo')}", {x: datas.x, y: datas.y, w: datas.w, h: datas.h, src: photo}, function(data) {
				if(data=='1'){
					layui.use(['layer'], function(){
						layer.msg('编辑成功', {time: 3000, icon:1,anim: 2});
					});
					
				} else {
					layui.use(['layer'], function(){
						layer.msg('编辑失败', {time: 3000, icon:2,anim: 2});
					});
				}
				
			});
			
			return false;
		}
	);
	
});
</script>
</body>
</html>
