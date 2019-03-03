<?php if (!defined('THINK_PATH')) exit(); /*a:1:{s:50:"D:\phpStudy\WWW\yg/apps/admin\view\index\index.tpl";i:1502420778;}*/ ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>后台管理系统</title>
</head>

<frameset cols="270,*" framespacing="0" frameborder="no" border="0">
	<frame src="<?php echo url("admin/index/left"); ?>" name="menu" noresize="noresize" scrolling="no" />
	<frame src="<?php echo url("admin/index/main"); ?>" name="main" noresize="noresize" scrolling="yes" target="_self"/>
</frameset>
<noframes></noframes>

</html>
