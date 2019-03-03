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
		{Leesun:profav name='v' page='1' order='id desc'}
		
		<li >
			<div class="pimg url"  url="{$v.url}">{if ($v.product.thumb)}<img src="__ROOT____UPLOADS__/{$v.product.thumb}">{else}<img src="__WAP__/images/no-pic.jpg"  />{/if}</div>
			<div class="pname">{$v.product.name|mb_substr=0,20,'utf-8'}</div>
			<div class="pdetail del" url="{$v.del_url}">删除</div>
			<div class="clear"></div>
		</li>
			
			
		{/Leesun:profav}
		
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