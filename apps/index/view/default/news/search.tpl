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
	$("#news-box:nth-child(2n)").css('margin-right','0');
});
</script>
</head>

<body>
{include file="public/header" /}
<div class="web_body">
	
	<div class="left">
		
		<div class="box">
		<div class="rec-box">
			<div class="tit">最热新闻</div>
			<div class="con">
				<ul class="dgrey_l" style="font-size:14px;color:#666">
					{Leesun:news name='v' num='8' sort='click desc'}
					<li style="list-style-type:decimal;list-style-position:inside;">
						<a href="{$v.url}">{$v.title}</a>
					</li>
					{/Leesun:news}
				</ul>
			</div>
		</div>
	</div><!-- end of box -->
	</div><!-- end of left -->
	
	<div class="right">
		<div class="box">
			<div class="banner">
				{Leesun:adv name='v' pid='26' num='1'}
				<a target="_blank" href="{$v.url}"><img  src="__ROOT____UPLOADS__/{$v.pic}" class="img" ></a>
				{/Leesun:adv}
			</div>
		</div>
		
		
		<div class="box" >
			<div class="news-box" id="news-box">
				<div class="tit"><h1>搜索列表</h1></div>
				<div class="lists">
					
					<ul class="dgrey_l">
						{Leesun:news name='v' pid='$Request.param.id' num='0' sort='create_time desc' page='1'}
						<li>
							<div class="m">{if ($v.thumb)}[图]{/if}<a href="{$v.url}">{$v.title}</a>&nbsp;{$v.create_time|mb_substr=0,10,'utf-8'}&nbsp;&nbsp;[评论:{$v.commentNum}]</div>
							<div class="s">简介:{$v.description}</div>
						</li>
						{/Leesun:news}
						<div class="clear"></div>
					</ul>
				</div>
			</div>
		</div>
		<div class="page">
			{$page}
			<div class="clear"></div>
		</div>
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>
{include file="public/footer" /}


</body>
</html>
