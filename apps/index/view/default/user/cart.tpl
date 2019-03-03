<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=7">
<title>{$config.site_name}</title>
<meta name="keywords" content="{$config.key_word}" />
<meta name="description" content="{$config.description}" />
<meta name="author" content="乐尚商城" />
<meta name="copyright" content="leesuntech.com" />
<link rel="shortcut icon" href="__ROOT____UPLOADS__/{$config.favicon}" />
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/common.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/layout.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/cart.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
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
	
	$("input[name='payment_id']:eq(0)").attr("checked","checked");
	
	
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
	
	$(".delPro").on("click",function(){
		var url=$(this).attr("url");
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 window.location.href=url;
			  layer.close(index);
			});
		});
	})
	
	$("#addOrder").on('click',
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
							layer.tips(d[x], '#'+x,{tips: [2,'#8E0000'],tipsMore: true});
						}
					});
				}
			});
		}
	)
	
	
	
})
</script>
</head>

<body>
{include file="public/header" /}
{if($cartDatas)}
<form action="{Leesun:url name='addOrder' /}" enctype="multipart/form-data" method="post" id="form1">

<div id="body" class="web_body">
	
    <div class="cart_box">
    	
        <div class="content">
        	<div class="p_tit">
            	<ul>
                	<li style="width:300px;">商品图片</li>
                    <li style="width:450px;">名称</li>
                    <li style="width:100px;">单价</li>
                    <li style="width:130px;">数量</li>
                    <li style="width:120px;">操作</li>
                </ul>
            </div>
		   {Leesun:cart name='v' uid='$uid'}
          
            
            <div class="p_con">
            	<ul>
                	<li style="width:300px;"><img src="__ROOT____PUBLIC__/uploads/{$v.pro.img}" /></li>
                    <li style="width:450px;">
                    	<div style="line-height:20px;">
                            {$v.pro.name}&nbsp;<p style="color:red;">所选参数：
							{volist name="$v.specs_cn" id="d"}
                            
                                [{$d}]&nbsp;
                            
							{/volist}
                            </p>
                        </div>
                    </li>
                    <li style="width:100px;">&yen;{$v.price}</li>
                    <li style="width:130px;">{$v.amount}</li>
                    <li style="width:120px;cursor:pointer"><a href="javascript:;" url="{$v.del_url}" class="delPro">删除</a></li>
                </ul>
                <div class="clear"></div>
            </div>
            <input type="hidden" name="price[{$v.pro.id}]" value="{$v.price}" />
            <input type="hidden" name="amount[{$v.pro.id}]" value="{$v.amount}" />
            <input type="hidden" name="specs[{$v.pro.id}]" value="{$v.specs}" />
            <input type="hidden" name="pid[]" value="{$v.pro.id}" />
			<input type="hidden" name="cart_id[]" value="{$v.id}" />
           
            
			{/Leesun:cart}
            
            
			
            <div class="content">
                <div class="p_tit">
                    <ul>
                        <li style="width:350px;">您的积分</li>
                        <li style="width:450px;">积分抵现</li>
                        <li style="width:100px;">总价</li>
                        <li style="width:130px;">运费</li>
                        <li style="width:120px;">应付款</li>
                    </ul>
                </div>
                <div class="p_con">
                    <ul>
                        <li style="width:350px;color:red;">您有<b>{$userInfo.score}积分</b>，{$config.score_money}积分换1元{if ($config.every_max_score!=0)}&nbsp;&nbsp;，每次使用最多{$config.every_max_score}积分{/if}</li>
                        <li style="width:450px;"><input type="checkbox" id="score_money_but" name="score_money" value="1" />&nbsp;
                        	<span id="score_input" style="display:none;">请输入抵的积分<input type="text" name="score" id="score" style="width:50px;"/></span>
                        </li>
                        <li style="width:100px;">&yen;{$total_price}</li>
                        <li style="width:130px;">&yen;{$delivery_fee}</li>
                        <li style="width:120px;font-size:16px;color:red;font-weight:bold;">&yen;<span id="payable">{$payable}</span></li>
                    </ul>
                    <div class="clear"></div>
                </div>
            </div>
            <input type="hidden" name="delivery_fee" id="delivery_fee" value="{$delivery_fee}" />
            <input type="hidden" name="total_price" id="total_price" value="{$total_price}" />
            <div class="content">
                <div class="p_tit">
                    <ul>
                        <li style="width:280px;">支付方式</li>
                        <li style="width:850px;">介绍</li>
                    </ul>
                </div>
                
				{Leesun:payment name='v'}
                <div class="p_con" id="payment">
                    <ul>
                        <li style="width:280px;color: #3399FF; text-align:left;text-indent:9em;"><input type="radio" name="payment_id" value="{$v.id}" />{$v.byname}</li>
                        <li style="width:850px;text-align:left;text-indent:15em;">{$v.introduction}
                        	
                        </li>
                        
                    </ul>
                    <div class="clear"></div>
                </div>
                {/Leesun:payment}
            </div>
            
            <div class="content">
                <div class="p_tit">
                    <ul>
                        <li style="width:300px;">收货信息</li>
                       
                    </ul>
                </div>
                <div class="p_con">
                    <ul>
                        <li style="width:950px;color: #333333;text-align:left;text-indent:10em;" class="clear">收货地区：
                        	<select name="district" id="district" class="select_box">
                            	<option value="">请选择</option>
								{Leesun:district name='v' pid='0'}
                            		<option value="{$v.id}">{$v.district_name}</option>
                                {/Leesun:district}
                            </select>&nbsp;&nbsp;
                            <select name="sdistrict" id="sdistrict" class="select_box">
                            		<option value="">请选择</option>
                            </select>
							<span class="tip">*</span>
                        </li>
                        <li style="width:950px;text-align:left;text-indent:10em;" class="clear">收货地址：<input type="text" name="address" id="address" style="width:300px;" class="input_box"/><span class="tip">*</span></li>
                        <li style="width:950px;text-align:left;text-indent:10em;" class="clear">收货姓名：<input type="text" name="name" id="name" style="width:150px;" class="input_box"/><span class="tip">*</span></li>
                        <li style="width:950px;text-align:left;text-indent:10em;" class="clear">联系电话：<input type="text" name="tel" id="tel" style="width:150px;" class="input_box"/><span class="tip">*</span></li>
                        <li style="width:950px;text-align:left;text-indent:10em;" class="clear">用户留言：<input type="text" name="message" style="width:500px;" class="input_box"/></li>
                        <li style="text-align:left;margin-left:60px" class="clear"><input type="hidden" name="uid" value="{$userInfo.id}" /><input type="button" id="addOrder" class="submit" value="提交订单" /></li>
                    </ul>
                    <div class="clear"></div>
                </div>
            </div>
          
            
        </div>
    </div>
    
</div>
{:token()}

</form>
{else}
<div class="no-content"></div>
 {/if}
{include file="public/footer" /}
</body>
</html>
