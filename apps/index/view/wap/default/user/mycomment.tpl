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
			
		  
		  $(".detail").on("click",function(){
			var id=$(this).attr("id");
			$(".order-window").hide();
			$(".win_"+id).show();
			$(".mask").show();
		  })
		  $(".close").on("click",function(){
			$(".order-window").hide();
			$(".mask").hide();
		  })
		  
			$(".del").click(function(){
				 
				 var url=$(this).attr('url');
				 layer.open({
					content: '确定要删除吗？'
					,btn: ['确定', '不要']
					,yes: function(index){
					  $.post(url,{},function(d){
							layer.close(index);
							window.location.reload();
							
						},'json')
					  
					}
				  });
			});
		  
		});
	</script>
</head>
<body>

{include file="public/member_head" /}
<section>
	
	<div class="detail-list" >
		<ul>
		{Leesun:comment name='v' uid='$uid' page='1'}
		
		<li >
			<div class="pname url" url="{$v.url}">{$v.news.title|mb_substr=0,10,'utf-8'}</div>
			<div class="plevel" style="color:#fff">顶:{$v.top}</div>
			<div style="float:right">
				<div class="pdetail detail" id="{$v.id}" style="float:left;margin-right:0.5rem">详细</div>
				<div class="pdetail del" id="{$v.id}" style="float:left;">删除</div>
			</div>
			<div class="clear"></div>
		</li>
			<div class="order-window win_{$v.id}">
				<div class="title">
					<p>评论详情</p><div class="close">×</div>
					<div class="clear"></div>
				</div>
				
				<div class="order-info">
					<h3><span>新闻名称：</span>{$v.news.title}</h3>
					<h3><span>评论内容：</span>{$v.content}</h3>
					<h3><span>评论时间：</span>{$v.create_time}</h3>
					
				</div>
			</div>
			
		{/Leesun:comment}
		</ul>
	</div>
	<div class="page">
		{$page}
		<div class="clear"></div>
	</div>
</section>
{include file="public/foot" /}

</body>
</html>