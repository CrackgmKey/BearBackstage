<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=7">
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
	$(".detail").click(
		  function(){
			  var url=$(this).attr("url");
			  layui.use(['layer', 'form'], function(){
				layer.open({
				  type: 2,
				  area: ['590px', '480px'],
				  title:'订单详情',
				  fixed: false, //不固定
				  maxmin: false,
				  content: url,
				  end: function () {
					location.reload();
				  }
				});
			});
			 	
		  }
	  );
	  $(".list ul li").click(function(){
		 var url=$(this).attr("url");
		
		 window.location.href=url;
	  })
	  
	 
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
				<div class="tit">我的订单</div>
				<div class="icon"></div>
				<form action="{Leesun:url name='myOrders' /}" method="get">
				<div class="input-box"><label>订单号</label>&nbsp;&nbsp;<input type="text" name="order_sn" class="input_box">&nbsp;&nbsp;<input type="submit" class="but" value="搜索"></div>
				</form>
			</div>
		</div>
		
		<div class="box">
			<div class="filter-box">
				<div class="tit">支付方式</div>
				<div class="list" id="payment">
					<ul>
						
						<li {if condition="$Request.param.payment_id=='' || $Request.param.payment_id=='-1'"}class="cur"{/if} url="{:url('index/orders/myOrders',array('pay_status'=>$Request.param.pay_status,'order_status'=>$Request.param.order_status,'payment_id'=>''))}">全部</li>
						{Leesun:payment name='v'}
							<li url="{:url('index/orders/myOrders',array('payment_id'=>$v.id,'order_status'=>$Request.param.order_status,'pay_status'=>$Request.param.pay_status))}" {if condition="$Request.param.payment_id==$v['id']"}class="cur"{/if}>{$v.byname}</li>
						{/Leesun:payment}
						<li url="{:url('index/orders/myOrders',array('payment_id'=>4,'order_status'=>$Request.param.order_status,'pay_status'=>$Request.param.pay_status))}" {if condition="$Request.param.payment_id==4"}class="cur"{/if}>积分兑换</li>
						<div class="clear"></div>
					</ul>
				</div>
				<div class="clear"></div>
			</div>
			<div class="filter-box">
				<div class="tit">支付状态</div>
				<div class="list" id="pay_status">
					<ul>
						<li {if condition="$Request.param.pay_status=='' || $Request.param.pay_status=='-1'"}class="cur"{/if} url="{:url('index/orders/myOrders',array('pay_status'=>'','order_status'=>$Request.param.order_status,'payment_id'=>$Request.param.payment_id))}">全部</li>
						<li url="{:url('index/orders/myOrders',array('pay_status'=>0,'order_status'=>$Request.param.order_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.pay_status=='0'"}class="cur"{/if}>未支付</li>
						<li url="{:url('index/orders/myOrders',array('pay_status'=>1,'order_status'=>$Request.param.order_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.pay_status=='1'"}class="cur"{/if}>支付成功</li>
						<li url="{:url('index/orders/myOrders',array('pay_status'=>2,'order_status'=>$Request.param.order_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.pay_status=='2'"}class="cur"{/if}>支付失败</li>
						<div class="clear"></div>
					</ul>
				</div>
				<div class="clear"></div>
			</div>
			<div class="filter-box">
				<div class="tit">订单状态</div>
				<div class="list" id="order_status">
					<ul>
						<li {if condition="$Request.param.order_status=='' || $Request.param.order_status=='-1'"}class="cur"{/if} url="{:url('index/orders/myOrders',array('order_status'=>'','pay_status'=>$Request.param.pay_status,'payment_id'=>$Request.param.payment_id))}">全部</li>
						<li url="{:url('index/orders/myOrders',array('order_status'=>0,'pay_status'=>$Request.param.pay_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.order_status=='0'"}class="cur"{/if}>交易中</li>
						<li url="{:url('index/orders/myOrders',array('order_status'=>1,'pay_status'=>$Request.param.pay_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.order_status=='1'"}class="cur"{/if}>交易成功</li>
						<li url="{:url('index/orders/myOrders',array('order_status'=>2,'pay_status'=>$Request.param.pay_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.order_status=='2'"}class="cur"{/if}>已退款</li>
						<li url="{:url('index/orders/myOrders',array('order_status'=>3,'pay_status'=>$Request.param.pay_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.order_status=='3'"}class="cur"{/if}>已退货</li>
						<li url="{:url('index/orders/myOrders',array('order_status'=>4,'pay_status'=>$Request.param.pay_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.order_status=='4'"}class="cur"{/if}>已退款已退货</li>
						<li url="{:url('index/orders/myOrders',array('order_status'=>5,'pay_status'=>$Request.param.pay_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.order_status=='5'"}class="cur"{/if}>交易失败</li>
						<div class="clear"></div>
					</ul>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		
		<div class="box">
			<div class="userlist-box">
				<ul>
					{Leesun:orders name='v' uid='$uid' order_sn='$Request.param.order_sn' pay_status='$Request.param.pay_status' order_status='$Request.param.order_status'  payment_id='$Request.param.payment_id' page='1'}
					<li>
						<span style="width:230px">订单号：{$v.sn}</span>
						<span style="width:170px"><strong style="color:red">{$v.symbol}&nbsp;{$v.pay_price}</strong></span>
						<span style="width:170px">支付方式：{$v.payment_cn}</span>
						<span style="width:160px">付款状态：{$v.pay_status_cn}</span>
						<span style="width:170px">订单状态：{$v.order_status_cn}</span>
						<span><div class="circle-but detail" url="{$v.det_url}">详</div></span>
						<div class="clear"></div>
					</li>
					<div class="clear"></div>
					{/Leesun:orders}
				</ul>
			</div>
		</div>
		
		<div class="page">
			{$page}
			<div class="clear"></div>
		</div>
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>
{include file="public/footer" /}


</body>
</html>
