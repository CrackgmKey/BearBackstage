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

	$(".display").click(function(){
		
		var url="{:url('admin/spec/changeDisplay')}";
		var id=$(this).attr("id");
		var obj=$(this);
		
		$.get(url,{"id":id},function(d){
			
			if(d!="err"){
				var last_display=d?"0":"1";
				$(obj).removeClass("display_"+last_display);
				$(obj).addClass("display_"+d);
			}
		})
	})
	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	$(".select-box ul li").click(function(){
		var url=$(this).attr("url");
		if(url){
			window.location.href=url;
		}
	})
	
	$("#update").click(function(){
		$("#form1").attr("action","{:url('admin/spec/batchSort')}");
		$("#form1").submit();
	})
	
	$("#dels").click(function(){
		
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 $("#form1").attr("action","{:url('admin/spec/del')}");
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
		window.location.href="{:url('admin/spec/add')}";
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
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;商品管理&nbsp;>&nbsp;规格管理</div>
	<div class="search-box">
		<div class="input-box-s left" style="z-index:900"><span class="select-title">{$currentName}</span>
			<div class="select-box">
					<ul>
						<li  style="text-indent:1em;text-align:left;"  url="{:url('admin/spec/index')}"><strong>所有类别</strong></li>
						{volist name="navDatas" id="v"}
							<li id="{$v.id}" style="text-indent:1em;text-align:left;" {if condition="$v.has_sub==1"}class="read_only"{else} url="{$v.go_url}" class="can_select"{/if}><strong>{$v.name}</strong></li>
							{if condition="$v.has_sub==1"}
							{volist name="v.sub" id="sv"}
								<li id="{$sv.id}" style="text-indent:2em;text-align:left;" url="{$sv.go_url}" class="can_select">{$sv.name}</li>
							{/volist}
							{/if}
						{/volist}
					</ul>
				</div>
		</div>
		<div class="clear"></div>
	</div>
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:10%">编号</li>
				<li style="width:30%">规格名称</li>
				<li style="width:15%">所属分类</li>
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
					<li style="width:30%"><div class="left" style="width:100px;">{$data.name}</div>{if condition="$data.is_sub"}<div class="up-icon slide" id="{$data.id}" title="下拉子菜单"></div>{/if}</li>
					<li style="width:15%"><div class="left" style="width:100px;">{$data.classname}</div></li>
					<li style="width:15%;"><input type="text" name="sort[{$data.id}]" value="{$data.sort}" class="input" maxlength="3"></li>
					<li style="width:20%"><div class="mod-icon mod"  url="{$data.mod_url}">编</div><div class="del-icon del" url="{$data.del_url}" >删</div><div class="clear"></div></li>
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
							<li style="width:15%"><div class="left" style="width:100px;"></div></li>
							<li style="width:15%;"><input type="text" name="sort[{$d.id}]" value="{$d.sort}" class="input_sub" maxlength="3"></li>
							
							<li style="width:20%"><div class="mod-icon mod" url="{$d.mod_url}">编</div><div class="del-icon del" url="{$d.del_url}">删</div><div class="clear"></div></li>
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
