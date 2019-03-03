<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><{$con_datas.site_name}>-找回密码</title>
<meta name="keywords" content="<{$con_datas.key_word}>" />
<meta name="description" content="<{$con_datas.description}>" />
<meta name="author" content="乐尚商城" />
<meta name="copyright" content="leesuntech.com" />

<link rel="shortcut icon" href="<{$public}>/uploads/<{$con_datas.favicon}>" />
<link href="<{$public}>/css/global.css" rel="stylesheet" type="text/css" />
<link href="<{$res}>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<{$res}>/css/layout.css" rel="stylesheet" type="text/css" />
<link href="<{$public}>/css/easyform.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<{$public}>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<{$public}>/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="<{$public}>/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="<{$res}>/js/common.js"></script>
<script type="text/javascript" src="<{$public}>/js/easyform.js"></script>
<script>

$(document).ready(function(){
	
	$(".agreement-box ul li:nth-child(3n)").css('margin-right','0');
	$('#reg_form').easyform();
});

</script>
</head>

<body>
<{include file="public/user-header.tpl"}>

<div class="web_body">
	<div class="agreement-box">
		<div class="tit">
			<ul>
				<li>填写邮箱</li>
				<li class="cur">找回密码</li>
				<li >设置密码</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="con">
			<div class="box">
				<{if $flag==1}>
				<div class="success">
					<{$msg}>
				</div>
				<{else}>
				<div class="alert">
					<{$msg}>
				</div>
				<{/if}>
			</div>
			
		</div>
	</div>
</div>

<{include file="public/footer.tpl"}>


</body>
</html>
