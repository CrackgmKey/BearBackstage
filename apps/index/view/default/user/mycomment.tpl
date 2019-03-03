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
<link href="__ROOT____INDEX__/css/lottery.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script>
$(function(){
	$(".userlist-box ul li:odd").css({"background":"#f4f4f4"});
	
	  
	 
	
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
				<div class="tit">我的评论</div>
				<div class="icon"></div>
			</div>
		</div>
		
		
		
		<div class="box">
			<div class="userlist-box">
				<ul>
					{Leesun:comment name='v' uid='$uid' page='1'}
					<li>
						<span style="width:230px" class="dgrey_l">评论资讯：<label title="{$v.news.title}"><a href="{$v.news_url}" target="_blank">{$v.news.title|mb_substr=0,10,'utf-8'}</a></label></span>
						<span style="width:380px">评论内容：<label title="{$v.content}" class="green">{$v.content|mb_substr=0,20,'utf-8'}</label></span>
						<span style="width:180px">评论时间：{if ($v.create_time)}{$v.create_time}{else}<label style='color:red'>暂无</label>{/if}</span>
						<span style="width:100px">顶：<label class="red">{$v.top}次</label></span>

						<span><div class="circle-but-b del" url="{$v.del_url}">删</div></span>
						<div class="clear"></div>
					</li>
					<div class="clear"></div>
					{/Leesun:comment}
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
