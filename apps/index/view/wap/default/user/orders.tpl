<!DOCTYPE html> 
<html>
<head>
	<title>在线支付</title>
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
			$("#wxpay").on('click',function(){
				var orderid='{$order.id}';
				var total_fee='{$order.price}';
				
				$.post("{:url('index/pay/pay_wxpay')}",{orderid:orderid,total_fee:total_fee},function(s){
						window.location.href=s;
					})
				
			})
		});
		
		{if($is_weixin=='1')}
			function jsApiCall()  
			{  
				 
				WeixinJSBridge.invoke(  
					'getBrandWCPayRequest', {$jsapiData},
					function(res){  
						WeixinJSBridge.log(res.err_msg);  
						//alert('err_code:'+res.err_code+'err_desc:'+res.err_desc+'err_msg:'+res.err_msg);  
						//alert(res.err_code+res.err_desc+res.err_msg);  
						//alert(res);  
						if(res.err_msg == "get_brand_wcpay_request:ok"){    
							
							layer.open({
								content: "支付成功!"
								,skin: 'msg'
								,time: 2 //2秒后自动关闭
							  });
							window.location.href="{:url('index/user/index')}";  
						}else if(res.err_msg == "get_brand_wcpay_request:cancel"){    
							layer.open({
								content: "用户取消支付!"
								,skin: 'msg'
								,time: 2 //2秒后自动关闭
							  });
						}else{    
							layer.open({
								content: "支付失败!"
								,skin: 'msg'
								,time: 2 //2秒后自动关闭
							  });
						}    
					}  
				);  
			}  
			
		   
			function callpay()  
			{  
			
				if (typeof WeixinJSBridge == "undefined"){  
					if( document.addEventListener ){  
						document.addEventListener('WeixinJSBridgeReady', jsApiCall, false);  
					}else if (document.attachEvent){  
						document.attachEvent('WeixinJSBridgeReady', jsApiCall);   
						document.attachEvent('onWeixinJSBridgeReady', jsApiCall);  
					}  
				}else{  
					jsApiCall();  
				}  
			}    
		{/if}
	</script>
</head>
<body>

{include file="public/head" /}
<section>
	
	<div class="input-box" >
		<ul>
			
			
			<li>
				<span class="tip" style='font-size:1.5rem'>订单编号：{$order.sn}</span>
				<span class="tip" style='font-size:1.3rem;'>支付方式：{$order.payment_cn}</span>
				<span class="tip" style='color:red;font-size:1.3rem;'>总价：&yen;{$order.price}</span>
				<div class="clear"></div>
			</li>
			
			<li>
				<div class="t"></div>
				{if ($order.payment_id==1)}
				<form enctype="multipart/form-data" action="{:url('index/pay/pay_wap_alipay')}" method="post" id="form1" target="_self">
				<div class="input"><input type="submit" data-role="none" id="submit" value="立即支付" class="but" style="background:#ff0000;color:#fff;border:0;"></div>
				<input type="hidden" name="oid" value="{$order.id}">
				</form>
				{/if}
				{if ($order.payment_id==2)}
					{if($is_weixin=='1')}
					<div class="input"><input type="button" onClick="callpay()" value="微信支付" class="but" style="background:#ff0000;color:#fff;border:0;"></div>
					{else}
					<div class="input"><input type="button" id="wxpay" value="微信支付" class="but" style="background:#ff0000;color:#fff;border:0;"></div>
					{/if}
				{/if}
				{if ($order.payment_id==3)}
					<span class="tip" style='color:red;font-size:1.8rem'>请等待发货!</span>
				{/if}
			</li>
			
		</ul>
	</div>
	
	
	
	<div class="clear"></div>
</section>

{include file="public/foot" /}

</body>
</html>