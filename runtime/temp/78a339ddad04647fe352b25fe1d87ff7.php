<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:50:"D:\phpStudy\WWW\yg/apps/admin\view\mails\index.tpl";i:1500300212;s:48:"D:\phpStudy\WWW\yg\apps\admin\view\index\top.tpl";i:1508850092;}*/ ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/yg/public/static/common/css/global.css" rel="stylesheet" type="text/css" />
<link href="/yg/public/static/admin/css/main.css" rel="stylesheet" type="text/css" />
<link href="/yg/public/ueditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="/yg/public/static/common/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/yg/public/static/common/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="/yg/public/static/admin/js/jquery.jclock.js"></script>
<script type="text/javascript" charset="utf-8" src="/yg/public/ueditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/yg/public/ueditor/umeditor.min.js"></script>
<script type="text/javascript" src="/yg/public/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="/yg/public/static/admin/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	$("#back").click(function(){
		window.location.href="<?php echo url('admin/mails/index'); ?>";
	})
	
	$("#mod").click(function(){
		$("#form1").attr("action","<?php echo url('admin/mails/mod'); ?>");
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
<link rel="stylesheet" href="/yg/public/static/common/layui/css/layui.css" media="all">
<script type="text/javascript" src="/yg/public/static/common/layui/layui.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#clearCache").click(function(){
		$.get("<?php echo url('admin/invalid/clearCache'); ?>",function(d){
		
			if(d==1){
				layui.use(['layer', 'form'], function(){
					layer.msg('缓存清除成功',{icon: 1});
				});
			} else {
				layui.use(['layer', 'form'], function(){
					layer.msg('缓存清除失败',{icon: 5});
				});
			}
		})
	})
})
</script>
<div class="top-bar">
	<div class="copy">&copy;版权所有：乐尚商城</div>
	<div class="ver">当前系统版本：<?php echo config("version"); ?></div>
	<div class="time" id="current-time"></div>
	<div class="right-nav white_l link">
		<ul>
			<li><a href="<?php echo url('index/index/index'); ?>" target="_blank">前台首页</a></li>
			<li><a href="<?php echo url('admin/index/index'); ?>" target="_top">后台首页</a></li>
			<li><a href="javascript:;" id="clearCache">清除缓存</a></li>
			<li><a href="<?php echo url('admin/login/logout'); ?>" target="_top">退出管理</a></li>
			<div class="clear"></div>
		</ul>
	</div>
	<div class="clear"></div>
</div>
<form enctype="multipart/form-data" action="" method="post" id="form1">
<div class="main" id="main">
	
	<div class="position link grey_l"><a href="<?php echo url('admin/index/index'); ?>" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;邮件设置</div>
	<div class="tab-box">
		<ul>
			<li class="cur">邮件服务器</li>
			<li><a href="<?php echo url('admin/mails/test'); ?>">测试邮件</a></li>
			<li><a href="<?php echo url('admin/mailrules/index'); ?>">邮件规则</a></li>
		</ul>
	</div>
	<div class="loading">乐尚商城提示您，请稍候！</div>
	<div class="add-box">
		<ul>
			<li><div class="title">SMTP服务器</div><div class="input-box"><input name="mail_host" type="text" class="input" value="<?php echo $data['mail_host']; ?>"/></div><div class="clear"></div></li>
			<li><div class="title">服务器用户名</div><div class="input-box"><input name="user_name" type="text" class="input" value="<?php echo $data['user_name']; ?>"/></div><div class="clear"></div></li>
			<li><div class="title">服务器密码</div><div class="input-box"><input name="password" type="text" class="input" value="<?php echo $data['password']; ?>"/></div><div class="clear"></div></li>
			<li><div class="title">端口</div><div class="input-box"><input name="port" type="text" class="input" value="<?php echo $data['port']; ?>"/></div><div class="clear"></div></li>
		</ul>
	</div>
	<div class="fun-box" style="margin-left:30px;">
		<div class="button">
			<ul>
				<li class="add" id="mod">编辑</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="clear"></div>
	</div>
	
	
	
</div><!-- end of main -->
<input type="hidden" name="id" value="1" />
</form>
</body>
</html>
