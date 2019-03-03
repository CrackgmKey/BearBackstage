<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/common.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/layout.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/user.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.caretInsert.js"></script>
<script>
$(document).ready(function(){
	
	$("#send_form").click(
		function(){
			
			if($("#message").val()==''){
				alert('请填写私信内容');
				return false;
			} else {
				var user_id=$("#user_id").val();
				var message=$("#message").val();
				$.post('{Leesun:url name='reply' /}',{user_id:user_id,message:message},function(d){
					if(d=="1"){
						
						alert('回复成功');
						
					} else {
						
						alert('回复失败');
					}
				})
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
	<!--用户登陆-->
	<div id="login_box">
    <div class="content">
    	
   	  	<table width="100%" border="0" cellspacing="0" cellpadding="12">
          <tr>
            <td width="23%" align="right">私信内容：</td>
            <td width="77%"><textarea name="message" id="message"  style="width:345px;height:100px;"></textarea></td>
          </tr>
          <tr>
            <td width="23%" align="right">表情：</td>
            <td width="77%"><div style="width:360px;">{$expression}</div></td>
          </tr>
          <tr>
            <td align="right"></td>
            <td><input type="hidden" name="user_id" id="user_id" value="{$id}" /><input type="button" class="sub_button" id="send_form"  value="发 送"/></td>
          </tr>
        </table>
    </div>
    </div>
    
    
</div>
