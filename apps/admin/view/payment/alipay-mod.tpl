<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/main.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.jclock.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	$("#back").click(function(){
		window.location.href="{:url('admin/payment/index')}";
	})
	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	$(".select-box ul li").click(function(){
		var id=$(this).attr("id");
		var text=$(this).text();
		$(this).parent("ul").parents(".input-box-s").children(".select-title").html(text);
		$(this).parent("ul").children("input").val(id);
		if(id!=0){
			$("#catelist-box").slideUp("fast");
		} else {
			$("#catelist-box").slideDown("fast");
		}
	})
	$("#mod").click(function(){
		$("#form1").attr("action","{:url('admin/payment/mod')}");
		$("#form1").submit();
	})
	
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;支付管理&nbsp;>&nbsp;编辑{$data.byname}</div>
	
	<div class="add-box">
		<ul>
			<li><div class="title">名称</div><div class="text-box">{$data.byname}</div><div class="clear"></div></li>
			<li><div class="title">应用ID</div><div class="input-box"><input name="partner_id" type="text" class="input" value="{$data.partner_id}"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li class="textarea" style="min-height:140px"><div class="title">商户私钥</div><div class="textarea-box" ><textarea name="authkey" id="authkey" cols="80" rows="5" style="width:800px;height:100px;font-size:14px;line-height:20px;">{$data.authkey}</textarea></div><div class="tip">*</div><div class="clear"></div></li>
			<li class="textarea" style="min-height:140px"><div class="title">支付宝公钥</div><div class="textarea-box" ><textarea name="parameter1" id="parameter1" cols="80" rows="5" style="width:800px;height:100px;font-size:14px;line-height:20px;">{$data.parameter1}</textarea></div><div class="tip">*</div><div class="clear"></div></li>
			<!--<li>
				<div class="title">交易类型</div>
				<div class="input-box-s" style="z-index:101"><span class="select-title">{$data.parameter2_cn}</span>
					<div class="select-box" >
						<ul>
							<input type="hidden" name="parameter2" value="{$data.parameter2}">
							<li id="1">即时到账收款</li>
							<li id="2">担保交易收款</li>
							<li id="3">双功能收款</li>
						</ul>
					</div>
				</div>
				<div class="tip">*</div>
				<div class="clear"></div>
			</li>-->
			<li>
				<div class="title">证书文件</div>
				<div class="file-box">
					<input name="parameter3" type="file" id="thumb1" accept=".pem"/>
					
				</div>
				<div class="img-path" id="img-path1">{$data.parameter3}</div>
				<div class="clear"></div>
			</li>
			<li><div class="title">描述</div><div class="input-box"><input name="introduction" type="text" class="input" value="{$data.introduction}"/></div><div class="clear"></div></li>
			<li class="textarea" style="min-height:140px"><div class="title">简介</div><div class="textarea-box" ><textarea name="notes" id="notes" cols="80" rows="5" style="width:800px;height:100px;font-size:14px;line-height:20px;">{$data.notes}</textarea></div><div class="clear"></div></li>
			<li><div class="title">手续费</div><div class="input-box"><input name="fee" type="text" class="input" value="{$data.fee}"/></div><div class="tip">%</div><div class="clear"></div></li>
			<li><div class="title">排序</div><div class="input-box"><input name="sort" type="text" class="input" value="{$data.sort}"/></div><div class="tip">*</div><div class="clear"></div></li>
			
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
