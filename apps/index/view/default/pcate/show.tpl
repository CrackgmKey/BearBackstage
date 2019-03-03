<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$config.site_name}</title>
<meta name="keywords" content="{$config.key_word}" />
<meta name="description" content="{$config.description}" />
<meta name="author" content="乐尚商城" />
<meta name="copyright" content="leesuntech.com" />

<link rel="shortcut icon" href="__ROOT____UPLOADS__/{$config.favicon}" />
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/common.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/layout.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/user.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script>
$(function(){
	
});
</script>
</head>

<body>
{include file="public/header" /}
{Leesun:page_1 name='pdata' id="$Request.param.id" /}
<div class="web_body">
	
	<div class="left">
		
		<div class="box">
			<div class="class-box">
				<span class="icon-s"></span><h1>本站说明</h1>
				<div class="clear"></div>
			</div>
			<div class="sclass-box" id="sclass-box">
				<ul>
					{Leesun:page name='sv'}
					<li {if ($Request.param.id==$sv['id'])}class="cur"{/if}><a href="{$sv.url}">{$sv.name}</a></li>
					{/Leesun:page}
				</ul>
			</div>
		</div><!-- end of box -->
		
	</div><!-- end of left -->


	<div class="right">
		
		
		
		<div class="box" >
			<div class="page-box" >
				<div class="content">
					<h1>{$pdata.name}</h1>
					<h3>{$pdata.content}</h3>
				</div>
			</div>
		</div>
		
		
		
		
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>
{include file="public/footer" /}


</body>
</html>
