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
			$(".list").change(function(){
				var url=$(this).val();
				 window.location.href=url;
			});
		  
		  $(".pdetail").on("click",function(){
			var id=$(this).attr("id");
			$(".order-window").hide();
			$(".win_"+id).show();
			$(".mask").bind("touchmove",function(e){e.preventDefault();});
			$(".mask").show();
		  })
		  $(".close").on("click",function(){
			$(".order-window").hide();
			$(".mask").unbind("touchmove");
			$(".mask").hide();
		  })
		  
		  $(".pimg").click(function(){
			var url=$(this).attr("url");
			window.location.href=url;
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
			<select name="reply" class='list' id="reply">
				<option value="{:url('index/consult/index',array('verify'=>$Request.param.verify))}" {if ($Request.param.is_reply=="" || $Request.param.is_reply=="-1")} selected="selected"{/if}>选择回复状态</option>
				<option value="{:url('index/consult/index',array('is_reply'=>'0','verify'=>$Request.param.verify))}" {if ($Request.param.is_reply=="0")} selected="selected"{/if} >未回复</option>
				<option value="{:url('index/consult/index',array('is_reply'=>'1','verify'=>$Request.param.verify))}" {if ($Request.param.is_reply=="1")} selected="selected"{/if} >已回复</option>
			</select>
			</li>
			<li>
			<select name="verify" class='list' id="verify">
				<option value="{:url('index/consult/index',array('is_reply'=>$Request.param.is_reply))}" {if ($Request.param.verify=="" || $Request.param.verify=="-1")} selected="selected"{/if}>选择审核状态</option>
				<option value="{:url('index/consult/index',array('verify'=>'0','is_reply'=>$Request.param.is_reply))}" {if ($Request.param.verify=="0")} selected="selected"{/if} >未审核</option>
				<option value="{:url('index/consult/index',array('verify'=>'1','is_reply'=>$Request.param.is_reply))}" {if ($Request.param.verify=="1")} selected="selected"{/if} >已审核</option>
			</select>
			</li>
			
		</ul>
	</div>
	<div class="detail-list" >
		<ul>
		{Leesun:consult name='v' uid='$uid' is_reply='$Request.param.is_reply' verify='$Request.param.verify' page='1'}
		
		<li >
			<div class="pimg"  url="{$v.url}">{if ($v.product.img)}<img src="__ROOT____UPLOADS__/{$v.product.img}">{else}<img src="__WAP__/images/no-pic.jpg"  />{/if}</div>
			<div class="plevel">{if($v.verify)}已审核{else}未审核{/if}</div>
			<div class="plevel">{if($v.is_reply)}已回复{else}未回复{/if}</div>
			<div class="pdetail" id="{$v.id}">详细</div>
			<div class="clear"></div>
		</li>
			<div class="order-window win_{$v.id}">
				<div class="title">
					<p>咨询详情</p><div class="close">×</div>
					<div class="clear"></div>
				</div>
				
				<div class="order-info">
					<h3><span>商品名称：</span>{$v.product.name}</h3>
					<h3><span>咨询内容：</span>{$v.question}</h3>
					<h3><span>咨询时间：</span>{$v.q_time}</h3>
					{if ($v.is_reply==1)}
					<h3><span>回复内容：</span>{$v.answer}</h3>
					<h3><span>回复时间：</span>{$v.a_time}</h3>
					{/if}
					
				</div>
			</div>
			
		{/Leesun:consult}
		
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