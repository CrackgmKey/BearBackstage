<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:58:"D:\phpStudy\WWW\yg/apps/admin\view\configs\config_site.tpl";i:1550552010;s:48:"D:\phpStudy\WWW\yg\apps\admin\view\index\top.tpl";i:1550568981;}*/ ?>
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
                window.location.href="<?php echo url('admin/index/index'); ?>";
            })

            $("#mod").click(function(){
                $("#form1").attr("action","<?php echo url('admin/configs/mod'); ?>");
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
            $(".radio-box2 .radio").click(function(){
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
		<div class="position link grey_l"><a href="" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;App设置</div>
		<div class="tab-box">
			<ul>
				<li class="cur">App设置</li>
			</ul>
		</div>
		<div class="add-box">
			<ul>
				<li><div class="title">当前模板</div><div class="input-box"><input name="template" type="text" class="input" value="<?php echo $datas['template']; ?>" /></div><div class="clear"></div></li>
				<li><div class="title">客服QQ</div><div class="input-box"><input name="qq_num" type="text" class="input" value="<?php echo $datas['qq_num']; ?>"  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></div><div class="clear"></div></li>
				<li><div class="title">最新版本</div><div class="input-box"><input name="home_page_num" type="text" class="input" value="<?php echo $datas['home_page_num']; ?>"/></div><div class="clear"></div></li>
				<li>
					<div class="title">是否强制更新</div>
					<div class="radio-box2">
						<div class="<?php if($datas['is_lottery']==1): ?>radio-s<?php else: ?>radio-n<?php endif; ?>  radio" id="1"></div><div class="radio-t">是</div>
						<div class="<?php if($datas['is_lottery']==0): ?>radio-s<?php else: ?>radio-n<?php endif; ?>  radio" id="0" style="margin-left:30px;"></div><div class="radio-t">否</div>
						<input type="hidden" name="is_lottery" value="<?php echo $datas['is_lottery']; ?>">
					</div>
					<div class="clear"></div>
				</li>
				<li class="textarea"><div class="title">更新公告</div><div class="textarea-box" ><textarea name="filter_keyword" id="filter_keyword" cols="80" rows="5" style="width:800px;height:270px;"><?php echo $datas['filter_keyword']; ?></textarea></div><div class="clear"></div></li>
			</ul>
		</div>
		<script type="text/javascript">
            var um = UM.getEditor('agreement');
		</script>
		<div class="fun-box" style="margin-left:30px;">
			<div class="button">
				<ul>
					<li class="add" id="mod">提交</li>
					<div class="clear"></div>
				</ul>
			</div>

			<div class="clear"></div>
		</div>

	</div><!-- end of main -->

</form>
</body>
</html>
