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
	$(".imglist-box ul li:nth-child(6n)").css('margin-right','0');
	  
	 $(".letter").click(
			function(){
				open_url=$(this).attr("url");
					user_name=$(this).attr("data-name");
					title="给"+user_name+"发私信";
					
					layui.use(['layer', 'form'], function(){
						layer.open({
						  type: 2,
						  area: ['590px', '470px'],
						  title: title,
						  fixed: false, //不固定
						  maxmin: false,
						  content: open_url
						  
						});
					});
				
			}
		);
	
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
				<div class="tit">我的好友</div>
				<div class="icon"></div>
			</div>
		</div>
		
		
		<div class="box">
			<div class="imglist-box">
				<ul>
				{Leesun:friend name='v' page='1' verify='1' order='addtime desc'}
					<li>
						<div class="img" style="height:140px">{if ($v.friend_info.photo)}<img src="__ROOT____UPLOADS__/{$v.friend_info.photo}" width="140" height="140">{else}<img src="__ROOT____INDEX__/images/user_default.gif"  />{/if}</div>
						<div class="name" style="height:20px;color:red">用户名：{$v.friend_info.user_name}</div>
						<div class="name"  style="color:green">个人签名：<label title="{$v.friend_info.signature}">{$v.friend_info.signature|mb_substr=0,20,'utf-8'}</label></div>
						<div class="price"><span style="margin-right:30px;float:left" class="red_l"><a href="javascript:;"  id="{$v.friend_info.id}" class="letter" data-name="{$v.friend_info.user_name}" url="{$v.url}">发私信</a></span><span style="margin-left:30px;float:left" class="red_l"><a href="javascript:;"  url="{$v.del_url}" class="del">删除</a></span></div>
						
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
