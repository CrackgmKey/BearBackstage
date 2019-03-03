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
		window.location.href="{:url('admin/module/index')}";
	})
	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	$(".select-box ul li").click(function(){
		var id=$(this).attr("id");
		var text=$(this).text();
		$(this).parent("ul").parents(".input-box-s").children(".select-title").html(text);
		$(this).parent("ul").children("input").val(id);
	})
	$("#add").click(function(){
		$("#form1").attr("action","{:url('admin/module/add')}");
		$("#form1").submit();
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
	
	$(".classname").click(function(){
		var id=$(this).val();
		if($(this).is(':checked')){
			$(".sub_list_"+id).prop('checked',true);
		} else {
			$(".sub_list_"+id).prop('checked',false);
		}
	})
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;添加模块</div>
	
	<div class="add-box">
		<ul>
			<li><div class="title">模块名称</div><div class="input-box"><input name="name" type="text" class="input"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li><div class="title">英文名称</div><div class="input-box"><input name="classname" type="text" class="input"/></div><div class="tips">需填英文半角</div><div class="clear"></div></li>
			<li>
				<div class="title">模块类型</div>
				<div class="input-box-s" style="z-index:100"><span class="select-title">选择类型</span>
					<div class="select-box" >
						<ul>
							<input type="hidden" name="type" value="">
							<li id="1">普通商品</li>
							<li id="2">新闻资讯</li>
							<li id="4">积分商品</li>
						</ul>
					</div>
				</div>
				<div class="tip">*</div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="title">是否会员发布</div>
				<div class="radio-box1">
					<div class="radio-s  radio" id="1"></div><div class="radio-t">是</div>
					<div class="radio-n  radio" id="0" style="margin-left:30px;"></div><div class="radio-t">否</div>
					<input type="hidden" name="is_user_pub" value="1">
				</div>
				<div class="clear"></div>
			</li>
			
			<li><div class="title">模块排序</div><div class="input-box"><input name="sort" type="text" class="input" value="{$max_sort}"/></div><div class="tip">*</div><div class="clear"></div></li>
			
			
		</ul>
	</div>
	
	<div class="fun-box" style="margin-left:30px;">
		<div class="button">
			<ul>
				<li class="add" id="add">添加</li>
				<li class="dels"  id="back">返回</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->

</form>
</body>
</html>
