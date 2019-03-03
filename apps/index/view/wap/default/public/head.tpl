<script type="text/javascript" src="__WAP__/layer/layer.js"></script>
<script>
$(document).ready(function(){
	$("#user-login").on("click",function(){
		var username=$("#username").val();
		var password=$("#password").val();
		if(username!='' && password!=''){
			$.post("{Leesun:url name='ajaxLogin' /}",{user_name:username,password:password},function(d){
				if(d=='1'){
					window.location.href="{Leesun:url name='user' /}";
				} else if(d=='3'){
					layer.open({
						content: '用户名或密码错误'
						,skin: 'footer'
					  });
				} else {
					var msg='';
					for(x in d){
						msg+=d[x];
					}
					layer.open({
						content: msg
						,skin: 'msg'
						,time: 2 //2秒后自动关闭
					  });
				}
			},'json')
		} else {
			layer.open({
				content: '请填写账号，密码'
				,skin: 'footer'
			  });
		}
		
	})
	$(".user_center").on('click',function(){
		window.location.href="{Leesun:url name='user' /}";
	})
})
</script>
<header>
	<h1>{$config.site_name}</h1>
	<div class="nav-icon"><img src="__WAP__/images/nav-icon.gif"></div>
	<div class="log-icon {if condition="$uid"}user_center{else}log{/if}" id="{$uid}">{if condition="$uid"}<img src="__WAP__/images/member-icon.png">{else}<img src="__WAP__/images/log-icon.png">{/if}</div>
	<div class="left-nav">
		<ul>
			<li class="{if condition="!$Request.param.id"}selected{/if} url" url="{Leesun:url name='home' /}"  >网站首页</li>
			
			
			{Leesun:nav name='v' pid='0' num='10'  display='1'}
				<li {if condition="$v.selected"}class="selected"{/if} url="{$v.url}" class="url">
					{$v.name}
				</li>
			{/Leesun:nav}
		</ul>
	</div>
	
	<div class="log-box">
		<div class="title">
			<div class="t">会员登陆</div>
			<div class="x" id="close">×</div>
		</div>
		<div class="login">
			<div class="input"><input id="username" type="text" name="username" id="username" required placeholder="请填写账号" /></div>
			<div class="input"><input id="password" type="password" name="password" id="password" required placeholder="请填写密码" /></div>
			<div class="butt" id="user-login">登陆</div>
		</div>
	</div>
</header>