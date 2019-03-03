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

	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	$(".select-box ul li").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
		
		
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
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;模板编辑</div>
	<div class="search-box">
		<div class="input-box-s left" style="z-index:1000"><span class="select-title">{$current_name}</span>
			<div class="select-box">
					<ul>
						
						{volist name="res_dir_list" id="item"}
						<li url="{$item.url}">{$item.name}</li>
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
				<li style="width:40%">文件名称</li>
				<li style="width:15%">文件大小</li>
				<li style="width:20%">更新时间</li>
				<li style="width:15%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="list" id="list">
				 {if condition="$current_dir=='tpl'"}
				
				 {volist name="dir" id="item" }
				<ul>
					<a>
					<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value=""></li>
					<li style="width:40%"><div class="left" style="width:100px;">{$item}</div><div class="up-icon slide" id="{$key}" title="下拉子导航"></div></li>
					<li style="width:15%"><div class="left" style="width:100px;"></div></li>
					<li style="width:20%;"></li>
					<li style="width:15%"><div class="clear"></div></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				<div class="sub sub_{$key}">
					
					  {volist name="datas[$key]" id="data"}
						<ul >
							<a>
							<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value=""></li>
							<li style="width:40%;"><div class="ntree-icon"></div><div class="left name">{$data.file}</div></li>
							<li style="width:15%"><div class="left" style="width:100px;">{$data.size}</div></li>
							<li style="width:20%;">{$data.time}</li>
							
							<li style="width:15%"><div class="mod-icon mod" url="{$data.url}">编</div><div class="clear"></div></li>
							<div class="clear"></div>
						</a>
						</ul>
						{/volist}
				</div>
				{/volist}
				{else}
				{volist name="datas" id="data"}
				<ul >
							<a>
							<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value=""></li>
							<li style="width:40%;"><div class="ntree-icon"></div><div class="left name">{$data.file}</div></li>
							<li style="width:15%"><div class="left" style="width:100px;">{$data.size}</div></li>
							<li style="width:20%;">{$data.time}</li>
							
							<li style="width:15%"><div class="mod-icon mod" url="{$data.url}">编</div><div class="clear"></div></li>
							<div class="clear"></div>
					</a>
					</ul>
				{/volist}
				{/if}
			
		</div>
	</div><!-- end of list-box -->
	
	<div class="fun-box">
		
		<div class="page grey_l link"></div>
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->
</form>
</body>
</html>
