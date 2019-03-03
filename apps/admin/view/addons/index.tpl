<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.jclock.js"></script>

<script type="text/javascript" src="__ROOT____ADMIN__/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	
	$(".inst,.uninst").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
	})
	
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<input type="hidden" name="dels" value="1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;插件管理</div>
	
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:15%">插件名称</li>
				<li style="width:25%">简介</li>
				<li style="width:10%">状态</li>
				<li style="width:10%">版本</li>
				<li style="width:20%">作者</li>
				
				<li style="width:10%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		
		
		{if($datas)}
		<div class="list" id="list">
				{volist name="datas" id="data"}
				<ul>
					<a>
					<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" class="check-style"  name="id[]" value="{$data.title}"></li>
					
					<li style="width:15%"><div class="left" style="width:160px;"><strong>{$data.title}</strong></div></li>
					<li style="width:25%">{$data.description}</li>
					<li style="width:10%">{if($data.is_install)}<span style="color:green">已安装</span>{else}<span style="color:red">未安装</span>{/if}</li>
					<li style="width:10%">{$data.version}</li>
					<li style="width:20%">{$data.author}</li>
					<li style="width:10%">{if($data.is_install)}<div class="del-icon uninst" url="{$data.uni_url}" >卸</div><div class="clear"></div>{else}<div class="mod-icon inst" url="{$data.ins_url}">安</div>{/if}</li>
					<div class="clear"></div>
					</a>
					
				</ul>
				
				{/volist}
			
		</div>
		{else}
			
		{/if}
	</div><!-- end of list-box -->
	
	<div class="fun-box">
		<div class="button">
			<ul>
				
				<div class="clear"></div>
			</ul>
		</div>
		<div class="page grey_l link">{$bootstrap}</div>
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->
</form>
</body>
</html>
