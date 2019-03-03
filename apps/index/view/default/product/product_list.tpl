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
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/unslider.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jQuery.autoIMG.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script>
$(function(){
	$("#product-box ul li:nth-child(4n)").css('margin-right','0');
	$("#sort ul li").click(function(){
		var id=$(this).attr("id");
		var url=$(this).attr("url");
		window.location.href=url;
	})
	$("#brand ul li").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
	})
	$('.img').autoIMG();
});
</script>
</head>

<body>
{include file="public/header" /}
<div class="web_body">
	
	{include file="product/left" /}
	
	<div class="right" >
		
		
		<div class="box">
			<div class="brand-box">
				<div class="tit">品牌筛选</div>
				<div class="con" id="brand">
					<ul>
						<li url="{:url('index/product/lists',array('id'=>$Request.param.id,'pid'=>$Request.param.pid,'mid'=>$Request.param.mid,'sort'=>$Request.param.sort))}" {if condition="$Request.param.brand==''"} class="cur"{/if}>全部</li>
						{Leesun:brand name='v' pid='$Request.param.id' bid='$Request.param.brand','sort'=>$Request.param.sort}
						<li url="{$v.url}" {if condition="$v.selected"}class="cur"{/if}>{$v.name}</li>
						{/Leesun:brand}
						
						<div class="clear"></div>
					</ul>
				</div>
			</div>
		</div>
		<div class="box">
			<div class="product-box" id="product-box">
				<div class="tit" id="sort">
					<ul>
						<li id="1"  url="{:url('index/product/lists',array('id'=>$Request.param.id,'pid'=>$Request.param.pid,'mid'=>$Request.param.mid,'sort'=>1,'brand'=>$Request.param.brand))}" {if condition="$Request.param.sort==1 || $Request.param.sort==''"}class="cur"{/if}>最新</li>
						<li id="2"  url="{:url('index/product/lists',array('id'=>$Request.param.id,'pid'=>$Request.param.pid,'mid'=>$Request.param.mid,'sort'=>2,'brand'=>$Request.param.brand))}" {if condition="$Request.param.sort==2"}class="cur"{/if}>价格↑</li>
						<li id="3"  url="{:url('index/product/lists',array('id'=>$Request.param.id,'pid'=>$Request.param.pid,'mid'=>$Request.param.mid,'sort'=>3,'brand'=>$Request.param.brand))}" {if condition="$Request.param.sort==3"}class="cur"{/if}>价格↓</li>
						<li id="4"  url="{:url('index/product/lists',array('id'=>$Request.param.id,'pid'=>$Request.param.pid,'mid'=>$Request.param.mid,'sort'=>4,'brand'=>$Request.param.brand))}" {if condition="$Request.param.sort==4"}class="cur"{/if}>人气</li>
						<div class="clear"></div>
					</ul>
				</div>
				<div class="list">
					<ul>
						
						{Leesun:product name='pv' pid='$Request.param.id' bid='$Request.param.brand'  page='1'}
						<li>
							<div class="img"><a href="{$pv.url}">{if condition="$pv.thumb"}<img src="__ROOT____UPLOADS__/{$pv.thumb}" id="pimg_{$pv.id}" onload='AutoResizeImage(208,159,this)' />{else}<img src="__ROOT____INDEX__/images/no-pic.jpg" class="img"/>{/if}</a></div>
							<div class="name dgrey_l"><a href="{$pv.url}">{$pv.name}</a></div>
							<div class="price"><span class="red">&yen;{$pv.current_price}</span>&nbsp;&nbsp;&nbsp;<span class="grey" style="text-decoration:line-through">&yen;{$pv.origin_price}</span></div>
						</li>
						{/Leesun:product}
						
						<div class="clear"></div>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="page">
			{$page}
			<div class="clear"></div>
		</div>
		
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>
{include file="public/footer" /}


</body>
</html>
