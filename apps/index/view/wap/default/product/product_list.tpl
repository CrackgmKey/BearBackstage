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

	<script>
		
		$(document).ready(function(){
			
			$(".product ul li:nth-child(2n)").css({"border-right":"0"});
			$(".sort ul li:nth-child(4n)").css({"border-right":"0"});
			$("#sort ul li").click(function(){
				var url=$(this).attr("url");
				window.location.href=url;
			})
			$(".brand-nav").change(function(){
				var url=$(this).val();
				window.location.href=url;
			})
			
		});
	</script>
</head>
<body>

{include file="public/head" /}

<section>
	
	<div class="product-box">
		<div class="sub-title">当前分类：{Leesun:nav name='sv' pid='$Request.param.id' display='1'}{$sv.name}{/Leesun:nav}</div>
		<div class="sort" id="sort">
			<ul>
				<li id="1"  url="{:url('index/product/lists',array('id'=>$Request.param.id,'pid'=>$Request.param.pid,'mid'=>$Request.param.mid,'sort'=>1,'brand'=>$Request.param.brand))}" {if condition="$Request.param.sort==1 || $Request.param.sort==''"}class="cur"{/if}>最新</li>
						<li id="2"  url="{:url('index/product/lists',array('id'=>$Request.param.id,'pid'=>$Request.param.pid,'mid'=>$Request.param.mid,'sort'=>2,'brand'=>$Request.param.brand))}" {if condition="$Request.param.sort==2"}class="cur"{/if}>价格↑</li>
						<li id="3"  url="{:url('index/product/lists',array('id'=>$Request.param.id,'pid'=>$Request.param.pid,'mid'=>$Request.param.mid,'sort'=>3,'brand'=>$Request.param.brand))}" {if condition="$Request.param.sort==3"}class="cur"{/if}>价格↓</li>
						<li id="4"  url="{:url('index/product/lists',array('id'=>$Request.param.id,'pid'=>$Request.param.pid,'mid'=>$Request.param.mid,'sort'=>4,'brand'=>$Request.param.brand))}" {if condition="$Request.param.sort==4"}class="cur"{/if}>人气</li>
			</ul>
		</div>
		<div class="brand" id="brand">
			<div class="brand-box">
				<select class="brand-nav">
					<option value="{:url('index/product/lists',array('id'=>$Request.param.id,'pid'=>$Request.param.pid,'mid'=>$Request.param.mid,'sort'=>$Request.param.sort))}">全部品牌</option>
					
					{Leesun:brand name='v' pid='$Request.param.id' bid='$Request.param.brand'}
					<option value="{$v.url}" {if condition="$v.selected"}selected{/if}>{$v.name}</option>
					{/Leesun:brand}
				</select>
			</div>
		</div>
		
		<div class="product" id="product-box">
			<ul>
				{Leesun:product name='pv' pid='$Request.param.id' bid='$Request.param.brand' page='1'}
				<li class="url" url="{$pv.url}">
					<div class="img" >
						{if condition="$pv.thumb"}<img src="__ROOT____UPLOADS__/{$pv.thumb}" />{else}<img src="__ROOT____INDEX__/images/no-pic.jpg" class="img"/>{/if}
					</div>
					<div class="name">{$pv.name|mb_substr=0,15,'utf-8'}</div>
					<div class="price">&yen;{$pv.current_price}</div>
				</li>
				{/Leesun:product}
				<div class="clear"></div>
			</ul>
		</div>
	</div>
	
	
</section>
{include file="public/foot" /}

</body>
</html>