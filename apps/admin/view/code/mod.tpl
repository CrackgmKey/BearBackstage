<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/main.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____ADMIN__/codemirror/codemirror.css">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.jclock.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/common.js"></script>
<script src="__ROOT____ADMIN__/codemirror/codemirror.js"></script>
<script src="__ROOT____ADMIN__/codemirror/xml.js"></script>
<script src="__ROOT____ADMIN__/codemirror/javascript.js"></script>
<script src="__ROOT____ADMIN__/codemirror/css.js"></script>
<script src="__ROOT____ADMIN__/codemirror/htmlmixed.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){
	$("#back").click(function(){
		window.location.href="{$backUrl}";
	})
	
	$("#mod").click(function(){
		
		$("#form1").submit();
	})
	
	  var mixedMode = {
        name: "{$mixedMode}",
        scriptTypes: [{matches: /\/x-handlebars-template|\/x-mustache/i,
                       mode: null}]
      };
	  var editor = CodeMirror.fromTextArea(document.getElementById("tpl_content"), {
	  
	  lineNumbers: true,
        mode: mixedMode,
        selectionPointer: true
      });
		editor.setOption('lineWrapping', true);
		
		$(window).resize(function(){
			var h = $(window).height();
			var w = $(window).width();
			editor.setSize(w-120,h-330);
		})
		var h = $(window).height();
		var w = $(window).width();
		editor.setSize(w-120, h-330);
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="{:url('admin/code/mod')}" method="post" id="form1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;编辑模板</div>
	
	<div class="add-box">
		<ul>
			<li><div class="title">文件名称</div><div class="text-box">{$tpl.name}</div><div class="clear"></div></li>
			<li class="textarea"><div class="textarea-box" style="margin-left:30px;border:2px solid #ccc;"><textarea name="tpl_content" id="tpl_content" cols="80" rows="5" >{$tpl.content}</textarea></div><div class="clear"></div></li>
			
		</ul>
	</div>
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
<input type="hidden" name="name" value="{$tpl.name}" />
<input type="hidden" name="dir" value="{$tpl.dir}" />
<input type="hidden" name="current_dir" value="{$tpl.current_dir}" />
</form>
</body>
</html>
