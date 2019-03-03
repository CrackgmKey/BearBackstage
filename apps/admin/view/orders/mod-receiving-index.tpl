<script type="text/javascript">
$(document).ready(function(e) {
   
	$("#form1").submit(
		function(){
			
			if($("#name").val()==""){
					alert("请填写收货姓名!");
					return false;
			}
			if($("#tel").val()==""){
					alert("请填写联系电话!");
					return false;
			}
			if($("#address").val()==""){
					alert("请填写收货地址!");
					return false;
			}
		}
	)
});
</script>
<form enctype="multipart/form-data" name="form1" id="form1" action="<{$app}>/orders/mod_preceiving" method="post">
   	  	<table width="100%" border="0" cellspacing="0" cellpadding="12">
          <tr>
            <td width="23%" align="right"  style="border-bottom:1px solid #ccc">订单号：</td>
            <td width="77%" style="border-bottom:1px solid #ccc"><{$data.sn}></td>
          </tr>
          <tr>
            <td align="right"  style="border-bottom:1px solid #ccc">收货姓名：</td>
            <td  style="border-bottom:1px solid #ccc"><input type="text" name="name" id="name" value="<{$data.name}>" /></td>
          </tr>
          <tr>
            <td align="right"  style="border-bottom:1px solid #ccc">联系电话：</td>
            <td style="border-bottom:1px solid #ccc"><input type="text" name="tel" id="tel" value="<{$data.tel}>" /></td>
          </tr>
          <tr>
            <td align="right" style="border-bottom:1px solid #ccc">收货地址：</td>
            <td style="border-bottom:1px solid #ccc"><textarea cols="50" rows="6" name="address"><{$data.address}></textarea></td>
          </tr>
          
          <tr>
            <td align="right"></td>
            <td><input type="hidden" name="id" value="<{$data.id}>"/><input type="submit" class="submit_button"  value="修改"/></td>
          </tr>
          
        </table>
		</form>