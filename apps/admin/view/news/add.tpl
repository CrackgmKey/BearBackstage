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
<script type="text/javascript" charset="utf-8" src="__ROOT____PUBLIC__/ueditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="__ROOT____PUBLIC__/ueditor/umeditor.min.js"></script>
<script type="text/javascript" src="__ROOT____PUBLIC__/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	$("#back").click(function(){
		window.location.href="{:url('admin/news/index')}";
	})
	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	$(".select-box ul li.can_select").click(function(){
		var id=$(this).attr("id");
		var text=$(this).text();
		$(this).parent("ul").parents(".input-box-s").children(".select-title").html(text);
		$(this).parent("ul").children("input").val(id);
	})
	$("#add").click(function(){
		$(".add-box,.fun-box").hide();
		$(".loading").show();
		$("#form1").attr("action","{:url('admin/news/add')}");
		$("#form1").submit();
	})
	
	$("#thumb").change(function(){
		$("#img-path").html($(this).val());
	})
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;内容管理&nbsp;>&nbsp;添加新闻</div>
	<div class="loading">乐尚商城提示您，请稍候！</div>
	<div class="add-box">
		<ul>
			<li><div class="title">文章标题</div><div class="input-box"><input name="title" type="text" class="input"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li>
				<div class="title">所属栏目</div>
				<div class="input-box-s" style="z-index:1000"><span class="select-title">选择栏目</span>
					<div class="select-box" >
						<ul>
							<input type="hidden" name="cate" value="">
							{volist name="navDatas" id="v"}
								<li id="{$v.id}" style="text-indent:1em;text-align:left;" {if condition="$v.has_sub==1"}class="read_only"{else}class="can_select"{/if}><strong>{$v.name}</strong></li>
								{if condition="$v.has_sub==1"}
								{volist name="v.sub" id="sv"}
									<li id="{$sv.id}" style="text-indent:2em;text-align:left;" class="can_select">{$sv.name}</li>
								{/volist}
								{/if}
							{/volist}
						</ul>
					</div>
				</div>
				<div class="tip">*</div>
				<div class="clear"></div>
			</li>
			<li class="textarea"><div class="title">文章内容</div><div class="textarea-box" ><textarea name="content" id="content" cols="80" rows="5" style="width:800px;height:370px;"></textarea><div class="clear"></div></li>
			<li><div class="title">文章排序</div><div class="input-box"><input name="sort" type="text" class="input" value="{$maxsort}"/></div><div class="tip">*</div><div class="clear"></div></li>
			
		</ul>
	</div>
	<script type="text/javascript">  
		 var um = UM.getEditor('content');
         </script>
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
