<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:51:"D:\phpStudy\WWW\yg/apps/admin\view\addons\index.tpl";i:1529048799;s:48:"D:\phpStudy\WWW\yg\apps\admin\view\index\top.tpl";i:1508850092;}*/ ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/yg/public/static/common/css/global.css" rel="stylesheet" type="text/css" />
<link href="/yg/public/static/admin/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/yg/public/static/common/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/yg/public/static/common/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="/yg/public/static/admin/js/jquery.jclock.js"></script>

<script type="text/javascript" src="/yg/public/static/admin/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	
	$(".inst,.uninst").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
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
<input type="hidden" name="dels" value="1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="<?php echo url('admin/index/index'); ?>" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;插件管理</div>
	
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:15%">插件名称</li>
				<li style="width:25%">简介</li>
				<li style="width:10%">状态</li>
				<li style="width:10%">版本</li>
				<li style="width:20%">作者</li>
				
				<li style="width:10%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		
		
		<?php if(($datas)): ?>
		<div class="list" id="list">
				<?php if(is_array($datas) || $datas instanceof \think\Collection || $datas instanceof \think\Paginator): $i = 0; $__LIST__ = $datas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$data): $mod = ($i % 2 );++$i;?>
				<ul>
					<a>
					<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" class="check-style"  name="id[]" value="<?php echo $data['title']; ?>"></li>
					
					<li style="width:15%"><div class="left" style="width:160px;"><strong><?php echo $data['title']; ?></strong></div></li>
					<li style="width:25%"><?php echo $data['description']; ?></li>
					<li style="width:10%"><?php if(($data['is_install'])): ?><span style="color:green">已安装</span><?php else: ?><span style="color:red">未安装</span><?php endif; ?></li>
					<li style="width:10%"><?php echo $data['version']; ?></li>
					<li style="width:20%"><?php echo $data['author']; ?></li>
					<li style="width:10%"><?php if(($data['is_install'])): ?><div class="del-icon uninst" url="<?php echo $data['uni_url']; ?>" >卸</div><div class="clear"></div><?php else: ?><div class="mod-icon inst" url="<?php echo $data['ins_url']; ?>">安</div><?php endif; ?></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				
				<?php endforeach; endif; else: echo "" ;endif; ?>
			
		</div>
		<?php else: endif; ?>
	</div><!-- end of list-box -->
	
	<div class="fun-box">
		<div class="button">
			<ul>
				
				<div class="clear"></div>
			</ul>
		</div>
		<div class="page grey_l link"><?php echo $bootstrap; ?></div>
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->
</form>
</body>
</html>
