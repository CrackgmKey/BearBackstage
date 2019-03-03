<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:52:"D:\phpStudy\WWW\yg/apps/admin\view\lottery\index.tpl";i:1511702360;s:48:"D:\phpStudy\WWW\yg\apps\admin\view\index\top.tpl";i:1550568981;}*/ ?>
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
<script type="text/javascript" src="/yg/public/static/admin/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	
	
	$("#dels").click(function(){
		
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 $("#form1").attr("action","<?php echo url('admin/lottery/del'); ?>");
			 $("#form1").submit();
			  layer.close(index);
			});
		});
	})
	$(".del").click(function(){
		var url=$(this).attr("url");
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 window.location.href=url;
			  layer.close(index);
			});
		});
		
	})
	
	$(".default").click(function(){
		
		var url="<?php echo url('admin/lottery/changeDefault'); ?>";
		var id=$(this).attr("id");
		var obj=$(this);
		
		$.get(url,{"id":id},function(d){
			
			if(d=='auth_err'){
				layui.use(['layer', 'form'], function(){
					layer.msg('对不起，您无权操作此项目');
				});
			}else if(d!="err"){
				$(".default").removeClass("default_0");
				$(".default").addClass("default_0");
				$(obj).removeClass("default_0");
				$(obj).addClass("default_1");
			}
		})
	})
	
	$("#add").click(function(){
		window.location.href="<?php echo url('admin/lottery/add'); ?>";
	})
	
	$(".mod").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
	})
	
	
	$(".items").click(
		function(){
			var id=$(this).attr("id");
			var data=$(this).attr("data");
			var title="编辑"+data;
			
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
						  area: ['900px', '500px'],
						  title:'编辑奖项',
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
	<div class="position link grey_l"><a href="<?php echo url('admin/index/index'); ?>" target="_top">首页</a>&nbsp;>&nbsp;用户管理&nbsp;>&nbsp;积分抽奖</div>
	<div class="tab-box">
		<ul>
			<li class="cur">抽奖列表</li>
			<li><a href="<?php echo url('admin/lotterywin/index'); ?>">中奖列表</a></li>
		</ul>
	</div>
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:10%">编号</li>
				<li style="width:30%">名称</li>
				<li style="width:15%">默认状态</li>
				<li style="width:15%">类型</li>
				<li style="width:20%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="list" id="list">
				<?php if(is_array($datas) || $datas instanceof \think\Collection || $datas instanceof \think\Paginator): $i = 0; $__LIST__ = $datas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$data): $mod = ($i % 2 );++$i;?>
				<ul>
					<a>
					<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="<?php echo $data['id']; ?>"></li>
					<li style="width:10%"><?php echo $data['id']; ?></li>
					<li style="width:30%"><?php echo $data['name']; ?></li>
					<li style="width:15%"><div class="default_<?php echo $data['is_default']; ?> default" id="<?php echo $data['id']; ?>" ></div></li>
					<li style="width:15%;"><?php echo $data['category_cn']; ?></li>
					<li style="width:20%"><div class="mod-icon mod" url="<?php echo $data['mod_url']; ?>">编</div><div class="del-icon del" url="<?php echo $data['del_url']; ?>" >删</div><div class="green-icon items" url="<?php echo $data['ite_url']; ?>" title="编辑中奖项目">项</div><div class="clear"></div></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				
				<?php endforeach; endif; else: echo "" ;endif; ?>
			
		</div>
	</div><!-- end of list-box -->
	
	<div class="fun-box">
		<div class="button">
			<ul>
				<li class="add" id="add">添加</li>
				<li class="dels"  id="dels">删除</li>
				<div class="clear"></div>
			</ul>
		</div>
		<div class="page grey_l link"><?php echo $page; ?></div>
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->
</form>
</body>
</html>
