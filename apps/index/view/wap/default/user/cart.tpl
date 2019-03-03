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
			
			$("#score").keyup(
				function(){
					var score=parseFloat("{$userInfo.score}");
					var score_money=parseFloat("{$config.score_money}");
					var input_score=$(this).val();
					var payable=parseFloat("{$payable}");
					var totalprice=parseFloat("{$total_price}");
					var every_max_score=parseFloat("{$config.every_max_score}");
					
					if(every_max_score!=0){
						if(score>=every_max_score){
							max_score=every_max_score;
						} else {
							max_score=score;
						}
					} else {
						max_score=score;
					}
					if(input_score>max_score){
						input_score=max_score;
					}else if(input_score<0 || isNaN(input_score)){
						input_score=0;
					}
					$(this).val(input_score);
					if(input_score>0){
						money=input_score/score_money;
						payable=payable-money;
						totalprice=totalprice-money
						if(payable<0) payable=0;
						$("#payable").html(payable);
						$("#total_price").val(totalprice);
					}else if(input_score==0){
						$("#payable").html("{$payable}");
						$("#total_price").val("{$total_price}");
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
	<form action="{Leesun:url name='addOrder' /}" method="post" id="form1">
	<div class="input-box" >
		<ul>
			{Leesun:cart name='v' uid='$uid'}
			<li style="margin-left:2rem;">
				<div class="img"><img src="__ROOT____PUBLIC__/uploads/{$v.pro.img}" /></div>
				<div class="info">
					<div class="name">{$v.pro.name}</div>
					<div class="spec">
						{volist name="$v.specs_cn" id="d"}
							[{$d}]&nbsp;
						{/volist}
					</div>
					<div class="price">&yen;{$v.price}&nbsp;&nbsp;[数量:{$v.amount}]</div>
				</div>
				<div class="clear"></div>
			</li>
			<input type="hidden" name="price[{$v.pro.id}]" value="{$v.price}" />
            <input type="hidden" name="amount[{$v.pro.id}]" value="{$v.amount}" />
            <input type="hidden" name="specs[{$v.pro.id}]" value="{$v.specs}" />
            <input type="hidden" name="pid[]" value="{$v.pro.id}" />
			<input type="hidden" name="cart_id[]" value="{$v.id}" />
			{/Leesun:cart}
			<li>
				<div class="txt">您有<b>{$userInfo.score}积分</b>，<b>{$config.score_money}</b>积分换1元<br>{if ($config.every_max_score!=0)}&nbsp;&nbsp;，每次使用最多{$config.every_max_score}积分{/if}</div>
			</li>
			<li>
				<span class="tip">使用积分抵现：</span>
				<span class="tip"><input type="checkbox"  name="score_money" id="score_money_but"  class=" score_money" ></span>
				<span id="score_input" class="tip" style="display:none;"><input type="number" name="score" id="score" class="score"/></span>
				<div class="clear"></div>
			</li>
			<li>
				{Leesun:payment name='v'}
					<div class="payment_but" id="{$v.id}">{$v.byname}</div>
				{/Leesun:payment}
				<div class="clear"></div>
				<input type="hidden" name="payment_id" id="payment_id" value="1" />
			</li>
			
			<li>
				<div class="total">
					<div class="price">总价：&yen;{$total_price}</div>
					<div class="price">运费：&yen;{$delivery_fee}</div>
					<div class="price">应付款：&yen;<span id="payable">{$payable}</span></div>
					
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
				<div class="input"><input type="button"  id="submit_but" value="提交订单" class="but" style="background:#ff0000;color:#fff;border:0;margin-bottom:5rem"></div>
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