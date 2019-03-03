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

	$("#back").click(function(){
		window.location.href="{:url('admin/orders/index')}";
	})
	
	$("#pay").click(
		function(){
			open_url=$(this).attr("url");
			layui.use(['layer', 'form'], function(){
				layer.open({
				  type: 2,
				  area: ['590px', '350px'],
				  title:'订单付款',
				  fixed: false, //不固定
				  maxmin: true,
				  content: open_url
				});
			});
		}
	);
	$("#deliver").click(
		function(){
			open_url=$(this).attr("url");
			layui.use(['layer', 'form'], function(){
				layer.open({
				  type: 2,
				  area: ['700px', '480px'],
				  title:'发货信息',
				  fixed: false, //不固定
				  maxmin: true,
				  content: open_url,
				  end: function () {
					 location.reload();
				  }
				});
			});
		}
	);
	$("#close").click(
		function(){
			open_url=$(this).attr("url");
			layui.use(['layer', 'form'], function(){
				layer.open({
				  type: 2,
				  area: ['590px', '350px'],
				  title:'关闭交易',
				  fixed: false, //不固定
				  maxmin: true,
				  content: open_url
				});
			});
		}
	);
	$("#mod_pay").click(
		function(){
			open_url=$(this).attr("url");
			layui.use(['layer', 'form'], function(){
				layer.open({
				  type: 2,
				  area: ['590px', '350px'],
				  title:'修改价格',
				  fixed: false, //不固定
				  maxmin: true,
				  content: open_url
				});
			});
		}
	);
	$("#mod_receiving").click(
		function(){
			open_url=$(this).attr("url");
			layui.use(['layer', 'form'], function(){
				layer.open({
				  type: 2,
				  area: ['590px', '350px'],
				  title:'修改收货信息',
				  fixed: false, //不固定
				  maxmin: true,
				  content: open_url
				});
			});
		}
	);
	$("#offpay").click(
		function(){
			open_url=$(this).attr("url");
			layui.use(['layer', 'form'], function(){
				layer.confirm('确认支付了么?', {icon: 3, title:'提示'}, function(index){
				 window.location.href=open_url;
				  layer.close(index);
				});
			});
			
			
		}
	)
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;商品管理&nbsp;>&nbsp;订单详情</div>
	
	<div class="add-box">
		<ul>
			<li><div class="title">订单号</div><div class="text-box">{$data.sn}</div><div class="clear"></div></li>
			<li><div class="title">订单状态</div><div class="text-box">{$data.pay_status_cn}{$data.opt_cn}</div><div class="clear"></div></li>
			<li><div class="title">商品信息</div>
				<div class="product-info left">
					<div class="title">
						<ul>
							<li>名称</li>
							<li>图片</li>
							<li>规格</li>
							<li>单价</li>
							<li>数量</li>
							<div class="clear"></div>
						</ul>
					</div>
					<div class="clear"></div>
					<div class="con">
						<ul>
							{volist name="product" id="d"}
							<li><span title="{$d.name}">{$d.name|mb_substr=0,10,'utf-8'}</span></li>
							<li class="img-big" style="cursor:pointer;"><img src="__ROOT____UPLOADS__/{$d.thumb}"></li>
							<li>{volist name="data.specs" id="v"}[{$v}]&nbsp;{/volist}</li>
							<li><span class="red">{if($data.type==1)}&yen;{$d.price}{else}积分:{$d.price}{/if}</span></li>
							<li>{$d.amount}</li>
							<div class="clear"></div>
							{/volist}
						</ul>
					</div>
					<div class="bot">
						<ul>
							{if($data.type==1)}
							<li>总金额:{$data.pay_price}</li>
							<li>运费:{$data.delivery_fee}</li>
							<li>使用积分:{$data.score}</li>
							{else}
							<li>积分:{$data.pay_price}</li>
							{/if}
							<div class="clear"></div>
						</ul>
					</div>
				</div>
				
				
				<div class="clear"></div>
			</li>
			
			<li>
				<div class="title">用户信息</div>
				<div class="info-list left">
					<ul>
						{if condition="$data['is_user']"}
						<li>用户名：{$user.user_name}</li>
						<li>电话：{$user.phone}</li>
						<li>邮箱：{$user.email}</li>
						<li>积分：{$user.score}</li>
						{else}
						<li><span style="color:red">已无此用户</span></li>
						{/if}
					</ul>
				</div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="title">收货信息</div>
				<div class="info-list left">
					<ul>
						<li>地区：{$data.district_cn}{$data.sdistrict_cn}</li>
						<li>姓名：{$data.name}</li>
						<li>电话：{$data.tel}</li>
						<li>地址：{$data.address}</li>
						<li>留言：{$data.message}</li>
					</ul>
				</div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="title">订单信息</div>
				<div class="info-list left">
					<ul>
						<li>下单时间：{if condition="$data.create_time"}{$data.create_time_cn}{else}无{/if}</li>
						<li>支付时间：{if condition="$data.pay_time"}{$data.pay_time_cn}{else}无{/if}</li>
						<li>订单结束时间：{if condition="$data.order_time"}{$data.order_time}{else}无{/if}</li>
					</ul>
				</div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="title">付款信息</div>
				<div class="info-list left">
					<ul>
						{if($data.type==1)}
						<li>商品金额：&yen;{$data.total_price}</li>
						<li>运费：&yen;{$data.delivery_fee}</li>
						<li>应付金额：&yen;{$data.pay_price}</li>
						{else}
						<li>积分:{$data.total_price}</li>
						{/if}
					</ul>
				</div>
				<div class="clear"></div>
			</li>
			 {if ($data.delivery_status==1)}
			<li>
				<div class="title">发货信息</div>
				<div class="info-list left">
					<ul>
						<li>快递单号：{$data.express_sn}</li>
						<li>快递公司：{$data.express_cn}</li>
						<li>发货时间：{if condition="$data.delivery_time"}{$data.delivery_time}{else}无{/if}</li>
					</ul>
				</div>
				<div class="clear"></div>
			</li>
			{/if}
		</ul>
	</div>
	
	<div class="fun-box" style="margin-left:30px;">
		<div class="button">
			<ul>
				<li class="dels"  id="back">返回</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="clear"></div>
	</div>
	
	

</div><!-- end of main -->

</form>

</body>
</html>
