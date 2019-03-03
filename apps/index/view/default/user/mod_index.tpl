<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><{$seo.title}></title>
<meta name="keywords" content="<{$seo.keyword}><{$seo.title}>" />
<meta name="description" content="<{$con_datas.description}>" />
<meta name="author" content="乐尚商城" />
<meta name="copyright" content="leesuntech.com" />

<link rel="shortcut icon" href="<{$public}>/uploads/<{$con_datas.favicon}>" />
<link href="<{$public}>/css/global.css" rel="stylesheet" type="text/css" />
<link href="<{$res}>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<{$res}>/css/layout.css" rel="stylesheet" type="text/css" />
<link href="<{$res}>/css/user.css" rel="stylesheet" type="text/css" />
<link href="<{$public}>/css/easyform.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<{$public}>/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<{$public}>/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="<{$public}>/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="<{$public}>/js/easyform.js"></script>
<script type="text/javascript" src="<{$res}>/js/common.js"></script>
<script>
var APP_PATH="<{$app}>";var ISLOGIN="<{$user.id}>"
$(function(){
	$('#mod_form').easyform();
});
</script>
</head>

<body>
<{include file="public/header.tpl"}>
<div class="web_body">
	
	<{include file="user/left.tpl"}>
	<div class="right">
		
		<div class="box">
			<div class="title-box">
				<div class="tit">修改个人资料</div>
				<div class="icon"></div>
			</div>
		</div>
		
		<div class="box">
		<form  enctype="multipart/form-data" name="form1" id="mod_form" action="<{$app}>/user/mod" method="post">
           	 <table width="100%" border="0" cellspacing="0" class="table">
              <tr>
                <td width="15%" align="right">用户名：</td>
                <td width="85%"><input type="text" class="input_box" id="user_name" name="user_name" value="<{$data.user_name}>" data-easyform="length:4 16;char-normal;" data-message="用户名必须为4—16位的英文字母或数字" data-easytip="position:right;"/></td>
              </tr>
              <tr>
                <td align="right">密码：</td>
                <td><input type="password" class="input_box" name="password" id="password" data-easyform="null;"/></td>
              </tr>
              <tr>
                <td align="right">确认密码：</td>
                <td><input type="password" class="input_box" name="confirm_pass"  id="confirm_pass"  data-easyform="null;"/></td>
              </tr>
			  <tr>
                <td align="right">头像：</td>
                <td ><input type="file"  name="photo"/></td>
              </tr>
              <tr>
                <td align="right">签名：</td>
                <td ><input type="text" class="input_box" name="signature" id="signature" value="<{$data.signature}>" /></td>
              </tr>
              <tr>
                <td align="right">邮箱：</td>
                <td><input type="text" class="input_box" name="email" id="email" value="<{$data.email}>"/></td>
              </tr>
              <tr>
                <td align="right">电话：</td>
                <td><input type="text" class="input_box" name="phone" id="phone" value="<{$data.phone}>" /></td>
              </tr>
              <tr>
                <td align="right">地址：</td>
                <td><input type="text" class="input_box" name="address" id="address" value="<{$data.address}>" /></td>
              </tr>
              <tr>
                <td align="right">&nbsp;</td>
                <td><input type="hidden" name="id" value="<{$data.id}>"  /><input type="submit" class="sub_button"  value="修 改"/></td>
              </tr>
            </table>
            </div>
            
    		</form>
		</div>
		
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>
<{include file="public/footer.tpl"}>


</body>
</html>
