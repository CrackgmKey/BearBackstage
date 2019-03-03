<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/main.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____PUBLIC__/ueditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.jclock.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	$("#back").click(function(){
		window.location.href="{:url('admin/index/index')}";
	})
	
	$("#mod").click(function(){
		$("#form1").attr("action","{:url('admin/configs/mod')}");
		$("#form1").submit();
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
	
	$("#logo").change(function(){
		$(".logo-path").html($(this).val());
	})
	
	$("#favicon").change(function(){
		$(".favicon-path").html($(this).val());
	})
	$("#water_mark").change(function(){
		$(".water_mark-path").html($(this).val());
	})
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;网站设置</div>
	<div class="tab-box">
		<ul>
			<li><a href="{:url('admin/configs/index',array('id'=>1))}">站点设置</a></li>
			<li class="cur">图片设置</li>
			<li><a href="{:url('admin/configs/index',array('id'=>3))}">App设置</a></li>
		</ul>
	</div>
	<div class="add-box">
		<ul>
			<li>
				<div class="title">网站LOGO</div>
				<div class="upload-box">
					<input name="logo" type="file" id="logo" />
				</div>
				<div class="img-path logo-path" id="img-path"><img src="__ROOT____UPLOADS__/{$datas.logo}"></div>
				
				<div class="clear"></div>
			</li>
			<li>
				<div class="title">收藏夹图标</div>
				<div class="upload-box">
					<input name="favicon" type="file" id="favicon" />
				</div>
				<div class="img-path favicon-path" id="img-path"><img src="__ROOT____UPLOADS__/{$datas.favicon}"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="title">水印图片</div>
				<div class="upload-box">
					<input name="water_mark" type="file" id="water_mark" />
				</div>
				<div class="img-path water_mark-path" id="img-path"><img src="__ROOT____UPLOADS__/{$datas.water_mark}"></div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="title">是否使用水印</div>
				<div class="radio-box1">
					<div class="{if condition="$datas.water_marked==1"}radio-s{else}radio-n{/if}  radio" id="1"></div><div class="radio-t">是</div>
					<div class="{if condition="$datas.water_marked==0"}radio-s{else}radio-n{/if}  radio" id="0" style="margin-left:30px;"></div><div class="radio-t">否</div>
					<input type="hidden" name="water_marked" value="{$datas.water_marked}">
				</div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="title">水印位置</div>
				<div class="input-box-s" style="z-index:100"><span class="select-title">{$datas.water_position}</span>
					<div class="select-box" >
						<ul>
							<input type="hidden" name="water_position" value="{$datas.water_position}">
							<li id="0">随机位置</li>
							<li id="1">顶端居左</li>
							<li id="2">顶端居中</li>
							<li id="3">顶端居右</li>
							<li id="4">中部居左</li>
							<li id="5">中部居中</li>
							<li id="6">中部居右</li>
							<li id="7">底端居左</li>
							<li id="8">底端居中</li>
							<li id="9">底端居右</li>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
			</li>
			<li><div class="title">缩略图宽</div><div class="input-box"><input name="thumb_width" type="text" class="input" value="{$datas.thumb_width}"/></div><div class="tips">像素</div><div class="clear"></div></li>
			<li><div class="title">缩略图高</div><div class="input-box"><input name="thumb_height" type="text" class="input" value="{$datas.thumb_height}"/></div><div class="tips">像素</div><div class="clear"></div></li>
			<li><div class="title">上传图片容量</div><div class="input-box"><input name="upload_size" type="text" class="input" value="{$datas.upload_size}"/></div><div class="tips">字节</div><div class="clear"></div></li>
		</ul>
	</div>
	<div class="fun-box" style="margin-left:30px;">
		<div class="button">
			<ul>
				<li class="add" id="mod">提交</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->

</form>
</body>
</html>
