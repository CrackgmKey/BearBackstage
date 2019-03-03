<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:52:"D:\phpStudy\WWW\yg/apps/admin\view\logs\adminlog.tpl";i:1526614286;s:48:"D:\phpStudy\WWW\yg\apps\admin\view\index\top.tpl";i:1550568981;}*/ ?>
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
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	$(".show").click(function(){
		
		var data=$(this).attr('data');
		
		$.post("<?php echo url('admin/logs/ajaxGetInfo'); ?>",{ip:data},function(d){
			var msg='';
			msg+='国家：'+d.data.country+"<br>";
			msg+='省：'+d.data.region+"<br>";
			msg+='市：'+d.data.city+"<br>";
			msg+='所属运营商：'+d.data.isp;
			layui.use(['layer', 'form'], function(){
				layer.open({
				  type: 1
				  ,title: false //不显示标题栏
				  ,closeBtn: false
				  ,area: '300px;'
				  ,shade: 0.8
				  ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
				  ,resize: false
				  ,btn: ['关闭']
				  ,btnAlign: 'c'
				  ,moveType: 1 //拖拽模式，0或者1
				  ,content: '<div style="padding: 50px; line-height: 22px; background-color: #fff; color: #393D49; font-weight: 300;">'+msg+'</div>'
				  
				});
			});
		},'json')
		
		
	})
	
	
	$("#dels").click(function(){
		
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 $("#form1").attr("action","<?php echo url('admin/logs/del'); ?>");
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
<input type="hidden" name="type" value="2">
<div class="main" id="main">
	<div class="position link grey_l"><a href="<?php echo url('admin/index/index'); ?>" target="_top">首页</a>&nbsp;>&nbsp;日志管理&nbsp;>&nbsp;管理员登陆日志</div>
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:10%">编号</li>
				<li style="width:35%">管理员名称</li>
				<li style="width:20%">登陆时间</li>
				<li style="width:15%">登陆IP</li>
				<li style="width:10%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="list" id="list">
				<?php if(is_array($datas) || $datas instanceof \think\Collection || $datas instanceof \think\Paginator): $i = 0; $__LIST__ = $datas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$data): $mod = ($i % 2 );++$i;?>
				<ul>
					<a>
					<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="<?php echo $data['id']; ?>"></li>
					<li style="width:10%"><?php echo $data['id']; ?></li>
					<li style="width:35%"><?php echo $data['adm_name']; ?></li>
					<li style="width:20%;"><span class="green"><?php echo $data['log_time']; ?></span></li>
					<li style="width:15%;"><?php echo $data['log_ip']; ?></li>
					<li style="width:10%"><div class="mod-icon show" data="<?php echo $data['log_ip']; ?>">详</div><div class="del-icon del" url="<?php echo $data['del_url']; ?>" >删</div><div class="clear"></div></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				
				<?php endforeach; endif; else: echo "" ;endif; ?>
			
		</div>
	</div><!-- end of list-box -->
	
	<div class="fun-box">
		<div class="button">
			<ul>
				<li class="dels"  id="dels">删除</li>
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
