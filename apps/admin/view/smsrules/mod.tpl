<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.caretInsert.js"></script>

<script>
$(document).ready(function(){
	$(".label-box ul li").click(
		function(){
			
			var id=$(this).attr("id");
			
			$('#template').setCaret();
			$('#template').insertAtCaret(id);
		}
	)
})
</script>
<form enctype="multipart/form-data" name="form1" id="log_form" action="{:url('admin/smsrules/mod')}" method="post">
   	  	<table width="100%" border="0" cellspacing="0" cellpadding="12">
          <tr>
            <td width="18%" align="right"  style="border-bottom:1px dotted #ccc">标签：</td>
            <td width="82%" style="border-bottom:1px dotted #ccc">
				<div class="label-box">
					<ul>
					
					{volist name="labels" id="label"}
						<li id="{$key}">{$label}</li>
					{/volist}
					</ul>
				</div>
			</td>
          </tr>
          <tr>
            <td align="right"  style="border-bottom:1px dotted #ccc">模版内容：</td>
            <td  style="border-bottom:1px dotted #ccc"><textarea cols="80" rows="10" name="template" id="template" class="textarea_box">{$data.template}</textarea></td>
          </tr>
          
          <tr>
            <td align="right"></td>
            <td><input type="hidden" name="id" value="{$data.id}"/><input type="submit" class="submit_button"  value="编辑"/></td>
          </tr>
          
        </table>
</form>