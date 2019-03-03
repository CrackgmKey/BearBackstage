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
<link href="__ROOT____INDEX__/css/index.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/unslider.min.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jQuery.autoIMG.js"></script>
<script>
$(function(){
	
	$(".product dl:nth-child(6n)").css('margin-right','0');
	$(".link-box ul li:nth-child(9n)").css('margin-right','0');
	 $('.mainbanner').unslider({
		speed: 500,               //  滚动速度
		delay: 3000,              //  动画延迟
		complete: function() {},  //  动画完成的回调函数
		keys: true,               //  启动键盘导航
		dots: true,               //  显示点导航
		fluid: false              //  支持响应式设计
	});
	
	$(".product-class").click(function(){
		var id=$(this).attr("id");
		var data=$(this).attr("data");
		$(this).parent("ul").children("li").removeClass("cur");
		$(this).addClass("cur");
		
		$(".product_"+data).fadeOut("fast",function(){
			$(".loading_"+data).fadeIn("fast",function(){
				$.get("{:url('index/index/ajaxList')}",{id:id},function(datas){
					
					$(".loading_"+data).fadeOut("fast",function(){
						
						$(".product_"+data).html(datas);
						$(".product dl:nth-child(6n)").css('margin-right','0');
						if(datas!=""){
							$(".product_"+data).fadeIn("fast");
						}
					});
				})
			});
		});
	})
	
	
	$("#index-user-nav dl").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
	})
	//$('.box .product-box .product dl dt a').autoIMG();
	
});
</script>
</head>

<body>
{include file="public/header" /}
<div class="web_body">
	<div class="box">
		<div class="index-user-box left" id="index-user-nav">
			<dl class="l" url="{Leesun:url name='myOrders' /}">
				<dt class="icon-1"></dt>
				<dd>我的订单</dd>
			</dl>
			<dl class="r" url="{Leesun:url name='myFriend' /}">
				<dt class="icon-2"></dt>
				<dd>朋友圈</dd>
			</dl>
			<dl class="l" url="{Leesun:url name='myFriendMessage' /}">
				<dt class="icon-3"></dt>
				<dd>添加好友</dd>
			</dl>
			<dl class="r" url="{Leesun:url name='lottery' /}">
				<dt class="icon-4"></dt>
				<dd>积分抽奖</dd>
			</dl>
			<dl class="lb" url="{Leesun:url name='cart' /}">
				<dt class="icon-5"></dt>
				<dd>购物车</dd>
			</dl>
			<dl class="rb" url="{Leesun:url name='letter' /}">
				<dt class="icon-6"></dt>
				<dd>我的私信</dd>
			</dl>
			<div class="clear"></div>
		</div><!-- end of index-user-box -->
		
		<div class="mainbanner left">
			<ul>
				{Leesun:adv name='v' pid='23' num='6'}
					<li><a target="_blank" href="{$v.go}"><img class="sliderimg" src="{$v.pic}" alt="" width="100%"></a></li>
				{/Leesun:adv}
			
			 </ul>
		</div><!-- end of banner -->
		
		<div class="right">
			<div class="news-box">
				<div class="tit">
					<h1 class="left">最新消息</h1>
					<!--<h3 class="right more"><a href="">更多...</a></h3>-->
				</div>
				<div class="list grey_l">
					<ul>
						
						{Leesun:news name='v' sort='create_time desc' num='7'}
						<li><a href="{$v.url}">·{$v.title|mb_substr=0,10,'utf-8'}</a>&nbsp;&nbsp;[<span style="color:#006600">{$v.create_time|mb_substr=0,10,'utf-8'}</span>]</li>
						{/Leesun:news}
					</ul>
				</div>
			</div>
			<div class="sbanner">
				 {Leesun:adv name='v' pid='24' num='1'}
					<a target="_blank" href="{$v.go}"><img class="sliderimg" src="{$v.pic}" alt="" width="100%"  class="img"></a>
				 {/Leesun:adv}
			</div>
		</div>
		
		<div class="clear"></div>
	</div><!-- end of box -->
	
	{Leesun:nav name='v' pid='0' type='1' display='1'}
		<div class="box" style="margin-bottom:20px;">
		
			<div class="product-box">
				<div class="tit">
					<div class="floor left">{$key+1}F</div>
					<div class="name left"><h1>{$v.name}<h1></div>
					<div class="pnav right">
						<ul>
							<li id="{$v.id}" class="product-class cur" data="{$v.id}">所有</li>
							{Leesun:nav name='sv' pid='$v.id'}
							<li id="{$sv.id}" class="product-class" data="{$v.id}">{$sv.name}</li>
							{/Leesun:nav}
							<div class="clear"></div>
						</ul>
					</div>
				</div>
				<div class="product">
					<div class="loading loading_{$v.id}" style="height:206px;"></div>
					<div class="product_{$v.id}">
					
					
					{Leesun:product name='pv' pid='$v.id' recommend='1' status='1'}
					<dl>
						<dt><a href="{$pv.url}">{if condition="$pv.thumb"}<img src="__ROOT____UPLOADS__/{$pv.thumb}"   onload='AutoResizeImage(181,138,this)'/>{else}<img src="__ROOT____INDEX__/no-pic.jpg" class="img"/>{/if}</a></dt>
						<dd>
							<h2 class="dgrey_l"><a href="{$pv.url}">{$pv.name|mb_substr=0,30,'utf-8'}</a></h2>
							<h1>{$pv.symbol}&nbsp;{$pv.current_price}</h1>
						</dd>
					</dl>
					{/Leesun:product}
					<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
			
		</div>
	{/Leesun:nav}
	
	
	
	<div class="box">
		{Leesun:adv name='v' pid='25' num='1'}
			<div class="b-banner">
				<a target="_blank" href="{$v.go}"><img  src="{$v.pic}"  class="img"></a>
			</div>
		{/Leesun:adv}
	</div>
	
	<div class="box">
		<div class="link-box">
			<div class="tit">友情链接</div>
			<div class="list">
				<ul class="grey_l">
					{Leesun:link name='v'}
					<li><a href="{$v.url}" target="_blank">{$v.name}</a></li>
					{/Leesun:link}
					
					<div class="clear"></div>
				</ul>
			</div>
		</div>
	</div>
	
</div>
<div class="clear"></div>

{include file="public/footer" /}

</body>
</html>
