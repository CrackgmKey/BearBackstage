<div id="top">
	<div class="bar">
		<div class="web_body">
			<div class="left">欢迎光临<{$con_datas.site_name}></div>
			<div class="right">
				<div class="top-nav">
					<ul>
						<{if !$user_login_info.isLogin}>
						<li><a href="<{$app}>/user/login_index">登录</a></li>
						<li><a href="<{$app}>/user/reg_index">注册</a></li>
						<li><a href="<{$app}>/message">意见反馈</a></li>
						<{else}>
						<li class="username"><a href="<{$app}>/user/index"><{$user_login_info.user_name}></a></li>
						<li class="cart"><a href="<{$app}>/cart/index">我的购物车[<{$cart_num}>]</a></li>
						<li><a href="<{$app}>/user/logout">退出</a></li>
						<{/if}>
						<div class="clear"></div>
					</ul>
				</div>
			</div>
		</div>
	</div>
	
	<div class="main-box">
		<div class="web_body">
			<div class="logo left" ><a href="<{$app}>" title="回首页"><img src="<{$public}>/uploads/<{$con_datas.logo}>"></a></div>
			<div class="right-box right">
				<form id="search_form" action="<{$app}>/product/search_index" method="post">
				<div class="search-box">
					<ul>
						<li class="input"><input type="text" name="keywords" class="search" id="search_box" value="" /></li>
						<li class="classname" id="txt">商品</li>
						<li class="but s_but">搜索</li>
						<div class="clear"></div>
					</ul>
				</div>
				</form>
				<div class="hotword-box">
					热门搜索：
					<{section name=sn loop=$hot_datas max=5}>
						<a href="<{$hot_datas[sn].url}>"><{$hot_datas[sn].keyword}></a>
					<{/section}>
				</div>
			</div>
		</div>
	</div><!-- end of main-box -->
	
</div>
