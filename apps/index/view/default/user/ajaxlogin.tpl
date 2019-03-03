<link href="__ROOT____INDEX__/css/common.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/layout.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/user.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script>
var index = parent.layer.getFrameIndex(window.name);
$(document).ready(function(){
	$("#user_name").focus(function(){
		$(this).val("");
	});
	$("#user_name").blur(function(){
		$(this).val("邮箱 或 用户名");
	});
	
	$(".sub_button").click(
		function(){
			if($("#user_name").val()=='邮箱 或 用户名'){
				$("#user_name").val("");
			}
			
			var user_name=$("#user_name").val();
			var password=$("#password").val();
			
			$.post("{Leesun:url name='ajaxLogin' /}",{user_name:user_name,password:password},function(d){
					
				
				if(d=='1'){
					 layui.use(['layer'], function(){
						var index=layer.alert('恭喜您登陆成功', {
						  skin: 'layui-layer-molv'
						   ,closeBtn: 0
						   ,anim: 1 //动画类型
						   ,yes: function(layero){
							 parent.layer.close(index);
							
						  }
						});
					});
					
					
				}  else if(d=='3'){
					layui.use(['layer'], function(){
						layer.msg('用户名或密码错误', {time: 3000, icon:2,anim: 2});
					});
				}else{
					layui.use(['layer'], function(){
						for(x in d){
							layer.tips(d[x], '#'+x,{tips: [2,'#8E0000'],tipsMore: true});
						}
						
					});
				}
			})
		}
	);
	
	$("#user_reg").click(
		function(){
			open_url=APP_PATH+'/user/reg_index';
			window.location.href=open_url;

		}
	)
	
	$("#message").click(
		function(){
			open_url=APP_PATH+'/message';
			window.location.href=open_url;

		}
	)
	
	$("#forget").click(
		function(){
			open_url=APP_PATH+'/user/get_pass_index';
			window.location.href=open_url;

		}
	)
	

})
</script>
<div id="user_box">
	<!--用户登陆-->
	<div id="login_box">
	
    <div class="content">
    	<form enctype="multipart/form-data" name="form1" id="log_form" action="{Leesun:url name='login' /}" method="post">
   	  	<table width="100%" border="0" cellspacing="10" cellpadding="12">
          <tr>
            <td width="23%" height="70" align="right">用户名：</td>
            <td width="77%"><input type="text" class="input_box" name="user_name" id="user_name" value="邮箱 或 用户名"/></td>
          </tr>
          <tr>
            <td align="right" height="70" >密码：</td>
            <td><input type="password" class="input_box" id="password" name="password"  /></td>
          </tr>
          <tr>
            <td align="right" height="70"></td>
            <td><input type="button" class="sub_button"  value="登 陆"/></td>
          </tr>
         
        </table>
		</form>
    </div>
    </div>
    
    
</div>
