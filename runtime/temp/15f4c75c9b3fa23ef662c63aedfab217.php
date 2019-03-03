<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:47:"D:\phpStudy\WWW\yg/apps/admin\view\news\add.tpl";i:1551081725;s:48:"D:\phpStudy\WWW\yg\apps\admin\view\index\top.tpl";i:1550568981;}*/ ?>
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
		window.location.href="<?php echo url('admin/news/index'); ?>";
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
		$("#form1").attr("action","<?php echo url('admin/news/add'); ?>");
		$("#form1").submit();
	})
	
	$("#thumb").change(function(){
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
	<div class="position link grey_l"><a href="<?php echo url('admin/index/index'); ?>" target="_top">首页</a>&nbsp;>&nbsp;内容管理&nbsp;>&nbsp;添加新闻</div>
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
							<?php if(is_array($navDatas) || $navDatas instanceof \think\Collection || $navDatas instanceof \think\Paginator): $i = 0; $__LIST__ = $navDatas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
								<li id="<?php echo $v['id']; ?>" style="text-indent:1em;text-align:left;" <?php if($v['has_sub']==1): ?>class="read_only"<?php else: ?>class="can_select"<?php endif; ?>><strong><?php echo $v['name']; ?></strong></li>
								<?php if($v['has_sub']==1): if(is_array($v['sub']) || $v['sub'] instanceof \think\Collection || $v['sub'] instanceof \think\Paginator): $i = 0; $__LIST__ = $v['sub'];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$sv): $mod = ($i % 2 );++$i;?>
									<li id="<?php echo $sv['id']; ?>" style="text-indent:2em;text-align:left;" class="can_select"><?php echo $sv['name']; ?></li>
								<?php endforeach; endif; else: echo "" ;endif; endif; endforeach; endif; else: echo "" ;endif; ?>
						</ul>
					</div>
				</div>
				<div class="tip">*</div>
				<div class="clear"></div>
			</li>
			<li class="textarea"><div class="title">文章内容</div><div class="textarea-box" ><textarea name="content" id="content" cols="80" rows="5" style="width:800px;height:370px;"></textarea><div class="clear"></div></li>
			<li><div class="title">文章排序</div><div class="input-box"><input name="sort" type="text" class="input" value="<?php echo $maxsort; ?>"/></div><div class="tip">*</div><div class="clear"></div></li>
			
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
