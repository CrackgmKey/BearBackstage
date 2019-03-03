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
<link href="__ROOT____INDEX__/css/user.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/unslider.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jQuery.autoIMG.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script>
$(function(){
	$("#news-box:nth-child(2n)").css('margin-right','0');
	var pnum=$("#product ul li").length;
	var width=$("#product ul li").width()+25;
	var img_width=pnum*width;
	$("#product").width(img_width);
	var imgbox_num=Math.ceil(img_width/895);
	var num=0;
	$("#img-left").click(function(){
		var dis=-870;
		
		if(num<(imgbox_num-1)){
			num++;
		}
		$("#product").animate({"left":num*dis},"2000");
		
	})
	$("#img-right").click(function(){
		var dis=-870;
		
		if(num>=1){
			num--;
		}
		
		$("#product").animate({"left":num*dis},"2000");
	})
	$(".submit-but").click(function(){
		var pid=$(this).attr("id");
		$(".appraise_form_"+pid).submit();
	})
	
	$("#top-nav ul li").click(function(){
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
	
	{include file="user/left" /}
	<div class="right">
		
		<div class="box">
			<div class="info-bar">
				<span>欢迎您：{$userInfo.user_name}<span>您目前积分：{$userInfo.score}</span><span>等级：{$userInfo.group_name}</span><span>最近一次登陆时间：{$userInfo.log_time}</span>
			</div>
		</div>
		
		<div class="box">
			<div class="outline-box" id="top-nav">
				<ul>
					<li url="{:url('index/orders/myorders')}">
						<div class="data">
							<div class="icon_1"></div>
							<div class="num">{Leesun:count name='order' /}</div>
						</div>
						<div class="name">交易中的订单</div>
					</li>
					
					<li url="{:url('index/fav/profav')}">
						<div class="data">
							<div class="icon_2"></div>
							<div class="num">{Leesun:count name='profav' /}</div>
						</div>
						<div class="name">我收藏的商品</div>
					</li>
					
					<li url="{:url('index/comment/index')}">
						<div class="data">
							<div class="icon_3"></div>
							<div class="num">{Leesun:count name='comment' /}</div>
						</div>
						<div class="name">我的资讯评论</div>
					</li>
					
					<li url="{:url('index/fav/newsfav')}">
						<div class="data">
							<div class="icon_4"></div>
							<div class="num">{Leesun:count name='fav' /}</div>
						</div>
						<div class="name">我收藏的资讯</div>
					</li>
					
					<li url="{:url('index/letter/index')}">
						<div class="data">
							<div class="icon_5"></div>
							<div class="num">{Leesun:count name='letter' /}</div>
						</div>
						<div class="name">我的私信</div>
					</li>
					
					<li url="{:url('index/friend/message')}">
						<div class="data">
							<div class="icon_6"></div>
							<div class="num">{Leesun:count name='friend' /}</div>
						</div>
						<div class="name">添加好友消息</div>
					</li>
					
					<div class="clear"></div>
				</ul>
			</div>
		</div>
		
		
		<div class="box">
			<div class="long-box">
				<div class="tit">
					<span class="name left">已收藏商品</span><span class="more right"><a href="{Leesun:url name='myProfav' /}">更多</a></span>
				</div>
				
				{if condition="$profav"}
				<div class="con">
					<div class="leftbut" id="img-left"></div>
					<div class="product-box">
						<div class="product" id="product">
							<ul>
								{Leesun:profav name='v'}
								<li>
									<div class="img"><a href="{$v.url}" target="_blank">{if condition="$v.product.thumb"}<img src="__ROOT____UPLOADS__/{$v.product.thumb}" onload='AutoResizeImage(154,117,this)'/>{else}<img src="__ROOT____INDEX__/images/no-pic.jpg"  class="img"/>{/if}</a></div>
									<div class="name dgrey_l"><a href="{$v.url}" target="_blank"><span title="{$v.product.name}">{$v.product.name}</span></a></div>
									<!--<div class="price">&yen;{$v.product.current_price}</div>-->
								</li>
								{/Leesun:profav}
								
							</ul>
						</div>
					</div>
					<div class="rightbut" id="img-right"></div>
					<div class="clear"></div>
				</div>
				{else}
				<div class="con">
					<div class="no-content"></div>
				</div>
				{/if}
				
			</div>
		</div>
		
		<div class="box">
			<div class="left" >
				<div class="long-box" style="width:478px;">
					<div class="tit">
						<span class="name left">最新评论</span><span class="more right"><a href="{Leesun:url name='comment' /}">更多</a></span>
					</div>
					{if condition="$comment"}
					
					{Leesun:comment name='v' num='5'}
					
					<div class="con " style="border-bottom:1px dotted #ccc;padding:10px 0px;">
						<div class="news">
							<ul>
								<li>
									<div class="list dgrey_l">◆&nbsp;<a href="{$v.news_url}" target="_blank"><span title="{$v.content}">{$v.content|mb_substr=0,16,'utf-8'}</span></a>&nbsp;&nbsp;[{$v.create_time}]</div>
									
								</li>
								<div class="clear"></div>
							</ul>
						</div>
						
					</div>
					
					{/Leesun:comment}
					
					{else}
					<div class="con">
						<div class="no-content"></div>
					</div>
					{/if}
					
				</div><!-- end of long-box -->
			</div><!-- end of left -->
			
			<div class="left" style="margin-left:10px;">
				<div class="long-box" style="width:478px;">
					<div class="tit">
						<span class="name left">最新回复评价</span><span class="more right"><a href="{Leesun:url name='myAppraise' /}">更多</a></span>
					</div>
					{if condition="$appraise"}
					{Leesun:appraise name='v' order='reply_time desc' num='1' is_reply='1'}
					<div class="con">
						<div class="new-product">
							<ul>
								<li>
									<div class="img"><a href="#" target="_blank">{if condition="$v.product.thumb"}<img src="__ROOT____UPLOADS__/{$v.product.thumb}" />{else}<img src="__ROOT____INDEX__/images/no-pic.jpg" />{/if}</a></div>
									<div class="name dgrey_l"><a href="#" target="_blank">{$v.product.name|mb_substr=0,13,'utf-8'}</a></div>
									<div class="price">&yen;{$v.product.current_price}</div>
								</li>
								<div class="clear"></div>
							</ul>
						</div>
						<div class="mess-box">
							<div class="mess">
								<div class="t">我的评价：</div>
								<div class="cont">{$v.content}</div>
								<div class="time">评价时间：{$v.content_time}</div>
							</div>
							<div class="reply">
								<div class="t">管理员回复：</div>
								<div class="cont">{$v.reply}</div>
								<div class="time">回复时间：{$v.reply_time}</div>
							</div>
						</div>
						<div class="clear"></div>
					</div>
					{/Leesun:appraise}
					{else}
					<div class="con">
						<div class="no-content"></div>
					</div>
					{/if}
					
				</div>
			</div>
			<div class="clear"></div>
		</div>
		
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>
{include file="public/footer" /}


</body>
</html>
