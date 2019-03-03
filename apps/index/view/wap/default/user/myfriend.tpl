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
			
		 $(".subtn").on('click',function(){
			var mess=$("#message").val();
			
			if(mess==''){
				layer.open({
					content: '请填写发送内容'
					,skin: 'msg'
					,time: 2 //2秒后自动关闭
				  });
			} else {
				var user_id=$("#user_id").val();
				var message=$("#message").val();
				$.post("{Leesun:url name='privateLetter' /}",{user_id:user_id,message:message},function(d){
					if(d.code=="1"){
						var msg='回复成功';
					} else {
						var msg='回复失败';
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
			}
		 })
		  
		 
		  
		   $(".send").on("click",function(){
			var id=$(this).attr("id");
			$("#user_id").val(id);
			$(".send-window").show();
			
			$(".mask").bind("touchmove",function(e){e.preventDefault();});
			$(".mask").show();
			
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
		  
		  $(".close").on("click",function(){
			$(".order-window").hide();
			$(".mask").unbind("touchmove");
			$(".mask").hide();
		  })
		  
			
		  
		});
	</script>
</head>
<body>

{include file="public/member_head" /}
<section>
	
	<div class="detail-list" >
		<ul>
		{Leesun:friend name='v' page='1' verify='1' order='addtime desc'}
		
		<li >
			<div class="pimg detail" id="<{$v.id}>" >{if $v.friend_info.photo}<img src="__ROOT____UPLOADS__/{$v.friend_info.photo}">{else}<img src="__WAP__/images/no-pic.jpg"  />{/if}</div>
			<div class="pname">{$v.friend_info.user_name}</div>
			<div style="float:right">
				<div class="pdetail send" id="{$v.friend_info.id}" style="float:left;margin-right:0.5rem">发信</div>
				<div class="pdetail del" url="{$v.del_url}" style="float:left;">删除</div>
			</div>
			<div class="clear"></div>
		</li>
			<div class="order-window win_{$v.id}">
				<div class="title">
					<p>好友详情</p><div class="close">×</div>
					<div class="clear"></div>
				</div>
				
				<div class="order-info">
					<h3><span>好友名称：</span>{$v.friend_info.user_name}</h3>
					<h3><span>个人签名：</span>{$v.friend_info.signature}</h3>
					<h3><span>邮箱：</span>{$v.friend_info.email}</h3>
					<h3><span>手机：</span>{$v.friend_info.phone}</h3>
				</div>
			</div>
			
		{/Leesun:friend}
			<div class="order-window send-window">
				<div class="title">
					<p>发送私信</p><div class="close">×</div>
					<div class="clear"></div>
				</div>
				
				<div class="order-info">
					
					<h3><span>发送内容：</span></h3>
					<h3><textarea class="ta" name="message" id="message"></textarea></h3>
					<div class="clear"></div>
					<h3><input type="hidden" name="user_id" id="user_id" value="" /><input type="submit" class="subtn" value="提交"></h3>
				</div>
			</div>
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