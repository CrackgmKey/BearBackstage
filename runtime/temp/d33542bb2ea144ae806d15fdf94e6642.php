<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:47:"D:\phpStudy\WWW\yg/apps/admin\view\user\mod.tpl";i:1505220900;s:48:"D:\phpStudy\WWW\yg\apps\admin\view\index\top.tpl";i:1508850092;}*/ ?>
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
<script type="text/javascript" src="/yg/public/static/admin/js/common.js"></script>
<title>main</title>
<script type="text/javascript">

$(document).ready(function(){

	$("#back").click(function(){
		window.location.href="<?php echo url('admin/user/index'); ?>";
	})
	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	
	$(".group-list ul li.can_select").click(function(){
		var id=$(this).attr("id");
		var text=$(this).text();
		$(this).parent("ul").parents(".input-box-s").children(".select-title").html(text);
		$(this).parent("ul").children("input").val(id);
		
	})
	$("#mod").click(function(){
		$("#form1").attr("action","<?php echo url('admin/user/mod'); ?>");
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
<div class="main" id="main">
	<div class="position link grey_l"><a href="<?php echo url('admin/index/index'); ?>" target="_top">首页</a>&nbsp;>&nbsp;用户管理&nbsp;>&nbsp;编辑会员</div>
	
	<div class="add-box">
		<ul>
			<li><div class="title">会员名称</div><div class="input-box"><input name="user_name" type="text" class="input" value="<?php echo $data['user_name']; ?>"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li><div class="title">会员密码</div><div class="input-box"><input name="password" type="password" class="input"/></div><div class="clear"></div></li>
			<li>
				<div class="title">会员分组</div>
				<div class="input-box-s" style="z-index:1001"><span class="select-title"><?php echo $data['group_cn']; ?></span>
					<div class="select-box group-list" >
						<ul>
							<input type="hidden" name="group_id" value="<?php echo $data['group_id']; ?>">
							<?php if(is_array($groupDatas) || $groupDatas instanceof \think\Collection || $groupDatas instanceof \think\Paginator): $i = 0; $__LIST__ = $groupDatas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
							<li id="<?php echo $v['id']; ?>" style="text-indent:1em;text-align:left;" <?php if($v['has_sub']==1): ?>class="read_only"<?php else: ?> url="<?php echo $v['go_url']; ?>" class="can_select"<?php endif; ?>><strong><?php echo $v['name']; ?></strong></li>
							<?php if($v['has_sub']==1): if(is_array($v['sub']) || $v['sub'] instanceof \think\Collection || $v['sub'] instanceof \think\Paginator): $i = 0; $__LIST__ = $v['sub'];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$sv): $mod = ($i % 2 );++$i;?>
								<li id="<?php echo $sv['id']; ?>" style="text-indent:2em;text-align:left;" url="<?php echo $sv['go_url']; ?>" class="can_select"><?php echo $sv['name']; ?></li>
							<?php endforeach; endif; else: echo "" ;endif; endif; endforeach; endif; else: echo "" ;endif; ?>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="title">会员头像</div>
				<div class="upload-box">
					<input name="photo" type="file" id="thumb"/>
				</div>
				<div class="img-path" id="img-path">
					<?php if($data['photo']): ?>
						<img src="/yg/public/uploads/<?php echo $data['photo']; ?>">
					<?php else: ?>
						<img src="/yg/public/static/admin/images/no-pic.jpg">
					<?php endif; ?>
				</div>
				<div class="clear"></div>
			</li>
			<li><div class="title">个人签名</div><div class="input-box"><input name="signature" type="text" class="input" value="<?php echo $data['signature']; ?>"/></div><div class="clear"></div></li>
			<li><div class="title">个人邮箱</div><div class="input-box"><input name="email" type="text" class="input" value="<?php echo $data['email']; ?>"/></div><div class="clear"></div></li>
			<li><div class="title">电话</div><div class="input-box"><input name="phone" type="text" class="input" value="<?php echo $data['phone']; ?>"/></div><div class="clear"></div></li>
			<li><div class="title">地址</div><div class="input-box"><input name="address" type="text" class="input" value="<?php echo $data['address']; ?>"/></div><div class="clear"></div></li>
			<li><div class="title">积分</div><div class="input-box"><input name="score" type="text" class="input" value="<?php echo $data['score']; ?>"/></div><div class="clear"></div></li>
			<li><div class="title">余额</div><div class="input-box"><input name="account" type="text" class="input" value="<?php echo $data['account']; ?>"/></div><div class="clear"></div></li>
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
<input type="hidden" name="id" value="<?php echo $data['id']; ?>"/>
</form>

</body>
</html>
