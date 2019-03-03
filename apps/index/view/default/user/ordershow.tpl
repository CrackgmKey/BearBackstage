<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/common.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/layout.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/user.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">

<script type="text/javascript">
$(document).ready(function(e) {
    $("#take").click(
		function(){
			var url=$(this).attr("url");
			layui.use(['layer'], function(){
			layer.open({
			  content: '您确定已经收到货了么？'
			  ,btn: ['确定', '取消']
			  ,yes: function(index, layero){
				//按钮【按钮一】的回调
				$.post(url,function(d){
					
						layer.msg(d.msg, {time: 3000, icon:d.code,anim: 2},function(){
							location.reload();
						});
					
				},'json')
			  }
			  ,btn2: function(index, layero){
				//按钮【按钮二】的回调
				
				//return false 开启该代码可禁止点击该按钮关闭
			  }
			  
			  ,cancel: function(){ 
				//右上角关闭回调
				
				//return false 开启该代码可禁止点击该按钮关闭
			  }
			});
			});
		}
	)
});
</script>
<style>
.bot_line{
	border-bottom:1px dotted #ccc;
}
.table{
	font-size:14px;
}
.table td{
	height:35px;
	line-height:23px;
}
</style>
	<div class="content">
		<table width="570" border="0" cellspacing="0" cellpadding="5" align="center" class="table">
              <tr>
                <td class="bot_line" width="23%" align="right">订单号：</td>
                <td class="bot_line" width="77%">{$data.sn}</td>
              </tr>
               <tr>
                <td class="bot_line" width="23%" align="right">订单状态：</td>
                <td class="bot_line" width="77%">{$data.status_cn}</td>
              </tr>
              {if ($d.delivery_status==1)}
               <tr>
                <td class="bot_line" width="23%" align="right">快递单号：</td>
                <td class="bot_line" width="77%" style="color:#F60">{$data.express_sn}</td>
              </tr>
              <tr>
                <td class="bot_line" width="23%" align="right">快递公司：</td>
                <td class="bot_line" width="77%" style="color:#F60">{$data.express_cn}</td>
              </tr>
              {/if}
                <tr>
                <td class="bot_line" width="23%" align="right">名字：</td>
                <td class="bot_line" width="77%">{$data.name}</td>
              </tr>
              <tr>
                <td class="bot_line" width="23%" align="right">电话：</td>
                <td class="bot_line" width="77%">{$data.tel}</td>
              </tr>
              <tr>
                <td class="bot_line" width="23%" align="right">地址：</td>
                <td class="bot_line" width="77%">{$data.address}</td>
              </tr>
              <tr>
                <td class="bot_line" width="23%" align="right">下单时间：</td>
                <td class="bot_line" width="77%">{if ($data.create_time)}{$data.create_time}{else}无{/if}</td>
              </tr>
              <tr>
                <td class="bot_line" width="23%" align="right">支付时间：</td>
                <td class="bot_line" width="77%">{if ($data.pay_time)}{$data.pay_time}{else}无{/if}</td>
              </tr>
              <tr>
                <td class="bot_line" width="23%" align="right">发货时间：</td>
                <td class="bot_line" width="77%">{if ($data.delivery_time)}{$data.delivery_time}{else}无{/if}</td>
              </tr>
              <tr>
                <td class="bot_line" width="23%" align="right">结束时间：</td>
                <td class="bot_line" width="77%">{if ($data.order_time)}{$data.order_time}{else}无{/if}</td>
              </tr>
			  {if($data.type==1)}
              <tr>
                <td class="bot_line" width="23%" align="right">商品金额：</td>
                <td class="bot_line" width="77%">&yen;{$data.total_price}</td>
              </tr>
              <tr>
                <td class="bot_line" width="23%" align="right">运费：</td>
                <td class="bot_line" width="77%">&yen;{$data.delivery_fee}</td>
              </tr>
              <tr>
                <td class="bot_line" width="23%" align="right">应付金额：</td>
                <td class="bot_line" width="77%" style="color:red">&yen;{$data.pay_price}</td>
              </tr>
			  {else}
			  <tr>
                <td class="bot_line" width="23%" align="right">商品{$data.symbol}：</td>
                <td class="bot_line" width="77%">{$data.total_price}</td>
              </tr>
			  {/if}
			  
            </table>
		
	</div>
