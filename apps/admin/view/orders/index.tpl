<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/main.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.jclock.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	layui.use('laydate', function(){
		var laydate = layui.laydate;
		laydate.render({
		  elem: '#dateRange'
		  ,type: 'month'
		  ,range: true
		});
	});
	
	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	$(".select-box ul li").click(function(){
		var url=$(this).attr("url");
		if(url){
			window.location.href=url;
		}
	})
	
	$("#dels").click(function(){
		
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 $("#form1").attr("action","{:url('admin/orders/del')}");
			 $("#form1").submit();
			  layer.close(index);
			});
		});
	})
	$(".del").click(function(){
		var url=$(this).attr("url");
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 window.location.href=url;
			  layer.close(index);
			});
		});
		
	})
	$(".show").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
	})
	
	$("#search").click(function(){
		var key=$("#key").val();
		var dateRange=$("#dateRange").val();
		if(key){
			var url="{:url('admin/orders/index','sn=key_')}";
			url = url.replace('key_',key);
			$("#form1").attr("action",url);
		}else if(dateRange){
			var url="{:url('admin/orders/index','dateRange=dateRange_')}";
			url = url.replace('dateRange_',dateRange);
			$("#form1").attr("action",url);
			
		} else {
			$("#form1").attr("action","{:url('admin/orders/index')}");
		}
		$("#form1").submit();
	})
	
	$(".thumb").hover(function(){
		$(this).parents("li").css("z-index","901");
		$(this).parents("li").css("overflow","visible");
		$(this).parents("li").children(".thumb-box").show(100);
	},function(){
		$(this).parents("li").css("z-index","800");
		$(this).parents("li").css("overflow","hidden");
		$(this).parents("li").children(".thumb-box").hide(100);
	})
	
	
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;用户管理&nbsp;>&nbsp;缴费明细</div>
	
	<div class="search-box">
		<div class="input-box-s left" style="z-index:900"><span class="select-title">{$currentPayName}</span>
			<div class="select-box payment_id">
					<ul>
						<li url="{:url('admin/orders/index',array('payment_id'=>0))}">不限</li>
						<li url="{:url('admin/orders/index',array('payment_id'=>1))}">支付宝</li>
						<li url="{:url('admin/orders/index',array('payment_id'=>2))}">微信支付</li>
						<li url="{:url('admin/orders/index',array('payment_id'=>3))}">货到付款</li>
						<li url="{:url('admin/orders/index',array('payment_id'=>4))}">积分兑换</li>
					</ul>
				</div>
		</div>
		<div class="input-box-t left" style="z-index:900"><input type="text" name="dateRange" id="dateRange" placeholder="支付日期范围" value="{$dateRange}"></div>
		<div class="input-box-t left" style="z-index:900"><input type="text" name="sn" id="key" placeholder="订单编号"></div>
		<div class="search-but left" style="z-index:900" id="search">搜索</div>
		<div class="clear"></div>
	</div>
	
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:15%">订单编号</li>
				<li style="width:15%">支付金额</li>
				<li style="width:15%">支付状态</li>
				<li style="width:15%">会员名称</li>
				<li style="width:15%">支付时间</li>
				<li style="width:10%">支付方式</li>
				<li style="width:10%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="list" id="list">
				{volist name="datas" id="data"}
				<ul>
					<a>
					<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="{$data.id}"></li>
					<li style="width:15%;color:#d46e00">{$data.sn}</li>
					<li style="width:15%;"><span class="red" >{$data.symbol}{$data.pay_price}</span><span class="green" >[含运费:&yen;{$data.delivery_fee}]</span><span class="sienna" ></span></li>
					<li style="width:15%" title="[{$data.pay_status_cn}][{$data.delivery_status_cn}][{$data.order_status_cn}]">[{$data.pay_status_cn}][{$data.delivery_status_cn}][{$data.order_status_cn}]</li>
					<li style="width:15%;">{$data.user_name}</li>
					<li style="width:15%">{$data.pay_time_cn}</li>
					<li style="width:10%">{$data.payment_name}</li>
					<li style="width:10%">
						<div class="mod-icon show" url="{$data.det_url}">详</div>
					<div class="del-icon del" url="{$data.del_url}" >删</div><div class="clear"></div></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				
				{/volist}
			
		</div>
	</div><!-- end of list-box -->
	
	<div class="fun-box">
		<div class="button">
			<ul>
				<li class="dels"  id="dels">删除</li>
				<div class="clear"></div>
			</ul>
		</div>
		<div class="page grey_l link">{$page}</div>
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->
</form>
</body>
</html>
