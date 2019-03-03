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
<form enctype="multipart/form-data" name="form1" id="log_form" action="<{$app}>/mailRules/mod_temp" method="post">
   	  	<table width="100%" border="0" cellspacing="0" cellpadding="12">
          <tr>
            <td width="18%" align="right"  style="border-bottom:1px dotted #ccc">标签：</td>
            <td width="82%" style="border-bottom:1px dotted #ccc">
				<div class="label-box">
					<ul>
					<{foreach from=$label key=k item=list}>
						<li id="<{$k}>"><{$list}></li>
					<{/foreach}>
					</ul>
				</div>
			</td>
          </tr>
          <tr>
            <td align="right"  style="border-bottom:1px dotted #ccc">模版内容：</td>
            <td  style="border-bottom:1px dotted #ccc"><textarea cols="50" rows="10" name="template" id="template" class="textarea_box"><{$data.template}></textarea></td>
          </tr>
          
          <tr>
            <td align="right"></td>
            <td><input type="hidden" name="id" value="<{$data.id}>"/><input type="submit" class="submit_button"  value="编辑"/></td>
          </tr>
          
        </table>
</form>