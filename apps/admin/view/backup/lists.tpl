<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/main.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/weebox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.jclock.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.bgiframe.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.weebox.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	
	$("#dels").click(function(){
		if(confirm('你确定要删除选中的项目吗?')){
			$("#form1").attr("action","{:url('admin/backup/del')}");
			$("#form1").submit();
		}else {
			return false;
		}
	})
	$(".del").click(function(){
		var url=$(this).attr("url");
	
		if(confirm('你确定要删除此项目吗?')){
			
			window.location.href=url;
		} else {
			return false;
		}
		
	})
	
	$(".restore").click(function() {
		if(confirm('你确定要还原选中的数据吗?')){
			$(".list-box,.fun-box").hide();
			$(".loading").show();
			var url=$(this).attr("url");
			window.location.href=url;
		} else {
			return false;
		}
	});
	
	
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<input type="hidden" name="dels" value="1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;数据备份</div>
	<div class="tab-box">
		<ul>
			<li ><a href="{:url('admin/backup/index')}">数据表操作</a></li>
			<li class="cur">备份列表</li>
		</ul>
	</div>
	<div class="loading">乐尚商城提示您，请稍候！</div>
	
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:42%">文件名</li>
				<li style="width:23%">文件大小</li>
				<li style="width:20%">备份时间</li>
				<li style="width:10%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="list" id="list">
				{volist name="datas" id="data"}
				<ul>
					<a>
					<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="{$data.file}"></li>
					<li style="width:42%;">{$data.file}</li>
					<li style="width:23%">{$data.size}</li>
					<li style="width:20%">{$data.time}</li>
					
					<li style="width:10%"><div class="mod-icon restore" url="{$data.res_url}" title="还原数据">还</div><div class="del-icon del" url="{$data.del_url}" >删</div><div class="clear"></div></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				
				{/volist}
			
		</div>
	</div><!-- end of list-box -->
	
	<div class="fun-box">
		<div class="button">
			<ul>
				
				<li class="dels"  id="dels">删除</li>
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
