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

	
	
	$("#update").click(function(){
		$("#form1").attr("action","{:url('admin/link/batchSort')}");
		$("#form1").submit();
	})
	
	$("#dels").click(function(){
		
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 $("#form1").attr("action","{:url('admin/link/del')}");
			 $("#form1").submit();
			  layer.close(index);
			});
		});
	})
	$(".del").click(function(){
		var url=$(this).attr("url");
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 window.location.href=url;
			  layer.close(index);
			});
		});
		
	})
	$(".thumb").hover(function(){
		$(this).parents("li").css("z-index","901");
		$(this).parents("li").css("overflow","visible");
		$(this).parents("li").children(".thumb-box").show(100);
	},function(){
		$(this).parents("li").css("z-index","800");
		$(this).parents("li").css("overflow","hidden");
		$(this).parents("li").children(".thumb-box").hide(100);
	})
	
	
	$("#add").click(function(){
		window.location.href="{:url('admin/link/add')}";
	})
	
	$(".mod").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
	})
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">

<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;内容管理&nbsp;>&nbsp;友情链接</div>
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:10%">编号</li>
				<li style="width:45%">名称</li>
				<li style="width:15%">排序</li>
				<li style="width:20%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="list" id="list">
				{volist name="datas" id="data"}
				<ul>
					<a>
					<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="{$data.id}"></li>
					<li style="width:10%">{$data.id}</li>
					<li style="width:45%;position:relative;z-index:900">
						<div class="left" title="{$data.name}">
							<span class="green">[点击:{$data.click}]</span>&nbsp{if condition="$data.img"}<span  class="green thumb"  style="cursor:pointer;" url="{$data.img}">[有图]</span>{else}<span class="red">[无图]</span>{/if}&nbsp;{$data.name}
						</div>
						{if condition="$data.img"}<div class="thumb-box"><img src="{$data.img}"></div>{/if}
					</li>
					<li style="width:15%;"><input type="text" name="sort[{$data.id}]" value="{$data.sort}" class="input" maxlength="3"></li>
					<li style="width:20%"><div class="mod-icon mod" url="{$data.mod_url}">编</div><div class="del-icon del" url="{$data.del_url}" >删</div><div class="clear"></div></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				
				{/volist}
			
		</div>
	</div><!-- end of list-box -->
	
	<div class="fun-box">
		<div class="button">
			<ul>
				<li class="add" id="add">添加</li>
				<li class="dels"  id="dels">删除</li>
				<li class="update"  id="update">更新排序</li>
				<div class="clear"></div>
			</ul>
		</div>
		<div class="page grey_l link">{$datas->render()}</div>
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->
</form>
</body>
</html>
