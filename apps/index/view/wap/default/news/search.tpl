<!DOCTYPE html> 
<html>
<head>
	<title>{$config.site_name}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=device-dpi" />
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<link rel="stylesheet" type="text/css" href="__WAP__/css/common.css" />
	<link rel="stylesheet" type="text/css" href="__WAP__/css/news.css" />
	<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="__WAP__/js/common.js"></script>
<script>
$(function(){
	$("#news-box:nth-child(2n)").css('margin-right','0');
});
</script>
</head>

<body>

{include file="public/head" /}

<section>
	
	<div class="news-box">
		<div class="title">
			<div class="txt">搜索列表</div>
			
		</div>
		<div class="news">
			<ul>
				
				{Leesun:news name='nv' pid='$Request.param.id' num='0' sort='create_time desc' page='1'}
				<li>
					{if ($nv.thumb)}[图]{/if}<a href="{$nv.url}">{$nv.title|mb_substr=0,15,'utf-8'}</a>&nbsp;{$nv.create_time|mb_substr=0,10,'utf-8'}
				</li>
				{/Leesun:news}
				<div class="clear"></div>
			</ul>
		</div>
	</div>
	
	
	<div class="page">
		{$page}
		<div class="clear"></div>
	</div>
</section>
{include file="public/foot" /}

</body>
</html>
