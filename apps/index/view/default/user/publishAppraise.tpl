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
			
			

			if($("#content").val()==''){
				
				layui.use(['layer'], function(){
					layer.msg('请填写内容', {time: 3000, icon:2});
				});
				return false;
			}
			var uid=$("#uid").val();
			var pid=$("#pid").val();
			var level=$("input[type='radio']:checked").val();
			var content=$("#content").val();
			$.post("{Leesun:url name='appraiseAdd' /}",{uid:uid,pid:pid,level:level,content:content},function(data){
				
				if(data.code==1){
					layui.use(['layer'], function(){
						layer.msg(data.mess, {time: 3000, icon:1},function(){
							parent.layer.close(index); 
						});
					});
					
						
				} else if(data.code==2) {
					layui.use(['layer'], function(){
						layer.msg(data.mess, {time: 3000, icon:2});
					});
				} else if(data.code==4) {
					layui.use(['layer'], function(){
						layer.msg(data.mess, {time: 3000, icon:2});
					});
				} else if(data.code==5) {
					layui.use(['layer'], function(){
						layer.msg(data.mess, {time: 3000, icon:2});
					});
				}
			});
			
		}
	);
	
})
</script>
<div id="user_box">
	
    <div id="reg_box">
        <div class="content">
            
            <table width="100%" border="0" cellspacing="0" cellpadding="12">
            <tr>
            <td width="23%" height="50" align="right">评价：</td>
            <td width="77%"><input type="radio" name="level" class="level" value="1" checked="checked"/>&nbsp;好评&nbsp;&nbsp;<input type="radio" name="level" class="level" value="2" />&nbsp;中评&nbsp;&nbsp;<input type="radio" name="level" class="level" value="3" />&nbsp;差评</td>
          </tr>
          <tr>
            <td width="23%"  align="right">内容：</td>
            <td width="77%"><textarea name="content" id="content"  style="width:345px;height:100px;"></textarea></td>
          </tr>
          
          <tr>
            <td align="right"></td>
            <td height="70"><input type="hidden" name="uid" value="{$uid}" id="uid" /><input type="hidden" id="pid" name="pid" value="{$pid}" /><input type="button" class="sub_button" value="提交"/></td>
          </tr>
        </table>
        </div>
    </div>
  
</div>
