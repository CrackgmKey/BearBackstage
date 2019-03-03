<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:46:"D:\phpStudy\WWW\yg/apps/admin\view\nav\add.tpl";i:1501684866;s:48:"D:\phpStudy\WWW\yg\apps\admin\view\index\top.tpl";i:1550568981;}*/ ?>
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
		window.location.href="<?php echo url('admin/nav/index'); ?>";
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
		$("#form1").attr("action","<?php echo url('admin/nav/add'); ?>");
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
	<div class="position link grey_l"><a href="<?php echo url('admin/index/index'); ?>" target="_top">首页</a>&nbsp;>&nbsp;内容管理&nbsp;>&nbsp;添加导航</div>
	
	<div class="add-box">
		<ul>
			<li><div class="title">导航名称</div><div class="input-box"><input name="name" type="text" class="input"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li>
				<div class="title">所属栏目</div>
				<div class="input-box-s" style="z-index:100"><span class="select-title">选择栏目</span>
					<div class="select-box" id="nav-list">
						<ul>
							<input type="hidden" name="pid" id="pid" value="">
							<li id="0">顶级栏目</li>
							 <?php if(is_array($navdatas) || $navdatas instanceof \think\Collection || $navdatas instanceof \think\Paginator): $i = 0; $__LIST__ = $navdatas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$data): $mod = ($i % 2 );++$i;?>
								<li id="<?php echo $data['id']; ?>" mid="<?php echo $data['module_id']; ?>"><?php echo $data['name']; ?></li>
							 <?php endforeach; endif; else: echo "" ;endif; ?>
						</ul>
					</div>
				</div>
				<div class="tip">*</div>
				<div class="clear"></div>
			</li>
			<li id="module_list">
				<div class="title">所属模块</div>
				<div class="input-box-s" style="z-index:99"><span class="select-title">选择模块</span>
					<div class="select-box" id="module-list">
						<ul>
							<input type="hidden" name="module_id" id="module_id" value="">
							 
							 <?php if(is_array($moduledatas) || $moduledatas instanceof \think\Collection || $moduledatas instanceof \think\Paginator): $i = 0; $__LIST__ = $moduledatas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$data): $mod = ($i % 2 );++$i;?>
								<li id="<?php echo $data['id']; ?>"><?php echo $data['name']; ?></li>
							 <?php endforeach; endif; else: echo "" ;endif; ?>
						</ul>
					</div>
				</div>
				<div class="tip">*</div>
				<div class="clear"></div>
			</li>
			
			<li><div class="title">栏目排序</div><div class="input-box"><input name="sort" type="text" class="input" value="<?php echo $maxsort; ?>"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li>
				<div class="title">是否显示</div>
				<div class="radio-box1">
					<div class="radio-s  radio" id="1"></div><div class="radio-t">显示</div>
					<div class="radio-n  radio" id="0" style="margin-left:30px;"></div><div class="radio-t">隐藏</div>
					<input type="hidden" name="display" value="1">
				</div>
				<div class="clear"></div>
			</li>
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
