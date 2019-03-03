<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:54:"D:\phpStudy\WWW\yg/apps/admin\view\mailrules\index.tpl";i:1513004250;s:48:"D:\phpStudy\WWW\yg\apps\admin\view\index\top.tpl";i:1508850092;}*/ ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/yg/public/static/common/css/global.css" rel="stylesheet" type="text/css" />
<link href="/yg/public/static/admin/css/main.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/yg/public/static/common/layui/css/layui.css" media="all">
<script type="text/javascript" src="/yg/public/static/common/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/yg/public/static/common/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="/yg/public/static/admin/js/jquery.jclock.js"></script>
<script type="text/javascript" src="/yg/public/static/common/layui/layui.js"></script>
<script type="text/javascript" src="/yg/public/static/admin/js/jquery.caretInsert.js"></script>
<script type="text/javascript" src="/yg/public/static/admin/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	$(".notice").click(function(){
		
		var url="<?php echo url('admin/mailrules/changeNotice'); ?>";
		var id=$(this).attr("id");
		var obj=$(this);
		$.get(url,{"id":id},function(d){
			if(d=='auth_err'){
				layui.use(['layer', 'form'], function(){
					layer.msg('对不起，您无权操作此项目');
				});
			}else if(d!="err"){
				var last_status=d?"0":"1";
				$(obj).removeClass("notice_"+last_status);
				$(obj).addClass("notice_"+d);
			}
		})
	})
	
	$("#set").click(function(){
		$("#form1").attr("action","<?php echo url('admin/mailrules/batchSet'); ?>");
		$("#form1").submit();
	})
	
	
	
	$(".mod").click(
		function(){
			var id=$(this).attr("id");
			var data=$(this).attr("data");
			var title="编辑"+data+"模版";
			
			var open_url=$(this).attr("url");
			$.post(open_url,{},function(d){
				if(d=='auth_err'){
					layui.use(['layer', 'form'], function(){
						layer.msg('对不起，您无权操作此项目');
					});
				} else {
					layui.use(['layer', 'form'], function(){
						layer.open({
						  type: 2,
						  area: ['700px', '350px'],
						  title:'编辑邮件规则',
						  fixed: false, //不固定
						  maxmin: true,
						  content: open_url
						  
						  
						});
					});
				}
			})
			
		}
	);
	
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
	<div class="position link grey_l"><a href="<?php echo url('admin/index/index'); ?>" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;邮件规则</div>
	<div class="tab-box">
		<ul>
			<li><a href="<?php echo url('admin/mails/index'); ?>">邮件服务器</a></li>
			<li><a href="<?php echo url('admin/mails/test'); ?>">测试邮件</a></li>
			<li class="cur">邮件规则</li>
		</ul>
	</div>
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:7%">编号</li>
				<li style="width:30%">名称</li>
				<li style="width:10%">是否通知</li>
				<li style="width:41%">介绍</li>
				<li style="width:7%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="list" id="list">
				<?php if(is_array($datas) || $datas instanceof \think\Collection || $datas instanceof \think\Paginator): $i = 0; $__LIST__ = $datas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$data): $mod = ($i % 2 );++$i;?>
				<ul>
					<a>
					<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="<?php echo $data['id']; ?>"></li>
					<li style="width:7%"><?php echo $data['id']; ?></li>
					<li style="width:30%"><?php echo $data['name']; ?></li>
					<li style="width:10%;"><div class="notice_<?php echo $data['value']; ?> notice" id="<?php echo $data['id']; ?>" ></div></li>
					<li style="width:41%"><div class="green" ><?php echo $data['description']; ?></div></li>
					<li style="width:7%"><div class="mod-icon mod"  data="<?php echo $data['name']; ?>" url="<?php echo $data['mod_url']; ?>">编</div><div class="clear"></div></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				
				<?php endforeach; endif; else: echo "" ;endif; ?>
			
		</div>
	</div><!-- end of list-box -->
	
	<div class="fun-box">
		<div class="button">
			<ul>
				<li class="set"  id="set">设置通知</li>
				<div class="clear"></div>
			</ul>
		</div>
		<div class="page grey_l link"><?php echo $datas->render(); ?></div>
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->
</form>
</body>
</html>
