<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=7">
<title><{$con_datas.site_name}></title>
<meta name="keywords" content="<{$con_datas.key_word}>" />
<meta name="description" content="<{$con_datas.description}>" />
<link href="<{$public}>/css/global.css" rel="stylesheet" type="text/css" />
<link href="<{$public}>/css/weebox.css" rel="stylesheet" type="text/css" />
<link href="<{$res}>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<{$res}>/css/layout.css" rel="stylesheet" type="text/css" />
<link href="<{$res}>/css/cart.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<{$public}>/js/jquery.js"></script>
<script type="text/javascript" src="<{$public}>/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="<{$public}>/js/jquery.bgiframe.js"></script>
<script type="text/javascript" src="<{$public}>/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="<{$public}>/js/jquery.weebox.js"></script>
<script type="text/javascript" src="<{$public}>/js/koala.min.1.5.js"></script>
<script type="text/javascript" src="<{$res}>/js/common.js"></script>
<script type="text/javascript">
var APP_PATH="<{$app}>";
var ISLOGIN="<{$user.id}>";
$(document).ready(function(){
	
	
	
})
</script>
</head>

<body>
<{include file="public/header.tpl"}>
<div id="body" class="web_body">
	
    <div class="cart_box">
    	<div class="tit">
        	订单成功
        </div>
        <div class="content">
        	<div class="order_success">
            	<div class="success">您已成功付款!</div>
                <div class="sn">订单号:<{$orders_info.sn}></div>
                <div class="sn" style="color:red">支付金额:<{$orders_info.total_price}>&yen;&nbsp;&nbsp;运费:<{$orders_info.delivery_fee}>&yen;</div>
            </div>
        </div>
    </div>
    
</div>
<{include file="public/footer.tpl"}>
</body>
</html>
