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
	$(".imglist-box ul li:nth-child(6n)").css('margin-right','0');
	  
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
				<div class="tit">我的收藏</div>
				<div class="icon"></div>
			</div>
		</div>
		
		
		<div class="box">
			<div class="imglist-box">
				<ul>
					{Leesun:profav name='v' page='1' order='id desc'}
					<li>
						<div class="img"><a href="{$v.url}" target="_blank">{if ($v.product.thumb)}<img src="__ROOT____UPLOADS__/{$v.product.thumb}" id="img_{$v.product.id}" width='140' height='107' onload="DrawImg(this.id, 140,107)">{else}<img src="__ROOT____INDEX__/images/no-pic.jpg"  class="img"/>{/if}</a></div>
						<div class="name dgrey_l"><a href="{$v.url}" target="_blank">{$v.product.name|mb_substr=0,20,'utf-8'}</a></div>
						<div class="price"><span class="left">{$v.symbol}{$v.product.current_price}</span><span class="red_l right"><a href="javascript:;"  url="{$v.del_url}" class="del">删除</a></span></div>
						
					</li>
					{/Leesun:profav}
					<div class="clear"></div>
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
