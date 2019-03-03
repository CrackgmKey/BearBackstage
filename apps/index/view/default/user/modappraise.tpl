<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/common.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/layout.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/user.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script>
$(document).ready(function(){
	$(".sub_button").click(
		function(){
			
			if($("#content").val()==''){
				layui.use(['layer'], function(){
					layer.msg('请填写内容', {time: 3000, icon:2});
				});
				return false;
			} else {
				var level=$("input[name='level']:checked").val(); ;
				var content=$("#content").val();
				var id=$("#id").val();
				$.post("{:url('index/appraise/modAppraise')}",{level:level,content:content,id:id},function(d){
					layui.use(['layer'], function(){
						layer.msg(d.msg, {time: 3000, icon:d.code});
					});
				},'json')
			}
		}
	);
	
})
</script>
<div id="user_box">
	
    <div id="reg_box">
        <div class="content">
            
            <table width="100%" border="0" cellspacing="0" cellpadding="12">
            <tr>
            <td width="23%" height='40' align="right">评价：</td>
            <td width="77%"><input type="radio" name="level" class="level" value="1" {if ($data.level==1)}checked="checked"{/if}/>&nbsp;好评&nbsp;&nbsp;<input type="radio" name="level" class="level" value="2" {if ($data.level==2)}checked="checked"{/if}/>&nbsp;中评&nbsp;&nbsp;<input type="radio" class="level" name="level" value="3" {if ($data.level==3)}checked="checked"{/if}/>&nbsp;差评</td>
          </tr>
          <tr>
            <td width="23%" height='120' align="right">内容：</td>
            <td width="77%"><textarea name="content" id="content"  style="width:345px;height:100px;">{$data.content}</textarea></td>
          </tr>
		  {if ($data.is_reply)}
          <tr>
            <td width="23%" height='140' align="right">回复：</td>
            <td width="77%" style="font-size:14px;"><div style="overflow-y:scroll;width:350px;height:100px;border:1px solid #ccc;">{$data.reply}</div></td>
          </tr>
		  {/if}
          <tr>
            <td align="right"></td>
            <td><input type="hidden" name="id" id="id" value="{$id}" /><input type="button" class="sub_button" value="提交"/></td>
          </tr>
        </table>
        </div>
    </div>
</div>
