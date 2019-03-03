<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<{$public}>/css/global.css" rel="stylesheet" type="text/css" />
<link href="<{$res}>/css/main.css" rel="stylesheet" type="text/css" />
<link href="<{$public}>/css/weebox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<{$public}>/js/jquery.js"></script>
<script type="text/javascript" src="<{$public}>/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="<{$public}>/js/jquery.jclock.js"></script>
<script type="text/javascript" src="<{$public}>/js/jquery.bgiframe.js"></script>
<script type="text/javascript" src="<{$public}>/js/jquery.weebox.js"></script>
<script type="text/javascript" src="<{$res}>/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	$(".status").click(function(){
		
		var url="<{$url}>/change_status";
		var id=$(this).attr("id");
		var obj=$(this);
		
		$.get(url,{"id":id},function(d){
			
			if(d!="err"){
				var last_status=d?"0":"1";
				$(obj).removeClass("status_"+last_status);
				$(obj).addClass("status_"+d);
			}
		})
	})
	

	
	$("#dels").click(function(){
		if(confirm('你确定要删除选中的项目吗?')){
			$("#form1").attr("action","<{$url}>/del");
			$("#form1").submit();
		}else {
			return false;
		}
	})
	$(".del").click(function(){
		var id=$(this).attr("id");
	
		if(confirm('你确定要删除此项目吗?')){
			
			window.location.href="<{$url}>/del/id/"+id;
		} else {
			return false;
		}
		
	})
	
	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	$(".pay_status ul li").click(function(){
		var id=$(this).attr("id");
		var payment="<{$smarty.get.payment}>";
		var delivery_status="<{$smarty.get.delivery_status}>";
		if(payment!=""){
			var payment_str="/payment/"+payment;
		}  else {
			var payment_str="";
		}
		if(delivery_status!=""){
			var delivery_status_str="/delivery_status/"+delivery_status;
		}  else {
			var delivery_status_str="";
		}
		window.location.href="<{$url}>/index/pay_status/"+id+payment_str+delivery_status_str;
	})
	
	$(".payment ul li").click(function(){
		var id=$(this).attr("id");
		var pay_status="<{$smarty.get.pay_status}>";
		var delivery_status="<{$smarty.get.delivery_status}>";
		if(delivery_status!=""){
			var delivery_status_str="/delivery_status/"+delivery_status;
		}  else {
			var delivery_status_str="";
		}
		if(pay_status!=""){
			var pay_status_str="/pay_status/"+pay_status;
		}  else {
			var pay_status_str="";
		}
		
		window.location.href="<{$url}>/index/payment/"+id+delivery_status_str+pay_status_str;
	})
	
	$(".delivery_status ul li").click(function(){
		var id=$(this).attr("id");
		var pay_status="<{$smarty.get.pay_status}>";
		var payment="<{$smarty.get.payment}>";
		if(payment!=""){
			var payment_str="/payment/"+payment;
		}  else {
			var payment_str="";
		}
		if(pay_status!=""){
			var pay_status_str="/pay_status/"+pay_status;
		}  else {
			var pay_status_str="";
		}
		window.location.href="<{$url}>/index/delivery_status/"+id+payment_str+pay_status_str;
	})
	
	
	$(".show").click(function(){
		var id=$(this).attr("id");
		window.location.href="<{$url}>/show/id/"+id;
	})
	
	
	
	
})
</script>
</head>

<body>
<{include file="main/top.tpl"}>
<form enctype="multipart/form-data" action="" method="post" id="form1">
<input type="hidden" name="dels" value="1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="<{$app}>" target="_top">首页</a>&nbsp;>&nbsp;商品管理&nbsp;>&nbsp;订单管理</div>
	<div class="search-box">
		<div class="input-box-s left" style="z-index:900"><span class="select-title"><{$current_name.pay_status_cn}></span>
			<div class="select-box pay_status">
					<ul>
						<li id="-1">所有支付状态</li>
						<li id="0">未支付</li>
						<li id="1">支付成功</li>
						<li id="2">支付失败</li>
					</ul>
				</div>
		</div>
		<div class="input-box-s left" style="z-index:900"><span class="select-title"><{$current_name.payment_cn}></span>
			<div class="select-box payment">
					<ul>
						<li id="-1">所有支付方式</li>
						<li id="1">网银在线</li>
						<li id="2">财付通</li>
						<li id="3">支付宝</li>
						<li id="4">货到付款</li>
						<li id="5">微信支付</li>
					</ul>
				</div>
		</div>
		<div class="input-box-s left" style="z-index:900"><span class="select-title"><{$current_name.delivery_status_cn}></span>
			
			<div class="select-box delivery_status">
					<ul>
						<li id="-1">所有发货状态</li>
						<li id="0">未发货</li>
						<li id="1">已发货</li>
						<li id="2">已收货</li>
					</ul>
				</div>
		</div>
		<div class="clear"></div>
	</div>
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:15%">订单号</li>
				<li style="width:10%">下单用户</li>
				<li style="width:22%">付款信息</li>
				<li style="width:21%">订单状态</li>
				<li style="width:17%">下单时间</li>
				<li style="width:10%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="list" id="list">
				<{section name=sn loop=$datas}>
				<ul>
					<a>
					<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="<{$datas[sn].id}>"></li>
					<li style="width:15%"><{$datas[sn].sn}></li>
					<li style="width:10%;"><{$datas[sn].user.user_name}></li>
					<li style="width:22%;"><span class="red" >&yen;<{$datas[sn].pay_price}></span><span class="green" >[含运费:&yen;<{$datas[sn].delivery_fee}>]</span><span class="sienna" >[<{$datas[sn].payment_id|replace:"1":"网银在线"|replace:"2":"财付通"|replace:"3":"支付宝"|replace:"4":"货到付款"|replace:"5":"微信支付"}>]</span></li>
					<li style="width:21%"><{$datas[sn].pay_status|replace:0:"<span style='color:#F30'>[未支付]</span>"|replace:1:"<span style='color:green'>[支付成功]</span>"|replace:2:"<span style='color:red'>[支付失败]</span>"}><{$datas[sn].delivery_status|replace:0:"<span style='color:#F30'>[未发货]</span>"|replace:1:"<span style='color:green'>[已发货]</span>"|replace:2:"<span style='color:green'>[已收货]</span>"}><{$datas[sn].order_status|replace:1:"<span style='color:green'>[交易成功]</span>"|replace:2:"<span style='color:red'>[已退款]</span>"|replace:3:"<span style='color:green'>[已退货]</span>"|replace:4:"<span style='color:green'>[已退款，已退货]</span>"|replace:0:"<span style='color:red'>[交易失败]</span>"|replace:5:"<span style='color:green'>[未结单]</span>"}></li>
					<li style="width:17%"><{$datas[sn].create_time}></li>
					<li style="width:10%"><div class="mod-icon show" id="<{$datas[sn].id}>">详</div><div class="del-icon del" id="<{$datas[sn].id}>" >删</div><div class="clear"></div></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				
				<{/section}>
			
		</div>
	</div><!-- end of list-box -->
	
	<div class="fun-box">
		<div class="button">
			<ul>
				<li class="dels"  id="dels">删除</li>
				<div class="clear"></div>
			</ul>
		</div>
		<div class="page grey_l link"><{$fpage}></div>
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->
</form>
</body>
</html>
