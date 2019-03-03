<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:46:"D:\phpStudy\WWW\yg/apps/admin\view\adv\mod.tpl";i:1551061329;s:48:"D:\phpStudy\WWW\yg\apps\admin\view\index\top.tpl";i:1550568981;}*/ ?>
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

	$("#back").click(function(){
		window.location.href="<?php echo url('admin/adv/index'); ?>";
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
	$("#mod").click(function(){
		$(".add-box,.fun-box").hide();
		$(".loading").show();
		$("#form1").attr("action","<?php echo url('admin/adv/mod'); ?>");
		$("#form1").submit();
	})
	
	$("#img").change(function(){
		$("#img-path").html($(this).val());
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
	<div class="position link grey_l"><a href="<?php echo url('admin/index/index'); ?>" target="_top">首页</a>&nbsp;>&nbsp;内容管理&nbsp;>&nbsp;商品轮播</div>
	<div class="loading">乐尚商城提示您，请稍候！</div>
	<div class="add-box">
		<ul>
			<li><div class="title">商品名称</div><div class="input-box"><input name="name" type="text" class="input" value="<?php echo $data['name']; ?>"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li>
				<div class="title">所属分类</div>
				<div class="input-box-s" style="z-index:900"><span class="select-title"><?php echo $data['cate_cn']; ?></span>
					<div class="select-box" >
						<ul>
							<input type="hidden" name="cate" value="<?php echo $data['cate']; ?>">
							<?php if(is_array($acateData) || $acateData instanceof \think\Collection || $acateData instanceof \think\Paginator): $i = 0; $__LIST__ = $acateData;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
								<li id="<?php echo $v['id']; ?>" style="text-indent:1em;text-align:left;"><?php echo $v['name']; ?></li>
							<?php endforeach; endif; else: echo "" ;endif; ?>
						</ul>
					</div>
				</div>
				<div class="tip">*</div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="title">商品广告</div>
				<div class="upload-box">
					<input name="pic" type="file" id="img"/>
					
				</div>
				<div class="img-path" id="img-path"><img src="<?php echo $data['pic']; ?>"></div>
				<div class="clear"></div>
			</li>
			<li><div class="title">商品ID</div><div class="input-box"><input name="url" type="text" class="input" value="<?php echo $data['url']; ?>"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li><div class="title">轮播排序</div><div class="input-box"><input name="sort" type="text" class="input" value="<?php echo $data['sort']; ?>"/></div><div class="tip">*</div><div class="clear"></div></li>
			
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

<input type="hidden" name="id" value="<?php echo $data['id']; ?>" />
</form>
</body>
</html>
