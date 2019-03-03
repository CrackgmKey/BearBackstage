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

	$("#back").click(function(){
		window.location.href="{:url('admin/consult/index')}";
	})
	
	$("#mod").click(function(){
		$("#form1").attr("action","{:url('admin/consult/reply')}");
		$("#form1").submit();
	})
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;商品管理&nbsp;>&nbsp;回复咨询</div>
	
	<div class="add-box">
		<ul>
			<li><div class="title">用户名</div><div class="text-box">{$data.username}</div><div class="clear"></div></li>
			<li><div class="title">咨询商品</div><div class="text-box">{$data.productname}</div><div class="clear"></div></li>
			<li><div class="title">咨询时间</div><div class="text-box">{$data.q_time}</div><div class="clear"></div></li>
			<li><div class="title">咨询内容</div><div class="text-box" style="width:800px;">{$data.question}</div><div class="clear"></div></li>
			<li class="textarea" style="min-height:220px"><div class="title">回复内容</div><div class="textarea-box" ><textarea name="answer" id="answer" cols="80" rows="5" style="width:800px;height:170px;font-size:14px;line-height:20px;">{$data.answer}</textarea></div><div class="clear"></div></li>
			
			
		</ul>
	</div>
	<div class="fun-box" style="margin-left:30px;">
		<div class="button">
			<ul>
				<li class="add" id="mod">提交</li>
				<li class="dels"  id="back">返回</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->
<input type="hidden" name="is_reply" value="{$Request.param.is_reply}" />
<input type="hidden" name="id" value="{$data.id}" />
</form>
</body>
</html>
