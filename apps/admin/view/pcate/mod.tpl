<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/main.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____PUBLIC__/ueditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.jclock.js"></script>
<script type="text/javascript" charset="utf-8" src="__ROOT____PUBLIC__/ueditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="__ROOT____PUBLIC__/ueditor/umeditor.min.js"></script>
<script type="text/javascript" src="__ROOT____PUBLIC__/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	$("#back").click(function(){
		window.location.href="{:url('admin/pcate/index')}";
	})
	
	$("#mod").click(function(){
		$("#form1").attr("action","{:url('admin/pcate/mod')}");
		$("#form1").submit();
	})
	
	var um = UM.getEditor('contents');
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;内容管理&nbsp;>&nbsp;编辑单页</div>
	
	<div class="add-box">
		<ul>
			<li><div class="title">单页名称</div><div class="input-box"><input name="name" type="text" class="input" value="{$data.name}"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li class="textarea"><div class="title">单页内容</div><div class="textarea-box" ><textarea name="content" id="contents" cols="80" rows="5" style="width:800px;height:370px;">{$data.content}</textarea></div><div class="tip">*</div><div class="clear"></div></li>
			<li><div class="title">单页排序</div><div class="input-box"><input name="sort" type="text" class="input" value="{$data.sort}"/></div><div class="tip">*</div><div class="clear"></div></li>
			
		</ul>
	</div>
	<script type="text/javascript">  
		 
         </script>
	<div class="fun-box" style="margin-left:30px;">
		<div class="button">
			<ul>
				<li class="add" id="mod">编辑</li>
				<li class="dels"  id="back">返回</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->
<input type="hidden" name="id" value="{$data.id}" />
</form>
</body>
</html>
