<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
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
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script>
$(function(){
	$(".userlist-box ul li:odd").css({"background":"#f4f4f4"});
	
	
	  
	  $(".detail").click(function(){
		
		 var url=$(this).attr("url");
		  layui.use(['layer', 'form'], function(){
			layer.open({
			  type: 2,
			  area: ['590px', '480px'],
			  title:'详细信息',
			  fixed: false, //不固定
			  maxmin: false,
			  content: url,
			  end: function () {
				location.reload();
			  }
			});
		});
			
	});
	$(".del").click(function(){
		var url=$(this).attr('url');
		 layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 
				 $.post(url,{},function(d){
					layui.use(['layer'], function(){
						
						layer.msg(d.msg, {time: 3000, icon:d.code},function(){
							layer.close(index);
							 window.location.reload();
							 
						});
					});
					
				},'json')
			 
			});
		});
		 
	});
});
</script>
</head>

<body>
{include file="public/header" /}
<div class="web_body">
	
	{include file="user/left" /}
	<div class="right">
		
		<div class="box">
			<div class="title-box">
				<div class="tit">添加好友消息</div>
				<div class="icon"></div>
			</div>
		</div>
		
		
		
		<div class="box">
			<div class="userlist-box">
				<ul>
					{Leesun:friend name='v' page='1' verify='0' order='addtime desc'}
					<li>
						<span style="width:600px" class="dgrey_l">会员名称：<label class="red">{$v.friend_info.user_name}</label></span>
						<span style="width:280px">添加时间：{$v.addtime|mb_substr=0,10,'utf-8'}</span>
						<span style="width:30px"><div class="circle-but detail" url="{$v.det_url}" >详</div></span>
						<span><div class="circle-but-b del" url="{$v.del_url}">删</div></span>
						<div class="clear"></div>
					</li>
					<div class="clear"></div>
					{/Leesun:friend}
					
					
				</ul>
			</div>
		</div>
		
		<div class="box">
			<div class="page">{$page}</div>
		</div>
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>
{include file="public/footer" /}


</body>
</html>
