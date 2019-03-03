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
<link href="__ROOT____INDEX__/css/jqzoom.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/unslider.min.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.jqzoom.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jQuery.autoIMG.js"></script>
{Leesun:product_1 name='proData' id="$Request.param.id" /}
<script>
$(function(){
	$('.img-box .main').autoIMG();
	$("#product-box ul li:nth-child(4n)").css('margin-right','0');
	var uid="{$uid}";
	
	/*$(window).load(function() {
		$('div.main').imagefit({
			mode: 'inside',
			force : true,
			halign : 'center',
			valign : 'middle'
		});

	});*/

	 $(".jqzoom").jqueryzoom({
			xzoom: 300, //放大图的宽度(默认是 200)
			yzoom: 300, //放大图的高度(默认是 200)
			offset: 13, //离原图的距离(默认是 10)
			position: "right", //放大图的定位(默认是 "right")
			preload: 1
		});
			
	var cur_num=$("#p_num").val();
	$("#sub").click(
		function(){
			
			if(cur_num>1){
				cur_num--;
				$("#p_num").val(cur_num);
			} 
		}
	)
	$("#add").click(
		function(){
			var inventory=$("#inventory").attr("data");
			if(cur_num<inventory){
				cur_num++;
				$("#p_num").val(cur_num);
			} 
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
			if(param_num==selected_num){  //如果选完了分类开始判断价格等
				$(".select_box ul li.selected").each(
					function(){
						arr.push($(this).attr("id"));
						//arr+=$(this).attr("id");
					}
				)
				arr=arr.join(",");
				var img_path="__ROOT____UPLOADS__/";
				$.post("{Leesun:url name='ajaxPrice' /}",{arr:arr,id:"{$Request.param.id}"},
				 function(data){
						
					  $("#origin_price").html(data.origin_price);
					  $("#price").html(data.current_price);
					  $("#inventory").html(data.inventory);
					  $("#inventory").attr("data",data.inventory);
					  $(".main-img").attr("src",img_path+data.img);
					  $(".main-img").attr("jqimg",img_path+data.img);
				 },"json");
				
			}
		}
	)
	
	$(".detail_box .tit ul li").click(
		function(){
			var id=$(this).attr("id");
			$(".detail_box .tit ul li").removeClass();
			$(this).addClass("selected");
			$(".detail_box .content").hide();
			$("#con_"+id).show();
		}
	)
	
	$(".appraise_menu ul li").click(
		function(){
			var id=$(this).attr("id");
			$(".appraise_menu ul li").removeClass();
			$(this).addClass("s");
			$(".appraise_content").hide();
			$("#appraise_content_"+id).show();
		}
	)
	
	//结算
	$(".cart-list").click(function(){
		if(!uid){
			open_url="{Leesun:url name='ajaxLogin' /}";
			layui.use(['layer', 'form'], function(){
				layer.open({
				  type: 2,
				  area: ['590px', '320px'],
				  title:'详细内容',
				  fixed: false, //不固定
				  maxmin: true,
				  content: open_url
				});
			});
			return false;
		} else {
			window.location.href="{Leesun:url name='cart' /}";
		}
		
	})
	
	//加入购物车
	$(".buy").click(
		function(){
			if(!uid){
				open_url="{Leesun:url name='ajaxLogin' /}";
					layui.use(['layer', 'form'], function(){
						layer.open({
						  type: 2,
						  area: ['590px', '350px'],
						  title:'用户登陆',
						  fixed: false, //不固定
						  maxmin: false,
						  content: open_url
						  
						});
					});
					return false;
			} else {
				var param_num=$(".select_box").length;//分类数量
				var selected_num=$(".select_box ul li.selected").length;//当前选中分类数量
				var specs="";
				if(param_num!=selected_num){
				
					layui.use(['layer'], function(){
						layer.msg('请选择规格', {time: 3000, icon:2});
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
					
					layui.use(['layer'], function(){
						layer.msg('等有货再购买吧', {time: 3000, icon:2});
					});
					return false;
				}
				$.ajax({   
					type:"post",     
					url:url,
					data:{pid:pid,uid:uid,amount:p_num,price:price,specs:specs},
					success:function(msg){
						if(msg==1){
							
							layui.use(['layer'], function(){
								layer.msg('商品已加入购物车', {time: 3000, icon:1});
							});
							var num=$("#cart_num").html();
							num++;
							$("#cart_num").html(num);
						}else if(msg==2){
							
							layui.use(['layer'], function(){
								layer.msg('购物车中已有此商品', {time: 3000, icon:2});
							});
						}
					},   
					error:function(){
						
						layui.use(['layer'], function(){
							layer.msg('加入购物车失败', {time: 3000, icon:2});
						});
					}   
				});  
			}
		}
	)
	//去结算
	$(".settlement").click(
		function(){
			if(!uid){
				open_url="{Leesun:url name='ajaxLogin' /}";
					
					layui.use(['layer', 'form'], function(){
						layer.open({
						  type: 2,
						  area: ['590px', '350px'],
						  title:'用户登陆',
						  fixed: false, //不固定
						  maxmin: false,
						  content: open_url,
						  end: function () {
							location.reload();
							 //window.location.href="{Leesun:url name='user' /}";
						  }
						});
					});
					return false;
			} else {
				var param_num=$(".select_box").length;//分类数量
				var selected_num=$(".select_box ul li.selected").length;//当前选中分类数量
				var specs="";
				
				if(param_num!=selected_num){
					layui.use(['layer'], function(){
						layer.msg('请选择商品规格', {time: 3000, icon:2});
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
					
					layui.use(['layer'], function(){
						layer.msg('等有货再购买吧', {time: 3000, icon:2});
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
						layui.use(['layer'], function(){
							layer.msg('加入购物车失败', {time: 3000, icon:2});
						});
					}   
				});  
			}
		}
	)
	
	$(".nobuy").on("click",function(){
		layui.use(['layer'], function(){
			layer.msg('不好意思，商品已售罄', {time: 3000, icon:2});
		});
		return false;
	});
	//产品收藏
	$("#fav").click(
		function(){
			
			var pid="{$proData.id}";
			if(!uid){
				layui.use(['layer'], function(){
					layer.msg('请先登录后再收藏商品', {time: 3000, icon:2});
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
						layui.use(['layer'], function(){
							layer.msg('收藏商品成功', {time: 3000, icon:1});
						});
						
					}else if(msg==2){
						layui.use(['layer'], function(){
							layer.msg('收藏失败', {time: 3000, icon:2});
						});
					}
					else if(msg==3){
						layui.use(['layer'], function(){
							layer.msg('此商品您已收藏', {time: 3000, icon:2});
						});
					}
				},   
				error:function(){
					layui.use(['layer'], function(){
						layer.msg('收藏失败', {time: 3000, icon:2});
					});
				}   
			});  
		}
	)
	
	
	$("#publish").click(
	  function(){
		  if(!uid){
			  open_url="{Leesun:url name='ajaxLogin' /}";
			  layui.use(['layer', 'form'], function(){
					layer.open({
					  type: 2,
					  area: ['590px', '350px'],
					  title:'用户登陆',
					  fixed: false, //不固定
					  maxmin: true,
					  content: open_url
					});
				});
			  return false;
		  } else {
			  	var id="{$proData.id}";
			  	$.get("{Leesun:url name='appraisetimes' /}",{id:id},function(data){
					console.log(data);
					if(data.times>0){
						open_url="{Leesun:url name='appraisePublish'/}";
						
						 layui.use(['layer', 'form'], function(){
							layer.open({
							  type: 2,
							  area: ['590px', '320px'],
							  title:'发表评价',
							  fixed: false, //不固定
							  maxmin: true,
							  content: open_url
							});
						});
							
					} else {
						layui.use(['layer'], function(){
							layer.msg('还未购买或已够评价次数', {time: 3000, icon:2});
						});
						return false;
					}
				});
			  	
	  
		  }
	  	}
	  )
	
	$("#submit").click(
	  function(){
		  if(!uid){
			  open_url="{Leesun:url name='ajaxLogin' /}";
			   layui.use(['layer', 'form'], function(){
					layer.open({
					  type: 2,
					  area: ['590px', '320px'],
					  title:'用户登陆',
					  fixed: false, //不固定
					  maxmin: true,
					  content: open_url
					});
				});
			  return false;
		  } else {
			  	
				open_url="{Leesun:url name='appraisePublish' /}";
				layui.use(['layer', 'form'], function(){
					layer.open({
					  type: 2,
					  area: ['590px', '320px'],
					  title:'用户登陆',
					  fixed: false, //不固定
					  maxmin: true,
					  content: open_url
					});
				});
				
	  
		  }
	  	}
	  )
	  
	  $("#qa-but").click(
	  	function(){
			
			if(!uid){
			  open_url="{Leesun:url name='ajaxLogin' /}";
			  layui.use(['layer', 'form'], function(){
					layer.open({
					  type: 2,
					  area: ['590px', '350px'],
					  title:'用户登陆',
					  fixed: false, //不固定
					  maxmin: true,
					  content: open_url
					});
				});
			  return false;
		 	} else {
				
				var pid="{$proData.id}";
				var q=$("#question").val();
				if(q==""){
					
					layui.use(['layer'], function(){
						layer.msg('内容不能为空', {time: 3000, icon:2});
					});
					return false;
				}
				$.ajax({   
					type:"post",     
					url:"{:url('index/consult/question')}",
					data:{pid:pid,uid:uid,question:q},
					success:function(msg){
						if(msg==1){
							
							layui.use(['layer'], function(){
								layer.msg('提问成功，等待管理员回复', {time: 3000, icon:1});
							});
							$("#question").val("");
						}else if(msg==2){
							
							layui.use(['layer'], function(){
								layer.msg('提问失败', {time: 3000, icon:2});
							});
						}
					},   
					error:function(){
						
						layui.use(['layer'], function(){
							layer.msg('提问失败', {time: 3000, icon:2});
						});
					}   
				}); 
			}
		})
		
		//商品图片
		var num=0;
		var img_width=$("#imgs ul li").length*96;
		var imgbox_num=Math.ceil(img_width/288);
		$("#imgs").width(img_width);
		$("#img-left").click(function(){
			var dis=-288;
			
			if(num<(imgbox_num-1)){
				num++;
			}
			$("#imgs").animate({"left":num*dis},"fast");
			
		})
		$("#img-right").click(function(){
			var dis=-288;
			
			if(num>=1){
				num--;
			}
			
			$("#imgs").animate({"left":num*dis},"fast");
		})
		
		$("#imgs ul li img").click(function(){
			var src=$(this).attr("src");
			$(".main-img").attr("src",src);
			$(".main-img").attr("jqimg",src);
		})
		
		
		//详细页
		$(".detail-box .tit ul li").click(
			function(){
				var id=$(this).attr("id");
				$(".detail-box .tit ul li").removeClass();
				$(this).addClass("selected");
				$(".detail-box .content").hide();
				$("#con_"+id).show();
			}
		)
		$(".appraise-list .atit ul li").click(
			function(){
				var id=$(this).attr("id");
				$(".appraise-list .atit ul li").removeClass();
				$(this).addClass("s");
				$(".acon").hide();
				$("#appraise_content_"+id).show();
			}
		)
		
});
</script>
</head>
<body>
{include file="public/header" /}

<div class="web_body">
	<div class="left">
		<div class="box">
			<div class="percent-box">
				<ul>
					<li class="l">
						<h1 style="color:red">{$proData.success_orders_num}</h1>
						<h4 style="color:#af7d7d">销量(件)</h4>
					</li>
					<li>
						<h1 style="color:#506bff">{$proData.appraise_num}</h1>
						<h4 style="color:#61688d">评价(个)</h4>
					</li>
					<li class="l d">
						<h1 style="color:#ff8400">{$proData.good_per}</h1>
						<h4 style="color:#ff6600">评分(%)</h4>
					</li>
					<li class="d">
						<h1 style="color:#008a5b">{$proData.click}</h1>
						<h4 style="color:#038b50">点击(次)</h4>
					</li>
				</ul>
			</div>
		</div><!-- end of box -->
		<div class="box">
			<div class="rec-box">
				<div class="tit">商品推荐</div>
				<div class="con">
					<ul>
					{Leesun:product name='v'  num='6' recommend='1' type='1' sort='add_time desc'}
					<li>
						<div class="img"><a href="{$v.url}">{if condition="$v.thumb"}<img src="__ROOT____UPLOADS__/{$v.thumb}" onload='AutoResizeImage(185,141,this)' >{else}<img src="__ROOT____INDEX__/images/no-pic.jpg"  class="img"/>{/if}</a></div>
						<h1 class="dgrey_l"><a href="{$v.url}">{$v.name}</a></h1>
						<h2>&yen;{$v.current_price}</h2>
					</li>
					{/Leesun:product}
					
					</ul>
				</div>
			</div>
		</div><!-- end of box -->
	</div>
	
	<div class="left" style="margin-left:12px;">
		<div class="box">
			<div class="show-box">
				<div class="img-box">
					<div class="main jqzoom" ><img src="{$proData.img}" class="main-img" id="main_img" jqimg="{$proData.img}" ></div>
					<div class="clear"></div>
					<div class="scroll-box">
						<div class="leftb" id="img-left"></div>
						<div class="imgs-box" id="imgs-box">
							<div class="imgs" id="imgs">
								<ul>
									<li><img src="{$proData.img}" onload='AutoResizeImage(91,70,this)'  class="img"></li>
									
									{volist name="proData['spec']" id="v"}
									<li><img src="{$v.img}" onload='AutoResizeImage(91,70,this)'  class="img" ></li>
									{/volist}
								</ul>
							</div>
						</div>
						<div class="rightb" id="img-right"></div>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
					<div class="bottom-box">
						<div class="fav-but"  id="fav">
							<div class="icon"></div>
							<div class="name">加入收藏</div>
						</div>
						<div class="addtime">上架时间：{$proData.add_time}</div>
					</div>
				</div>
				
				<div class="info-box">
					
					<div class="tit">{$proData.name}</div>
					<div class="price-box">
						<h5>市场价：&yen;<span class="s" id="origin_price">{$proData.origin_price}</span></h5>
						<h1>销售价：&yen;<span class="s" id="current_price"><span id="price">{$proData.current_price}</span></span></h1>
						<div class="qrcode"><img src="{$qrcode}"></div>
					</div>
					<div class="specs-box">
						<ul>
						 
						 {Leesun:spec name='v' pid='0' product_id='$proData.id' cate_id='$proData.cate_id'}
							<li>
								<div class="t">{$v.name}</div>
								<div class="d">
									<div class="select_box" id="select_box_{$v.id}">
										<ul>
											{Leesun:spec name='sv' pid='$v.id'}
												
												<li id="{$sv.id}" pid="{$sv.pid}">{$sv.name}</li>
												
											{/Leesun:spec}
										</ul>
									</div>
								</div>
							</li>
						{/Leesun:spec}
							<li>
								<div class="t">数量</div>
								<div class="d">
									<div class="grey-box">
										<input type="text" class="p_num" value="1" id="p_num" readonly="readonly" />
										<div class="add" id="sub"></div>
										<div class="sub" id="add"></div>
									</div>
								</div>
								<div class="d">
									<div class="inventory">库存<span id="inventory" data="{$proData.inventory}">{$proData.inventory}</span>件</div>
								</div>
							</li>
						</ul>
					</div><!-- end of specs-box -->
					
					<div class="buy-box">
						<div class="buy-but left settlement">
							<div class="icon"></div>
							<div class="name">去结算</div>
						</div>
						<div class="cart-but left buy">
							<div class="icon"></div>
							<div class="name">加入购物车</div>
						</div>
						<div class="clear"></div>
					</div>
					
					<div class="serial-no">货号:{$proData.serial_no}</div>
					
				</div><!-- end of info-box -->
				<div class="clear"></div>
			</div><!-- end of show-box -->
		</div><!-- end of box -->
		
		<div class="detail-box">
			<div class="tit">
            	<ul >
                	<li class="selected" id="xq">商品详情</li>
					<li id="gg">规格详情</li>
                    <li id="pj">商品评价</li>
                    <li id="zx">商品咨询</li>
                </ul>
            </div>
			<div class="content" id="con_xq">
            	{$proData.brief}
            </div>
			<div class="content" id="con_gg"  style="display:none;">
            	{$proData.specifications}
            </div>
			<div class="content" id="con_pj"  style="display:none;">
            	<div class="appraise-show">
					<div class="heart-box">
						<div class="mask">{$proData.good_per}%</div>
						<div class="percent" style="height:{$proData.least_per}%;"></div>
					</div>
					<div class="split-line"></div>
					<div class="percent-line-box">
						<div class="per-box">
							<div class="mask">好评({$proData.good_per}%)</div>
							<div class="percent" style="width:{$proData.good_per}%;"></div>
						</div>
						<div class="per-box">
							<div class="mask">中评({$proData.middle_per}%)</div>
							<div class="percent" style="width:{$proData.middle_per}%;"></div>
						</div>
						<div class="per-box">
							<div class="mask">差评({$proData.bad_per}%)</div>
							<div class="percent" style="width:{$proData.bad_per}%;"></div>
						</div>
					</div>
					<div class="split-line"></div>
					<div class="appraise-but" id="publish">发表评价</div>
					<div class="clear"></div>
				</div>
				<div class="appraise-list">
					<div class="atit">
						<ul>
							<li class="s" id="all">所有({$proData.appraise_num})</li>
							<li id="good">好评({$proData.good_num})</li>
							<li id="mid">中评({$proData.middle_num})</li>
							<li id="bad">差评({$proData.bad_num})</li>
						</ul>
					</div>
					
					<div class="acon" id="appraise_content_all">
						
						
						{Leesun:appraise name='v' pid='$Request.param.id'}
						<div class="box">
							<div class="mess-box">
								<div class="avatar">{if ($v.user.photo)}<img src="__ROOT____UPLOADS__/{$v.user.photo}">{else}<img src="__ROOT____INDEX__/images/user_default.gif">{/if}</div>
								<div class="mess">
									<p style="color:#ff0000"><span >会员名称：{$v.user.user_name}</span><span>{$v.level_cn}</span><span>评价时间：{$v.content_time}</span></p>
									<p >{$v.content}</p>
								</div>
								<div class="clear"></div>
							</div>
							{if ($v.admin)}
							<div class="mess-box" style="border-bottom:1px dotted #ccc;">
								<div class="avatar">{if ($v.admin)}<img src="__ROOT____UPLOADS__/{$v.admin.avatar}">{else}<img src="__ROOT____INDEX__/images/user_default.gif">{/if}</div>
								<div class="mess">
									<p style="color:#0098d1"><span >管理员名称：{$v.admin.adm_name}</span><span>回复时间：{$v.reply_time}</span></p>
									<p style="color:#ff0000">{$v.reply}</p>
								</div>
								<div class="clear"></div>
							</div>
							{/if}
						</div>
						{/Leesun:appraise}
					</div>
					<div class="acon" id="appraise_content_good" style="display:none">
						{Leesun:appraise name='v' pid='$Request.param.id' level='1'}
						<div class="box">
							<div class="mess-box">
								<div class="avatar">{if ($v.user.photo)}<img src="__ROOT____UPLOADS__/{$v.user.photo}">{else}<img src="__ROOT____INDEX__/images/user_default.gif">{/if}</div>
								<div class="mess">
									<p style="color:#ff0000"><span >会员名称：{$v.user.user_name}</span><span>{$v.level_cn}</span><span>评价时间：{$v.content_time}</span></p>
									<p >{$v.content}</p>
								</div>
								<div class="clear"></div>
							</div>
							{if ($v.admin)}
							<div class="mess-box" style="border-bottom:1px dotted #ccc;">
								<div class="avatar">{if ($v.admin)}<img src="__ROOT____UPLOADS__/{$v.admin.avatar}">{else}<img src="__ROOT____INDEX__/images/user_default.gif">{/if}</div>
								<div class="mess">
									<p style="color:#0098d1"><span >管理员名称：{$v.admin.adm_name}</span><span>回复时间：{$v.reply_time}</span></p>
									<p style="color:#ff0000">{$v.reply}</p>
								</div>
								<div class="clear"></div>
							</div>
							{/if}
						</div>
						{/Leesun:appraise}
					</div>
					<div class="acon" id="appraise_content_mid" style="display:none">
						{Leesun:appraise name='v' pid='$Request.param.id' level='2'}
						<div class="box">
							<div class="mess-box">
								<div class="avatar">{if ($v.user.photo)}<img src="__ROOT____UPLOADS__/{$v.user.photo}">{else}<img src="__ROOT____INDEX__/images/user_default.gif">{/if}</div>
								<div class="mess">
									<p style="color:#ff0000"><span >会员名称：{$v.user.user_name}</span><span>{$v.level_cn}</span><span>评价时间：{$v.content_time}</span></p>
									<p >{$v.content}</p>
								</div>
								<div class="clear"></div>
							</div>
							{if ($v.admin)}
							<div class="mess-box" style="border-bottom:1px dotted #ccc;">
								<div class="avatar">{if ($v.admin)}<img src="__ROOT____UPLOADS__/{$v.admin.avatar}">{else}<img src="__ROOT____INDEX__/images/user_default.gif">{/if}</div>
								<div class="mess">
									<p style="color:#0098d1"><span >管理员名称：{$v.admin.adm_name}</span><span>回复时间：{$v.reply_time}</span></p>
									<p style="color:#ff0000">{$v.reply}</p>
								</div>
								<div class="clear"></div>
							</div>
							{/if}
						</div>
						{/Leesun:appraise}
					</div>
					<div class="acon" id="appraise_content_bad" style="display:none">
						{Leesun:appraise name='v' pid='$Request.param.id' level='3'}
						<div class="box">
							<div class="mess-box">
								<div class="avatar">{if ($v.user.photo)}<img src="__ROOT____UPLOADS__/{$v.user.photo}">{else}<img src="__ROOT____INDEX__/images/user_default.gif">{/if}</div>
								<div class="mess">
									<p style="color:#ff0000"><span >会员名称：{$v.user.user_name}</span><span>{$v.level_cn}</span><span>评价时间：{$v.content_time}</span></p>
									<p >{$v.content}</p>
								</div>
								<div class="clear"></div>
							</div>
							{if ($v.admin)}
							<div class="mess-box" style="border-bottom:1px dotted #ccc;">
								<div class="avatar">{if ($v.admin)}<img src="__ROOT____UPLOADS__/{$v.admin.avatar}">{else}<img src="__ROOT____INDEX__/images/user_default.gif">{/if}</div>
								<div class="mess">
									<p style="color:#0098d1"><span >管理员名称：{$v.admin.adm_name}</span><span>回复时间：{$v.reply_time}</span></p>
									<p style="color:#ff0000">{$v.reply}</p>
								</div>
								<div class="clear"></div>
							</div>
							{/if}
						</div>
						{/Leesun:appraise}
					</div>
					
				</div>
				
            </div>
			<div class="content" id="con_zx"  style="display:none;">
            	
					{Leesun:consult name='v' pid='$Request.param.id' verify='1'  is_reply='1'}
					<div class="box">
							<div class="mess-box">
								<div class="avatar">{if ($v.user.photo)}<img src="__ROOT____UPLOADS__/{$v.user.photo}">{else}<img src="__ROOT____INDEX__/images/user_default.gif">{/if}</div>
								<div class="mess">
									<p style="color:#ff0000"><span >会员名称：{$v.user.user_name}</span><span></span><span>评价时间：{$v.q_time}</span></p>
									<p >{$v.question}</p>
								</div>
								<div class="clear"></div>
							</div>
							{if ($v.admin)}
							<div class="mess-box" style="border-bottom:1px dotted #ccc;">
								<div class="avatar">{if ($v.admin)}<img src="__ROOT____UPLOADS__/{$v.admin.avatar}">{else}<img src="__ROOT____INDEX__/images/user_default.gif">{/if}</div>
								<div class="mess">
									<p style="color:#0098d1"><span >管理员名称：{$v.admin.adm_name}</span><span>回复时间：{$v.a_time}</span></p>
									<p style="color:#ff0000">{$v.answer}</p>
								</div>
								<div class="clear"></div>
							</div>
							{/if}
						</div>
					{/Leesun:consult}
				
				<div class="box">
					<span class="left txt">我要提问：</span>
                    <span class="left"><input type="text" name="question" value="" class="question" id="question"></span>
                    <span class="left"><input type="button" id="qa-but" value="提交" class="submit"></span>
                    <div class="clear"></div>
				</div>
            </div>
			
		</div><!-- end of detail-box -->
		
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>

{include file="public/footer" /}


</body>
</html>
