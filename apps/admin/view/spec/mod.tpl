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
		window.location.href="{:url('admin/spec/index')}";
	})
	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	$(".navlist ul li").click(function(){
		var id=$(this).attr("id");
		var text=$(this).text();
		var cate_id=$(this).attr("cate_id");
		$(this).parent("ul").parents(".input-box-s").children(".select-title").html(text);
		$(this).parent("ul").children("input").val(id);
		if(id!=0){
			$("#catelist-box").slideUp("fast");
			$("#cate_id").val(cate_id);
		} else {
			$("#catelist-box").slideDown("fast");
		}
	})
	$(".catelist ul li.can_select").click(function(){
		var id=$(this).attr("id");
		var text=$(this).text();
		$(this).parent("ul").parents(".input-box-s").children(".select-title").html(text);
		$(this).parent("ul").children("input").val(id);
	})
	$("#mod").click(function(){
		$("#form1").attr("action","{:url('admin/spec/mod')}");
		$("#form1").submit();
	})
	
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;商品管理&nbsp;>&nbsp;编辑规格</div>
	
	<div class="add-box">
		<ul>
			<li><div class="title">规格名称</div><div class="input-box"><input name="name" type="text" class="input" value="{$data.name}"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li>
				<div class="title">所属栏目</div>
				<div class="input-box-s" style="z-index:101"><span class="select-title">{$data.specname}</span>
					<div class="select-box navlist" >
						<ul>
							<input type="hidden" name="pid" value="{$data.pid}">
							<li id="0">顶级栏目</li>
							 
							 {volist name="main" id="v"}
								{if condition="$v.id!=$data.id"}
								<li id="{$v.id}" cate_id="{$v.cate_id}">{$v.name}</li>
								{/if}
							 {/volist}
						</ul>
					</div>
				</div>
				<div class="tip">*</div>
				<div class="clear"></div>
			</li>
			
			<li id="catelist-box" {if condition="$data.pid!=0"}style="display:none"{/if}>
				<div class="title">所属分类</div>
				<div class="input-box-s" style="z-index:100"><span class="select-title">{$data.cate_cn}</span>
					<div class="select-box catelist">
						<ul>
							<input type="hidden" name="cate_id" id="cate_id" value="{$data.cate_id}">
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
			<li><div class="title">栏目排序</div><div class="input-box"><input name="sort" type="text" class="input" value="{$data.sort}"/></div><div class="tip">*</div><div class="clear"></div></li>
			
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
