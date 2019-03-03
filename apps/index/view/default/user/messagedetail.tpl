<link href="__ROOT____INDEX__/css/common.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/layout.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script>
var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
$(document).ready(function(){
	$(".sub_button").click(
		function(){
			var id=$("#id").val();
			$.post("{Leesun:url name='agreeFriendMessage' /}",{id:id},function(data){
				
				layui.use(['layer'], function(){
					layer.msg(data.msg, {time: 3000, icon:data.code},function(){
						parent.layer.close(index); 
					});
				});
			},'json');
			
		}
	);
	
})
</script>
<div id="user_box">
	
    <div id="reg_box">
        <div class="content">
            
            <table width="100%" border="0" cellspacing="0" cellpadding="12">
             <tr>
            <td width="23%" align="right" height='300'>内容：</td>
            <td width="77%"style="font-size:14px;"><div style="overflow-y:scroll;width:350px;height:230px;border:1px solid #ccc;">{$data.message}</div></td>
          </tr>
          <tr>
            <td align="right"></td>
            <td><input type="hidden" name="id" id="id" value="{$data.id}" /><input type="button" class="sub_button" value="同意"/></td>
          </tr>
        </table>
        </div>
    </div>
   
</div>
