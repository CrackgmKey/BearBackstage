<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/common.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/layout.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/user.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.caretInsert.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script>
$(document).ready(function(){
	
	$("#send_form").click(
		function(){
			
			if($("#message").val()==''){
				layui.use(['layer'], function(){
					layer.msg('请填写请求内容', {time: 3000, icon:2});
				});
				return false;
			}else {
				var friend_id=$("#friend_id").val();
				var message=$("#message").val();
				$.post('{Leesun:url name='sendFriend' /}',{friend_id:friend_id,message:message},function(d){
					layui.use(['layer'], function(){
						layer.msg(d.msg, {time: 3000, icon:d.code});
					});
					
				},'json')
			}
		}
	);
	
	$(".expression").click(
		function(){
			var html=$(this).attr("id");
			$('#message').setCaret();
			$('#message').insertAtCaret(html);
		}
	)
	

})
</script>
<div id="user_box">
	<!--好友添加-->
	<div id="login_box">
    <div class="content">
    	
   	  	<table width="100%" border="0" cellspacing="10" cellpadding="12">
          <tr>
            <td width="23%" align="right" height="130">添加请求：</td>
            <td width="77%"><textarea name="message" id="message"  style="width:345px;height:100px;"></textarea></td>
          </tr>
          <tr>
            <td width="23%" align="right" height="200">表情：</td>
            <td width="77%"><div style="width:360px;">{$expression}</div></td>
          </tr>
          <tr>
            <td align="right"></td>
            <td><input type="hidden" name="friend_id" id="friend_id" value="{$user_id}" /><input type="button" class="sub_button" id="send_form" value="发 送"/></td>
          </tr>
        </table>
		
    </div>
    </div>
    
    
</div>
