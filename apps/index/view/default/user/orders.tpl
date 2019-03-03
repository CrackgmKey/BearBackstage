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
<link href="__ROOT____INDEX__/css/cart.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	sendPost(); //调用监听事件
	$("#alipay").click(function(){
		 
		
		$("#form1").attr("action","{:url('index/pay/pay_alipay')}");
		$("#form1").submit();
		
		
	})
	$("#wxpay").click(function(){
		 
		
		layui.use('layer', function(){
		  var layer = layui.layer;
		  layer.open({
			  type: 1, 
			  offset:'100px',
			 
			  maxWidth:'500px',
			  title:'微信支付',
			  content: "{$img}" //这里content是一个普通的String
			});
		});   
	
		
	})
	
})

function sendPost() {
	//发送AJAX请求
	
	$.ajax({
		url: "{:url('index/pay/listen')}",
		type: "POST",
		timeout: 30000,
		data: {'oid':'{$order.sn}'},
		dataType: "json",
		success: function (data, type) {
			console.log(data);
			if (data == 'SUCCESS') {
			   
				layui.use(['layer'], function(){
					layer.msg('支付成功！', {time: 3000, icon:1},function(){
						location.href ="{:url('index/orders/myorders')}";
					});
				});
			} else {
				time();
			}
		}
	});
}
function time() {
	
	setTimeout(function () {
		sendPost();
	}, 5000);
}
</script>
</head>

<body>
{include file="public/header" /}
<div id="body" class="web_body">
	
    <div class="cart_box">
    	<div class="tit">
        	我的订单
        </div>
        <div class="content">
        	<div class="p_tit">
            	<ul>
                	<li style="width:250px;">订单编号</li>
                    <li style="width:350px;">支付方式</li>
                    <li style="width:250px;">总价</li>
                    <li style="width:120px;">操作</li>
                </ul>
            </div>
            
            <div class="p_con" style="font-family:microsoft yahei">
            	<ul >
                	<li style="width:250px;font-size:16px;">{$order.sn}</li>
                    <li style="width:350px;font-size:16px;">
                    	{$order.payment_cn}
                    </li>
                    <li style="width:250px;font-size:16px;color:red">&yen;{$order.price}</li>
                    
                    {if ($order.payment_id==1)}
					<form enctype="multipart/form-data" action="" method="post" id="form1" target="_self">
                    <li style="width:120px;cursor:pointer;font-size:18px;"><a href="javascript:;" id="alipay" >支付宝支付</a></li>
					<input type="hidden" name="oid" value="{$order.id}">
					</form>
					{/if}
					
					{if ($order.payment_id==2)}
						 <li style="width:120px;cursor:pointer;font-size:18px;"><a href="javascript:;" id="wxpay" >扫码支付</a></li>
，					{/if}
                   
                     {if ($order.payment_id==3)}
                    <li style="width:120px;cursor:pointer;font-size:18px;">请等待发货</li>
                    {/if}
                    
                </ul>
                <div class="clear"></div>
            </div>
            
            
            
            
            
        </div>
    </div>
    
</div>
{include file="public/footer" /}
</body>
</html>
