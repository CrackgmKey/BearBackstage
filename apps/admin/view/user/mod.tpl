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
		window.location.href="{:url('admin/user/index')}";
	})
	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	
	$(".group-list ul li.can_select").click(function(){
		var id=$(this).attr("id");
		var text=$(this).text();
		$(this).parent("ul").parents(".input-box-s").children(".select-title").html(text);
		$(this).parent("ul").children("input").val(id);
		
	})
	$("#mod").click(function(){
		$("#form1").attr("action","{:url('admin/user/mod')}");
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
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;用户管理&nbsp;>&nbsp;编辑会员</div>
	
	<div class="add-box">
		<ul>
			<li><div class="title">会员名称</div><div class="input-box"><input name="user_name" type="text" class="input" value="{$data.user_name}"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li><div class="title">会员密码</div><div class="input-box"><input name="password" type="password" class="input"/></div><div class="clear"></div></li>
			<li>
				<div class="title">会员分组</div>
				<div class="input-box-s" style="z-index:1001"><span class="select-title">{$data.group_cn}</span>
					<div class="select-box group-list" >
						<ul>
							<input type="hidden" name="group_id" value="{$data.group_id}">
							{volist name="groupDatas" id="v"}
							<li id="{$v.id}" style="text-indent:1em;text-align:left;" {if condition="$v.has_sub==1"}class="read_only"{else} url="{$v.go_url}" class="can_select"{/if}><strong>{$v.name}</strong></li>
							{if condition="$v.has_sub==1"}
							{volist name="v.sub" id="sv"}
								<li id="{$sv.id}" style="text-indent:2em;text-align:left;" url="{$sv.go_url}" class="can_select">{$sv.name}</li>
							{/volist}
							{/if}
						{/volist}
						</ul>
					</div>
				</div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="title">会员头像</div>
				<div class="upload-box">
					<input name="photo" type="file" id="thumb"/>
				</div>
				<div class="img-path" id="img-path">
					{if condition="$data.photo"}
						<img src="__ROOT____UPLOADS__/{$data.photo}">
					{else}
						<img src="__ROOT____ADMIN__/images/no-pic.jpg">
					{/if}
				</div>
				<div class="clear"></div>
			</li>
			<li><div class="title">个人签名</div><div class="input-box"><input name="signature" type="text" class="input" value="{$data.signature}"/></div><div class="clear"></div></li>
			<li><div class="title">个人邮箱</div><div class="input-box"><input name="email" type="text" class="input" value="{$data.email}"/></div><div class="clear"></div></li>
			<li><div class="title">电话</div><div class="input-box"><input name="phone" type="text" class="input" value="{$data.phone}"/></div><div class="clear"></div></li>
			<li><div class="title">地址</div><div class="input-box"><input name="address" type="text" class="input" value="{$data.address}"/></div><div class="clear"></div></li>
			<li><div class="title">积分</div><div class="input-box"><input name="score" type="text" class="input" value="{$data.score}"/></div><div class="clear"></div></li>
			<li><div class="title">余额</div><div class="input-box"><input name="account" type="text" class="input" value="{$data.account}"/></div><div class="clear"></div></li>
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
<input type="hidden" name="id" value="{$data.id}"/>
</form>

</body>
</html>
