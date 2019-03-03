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
	
	{include file="news/left" /}
	<div class="right">
		<div class="box">
			<div class="banner">
				{Leesun:adv name='v' pid='26' num='1'}
				<a target="_blank" href="{$v.go}"><img  src="{$v.pic}" class="img" ></a>
				{/Leesun:adv}
			</div>
		</div>
		
		
		{Leesun:nav name='v' pid='$Request.param.id'}
		<div class="box" >
			<div class="news-box" id="news-box">
				<div class="tit"><h1>{$v.name}</h1><div class="more"><a href="{$v.url}">更多+</a></div></div>
				<div class="list">
					
					<ul class="dgrey_l">
						
						{Leesun:news name='nv' pid='$v.id' num='8' sort='create_time desc'}
						<li>
							{if ($nv.thumb)}[图]{/if}<a href="{$nv.url}">{$nv.title|mb_substr=0,20,'utf-8'}</a>&nbsp;{$nv.create_time|mb_substr=0,10,'utf-8'}
						</li>
						{/Leesun:news}
						<div class="clear"></div>
					</ul>
				</div>
			</div>
		</div>
		{/Leesun:nav}
		
		
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>
{include file="public/footer" /}


</body>
</html>
