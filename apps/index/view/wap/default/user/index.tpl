<!DOCTYPE html> 
<html>
<head>
	<title>会员中心</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=device-dpi" />
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<link rel="stylesheet" type="text/css" href="__WAP__/css/common.css" />
	<link rel="stylesheet" type="text/css" href="__WAP__/css/user.css" />
	<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="__WAP__/js/common.js"></script>
	<script>
		$(document).ready(function(){
			$("#photo").on("change",function(){
				var formData = new FormData();
				formData.append('photo', $('.photo')[0].files[0]);
				
				$.ajax({
				   url: "{:url('index/user/modphoto')}",
                   method: 'POST',
                   data: formData,
                   contentType: false, // 注意这里应设为false
                   processData: false,
                   cache: false,
                   success: function(data) {
					   var path="__ROOT____UPLOADS__/";
					   if(data.photo){
						$(".avatar .img").attr('src',path+data.photo);
					   }
                       layer.open({
							content: data.msg
							,skin: 'msg'
							,time: 2 //2秒后自动关闭
						  });
                   },
                   error: function (jqXHR) {
					     
						layer.open({
							title: [
							  '上传错误',
							  'background-color: #FF4351; color:#fff;'
							]
							,content: "<div style='font-size:5px'>"+JSON.stringify(jqXHR)+"</div>"
						  });
					   
                   }
               })
			}) 
		});
	</script>
</head>
<body>

{include file="public/member_head" /}
<section>
	<div class="profile">
		<div class="avatar">
			{if($userInfo.photo)}<img src="__ROOT____UPLOADS__/{$userInfo.photo}"  class="img"/>{else}<img src="__WAP__/images/user_default.gif" class="img">{/if}
			<input type="file" name="photo" class="photo" id="photo" >
		</div>
		<div class="info">
			<p>{$userInfo.user_name}</p>
			<p>积分：{$userInfo.score}</p>
			<p>等级：{if($userInfo.group_name)}{$userInfo.group_name}{else}无{/if}</p>
		</div>
		<div class="clear"></div>
	</div>
	<div class="result-list">
		<ul>
			<li url="{:url('index/orders/myorders')}" class="url"><span>{Leesun:count name='order' /}</span><br>交易中订单</li>
			<li url="{:url('index/fav/profav')}" class="url"><span>{Leesun:count name='profav' /}</span><br>我的收藏</li>
			<li url="{:url('index/letter/index')}" class="url"><span>{Leesun:count name='letter' /}</span><br>我的私信</li>
			<li url="{:url('index/friend/message')}" class="url"><span>{Leesun:count name='friend' /}</span><br>好友消息</li>
			<div class="clear"></div>
		</ul>
	</div>
	<div class="product-fav">
		<div class="title">收藏的商品</div>
		{if condition="$profav"}
		<div class="product">
			<ul>
				{Leesun:profav name='v' num='6'}
				<li class="url" url="{$v.url}">
					<div class="img">{if condition="$v.product.thumb"}<img src="__ROOT____UPLOADS__/{$v.product.thumb}"  />{else}<img src="__WAP__/images/no-pic.jpg"  class="img"/>{/if}</div>
					<div class="name">{$v.product.name|mb_substr=0,21,'utf-8'}</div>
					<div class="price">{$v.symbol}:{$v.product.current_price}</div>
				</li>
				{/Leesun:profav}
				
				<div class="clear"></div>
			</ul>
		</div>
		{/if}
	</div>
	<div class="tools-box">
		<ul>
			<li>
				<p class="icon icon1"></p>
				<p class="name">未回复</p>
				<div class="num">{Leesun:count name='appNoReply' /}</div>
			</li>
			<li>
				<p class="icon icon2"></p>
				<p class="name">已回复</p>
				<div class="num">{Leesun:count name='appReply' /}</div>
			</li>
			<li>
				<p class="icon icon3"></p>
				<p class="name">收藏资讯</p>
				<div class="num">{Leesun:count name='fav' /}</div>
			</li>
			<li>
				<p class="icon icon4"></p>
				<p class="name">已评论</p>
				<div class="num">{Leesun:count name='comment' /}</div>
			</li>
			<div class="clear"></div>
		</ul>
	</div>
</section>
{include file="public/foot" /}

</body>
</html>