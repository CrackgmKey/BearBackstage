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
	$("#modBut").on("click",function(){
		var formData = new FormData();
		var user_name=$("#user_name").val();
		var signature=$("#signature").val();
		var email=$("#email").val();
		var phone=$("#phone").val();
		var address=$("#address").val();
		var user_id=$("#user_id").val();
		var password=$("#password").val();
		
		
		formData.append('photo', $('#photo')[0].files[0]);
		formData.append('signature', signature);
		formData.append('email', email);
		formData.append('phone', phone);
		formData.append('address', address);
		formData.append('password', password);
		formData.append('id', user_id);
		$.ajax({
		   url: "{:url('index/user/modInfo')}",
		   method: 'POST',
		   data: formData,
		   contentType: false, // 注意这里应设为false
		   processData: false,
		   cache: false,
		   success: function(d) {
			   if(d.code=='1'){
					 layui.use(['layer'], function(){
						layer.msg(d.msg, {time: 3000, icon:1});
					});
					
					
				} else if(d.code=='2'){
					layui.use(['layer'], function(){
						layer.msg(d.msg, {time: 3000, icon:2});
					});
				} else if(d.code=='3'){
					layui.use(['layer'], function(){
						layer.msg(d.msg, {time: 3000, icon:2});
					});
				} else{
					layui.use(['layer'], function(){
						for(x in d){
							layer.tips(d[x], '#'+x,{tips: [2,'#8E0000'],tipsMore: true});
						}
						
					});
				}
		   },
		   error: function (jqXHR) {
			   console.log(JSON.stringify(jqXHR));
		   }
	   })
	   
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
				<div class="tit">修改个人资料</div>
				<div class="icon"></div>
			</div>
		</div>
		
		<div class="box">
		<form  enctype="multipart/form-data" name="form1" id="mod_form" action="" method="post">
           	 <table width="100%" border="0" cellspacing="0" class="table">
              <tr>
                <td width="15%" align="right">用户名：</td>
                <td width="85%"><input type="text" class="input_box" id="user_name" name="user_name" value="{$data.user_name}" /></td>
              </tr>
              <tr>
                <td width="15%" align="right">密码：</td>
                <td width="85%"><input type="password" class="input_box" id="password" name="password"  /></td>
              </tr>
			  <tr>
                <td align="right">头像：</td>
                <td ><input type="file"  name="photo" id="photo"/></td>
              </tr>
              <tr>
                <td align="right">签名：</td>
                <td ><input type="text" class="input_box" name="signature" id="signature" value="{$data.signature}" /></td>
              </tr>
              <tr>
                <td align="right">邮箱：</td>
                <td><input type="text" class="input_box" name="email" id="email" value="{$data.email}"/></td>
              </tr>
              <tr>
                <td align="right">电话：</td>
                <td><input type="text" class="input_box" name="phone" id="phone" value="{$data.phone}" /></td>
              </tr>
              <tr>
                <td align="right">地址：</td>
                <td><input type="text" class="input_box" name="address" id="address" value="{$data.address}" /></td>
              </tr>
              <tr>
                <td align="right">&nbsp;</td>
                <td><input type="hidden" name="id" id="user_id" value="{$data.id}"  /><input type="button" class="sub_button" id="modBut"  value="修 改"/></td>
              </tr>
            </table>
            </div>
            
    		</form>
			
			
		</div>
		
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>
{include file="public/footer" /}


</body>
</html>
