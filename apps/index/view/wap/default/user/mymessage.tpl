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
			$(".order-window").show();
			$("#xid").val(id);
			$(".mask").bind("touchmove",function(e){e.preventDefault();});
			$(".mask").show();
			$.get("",{id:id},function(d){
			})
		  })
		  
		  
		  
		  $(".close").on("click",function(){
			$(".order-window").hide();
			$(".mask").unbind("touchmove");
			$(".mask").hide();
		  })
		   $(".subtn").on('click',function(){
				var id=$("#id").val();
				$.post("{Leesun:url name='agreeFriendMessage' /}",{id:id},function(d){
					if(d.code=="1"){
						var msg='添加成功';
					} else {
						var msg='添加失败';
					}
					layer.open({
						content: msg
						,skin: 'msg'
						,time: 2 //2秒后自动关闭
						,end:function(index){
							location.reload();
						}
					  });
					 
				},'json')
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
		{Leesun:friend name='v' page='1' verify='0' order='addtime desc'}
		
		<li >
			<div class="pimg" >{if $v.friend_info.photo}<img src="__ROOT____UPLOADS__/{$v.friend_info.photo}">{else}<img src="__WAP__/images/no-pic.jpg"  />{/if}</div>
			<div class="pname">{$v.friend_info.user_name}</div>
			<div style="float:right">
				<div class="pdetail detail" id="{$v.id}" style="float:left;margin-right:0.5rem">详细</div>
				<div class="pdetail del" url="{$v.del_url}">删除</div>
			</div>
			<div class="clear"></div>
		</li>
			<div class="order-window win_{$v.id}">
				<div class="title">
					<p>详情</p><div class="close">×</div>
					<div class="clear"></div>
				</div>
				<div class="order-info">
					<h3><span>发信人：</span>{$v.friend_info.user_name}</h3>
					<h3><span>私信内容：</span>{$v.message}</h3>
					<h3><span>时间：</span>{$v.addtime}</h3>
					<h3><input type="hidden" name="id" id="id" value="{$v.id}" /><input type="submit" class="subtn" value="同意"></h3>
				</div>
			</div>
			
		{/Leesun:friend}
			
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