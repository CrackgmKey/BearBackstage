<script type="text/javascript">
$(document).ready(function(e) {
    $("#delivery_fee,#total_price").keyup(
		function(){
			
			
			if(isNaN($("#total_price").val())){
				$("#total_price").val("");
			} else {
				var total_price=parseFloat($("#total_price").val());
			}
			if(isNaN($("#delivery_fee").val())){
				$("#delivery_fee").val("");
			} else {
				var delivery_fee=parseFloat($("#delivery_fee").val());
			}
			var pay_price=eval(total_price+delivery_fee);
			$("#pay_price").text(pay_price);
		}
	)
	$("#form1").submit(
		function(){
			
			if($("#total_price").val()==""){
					alert("请填写商品金额!");
					return false;
			}
			if($("#delivery_fee").val()==""){
					alert("请填写运费!");
					return false;
			}
			if(isNaN($("#total_price").val()) || isNaN($("#delivery_fee").val())){
				alert("金额必须为数字!");
				return false;
			}
			
		}
	)
});
</script>
<form enctype="multipart/form-data" name="form1" id="form1" action="<{$app}>/orders/mod_pay" method="post">
   	  	<table width="100%" border="0" cellspacing="0" cellpadding="12">
          <tr>
            <td width="23%" align="right"  style="border-bottom:1px solid #ccc">订单号：</td>
            <td width="77%" style="border-bottom:1px solid #ccc"><{$data.sn}></td>
          </tr>
          <tr>
            <td align="right"  style="border-bottom:1px solid #ccc">收货姓名：</td>
            <td  style="border-bottom:1px solid #ccc"><{$data.name}></td>
          </tr>
          <tr>
            <td align="right"  style="border-bottom:1px solid #ccc">联系电话：</td>
            <td style="border-bottom:1px solid #ccc"><{$data.tel}></td>
          </tr>
          <tr>
            <td align="right" style="border-bottom:1px solid #ccc">收货地址：</td>
            <td style="border-bottom:1px solid #ccc"><{$data.address}></td>
          </tr>
          <tr>
            <td align="right" style="border-bottom:1px solid #ccc">商品金额：</td>
            <td style="border-bottom:1px solid #ccc"><input type="text" name="total_price" id="total_price" value="<{$data.total_price}>"/></td>
          </tr>
          <tr>
            <td align="right" style="border-bottom:1px solid #ccc">运费：</td>
            <td style="border-bottom:1px solid #ccc"><input type="text" name="delivery_fee" id="delivery_fee" value="<{$data.delivery_fee}>"/></td>
          </tr>
          
          <tr>
            <td align="right" style="border-bottom:1px solid #ccc">实付金额：</td>
            <td style="border-bottom:1px solid #ccc">&yen;<span id="pay_price"><{$data.pay_price}></span></td>
          </tr>
          <tr>
            <td align="right" style="border-bottom:1px solid #ccc">支付方式：</td>
            <td style="border-bottom:1px solid #ccc">
            <select name="payment_id" id="payment_id">
                    <{foreach from=$payment_list item=list}>
                    <option value="<{$list.id}>"  <{if $list.id==$data.payment_id}>selected="selected"<{/if}> ><{$list.byname}></option>
                    <{/foreach}>
                </select>
            </td>
          </tr>
          <tr>
            <td align="right"></td>
            <td><input type="hidden" name="id" value="<{$data.id}>"/><input type="submit" class="submit_button"  value="修改"/></td>
          </tr>
          
        </table>
		</form>