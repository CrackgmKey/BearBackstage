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
		window.location.href="{:url('admin/district/index')}";
	})
	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	
	var oid=0;
	$("#nav-list ul li").click(function(){
		var id=$(this).attr("id");
		var text=$(this).text();
		$(this).parent("ul").parents(".input-box-s").children(".select-title").html(text);
		$(this).parent("ul").children("input").val(id);
		//alert(oid);
		/*if(id!=oid && id!=0){
			var mid=$(this).attr("mid");
			$("#module_id").val(mid);
			$("#module_list").hide();
			
			
		} else if(id==0) {
			$("#module_id").val("");
			$(".select-title").html("选择模块");
			$("#module_list").show();
			
		}*/
		oid=id;
	})
	
	$("#module-list ul li").click(function(){
		var id=$(this).attr("id");
		var text=$(this).text();
		$(this).parent("ul").parents(".input-box-s").children(".select-title").html(text);
		$(this).parent("ul").children("input").val(id);
		
	})
	
	$("#add").click(function(){
		$("#form1").attr("action","{:url('admin/district/add')}");
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
	
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;内容管理&nbsp;>&nbsp;添加地区</div>
	
	<div class="add-box">
		<ul>
			<li><div class="title">地区名称</div><div class="input-box"><input name="district_name" type="text" class="input"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li>
				<div class="title">所属地区</div>
				<div class="input-box-s" style="z-index:100"><span class="select-title">选择地区</span>
					<div class="select-box" id="nav-list" style="height:200px;overflow-y:scroll">
						<ul>
							<input type="hidden" name="pid" id="pid" value="">
							<li id="0">顶级地区</li>
							 {volist name="datas" id="data"}
								<li id="{$data.id}">{$data.district_name}</li>
							 {/volist}
						</ul>
					</div>
				</div>
				<div class="tip">*</div>
				<div class="clear"></div>
			</li>
			
			<li><div class="title">排序</div><div class="input-box"><input name="sort" type="text" class="input" value="{$maxsort}"/></div><div class="tip">*</div><div class="clear"></div></li>
			
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
