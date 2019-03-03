<!DOCTYPE html> 
<html>
<head>
	<title>{$config.site_name}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=device-dpi" />
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<link rel="stylesheet" type="text/css" href="__WAP__/css/slick.css" />
	<link rel="stylesheet" type="text/css" href="__WAP__/css/common.css" />
	<link rel="stylesheet" type="text/css" href="__WAP__/css/index.css" />
	<link rel="stylesheet" href="__WAP__/css/sangarSlider.css" type="text/css" media="all">
	<link rel="stylesheet" href="__WAP__/css/default.css" type="text/css" media="all">
	
	<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="__WAP__/js/jquery.touchSwipe.min.js"></script>
	<script type="text/javascript" src="__WAP__/js/imagesloaded.min.js"></script>
	<script type="text/javascript" src="__WAP__/js/sangarSlider/sangarBaseClass.js"></script>
	<script type="text/javascript" src="__WAP__/js/sangarSlider/sangarSetupLayout.js"></script>
	<script type="text/javascript" src="__WAP__/js/sangarSlider/sangarSizeAndScale.js"></script>
	<script type="text/javascript" src="__WAP__/js/sangarSlider/sangarShift.js"></script>
	<script type="text/javascript" src="__WAP__/js/sangarSlider/sangarSetupBulletNav.js"></script>
	<script type="text/javascript" src="__WAP__/js/sangarSlider/sangarSetupNavigation.js"></script>
	<script type="text/javascript" src="__WAP__/js/sangarSlider/sangarSetupSwipeTouch.js"></script>
	<script type="text/javascript" src="__WAP__/js/sangarSlider/sangarSetupTimer.js"></script>
	<script type="text/javascript" src="__WAP__/js/sangarSlider/sangarBeforeAfter.js"></script>
	<script type="text/javascript" src="__WAP__/js/sangarSlider/sangarLock.js"></script>
	<script type="text/javascript" src="__WAP__/js/sangarSlider/sangarResponsiveClass.js"></script>
	<script type="text/javascript" src="__WAP__/js/sangarSlider/sangarResetSlider.js"></script>
	<script type="text/javascript" src="__WAP__/js/sangarSlider/sangarTextbox.js"></script>
	<script type="text/javascript" src="__WAP__/js/common.js"></script>
	<script type="text/javascript" src="__WAP__/js/sangarSlider.js"></script>
	
	<script>
		$(document).ready(function(){
			 
			$('#sangar-example').sangarSlider({
				timer : false, // true or false to have the timer
				width : 1500, // slideshow width
    			height : 500 // slideshow height
			});
			
			$(".product ul li:nth-child(3n)").css({"border-right":"0"});
			
		});
	</script>
</head>
<body>
{include file="public/head" /}
<div class='sangar-slideshow-container' id='sangar-example'>
	<div class='sangar-content-wrapper'>
		{Leesun:adv name='v' pid='23' num='5'}
			<div class='sangar-content'>
			<img src='{$v.pic}' />
			<a href='{$v.go}' target="_blank"></a>
		</div>
		{/Leesun:adv}
	</div>
</div>

<nav>
	<ul>
		<li class="url" url="{Leesun:url name='login' /}">
			<div class="icon"><img src="__WAP__/images/nav-icon1.gif"></div>
			<div class="name">会员登陆</div>
		</li>
		<li class="url" url="{Leesun:url name='reg' /}">
			<div class="icon"><img src="__WAP__/images/nav-icon2.gif"></div>
			<div class="name">会员注册</div>
		</li>
		<li class="url" url="{Leesun:url name='cart' /}">
			<div class="icon"><img src="__WAP__/images/nav-icon3.gif"></div>
			<div class="name">购物车</div>
		</li>
		<li class="url" url="{Leesun:url name='letter' /}">
			<div class="icon"><img src="__WAP__/images/nav-icon4.gif"></div>
			<div class="name">我的私信</div>
		</li>
		<div class="clear"></div>
	</ul>
</nav>


<section class="product-box">
	{Leesun:nav name='v' pid='0' type='1' display='1'}
	<div class="title">
		<span class="p"></span>
		<span class="l"></span>
		<span class="t">{$v.name}</span>
		<span class="l"></span>
		<span class="p"></span>
	</div>
	<div class="product">
		<ul>
			{Leesun:product name='pv' pid='$v.id' recommend='1' status='1' num='6'}
			<li class="url" url="{$pv.url}">
				<div class="img">{if condition="$pv.thumb"}<img src="__ROOT____UPLOADS__/{$pv.thumb}"  />{else}<img src="__WAP__/images/no-pic.jpg" />{/if}</div>
				<div class="name">{$pv.name|mb_substr=0,21,'utf-8'}</div>
				<div class="price">{$pv.symbol}&nbsp;{$pv.current_price}</div>
			</li>
			{/Leesun:product}
			
			<div class="clear"></div>
		</ul>
	</div>
	{/Leesun:nav}
</section>
{include file="public/foot" /}
</body>
</html>