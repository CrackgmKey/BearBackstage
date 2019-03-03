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
<script type="text/javascript" src="__ROOT____COMMON__/js/jQuery.autoIMG.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script>
$(function(){
	$("#product-box ul li:nth-child(4n)").css('margin-right','0');
	$("#sort ul li").click(function(){
		var id=$(this).attr("id");
		var url="";
		window.location.href=url;
	})
	$("#brand ul li").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
	})
	$('.img').autoIMG();
});
</script>
</head>

<body>
{include file="public/header" /}
<div class="web_body">
	
	{include file="product/left" /}
	<div class="left" style="margin-left:12px;">
		
		
		
		<div class="box">
			<div class="product-box" id="product-box">
				<div class="tit"><h1>搜索商品</h1></div>
				<div class="list">
					<ul>
						{Leesun:product name='pv'  page='1'}
						<li>
							<div class="img"><a href="{$pv.url}">{if condition="$pv.thumb"}<img src="__ROOT____UPLOADS__/{$pv.thumb}" onload='AutoResizeImage(208,159,this)'/>{else}<img src="__ROOT____INDEX__/images/no-pic.jpg" class="img"/>{/if}</a></div>
							<div class="name dgrey_l"><a href="{$pv.url}">{$pv.name}</a></div>
							<div class="price"><span class="red">&yen;{$pv.current_price}</span>&nbsp;&nbsp;&nbsp;<span class="grey" style="text-decoration:line-through">&yen;{$pv.origin_price}</span></div>
						</li>
						{/Leesun:product}
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
