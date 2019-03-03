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
	$("#product-box ul li:nth-child(4n)").css('margin-right','0');
});
</script>
</head>

<body>
{include file="public/header" /}
<div class="web_body">
	{include file="score/left" /}
	<div class="right">
		<div class="box">
			<div class="banner">
				{Leesun:adv name='v' pid='26' num='1'}
				<a target="_blank" href="{$v.url}"><img  src="__ROOT____UPLOADS__/{$v.pic}" class="img" ></a>
				{/Leesun:adv}
			</div>
		</div>
		
		{Leesun:nav name='v' pid='$Request.param.id'}
		<div class="box">
			<div class="product-box" id="product-box">
				<div class="tit"><h1>{$v.name}</h1><div class="more"><a href="{$v.url}">更多+</a></div></div>
				<div class="list">
					<ul>
						
						{Leesun:product name='pv' pid='$v.id' num='4' type='4' sort='add_time desc'}
						<li>
							<div class="img"><a href="{$pv.url}">{if condition="$pv.thumb"}<img src="__ROOT____UPLOADS__/{$pv.thumb}" id="pimg_{$pv.id}" onload="DrawImg(this.id, 208,159)"/>{else}<img src="__ROOT____INDEX__/images/no-pic.jpg" class="img"/>{/if}</a></div>
							<div class="name dgrey_l"><a href="{$pv.url}">{$pv.name}</a></div>
							<div class="price"><span class="red">{$pv.symbol}:{$pv.origin_price}</span>&nbsp;&nbsp;&nbsp;<span class="grey" style="text-decoration:line-through">{$pv.symbol}:{$pv.current_price}</span></div>
						</li>
						{/Leesun:product}
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
