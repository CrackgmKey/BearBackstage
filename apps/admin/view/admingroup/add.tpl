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
		window.location.href="{:url('admin/admingroup/index')}";
	})
	
	$("#add").click(function(){
		$("#form1").attr("action","{:url('admin/admingroup/add')}");
		$("#form1").submit();
	})
	  
	  $("#all").click(function(){
		if($(this).is(':checked')){
			$("[name='auth[]']").prop('checked',true);
		} else {
			$("[name='auth[]']").prop('checked',false);
		}
	});
	
	$(".classname").click(function(){
		var id=$(this).val();
		if($(this).is(':checked')){
			$(".node_"+id).prop('checked',true);
		} else {
			$(".node_"+id).prop('checked',false);
		}
	})
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;添加管理员分组</div>
	
	<div class="add-box">
		<ul>
			<li><div class="title">名称</div><div class="input-box"><input name="name" type="text" class="input" value=""/></div><div class="tip">*</div><div class="clear"></div></li>
			<li><div class="title">选择</div><div class="text-box" style="font-size:14px"><input type="checkbox" id="all" />全选</div><div class="clear"></div></li>
			<li><div class="title">权限</div><div class="left" style="width:600px;">
				
			
            {volist name="class_datas" id="class_data"}
				
              <div class="auth-main">
				<input type="checkbox" class="classname"  value="{$class_data.id}"/>&nbsp;{$class_data.name}</b>
			  </div>
			  <div class="auth-sub">
			  {volist name="node_datas" id="node_data"}
				{if condition="$class_data.id==$node_data.class_id"}
					<div class="auth-body"><input type="checkbox" name="auth[]" class="node_{$class_data.id}" value="{$node_data.id}"/>&nbsp;{$node_data.name}</div>
				{/if}
			  {/volist}
			  <div class="clear"></div>
              </div>
			  
            {/volist}
           
			</div><div class="clear"></div></li>
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
