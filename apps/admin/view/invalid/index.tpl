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

	
	$("#dels").click(function(){
		
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 $("#form1").attr("action","{:url('admin/invalid/del')}");
			 $("#form1").submit();
			  layer.close(index);
			});
		});
	})
	$(".del").click(function(){
		var id=$(this).attr("id");
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
	
	
	$(".thumb").hover(function(){
		$(this).parents("li").css("z-index","901");
		$(this).parents("li").css("overflow","visible");
		$(this).parents("li").children(".avatar-box").show(100);
	},function(){
		$(this).parents("li").css("z-index","800");
		$(this).parents("li").css("overflow","hidden");
		$(this).parents("li").children(".avatar-box").hide(100);
	})
	
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<input type="hidden" name="dels" value="1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;上传文件管理</div>
	
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:37%">文件名</li>
				<li style="width:23%">文件大小</li>
				<li style="width:20%">上传时间</li>
				
				<li style="width:10%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		
		
		<div class="list" id="list">
				{volist name="datas" id="data"}
				<ul>
					<a>
					<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" class="check-style"  name="id[]" value="{$data.name}"></li>
					
					<li style="width:37%"><div class="left" style="width:160px;"><strong>文件夹：{$data.name}</strong></div>{if condition="$data.is_sub"}<div class="up-icon slide" id="{$key}" title="下拉子导航"></div>{/if}</li>
					<li style="width:23%">{$data.size}</li>
					<li style="width:20%">{$data.date}</li>
					<li style="width:10%"></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				{if condition="$data.sub"}
				<div class="sub sub_{$key}">
					{volist name="data.sub" id="d"}
					<ul>
						<a>
						<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="{$data.name}/{$d.name}"></li>
						<li style="width:37%;position:relative;z-index:800">
							<div class="left">
								{if condition='$d.is_pic'}<span  class="green thumb"  style="cursor:pointer;" url="">[图]</span>{/if}&nbsp;{$d.name}</span>
							</div>
							<div class="avatar-box thumb-box"><img src="{$d.pic}"></div>
						</li>
						<li style="width:23%">{$d.size}</li>
						<li style="width:20%">{$d.date}</li>
						
						<li style="width:10%"><div class="del-icon del" url="{$d.del_url}" >删</div><div class="clear"></div></li>
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
