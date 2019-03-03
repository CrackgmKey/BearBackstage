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
			$("#is_new").change(function(){
				var url=$(this).val();
				window.location.href=url;
			})
			
			
		  
		  $(".detail").on("click",function(){
			var id=$(this).attr("id");
			var url=$(this).attr("url");
			$(".order-window").hide();
			$(".win_"+id).show();
			$(".mask").bind("touchmove",function(e){e.preventDefault();});
			$(".mask").show();
			$.get(url,{},function(d){
				
			})
		  })
		  
		   $(".send").on("click",function(){
			var id=$(this).attr("id");
			$("#user_id").val(id);
			$(".send-window").show();
			
			$(".mask").bind("touchmove",function(e){e.preventDefault();});
			$(".mask").show();
			
		  })
		  
		  $(".close").on("click",function(){
			$(".order-window").hide();
			$(".mask").unbind("touchmove");
			$(".mask").hide();
			location.reload();
		  })
		  
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
				$.post("{Leesun:url name='reply' /}",{user_id:user_id,message:message},function(d){
					if(d=="1"){
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
		  
		});
	</script>
</head>
<body>

{include file="public/member_head" /}
<section>
	<div class="option-list">
		 <ul>
			<li>
			<select name="is_new" id="is_new">
				<option value="{:url('index/letter/index')}" {if condition="$Request.param.is_new=='' || $Request.param.is_new=='-1'"} selected="selected"{/if}>选择是否查看</option>
				<option value="{:url('index/letter/index','is_new=1')}" {if condition="$Request.param.is_new=='1'"} selected="selected"{/if} >未查看</option>
				<option value="{:url('index/letter/index','is_new=0')}" {if condition="$Request.param.is_new=='0'"} selected="selected"{/if} >已查看</option>
			</select>
			</li>
			
			
		</ul>
	</div>
	<div class="detail-list" >
		<ul>
		{Leesun:letter name='v' uid='$uid' is_new='$Request.param.is_new' page='1'}
		
		<li >
			<div class="pimg" >{if $v.photo}<img src="__ROOT____UPLOADS__/{$v.photo}">{else}<img src="__WAP__/images/no-pic.jpg"  />{/if}</div>
			<div class="plevel">{if condition="$v.is_new"}未查看{else}已查看{/if}</div>
			<div style="float:right">
				<div class="pdetail detail" url="{$v.det_url}" id="{$v.id}" style="float:left;margin-right:0.5rem">详细</div>
				<div class="pdetail send" id="{$v.from_id}" style="float:left;">发信</div>
			</div>
			<div class="clear"></div>
		</li>
			<div class="order-window win_{$v.id}">
				<div class="title">
					<p>私信详情</p><div class="close">×</div>
					<div class="clear"></div>
				</div>
				
				<div class="order-info">
					<h3><span>发信人：</span>{$v.user_name}</h3>
					<h3><span>私信内容：</span>{$v.message}</h3>
					<h3><span>时间：</span>{$v.create_time}</h3>
					
				</div>
			</div>
			
		{/Leesun:letter}
			
			<div class="order-window send-window">
				<div class="title">
					<p>发送私信</p><div class="close">×</div>
					<div class="clear"></div>
				</div>
				
				<div class="order-info">
					
					<h3><span>发送内容：</span></h3>
					<h3><textarea class="ta" name="message" id="message"></textarea></h3>
					<h3></h3>
					<div class="clear"></div>
					<h3><input type="hidden" name="user_id" id="user_id" value="" /><input type="submit" class="subtn" value="提交"></h3>
				</div>
			</div>
			
		</ul>
	</div>
</section>
{include file="public/foot" /}

</body>
</html>