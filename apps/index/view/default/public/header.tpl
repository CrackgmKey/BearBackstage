<script>
	
	$(document).ready(function(){
		$(".logout").on("click",function(){
			layui.use(['layer'], function(){
				layer.msg('再见会员：{$userInfo.user_name}', {time: 3000, icon:1},function(){ window.location.href="{Leesun:url name='logout' /}"; });
				
			});
		})
		
		$(".s_but").on("click",function(){
			var key=$("#search_box").val();
			if(key==''){
				layui.use(['layer'], function(){
					layer.msg('请输入关键字', {time: 3000, icon:2});
				});
				return false;
			}
			var url=$('#search_form').attr('action');
			var value=$('#search_form').attr('value');
			switch(value){
				case '1':
					url="{Leesun:url name='searchPro' keywords='key__'/}"
				break;
				case '2':
					url="{Leesun:url name='searchNew' keywords='key__'/}"
				break;
				case '4':
					url="{Leesun:url name='searchScore' keywords='key__'/}"
				break;
			}
			url = url.replace('key__',key);
			window.location.href=url;
		})
		
		var i=0;
		$("#txt").click(
			function(){
				var t=$(this).html();
				var arr=['商品','新闻','积分商品'];
				i++;
				if(i>2) i=0;
				$(this).html(arr[i]);
				switch(i){
					case 0:
						$("#search_form").attr("value","1");
					break;
					case 1:
						$("#search_form").attr("value","2");
					break;
					case 2:
						$("#search_form").attr("value","4");
					break;
				}
				
			}
		)
	})
</script>
<div id="top">
	<div class="bar">
		<div class="web_body">
			<div class="left">欢迎光临{$config.site_name}</div>
			<div class="right">
				<div class="top-nav">
					<ul>
						{if condition="!$uid"}
						<li><a href="{Leesun:url name='login' /}">登录</a></li>
						<li><a href="{Leesun:url name='reg' /}">注册</a></li>
						<li><a href="{Leesun:url name='message' /}">意见反馈</a></li>
						{else}
						<li class="username"><a href="{Leesun:url name='user' /}">{$userInfo.user_name}</a></li>
						<li class="cart"><a href="{Leesun:url name='cart' /}">我的购物车[{Leesun:count name='cart' /}]</a></li>
						<li><a href="javascript:;" class="logout">退出</a></li>
						{/if}
						<div class="clear"></div>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="banner">
		<div class="web_body">
		 
		 {Leesun:adv name='v' pid='22' num='1'}
			<a target="_blank" href="{$v.go}"><img src="{$v.pic}" style="opacity: 1; "></a>
		 {/Leesun:adv}
		 </div>
	</div>
	<div class="main-box">
		<div class="web_body">
			<div class="logo left" ><a href="{Leesun:url name='home' /}" title="回首页"><img src="__ROOT____UPLOADS__/{$config.logo}"></a></div>
			<div class="right-box right">
				<form id="search_form" action="{Leesun:url name='searchPro' /}" method="post" value="1">
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
					
					{Leesun:hotword name='v' num='7'}
						<a href="{$v.url}">{$v.keyword}</a>
					{/Leesun:hotword}
				</div>
			</div>
		</div>
	</div><!-- end of main-box -->
	<div class="web_body">
		<div class="nav-box left">
			<h1>商城导航分类</h1>
			<div class="nav">
				<ul>
					<li {if condition="!$Request.param.id"}class="selected"{/if}><a href="{Leesun:url name='home' /}">网站首页</a></li>
					{Leesun:nav name='v' pid='0' num='10'  display='1'}
                        <li {if condition="$v.selected"}class="selected"{/if}>
                        <a href="{$v.url}">{$v.name}</a>
                    </li>
                	{/Leesun:nav}
				</ul>
			</div>
		</div>
		<div class="notice-box right" id="notice-box">
			<ul>
				
				{Leesun:news name='v' pid='73' sort='create_time desc' num='10'}
				<li><a href="{$v.url}">{$v.title}</a>&nbsp;[<span style="color:#006600">{$v.create_time}</span>]</li>
				{/Leesun:news}
			</ul>
		</div>
		<div class="clear"></div>
	</div>
</div>
