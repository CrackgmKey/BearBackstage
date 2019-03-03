<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
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
<link href="__ROOT____INDEX__/css/lottery.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jQueryRotate.2.2.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script>
$(function(){
	$(".userlist-box ul li:odd").css({"background":"#f4f4f4"});
	
	  
	  $(".del").click(function(){
		 if(confirm("确定要删除吗")){
			 var id=$(this).attr("id");
			 
		 }else{
			 return false;
		 }
	});
});
</script>
</head>

<body>
{include file="public/header" /}
<div class="web_body">
	
	{include file="user/left" /}
	<div class="right">
		
		<div class="box">
			<div class="title-box">
				<div class="tit">我的中奖信息</div>
				<div class="icon"></div>
			</div>
		</div>
		
		
		
		<div class="box">
			<div class="userlist-box">
				<ul>
					
					{Leesun:lotterywin name='v' pid='1' uid='$uid' page='1'}
					<li>
						<span style="width:550px" >奖项名称：<label class="red">{$v.item_name}</label></span>
						<span style="width:350px">中奖时间：{$v.create_time}</span>
						<div class="clear"></div>
					</li>
					{/Leesun:lotterywin}
					<div class="clear"></div>
					
				</ul>
			</div>
		</div>
		
		<div class="box">
			<div class="page">{$page}</div>
		</div>
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>
{include file="public/footer" /}


</body>
</html>
