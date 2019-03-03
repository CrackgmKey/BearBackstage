<!DOCTYPE html> 
<html>
<head>
	<title>{$config.site_name}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=device-dpi" />
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<link rel="stylesheet" type="text/css" href="__WAP__/css/common.css" />
	<link rel="stylesheet" type="text/css" href="__WAP__/css/product.css" />
	<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="__WAP__/js/common.js"></script>
	<script>
		
		$(document).ready(function(){
			
			$(".product ul li:nth-child(2n)").css({"border-right":"0"});
		});
	</script>
</head>
<body>

{include file="public/head" /}

<section>
	{Leesun:nav name='v' pid='$Request.param.id'}
	<div class="product-box">
		<div class="title">
			<div class="txt">{$v.name}</div>
			<div class="more" url="{$v.url}">更多</div>
		</div>
		<div class="product">
			<ul>
				{Leesun:product name='pv' pid='$v.id' num='4' sort='add_time desc'}
				<li class="url" url="{$pv.url}>">
					<div class="img">{if condition="$pv.thumb"}<img src="__ROOT____UPLOADS__/{$pv.thumb}" />{else}<img src="__WAP__/images/no-pic.jpg" class="img"/>{/if}
					<div class="name">{$pv.name|mb_substr=0,15,'utf-8'}</div>
					<div class="price">&yen;{$pv.current_price}</div>
				</li>
				{/Leesun:product}
				<div class="clear"></div>
			</ul>
		</div>
	</div>
	{/Leesun:nav}
	
</section>
{include file="public/foot" /}

</body>
</html>