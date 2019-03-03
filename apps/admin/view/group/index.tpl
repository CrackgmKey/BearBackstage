<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/main.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.jclock.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	$(".default").click(function(){
		
		var url="{:url('admin/group/changeDefault')}";
		var id=$(this).attr("id");
		var obj=$(this);
		
		$.get(url,{"id":id},function(d){
			
			if(d=='auth_err'){
				layui.use(['layer', 'form'], function(){
					layer.msg('对不起，您无权操作此项目');
				});
			}else if(d!="err"){
				$(".default").removeClass("default_0");
				$(".default").addClass("default_0");
				$(obj).removeClass("default_0");
				$(obj).addClass("default_1");
			}
			
			
		})
	})
	
	$("#update").click(function(){
		$("#form1").attr("action","{:url('admin/group/batchSort')}");
		$("#form1").submit();
	})
	
	$("#dels").click(function(){
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 $("#form1").attr("action","{:url('admin/group/del')}");
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
	
	$(".slide").click(function(){
		var id=$(this).attr("id");
		$(".sub_"+id).slideToggle();
		var classname=$(this).attr("class");
		
		if(classname=="up-icon slide"){
			$(this).removeClass();
			$(this).addClass("down-icon slide");
		} else {
			$(this).removeClass();
			$(this).addClass("up-icon slide");
		}
	})
	
	$("#add").click(function(){
		window.location.href="{:url('admin/group/add')}";
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
<input type="hidden" name="dels" value="1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;用户管理&nbsp;>&nbsp;用户分组</div>
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:10%">编号</li>
				<li style="width:30%">名称</li>
				<li style="width:15%">默认状态</li>
				<li style="width:10%">积分</li>
				<li style="width:15%">排序</li>
				<li style="width:10%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="list" id="list">
				{volist name="datas" id="data"}
				<ul>
					<a>
					<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="{$data.id}"></li>
					<li style="width:10%">{$data.id}</li>
					<li style="width:30%"><div class="left" style="width:100px;">{$data.name}</div>{if condition="$data.is_sub"}<div class="up-icon slide" id="{$data.id}" title="下拉子导航"></div>{/if}</li>
					<li style="width:15%">{if condition="!$data.is_sub"}<div class="default_{$data.is_default} default" id="{$data.id}" ></div>{/if}</li>
					<li style="width:10%;">&nbsp;</li>
					<li style="width:15%;"><input type="text" name="sort[{$data.id}]" value="{$data.sort}" class="input" maxlength="3"></li>
					<li style="width:10%"><div class="mod-icon mod" url="{$data.mod_url}">编</div><div class="del-icon del"url="{$data.del_url}" >删</div><div class="clear"></div></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				{if condition="$data.is_sub"}
				<div class="sub sub_{$data.id}">
					{volist name="data.sub" id="d"}
						<ul >
							<a>
							<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="{$d.id}"></li>
							<li style="width:10%">{$d.id}</li>
							<li style="width:30%;"><div class="ntree-icon"></div><div class="left name">{$d.name}</div></li>
							<li style="width:15%"><div class="default_{$d.is_default} default" id="{$d.id}" ></div></li>
							<li style="width:10%;">{$d.score}</li>
							<li style="width:15%;"><input type="text" name="sort[{$d.id}]" value="{$d.sort}" class="input_sub" maxlength="3"></li>
							<li style="width:10%"><div class="mod-icon mod" url="{$d.mod_url}">编</div><div class="del-icon del" url="{$d.del_url}">删</div><div class="clear"></div></li>
							<div class="clear"></div>
					</a>
					</ul>
					{/volist}
				</div>
				{/if}
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
		<div class="page grey_l link">{$page}</div>
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->
</form>
</body>
</html>
