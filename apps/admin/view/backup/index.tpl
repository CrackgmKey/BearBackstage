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

	
	
	$(".opt").click(function(){
		var url=$(this).attr("url");
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要优化此表吗?', {icon: 3, title:'提示'}, function(index){
			 window.location.href=url;
			  layer.close(index);
			});
		});
		
		
	})
	$(".rep").click(function(){
		var url=$(this).attr("url");
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要修复此表吗?', {icon: 3, title:'提示'}, function(index){
			 window.location.href=url;
			  layer.close(index);
			});
		});
		
		
	})
	
	$(".restore").click(function() {
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要还原选中的数据吗?', {icon: 3, title:'提示'}, function(index){
			 $(".list-box,.fun-box").hide();
			 $(".loading").show();
			 var url=$(this).attr("url");
			 window.location.href=url;
			 layer.close(index);
			});
		});
		
	});
	
	$("#backup").click(function(){
		$(".list-box,.fun-box").hide();
		$(".loading").show();
		$("#form1").attr("action","{:url('admin/backup/doBackup')}");
		$("#form1").submit();
	})
	
	$("#repair").click(function(){
		$(".list-box,.fun-box").hide();
		$(".loading").show();
		$("#form1").attr("action","{:url('admin/backup/repair')}");
		$("#form1").submit();
	})
	$("#optimize").click(function(){
		$(".list-box,.fun-box").hide();
		$(".loading").show();
		$("#form1").attr("action","{:url('admin/backup/optimize')}");
		$("#form1").submit();
	})
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">

<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;数据备份</div>
	<div class="tab-box">
		<ul>
			<li class="cur">数据表操作</li>
			<li><a href="{:url('admin/backup/lists')}">备份列表</a></li>
		</ul>
	</div>
	<div class="loading">乐尚商城提示您，请稍候！</div>
	
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:32%">数据表名</li>
				<li style="width:10%">容量大小</li>
				<li style="width:10%">碎片大小</li>
				<li style="width:13%">引擎</li>
				<li style="width:20%">创建时间</li>
				<li style="width:10%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="list" id="list">
				{volist name="datas" id="data"}
				<ul>
					<a>
					<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="{$data.name}"></li>
					<li style="width:32%;">{$data.name}</li>
					<li style="width:10%">{$data.size}</li>
					<li style="width:10%">{$data.data_free}</li>
					<li style="width:13%">{$data.engine}</li>
					<li style="width:20%">{$data.addtime}</li>
					
					<li style="width:10%"><div class="mod-icon rep" url="{$data.rep_url}" title="修复表">修</div><div class="del-icon opt" url="{$data.opt_url}" title="优化表">优</div><div class="clear"></div></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				
				{/volist}
			
		</div>
	</div><!-- end of list-box -->
	
	<div class="fun-box">
		<div class="button">
			<ul>
				<li class="add"  id="backup">备份</li>
				<li class="dels"  id="repair">修复</li>
				<li class="update"  id="optimize">优化</li>
				<div class="clear"></div>
			</ul>
		</div>
		<div class="page grey_l link"></div>
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->
</form>
</body>
</html>
