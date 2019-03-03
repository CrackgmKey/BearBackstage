<script>
$(function(){
	$(".avatar-box").hover(function(){
		$(".mod-avatar").show();
	},function(){
		$(".mod-avatar").hide();
	})
});
</script>
<div class="left">
	<div class="box">
		<div class="uleft-box">
			<div class="avatar-box img">
				{if condition="$userInfo.photo"}<img src="__ROOT____UPLOADS__/{$userInfo.photo}"/>{else}<img src="__ROOT____INDEX__/images/user_default.gif" >{/if}
				<div class="mod-avatar"><a href="{:url('index/user/modLogo')}">修改头像</a></div>
			</div>
			<div class="uname">{$userInfo.user_name}</div>
			<div class="nav-box">
				<div class="tit">商品管理</div>
				<div class="con">
					<ul>
						<li {if condition="$controller=='Orders'"}class="cur"{/if}><a href="{:url('index/orders/myOrders')}">我的订单</a></li>
						<li {if condition="$controller=='Appraise'"}class="cur"{/if}><a href="{:url('index/appraise/index')}">我的评价</a></li>
						<li {if condition="$controller=='Consult'"}class="cur"{/if}><a href="{:url('index/consult/index')}">我的咨询</a></li>
						<li class="last {if condition="$controller=='Fav' && $action=='profav'"}cur{/if}"><a href="{:url('index/fav/profav')}">我的收藏</a></li>
					</ul>
				</div>
			</div>
			<div class="nav-box">
				<div class="tit">资讯管理</div>
				<div class="con">
					<ul>
						<li {if condition="$controller=='Comment'"}class="cur"{/if}><a href="{:url('index/comment/index')}">我的评论</a></li>
						<li class="last {if condition="$controller=='Fav' && $action=='newsfav'"}cur{/if}"><a href="{:url('index/fav/newsfav')}">我的收藏</a></li>
					</ul>
				</div>
			</div>
			<div class="nav-box">
				<div class="tit">个人管理</div>
				<div class="con">
					<ul>
						<li {if condition="$controller=='User' && $action=='modinfo'"}class="cur"{/if}><a href="{:url('index/user/modInfo')}">我的资料</a></li>
						<li {if condition="$controller=='Letter'"}class="cur"{/if}><a href="{:url('index/letter/index')}">我的私信</a></li>
						{if condition="$config.is_lottery"}
						<li {if condition="$controller=='Lottery'"}class="cur"{/if}><a href="{:url('index/lottery/index')}">积分抽奖</a></li>
						<li {if condition="$controller=='Lotterywin'"}class="cur"{/if}><a href="{:url('index/lotterywin/index')}">中奖信息</a></li>
						{/if}
						<li {if condition="$controller=='Friend' && $action=='message'"}class="cur"{/if}><a href="{:url('index/friend/message')}">添加好友消息</a></li>
						<li {if condition="$controller=='Friend' && $action=='myfriend'"}class="cur"{/if}><a href="{:url('index/friend/myfriend')}">我的好友</a></li>
						<li class="last"><a href="javascript:;"  class="logout">退出</a></li>
					</ul>
				</div>
			</div>
		</div>
		
	</div><!-- end of box -->
</div><!-- end of left -->
	