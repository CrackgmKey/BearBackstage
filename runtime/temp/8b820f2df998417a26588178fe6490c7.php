<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:49:"D:\phpStudy\WWW\yg/apps/admin\view\news\index.tpl";i:1530437599;s:48:"D:\phpStudy\WWW\yg\apps\admin\view\index\top.tpl";i:1550568981;}*/ ?>
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

	
	
	$("#update").click(function(){
		$("#form1").attr("action","<?php echo url('admin/news/batchSort'); ?>");
		$("#form1").submit();
	})
	
	$("#dels").click(function(){
		
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 $("#form1").attr("action","<?php echo url('admin/news/del'); ?>");
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
	
	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	$(".select-box ul li").click(function(){
		var url=$(this).attr("url");
		if(url){
			window.location.href=url;
		}
	})
	
	$("#add").click(function(){
		window.location.href="<?php echo url('admin/news/add'); ?>";
	})
	
	$(".mod").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
	})
	$("#recommend").click(function(){
		
		$("#form1").attr("action","<?php echo url('admin/news/batchRecommend','value=1'); ?>");
		$("#form1").submit();
	});
	$("#cancel").click(function(){
		
		$("#form1").attr("action","<?php echo url('admin/news/batchRecommend','value=2'); ?>");
		$("#form1").submit();
	})
	$(".thumb").hover(function(){
		$(this).parents("li").css("z-index","901");
		$(this).parents("li").css("overflow","visible");
		$(this).parents("li").children(".thumb-box").show(100);
	},function(){
		$(this).parents("li").css("z-index","800");
		$(this).parents("li").css("overflow","hidden");
		$(this).parents("li").children(".thumb-box").hide(100);
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
<input type="hidden" name="dels" value="1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="<?php echo url('admin/index/index'); ?>" target="_top">首页</a>&nbsp;>&nbsp;内容管理&nbsp;>&nbsp;新闻管理</div>
	<div class="search-box">
		<div class="input-box-s left" style="z-index:900"><span class="select-title"><?php echo $currentName; ?></span>
			<div class="select-box">
					<ul>
						<li url="<?php echo url('admin/news/index'); ?>">所有类别</li>
						<?php if(is_array($navDatas) || $navDatas instanceof \think\Collection || $navDatas instanceof \think\Paginator): $i = 0; $__LIST__ = $navDatas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
							<li id="<?php echo $v['id']; ?>" style="text-indent:1em;text-align:left;" <?php if($v['has_sub']==1): ?>class="read_only"<?php else: ?> url="<?php echo $v['go_url']; ?>" class="can_select"<?php endif; ?>><strong><?php echo $v['name']; ?></strong></li>
							<?php if($v['has_sub']==1): if(is_array($v['sub']) || $v['sub'] instanceof \think\Collection || $v['sub'] instanceof \think\Paginator): $i = 0; $__LIST__ = $v['sub'];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$sv): $mod = ($i % 2 );++$i;?>
								<li id="<?php echo $sv['id']; ?>" style="text-indent:2em;text-align:left;" url="<?php echo $sv['go_url']; ?>" class="can_select"><?php echo $sv['name']; ?></li>
							<?php endforeach; endif; else: echo "" ;endif; endif; endforeach; endif; else: echo "" ;endif; ?>
					</ul>
				</div>
		</div>
		<div class="clear"></div>
	</div>
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:7%">编号</li>
				<li style="width:35%">标题</li>
				<li style="width:13%">所有类别</li>
				<li style="width:20%">添加/更新时间</li>
				<li style="width:10%">排序</li>
				<li style="width:10%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="list" id="list">
				<?php if(is_array($datas) || $datas instanceof \think\Collection || $datas instanceof \think\Paginator): $i = 0; $__LIST__ = $datas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$data): $mod = ($i % 2 );++$i;?>
				<ul>
					<a>
					<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="<?php echo $data['id']; ?>"></li>
					<li style="width:7%"><?php echo $data['id']; ?></li>
					<li style="width:35%;position:relative;z-index:899">
						<div class="left" title="<?php echo $data['title']; ?>">
							<span class="green">[点击:<?php echo $data['click']; ?>]</span>&nbsp;<?php if($data['is_recommend']=='1'): ?><span class="green">[已推]</span><?php elseif($data['is_recommend']=='2'): ?><span class="red">[未推]</span><?php endif; ?>&nbsp;<?php if($data['thumb']): ?><span  class="green thumb"  style="cursor:pointer;" url="<?php echo $data['thumb']; ?>">[图]</span><?php endif; ?>&nbsp;<?php echo $data['title']; ?>
						</div>
						<?php if($data['thumb']): ?><div class="thumb-box"><img src="<?php echo $data['thumb']; ?>"></div><?php endif; ?>
					</li>
					<li style="width:13%"><div class="left" ><?php echo $data['classname']; ?></div></li>
					<li style="width:20%"><div class="left" ><span class="sienna"><?php echo $data['addtime']; ?></span>&nbsp;/&nbsp;<span class="green"><?php echo $data['uptime']; ?></span></div></li>
					<li style="width:10%;"><input type="text" name="sort[<?php echo $data['id']; ?>]" value="<?php echo $data['sort']; ?>" class="input" maxlength="3"></li>
					<li style="width:10%"><div class="mod-icon mod" url="<?php echo $data['mod_url']; ?>">编</div><div class="del-icon del" url="<?php echo $data['del_url']; ?>" >删</div><div class="clear"></div></li>
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
				<li class="update"  id="update">更新排序</li>
				<li class="import"  id="recommend">设置推荐</li>
				<li class="export"  id="cancel">取消推荐</li>
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
