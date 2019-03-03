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
		window.location.href="{:url('admin/admin/index')}";
	})
	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	
	$(".group-list ul li").click(function(){
		var id=$(this).attr("id");
		var text=$(this).text();
		$(this).parent("ul").parents(".input-box-s").children(".select-title").html(text);
		$(this).parent("ul").children("input").val(id);
		
	})
	$("#mod").click(function(){
		$("#form1").attr("action","{:url('admin/admin/mod')}");
		$("#form1").submit();
	})
	$("#thumb").change(function(){
		$("#img-path").html($(this).val());
	})
	
	$(".radio-box1 .radio").click(function(){
		var id=$(this).attr("id");
		if($(this).hasClass("radio-n")){
			
			//去除同级选中状态
			$(this).siblings(".radio").removeClass("radio-s");
			$(this).siblings(".radio").addClass("radio-n");
			//添加本状态
			$(this).removeClass("radio-n");
			$(this).addClass("radio-s");
			
			$(this).siblings("input").val(id);
		}
	})
	
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;编辑管理员</div>
	
	<div class="add-box">
		<ul>
			<li><div class="title">管理员名称</div><div class="input-box"><input name="adm_name" type="text" class="input" value="{$data.adm_name}"/></div><div class="tip">*</div><div class="clear"></div></li>
			
			<li>
				<div class="title">管理员分组</div>
				<div class="input-box-s" style="z-index:1001"><span class="select-title">{$data.group_cn}</span>
					<div class="select-box group-list" >
						<ul>
							<input type="hidden" name="group_id" value="{$data.group_id}">
							{volist name="group_datas" id="group_data"}
							<li id="{$group_data.id}" style="text-indent:1em;text-align:left;" >{$group_data.name}</li>
							
							{/volist}
						</ul>
					</div>
				</div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="title">管理员头像</div>
				<div class="upload-box">
					<input name="avatar" type="file" id="thumb"/>
					
				</div>
				<div class="img-path" id="img-path"><img src="__ROOT____UPLOADS__/{$data.avatar}"></div>
				<div class="clear"></div>
			</li>
			<li><div class="title">管理员密码</div><div class="input-box"><input name="adm_password" type="password" class="input"/></div><div class="clear"></div></li>
			<li><div class="title">确认密码</div><div class="input-box"><input name="password_confirm" type="password" class="input"/></div><div class="clear"></div></li>
			
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
<input type="hidden" name="id" value="{$data.id}" />
</form>

</body>
</html>
