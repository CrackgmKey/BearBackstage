<form enctype="multipart/form-data" name="form1" id="log_form" action="<{$app}>/orders/order_paid" method="post">
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
            <td align="right" style="border-bottom:1px solid #ccc">实付金额：</td>
            <td style="border-bottom:1px solid #ccc">&yen;<{$data.pay_price}></td>
          </tr>
          <tr>
            <td align="right" style="border-bottom:1px solid #ccc">支付方式：</td>
            <td style="border-bottom:1px solid #ccc"><{$data.payment_cn}></td>
          </tr>
          <tr>
            <td align="right"></td>
            <td><input type="hidden" name="id" value="<{$data.id}>"/><input type="submit" class="submit_button"  value="付款"/></td>
          </tr>
          
        </table>
		</form>