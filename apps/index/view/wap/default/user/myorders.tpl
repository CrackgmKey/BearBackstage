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
		  
		   $("#take").click(function(){
				var url=$(this).attr("url");
					
				layer.open({
					content: '您确定已经收到货了么？'
					,btn: ['确定', '不要']
					,yes: function(index){
					  $.post(url,function(d){
							
							
							layer.open({
								content: d.msg
								,skin: 'msg'
								,time: 2 //2秒后自动关闭
								,end:function(){
									location.reload();
								}
							  });
							
						},'json')
					}
				  });	
			})
			
		  $(".order-list ul li").on("click",function(){
			var id=$(this).attr("id");
			$(".order-window").hide();
			$(".win_"+id).show();
			$(".mask").show();
		  })
		  $(".close").on("click",function(){
			$(".order-window").hide();
			$(".mask").hide();
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
			<select name="payment_id" class="list" id="payment">
				<option {if condition="$Request.param.payment_id=='' || $Request.param.payment_id=='-1'"}selected{/if} value="{:url('index/orders/myOrders',array('pay_status'=>$Request.param.pay_status,'order_status'=>$Request.param.order_status,'payment_id'=>''))}">选择支付方式</option>
				{Leesun:payment name='v'}
				 <option value="{:url('index/orders/myOrders',array('payment_id'=>$v.id,'order_status'=>$Request.param.order_status,'pay_status'=>$Request.param.pay_status))}" {if condition="$Request.param.payment_id==$v['id']"} selected="selected"{/if} >{$v.byname}</option>
				{/Leesun:payment}
				<option value="{:url('index/orders/myOrders',array('payment_id'=>4,'order_status'=>$Request.param.order_status,'pay_status'=>$Request.param.pay_status))}" {if condition="$Request.param.payment_id==4"} selected="selected"{/if} >积分兑换</option>
			</select>
			</li>
			<li>
			<select name="pay_status" class="list" id="pay_status">
				<option value="{:url('index/orders/myOrders',array('pay_status'=>'','order_status'=>$Request.param.order_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.pay_status=='' || $Request.param.pay_status=='-1'"} selected="selected"{/if}>选择支付状态</option>
				<option value="{:url('index/orders/myOrders',array('pay_status'=>0,'order_status'=>$Request.param.order_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.pay_status=='0'"} selected="selected"{/if}>未支付</option>
				<option value="{:url('index/orders/myOrders',array('pay_status'=>1,'order_status'=>$Request.param.order_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.pay_status=='1'"} selected="selected"{/if}>支付成功</option>
				<option value="{:url('index/orders/myOrders',array('pay_status'=>2,'order_status'=>$Request.param.order_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.pay_status=='2'"} selected="selected"{/if}>支付失败</option>
			</select>
			</li>
			<li>
			<select name="order_status" class="list" id="order_status">
				<option value="{:url('index/orders/myOrders',array('order_status'=>'','pay_status'=>$Request.param.pay_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.order_status=='' || $Request.param.order_status=='-1'"} selected="selected"{/if}>选择订单状态</option>
				<option value="{:url('index/orders/myOrders',array('order_status'=>0,'pay_status'=>$Request.param.pay_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.order_status=='0'"} selected="selected"{/if}>交易中</option>
				<option value="{:url('index/orders/myOrders',array('order_status'=>1,'pay_status'=>$Request.param.pay_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.order_status=='1'"} selected="selected"{/if}>交易成功</option>
				<option value="{:url('index/orders/myOrders',array('order_status'=>2,'pay_status'=>$Request.param.pay_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.order_status=='2'"} selected="selected"{/if}>已退款</option>
				<option value="{:url('index/orders/myOrders',array('order_status'=>3,'pay_status'=>$Request.param.pay_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.order_status=='3'"} selected="selected"{/if}>已退货</option>
				<option value="{:url('index/orders/myOrders',array('order_status'=>4,'pay_status'=>$Request.param.pay_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.order_status=='4'"} selected="selected"{/if}>已退款已退货</option>
				<option value="{:url('index/orders/myOrders',array('order_status'=>5,'pay_status'=>$Request.param.pay_status,'payment_id'=>$Request.param.payment_id))}" {if condition="$Request.param.order_status=='5'"} selected="selected"{/if}>交易失败</option>
			</select>
			</li>
		</ul>
	</div>
	<div class="order-list">
		<ul>
		{Leesun:orders name='v' uid='$uid' order_sn='$Request.param.order_sn' pay_status='$Request.param.pay_status' order_status='$Request.param.order_status'  payment_id='$Request.param.payment_id' page='1'}
		
		<li id="{$v.id}">
			<span style="width:230px;"><h4>订单号：{$v.sn}&nbsp;&nbsp;&nbsp;&nbsp;{$v.symbol}：<strong style="color:red">{$v.pay_price}</strong>&nbsp;[含运费]</h4></span>
			<span style="width:160px"><h4>付款状态：{$v.payment_cn}</h4></span>
		</li>
		
			<div class="order-window win_{$v.id}">
				<div class="title">
					<p>订单详情</p><div class="close">×</div>
					<div class="clear"></div>
				</div>
				
				<div class="order-info">
					<h3><span>订单号：</span>{$v.sn}</h3>
					<h3><span>订单状态：</span>{$v.order_status_cn}&nbsp;&nbsp;{$v.status_cn}</h3>
					{if ($v.delivery_status==1)}
					<h3><span>快递单号：</span>{$v.express_sn}</h3>
					<h3><span>快递公司：</span>{$v.express_cn}</h3>
					{/if}
					<h3><span>名字：</span>{$v.name}</h3>
					<h3><span>电话：</span>{$v.tel}</h3>
					<h3><span>地址：</span>{$v.address}</h3>
					<h3><span>下单时间：</span>{if($v.create_time)}{$v.create_time|date="y-m-d H:i:s",###}{else}暂无{/if}</h3>
					<h3><span>支付时间：</span>{if($v.pay_time)}{$v.pay_time|date="y-m-d H:i:s",###}{else}暂无{/if}</h3>
					<h3><span>发货时间：</span>{if($v.delivery_time)}{$v.delivery_time|date="y-m-d H:i:s",###}{else}暂无{/if}</h3>
					<h3><span>结束时间：</span>{if($v.order_time)}{$v.order_time|date="y-m-d H:i:s",###}{else}暂无{/if}</h3>
					<h3><span>商品金额：</span>{$v.total_price}</h3>
					<h3><span>运费：</span>{$v.delivery_fee}</h3>
					<h3><span>应付金额：</span>&yen;{$v.pay_price}</h3>
				</div>
			</div>
		{/Leesun:orders}
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