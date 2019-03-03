<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript">
$(document).ready(function(e) {
    $("#express_id").change(function(){
		var id=$(this).val();
		if(id!=0){
			$("#express_sn").show();
		}else {
			$("#express_sn").hide();
		}
	});
	
	
	$("#form1").submit(
		function(){
			
			if($("#express_id").val()!=0){
				if($("#express_sn_txt").val()==""){
					
					layui.use(['layer'], function(){
						layer.msg('请填写快递单号', {time: 3000, icon:2,anim: 2});
					});
					return false;
				}
			}
		}
	)
});
</script>
<style>
	.tab{
		font-size:14px;
		
	}
</style>
<form enctype="multipart/form-data" name="form1" id="form1" action="{:url('admin/orders/deliver')}" method="post">
   	  	<table width="100%" border="0" cellspacing="0" cellpadding="12" class="tab">
          <tr>
            <td width="23%" height='45' align="right"  style="border-bottom:1px solid #ccc;font-weight:bold">订单号：</td>
            <td width="77%" style="border-bottom:1px solid #ccc;color:green;">{$data.sn}</td>
          </tr>
          <tr>
            <td align="right" height='45' style="border-bottom:1px solid #ccc;font-weight:bold">收货姓名：</td>
            <td  style="border-bottom:1px solid #ccc;color:green;">{$data.name}</td>
          </tr>
          <tr>
            <td align="right" height='45' style="border-bottom:1px solid #ccc;font-weight:bold">联系电话：</td>
            <td style="border-bottom:1px solid #ccc;color:green;">{$data.tel}</td>
          </tr>
          <tr>
            <td align="right" height='45' style="border-bottom:1px solid #ccc;font-weight:bold">收货地址：</td>
            <td style="border-bottom:1px solid #ccc;color:green;">{$data.address}</td>
          </tr>
		  {if($data.type==1)}
          <tr>
            <td align="right" height='45' style="border-bottom:1px solid #ccc;font-weight:bold">实付金额：</td>
            <td style="border-bottom:1px solid #ccc;color:green;">&yen;{$data.pay_price}</td>
          </tr>
		  {else}
		  <tr>
            <td align="right" height='45' style="border-bottom:1px solid #ccc;font-weight:bold">实付积分：</td>
            <td style="border-bottom:1px solid #ccc;color:green;">{$data.pay_price}</td>
          </tr>
		  {/if}
          <tr>
            <td align="right" height='45' style="border-bottom:1px solid #ccc;font-weight:bold">支付方式：</td>
            <td style="border-bottom:1px solid #ccc;color:green;">{$data.payment_cn}</td>
          </tr>
          <tr>
            <td align="right" height='45' style="border-bottom:1px solid #ccc;font-weight:bold">快递：</td>
            <td style="border-bottom:1px solid #ccc;color:green;">
            	<select name="express_id" id="express_id">
                	<option value="0">无需快递</option>
                    {volist name="expressDatas" id="d"}
                    <option value="{$d.id}" {if($d.id==$data.express_id)}selected{/if}>{$d.name}</option>
                    {/volist}
                </select>
            </td>
          </tr>
          <tr {if(!$data.express_id)}style="display:none;"{/if} id="express_sn">
            <td align="right" height='45' style="border-bottom:1px solid #ccc;font-weight:bold">快递单号：</td>
            <td style="border-bottom:1px solid #ccc">
            	<input type="text" name="express_sn" id="express_sn_txt" value="{$data.express_sn}" />
            </td>
          </tr>
          
          <tr>
            <td align="right" height='45'></td>
            <td><input type="hidden" name="id" value="{$data.id}"/><input type="submit" class="input-button"  value="确认发货"/></td>
          </tr>
          
        </table>
		</form>