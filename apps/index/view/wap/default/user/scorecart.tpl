<!DOCTYPE html> 
<html>
<head>
	<title>购物车</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=device-dpi" />
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<link rel="stylesheet" type="text/css" href="__WAP__/css/common.css" />
	<link rel="stylesheet" type="text/css" href="__WAP__/css/user.css" />
	<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
	<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
	<script type="text/javascript" src="__WAP__/js/common.js"></script>
	
	
	<script>
	
		$(document).ready(function(){
		  $(".payment_but:eq(0)").addClass('cur');
		  
		  $(".payment_but").click(function(){
			var id=$(this).attr("id");
			$(".payment_but").removeClass('cur');
			$(this).addClass('cur');
			$("#payment_id").val(id);
		  })
		  $("#score_money_but").click(
				function(){
					if($(this).is(":checked")){
						$("#score_input").show();
						$("#score").val("");
					} else {
						$("#score_input").hide();
						$("#payable").html("{$payable}");
						$("#total_price").val("{$payable}");
					}
				}
			)
			
			
			$("#district").change(
				function(){
					var id=$(this).val();
					
					$("#sdistrict").empty();
					if(id==0){
						
						$("#sdistrict").prepend("<option value=0>请选择</option>"); 
					} else {
					 $.post("{Leesun:url name='ajaxDistrict' /}",{id:id},
					  function(data){
						$.each( data, function(index, content){ 
						  $("#sdistrict").prepend("<option value='"+index+"'>"+content+"</option>"); 
						});
						
					  },
					  "json");//这里返回的类型有：json,html,xml,text
					}
				}
			)
			if($("#district").val()){
				var id=$("#district").val();
				
				 $.post("{Leesun:url name='ajaxDistrict' /}",{id:id},
					  function(data){
						$.each( data, function(index, content){ 
						  $("#sdistrict").prepend("<option value='"+index+"'>"+content+"</option>"); 
						});
						
					  },
					  "json");
			}
			$("#submit_but").click(
				function(){
					var sdistrict=$("#sdistrict").val();
					var address=$("#address").val();
					var name=$("#name").val();
					var tel=$("#tel").val();
					
					$.post("{:url('index/orders/checkInput')}",{sdistrict:sdistrict,address:address,name:name,tel:tel},function(d){
						if(d=="1"){
							$("#form1").submit(); 
						} else{
							layui.use(['layer'], function(){
								for(x in d){
									layer.tips(d[x], '#'+x,{tips: [1,'#8E0000'],tipsMore: true});
								}
							});
							
						}
					});
					
				}
			)
		});
	</script>
</head>
<body>

{include file="public/head" /}
<section>
	{if($cartDatas)}
	<form action="{Leesun:url name='addScoreOrder' /}" method="post" id="form1">
	<div class="input-box" >
		<ul>
			{Leesun:scorecart name='v' uid='$uid'}
			<li style="margin-left:2rem;">
				<div class="img"><img src="__ROOT____PUBLIC__/uploads/{$v.pro.img}" /></div>
				<div class="info">
					<div class="name">{$v.pro.name}</div>
					
					<div class="price">{$config.score_name}:{$v.score}&nbsp;&nbsp;[数量:{$v.amount}]</div>
				</div>
				<div class="clear"></div>
			</li>
			<input type="hidden" name="price[{$v.pro.id}]" value="{$v.score}" />
            <input type="hidden" name="amount[{$v.pro.id}]" value="{$v.amount}" />
            <input type="hidden" name="pid[]" value="{$v.pro.id}" />
			<input type="hidden" name="cart_id[]" value="{$v.id}" />
			{/Leesun:scorecart}
			
			
			
			<li>
				<div class="total">
					<div class="price">应付{$config.score_name}：<span id="payable">{$payable}</span></div>
					
				</div>
			</li>
			<li>
				<div class="t">地区：</div>
				<div class="input"><select name="district" id="district" class="select_box">
                            	<option value="">请选择</option>
								{Leesun:district name='v' pid='0'}
                            		<option value="{$v.id}">{$v.district_name}</option>
                                {/Leesun:district}
                            </select>
							<select name="sdistrict" id="sdistrict" class="select_box">
                            		<option value="">请选择</option>
                            </select></div>
				<div class="clear"></div>
			</li>
			
			<li>
				<div class="t">地址：</div>
				<div class="input"><input type="text" name="address" id="address"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="t">姓名：</div>
				<div class="input"><input type="text" name="name" id="name"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="t">电话：</div>
				<div class="input"><input type="text" name="tel" id="tel"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="t">留言：</div>
				<div class="input"><input type="text" name="message" id="message"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="t"></div>
				<input type="hidden" name="delivery_fee" id="delivery_fee" value="{$delivery_fee}" />
				<input type="hidden" name="total_price" id="total_price" value="{$total_price}" />
				<input type="hidden" name="uid" value="{$userInfo.id}" />
				<div class="input"><input type="button"  id="submit_but" value="立即兑换" class="but" style="background:#ff0000;color:#fff;border:0;margin-bottom:5rem"></div>
			</li>
			
		</ul>
	</div>
	{:token()}
	</form>
	{else}
	<div class="no-content"></div>
	{/if}
	<div class="clear"></div>
</section>

{include file="public/foot" /}

</body>
</html>