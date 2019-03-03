<!DOCTYPE html> 
<html>
<head>
	<title>{$config.site_name}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=device-dpi" />
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<link rel="stylesheet" type="text/css" href="__WAP__/css/common.css" />
	<link rel="stylesheet" type="text/css" href="__WAP__/css/product.css" />
	<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="__WAP__/js/common.js"></script>
	{Leesun:product_1 name='proData' id="$Request.param.id" /}
	<script>
		
		
		$(document).ready(function(){
			var uid="{$uid}";
			var len=$(".show-imgs ul li").length;
			var wid=$(".show-imgs ul li").width();
			$(".pimgs").each(function(a,b){
				var img_w=$(b).width();
				var img_h=$(b).height();
				
				if(img_w>img_h){
					$(b).css({"width":wid});
					var dis=wid-$(b).height();
					$(b).css({"margin-top":dis/2});
				} else{
					$(b).css({"height":"18rem"});
					var dis=wid-$(b).width();
					$(b).css({"margin-left":dis/2});
				}
			})
			for(var i=1;i<=len;i++){
				$(".dots ul").append("<li></li>");
			}
			$(".dots ul").append("<div class='clear'></div>");
			$(".dots ul li:last").css({"margin-right":"0"});
			var dotlen=$(".dots ul li").length;
			var dotwidth=$(".dots ul li").width();
			$(".dots ul li:first").addClass("cur");
			$(".dots").css({"width":dotlen*dotwidth*2});
			$(".show-imgs").width(len*wid+2);
			
			$(".dots ul li").click(function(){
				var index=$(this).index();
				$(".dots ul li").removeClass("cur");
				$(this).addClass("cur");
				var dis=$(".imgs").width();
				$(".show-imgs").animate({"left":-index*dis},"fast");
			})
			
			$(".pdetail .tit ul li").click(
				function(){
					var id=$(this).attr("id");
					$(".pdetail .tit ul li").removeClass();
					$(this).addClass("cur");
					$(".pdetail .contents").hide();
					$(".content_"+id).show();
				}
			)
			
			var navH = $(".pdetail").offset().top;
			
			$(document).scroll(function(){
				var scroH = $(this).scrollTop();
				if(scroH>=navH){
					$(".pdetail .tit").addClass("fixed");
				}else if(scroH<navH){
					$(".pdetail .tit").removeClass("fixed");
				}
			})
			
			
			//加入购物车
			$("#addcart").click(
				function(){
					
					if(!uid){
						
						layer.open({
							content: '请先登录后再购买商品'
							,skin: 'msg'
							,time: 2 //2秒后自动关闭
						  });
						return false;
					} else {
						
						var param_num=$(".select_box").length;//分类数量
						var selected_num=$(".select_box ul li.selected").length;//当前选中分类数量
						var specs="";
						
						if(param_num!=selected_num){
							
							layer.open({
								content: '请选择规格'
								,skin: 'msg'
								,time: 2 //2秒后自动关闭
							  });
							return false;
						}
						if(param_num==0){
							specs=0;
						} else{
							$(".select_box ul li.selected").each(function(index, element) {
								specs+=$(this).attr("id")+',';
							});
							
						}
						
						var price=$("#price").text();
						var pid="{$proData.id}";
						var url="{Leesun:url name='addCart' /}";
						var p_num=$("#p_num").val();
						
						var inventory=$("#inventory").attr("data");
						if(!inventory){
							layer.open({
								content: '等有货再购买吧'
								,skin: 'msg'
								,time: 2 //2秒后自动关闭
							  });
							return false;
						}
						if(p_num>inventory){
							layer.open({
								content: '不能大于库存数量'
								,skin: 'msg'
								,time: 2 //2秒后自动关闭
							  });
							return false;
						}
						
						$.ajax({   
							type:"post",     
							url:url,
							data:{pid:pid,uid:uid,amount:p_num,price:price,specs:specs},
							success:function(msg){
								if(msg==1){
									layer.open({
										content: '商品已加入购物车'
										,skin: 'msg'
										,time: 2 //2秒后自动关闭
									  });
									
									var num=$("#cart_num").html();
									num++;
									$("#cart_num").html(num);
								}else if(msg==2){
									layer.open({
										content: '购物车中已有此商品'
										,skin: 'msg'
										,time: 2 //2秒后自动关闭
									  });
								}
							},   
							error:function(){
								layer.open({
									content: '加入购物车失败'
									,skin: 'msg'
									,time: 2 //2秒后自动关闭
								  });
							}   
						});  
					}
				}
			)
			
			$(".addfav").click(
				function(){
					var pid="{$proData.id}";
					if(!uid){
						 layer.open({
							content: '请先登录后再收藏商品'
							,skin: 'msg'
							,time: 2 //2秒后自动关闭
						  });
						return false;
					}
					var url="{Leesun:url name='addFav' /}";
					
					$.ajax({   
						type:"post",     
						url:url,
						data:{pid:pid,user_id:uid},
						success:function(msg){
							if(msg==1){
								layer.open({
									content: '收藏商品成功'
									,skin: 'msg'
									,time: 2 //2秒后自动关闭
								  });
							}else if(msg==2){
								layer.open({
									content: '收藏失败'
									,skin: 'msg'
									,time: 2 //2秒后自动关闭
								  });
							}else if(msg==3){
								layer.open({
									content: '此商品您已收藏'
									,skin: 'msg'
									,time: 2 //2秒后自动关闭
								  });
							}
						},   
						error:function(){
							layer.open({
								content: '收藏失败'
								,skin: 'msg'
								,time: 2 //2秒后自动关闭
							  });
						}   
					});  
				}
			)
			
			$(".select_box ul li").click(
				function(){
					var pid=$(this).attr("pid");
					var current_li_num=$("#select_box_"+pid+" ul li").length;//当前参数可选数量
					var param_num=$(".select_box").length;//分类数量
					
					if(current_li_num<2){
						$(this).toggleClass("selected");
					} else {
						$("#select_box_"+pid+" ul li").removeClass();
						$(this).addClass("selected");
					}
					var selected_num=$(".select_box ul li.selected").length;//当前选中分类数量
					var arr = new Array();
					if(param_num==selected_num){   //如果选完了分类开始判断价格等
						$(".select_box ul li.selected").each(function(){
								arr.push($(this).attr("id"));
								//arr+=$(this).attr("id");
						})
						arr=arr.join(",");
						var img_path="__ROOT____UPLOADS__/";
						$.post("{Leesun:url name='ajaxPrice' /}",{arr:arr,id:"{$Request.param.id}"},function(data){
							  $("#origin_price").html(data.origin_price);
							  $("#price").html(data.current_price);
							  $("#inventory").html(data.inventory);
							  $("#inventory").attr("data",data.inventory);
							  $(".main-img").attr("src",img_path+data.img);
						 },"json");
						
					}
			})
			
			//去结算
			$("#settlement").click(
				function(){
					if(!uid){
						layer.open({
							content: '请先登录后再结算商品'
							,skin: 'msg'
							,time: 2 //2秒后自动关闭
						  });
						return false;
					} else {
						var param_num=$(".select_box").length;//分类数量
						var selected_num=$(".select_box ul li.selected").length;//当前选中分类数量
						var specs="";
						if(param_num!=selected_num){
							layer.open({
								content: '请选择规格'
								,skin: 'msg'
								,time: 2 //2秒后自动关闭
							  });
							return false;
						}
						if(param_num==0){
							specs=0;
						} else{
							$(".select_box ul li.selected").each(function(index, element) {
								specs+=$(this).attr("id")+',';
							});
							
						}
						
						var price=$("#price").text();
						var pid="{$proData.id}";
						var url="{Leesun:url name='addCart' /}";
						var p_num=$("#p_num").val();
						var inventory=$("#inventory").attr("data");
						if(!inventory){
							layer.open({
								content: '等有货再购买吧'
								,skin: 'msg'
								,time: 2 //2秒后自动关闭
							  });
							return false;
						}
						$.ajax({   
							type:"post",     
							url:url,
							data:{pid:pid,uid:uid,amount:p_num,price:price,specs:specs},
							success:function(msg){
								window.location.href="{Leesun:url name='cart' /}";
							},   
							error:function(){
								layer.open({
									content: '加入购物车失败'
									,skin: 'msg'
									,time: 2 //2秒后自动关闭
								  });
								return false;
							}   
						});  
					}
				}
			)
			
			$("#appraise").click(
			  function(){
				  if(!uid){
					 layer.open({
						content: '请先登录后再评价商品'
						,skin: 'msg'
						,time: 2 //2秒后自动关闭
					  });
					 return false;
				  } else {
						var id="{$proData.id}";
						$.get("{Leesun:url name='appraisetimes' /}",{id:id},function(data){
							
							if(data.times>0){
								
								$("#appraise-box").slideDown("fast");
								$("#appraise-box").bind("touchmove",function(e){e.preventDefault();});
								$(".mask").bind("touchmove",function(e){e.preventDefault();});
								$(".mask").show();
									
							} else {
								layer.open({
									content: '还未购买或已够评价次数'
									,skin: 'msg'
									,time: 2 //2秒后自动关闭
								  });
								
								return false;
							}
						});
						
			  
				  }
				}
			  )
			  
			$(".consult").click(function(){
				
				if(!uid){
					layer.open({
						content: '请先登录后再评价商品'
						,skin: 'msg'
						,time: 2 //2秒后自动关闭
					  });
					return false;
				} else {
					var id=$(this).attr("id");
					
					$("#consult-box").slideDown("fast");
					$("#consult-box").bind("touchmove",function(e){e.preventDefault();});
					$(".mask").bind("touchmove",function(e){e.preventDefault();});
					$(".mask").show();
				}
			})
			$(".close").click(function(){
				$(".mask").hide();
				$(".mask").unbind("touchmove");
				$(".operator-window").slideUp("fast");
			})
			
			$("#consult_but").click(function(){
				if(!uid){
					layer.open({
						content: '请先登录'
						,skin: 'msg'
						,time: 2 //2秒后自动关闭
					  });
				} else {
					var pid='{$proData.id}';
					var content=$("#content").val();
					if(content==''){
						layer.open({
							content: '内容不能为空'
							,skin: 'msg'
							,time: 2 //2秒后自动关闭
						  });
					} else {
						$.ajax({   
							type:"post",     
							url:"{:url('index/consult/question')}",
							data:{pid:pid,uid:uid,question:content},
							success:function(msg){
								if(msg==1){
									
									
									layer.open({
										content: '提问成功，等待管理员回复'
										,skin: 'msg'
										,time: 2 //2秒后自动关闭
									  });
									  
									$("#content").val("");
									$(".mask").hide();
									$(".mask").unbind("touchmove");
									$("#consult-box").slideUp("fast");
								}else if(msg==2){
									layer.open({
										content: '提问失败'
										,skin: 'msg'
										,time: 2 //2秒后自动关闭
									  });
								}
							},   
							error:function(){
								
								layer.open({
										content: '提问失败'
										,skin: 'msg'
										,time: 2 //2秒后自动关闭
									  });
							}   
						}); 
					}
				}
				
				
			})
			
			$("#appraise_but").on('click',function(){
					if(!uid){
						layer.open({
							content: '请先登录'
							,skin: 'msg'
							,time: 2 //2秒后自动关闭
						  });
					} else {
						var pid='{$proData.id}';
						
						var level=$("input[type='radio']:checked").val();
						var app_content=$("#app_content").val();
						
						if(app_content==''){
							layer.open({
								content: '评价内容不能为空'
								,skin: 'msg'
								,time: 2 //2秒后自动关闭
							  });
						} else {
							$.post("{Leesun:url name='appraiseAdd' /}",{uid:uid,pid:pid,level:level,content:app_content},function(data){
					
								layer.open({
									content: data.mess
									,skin: 'msg'
									,time: 2 //2秒后自动关闭
								  });
								if(data.code==1){
									$("#app_content").val("");
									$(".mask").hide();
									$(".mask").unbind("touchmove");
									$("#appraise-box").slideUp("fast");
								}
							});
						}
					}
				});
			
		});
	</script>
</head>
<body>

{include file="public/head" /}
<section>
	<div class="imgs">
	<div class="show-imgs">
		<ul>
			<li><img src='{$proData.img}' class="pimgs"/></li>
			{volist name="proData['spec']" id="v"}
			<li><img src="{$v.img}" class="pimgs"></li>
			{/volist}
			<div class="clear"></div>
		</ul>
	</div>
	</div>
	
	<div class="dots">
		<ul>
		</ul>
	</div>
	
	<input type="hidden" id="product_id" value="{$proData.id}">
	
	<h1 class="pname">{$proData.name}</h1>
	<div class="pinfo">
		<div class="price">&yen;<span id="price">{$proData.current_price}</span></div>
		<div class="price_o" id="origin_price">&yen;{$proData.origin_price}</div>
		<div class="clear"></div>
	</div>
	<div class="pinfo" style="height:4.5rem;">
		<div class="addcart pbut" id="addcart">购物车</div>
		<div class="addfav pbut" id="addfav">收藏</div>
		<div class="buy pbut" id="settlement">购买</div>
		<div class="consult pbut" id="consult">咨询</div>
		<div class="appraise pbut" id="appraise">评价</div>
		<div class="clear"></div>
	</div>
	<div class="pinfo">
		<div class="specs">
			<ul>
		    {Leesun:spec name='v' pid='0' cate_id='$proData.cate_id'}
				<li>
					<div class="t">{$v.name}</div>
					<div class="d">
						<div class="select_box" id="select_box_{$v.id}">
							<ul>
								{Leesun:spec name='sv' pid='$v.id'}
									
									<li id="{$sv.id}" pid="{$sv.pid}">{$sv.name}</li>
									
								{/Leesun:spec}
								<div class="clear"></div>
							</ul>
						</div>
					</div>
				</li>
				<div class="clear"></div>
			{/Leesun:spec}
				<li>
					<div class="t">购买数量</div>
					<div class="d"><input type="number" class="p_num" value="1" id="p_num"></div>
				</li>
				<div class="clear"></div>
			</ul>
		</div>
	</div>
	<div class="pinfo">
		<div class="txt">库存:<span id="inventory" data="{$proData.inventory}">{$proData.inventory}</span>件</div>
		<div class="txt">上架时间：{$proData.add_time}</div>
		<div class="click">浏览：{$proData.click}</div>
		<div class="clear"></div>
	</div>
	<div class="pdetail">
		<div class="tit">
			<ul>
				<li class="cur" id="1">商品详情</li>
				<li id="2">规格详情</li>
				<li id="3">商品评价</li>
				<li id="4">商品咨询</li>
			</ul>
		</div>
		
		<div class="content_1 contents">
			{$proData.brief}
		</div>
		<div class="content_2 contents"  style="display:none;">
			{$proData.specifications}
		</div>
		<div class="content_3 contents"  style="display:none;">
			{Leesun:appraise name='v' pid='$Request.param.id'}
			<div class="consult">
				<div class="user-info">
					<p class="avatar">{if ($v.user.photo)}<img src="__ROOT____UPLOADS__/{$v.user.photo}">{else}<img src="__WAP__/images/user_default.gif">{/if}</p>
					<p class="username">{$v.user.user_name}</p>
					<p class="time">{$v.level_cn}</p>
					<p class="time">{$v.content_time}</p>
					<div class="clear"></div>
				</div>
				
				<div class="msg-info">
					{$v.content}
				</div>
				{if ($v.admin)}
				<div class="user-info">
					<p class="avatar">{if ($v.admin)}<img src="__ROOT____UPLOADS__/{$v.admin.avatar}">{else}<img src="__WAP__/images/user_default.gif">{/if}</p>
					<p class="username">{$v.admin.adm_name}</p>
					<p class="time">{$v.reply_time}</p>
					<div class="clear"></div>
				</div>
				<div class="msg-info" style="color:green;">
					{$v.reply}
				</div>
				{/if}
			</div>
			{/Leesun:appraise}
		</div>
		<div class="content_4 contents"  style="display:none;">
			{Leesun:consult name='v' pid='$Request.param.id' verify='1' is_reply='3'}
			<div class="consult">
				<div class="user-info">
					<p class="avatar">{if ($v.user.photo)}<img src="__ROOT____UPLOADS__/{$v.user.photo}">{else}<img src="__WAP__/images/user_default.gif">{/if}</p>
					<p class="username">{$v.user.user_name}</p>
					<p class="time">{$v.q_time}</p>
					<div class="clear"></div>
				</div>
				
				<div class="msg-info">
					{$v.question}
				</div>
				{if ($v.admin)}
				<div class="user-info">
					<p class="avatar">{if ($v.admin.avatar)}<img src="__ROOT____UPLOADS__/{$v.admin.avatar}">{else}<img src="__WAP__/images/user_default.gif">{/if}</p>
					<p class="username">{$v.admin.adm_name}</p>
					<p class="time">{$v.a_time}</p>
					<div class="clear"></div>
				</div>
				<div class="msg-info" style="color:green;">
					{$v.answer}
				</div>
				{/if}
			</div>
			{/Leesun:consult}
			<!--<div class="qtit">
				我要提问:
			</div>
			<textarea rows="3" cols="30" name="question" class="textbox">
			</textarea>
			<div class="button">提交</div>-->
		</div>
	</div>
	
	<div class="operator-window" id='consult-box'>
		<div class="close">×</div>
		<div class="content">
		
			<div class="tit">在线咨询</div>
			<div class="consult_con">
				
				<div class="textarea">
					<textarea class="ta" name="content" id="content"></textarea>
				</div>
				
				<div class="but" id="consult_but">提交</div>
				
				
			</div>
			
		</div>
	</div>
	
	<div class="operator-window" id='appraise-box'>
		<div class="close">×</div>
		<div class="content">
		
			<div class="tit">评价商品</div>
			<div class="consult_con">
				<div class="level_box">
				<input type="radio" name="level" class="level" value="1" checked="checked"/>&nbsp;好评&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="level" class="level" value="2" />&nbsp;中评&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="level" class="level" value="3" />&nbsp;差评
				</div>
				<div class="textarea">
					<textarea class="ta" name="content" id="app_content"></textarea>
				</div>
				
				<div class="but" id="appraise_but">提交</div>
				
				
			</div>
			
		</div>
	</div>
	
</section>

{include file="public/foot" /}

</body>
</html>