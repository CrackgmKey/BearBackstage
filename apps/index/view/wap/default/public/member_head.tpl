<link rel="stylesheet" href="__WAP__/layer/need/layer.css" type="text/css" media="all">
<script type="text/javascript" src="__WAP__/layer/layer.js"></script>
<script>
$(document).ready(function(){
	$(".logout").on('click',function(){
		layer.open({
			content: '您确定要退出吗？'
			,btn: ['确定', '不要']
			,yes: function(index){
			  window.location.href="{Leesun:url name='logout' /}";
			  layer.close(index);
			}
		  });
	})
})
</script>
<header>
	<h1>{$config.site_name}</h1>
	<div class="nav-icon"><img src="__WAP__/images/nav-icon.gif"></div>
	<div class="log-icon logout"><img src="__WAP__/images/member-quit-icon.png"></div>
	<div class="left-nav">
		<ul>
			<li url="{:url('index/user/index')}" class="url">中心首页</li>
			<li url="{:url('index/orders/myOrders')}" class="url">我的订单</li>
			<li url="{:url('index/appraise/index')}" class="url">我的评价</li>
			<li url="{:url('index/consult/index')}" class="url">我的咨询</li>
			<li url="{:url('index/fav/profav')}" class="url">商品收藏</li>
			<li url="{:url('index/comment/index')}" class="url">新闻评论</li>
			<li url="{:url('index/fav/newsfav')}" class="url">新闻收藏</li>
			<li url="{:url('index/letter/index')}" class="url">我的私信</li>
			<li url="{:url('index/friend/message')}" class="url">好友消息</li>
			<li url="{:url('index/friend/myFriend')}" class="url">我的好友</li>
			<li class="logout">退出</li>
		</ul>
	</div>
	
	
</header>