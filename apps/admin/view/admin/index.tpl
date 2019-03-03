<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.jclock.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	
	$("#dels").click(function(){
		
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 $("#form1").attr("action","{:url('admin/admin/del')}");
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
		
		var url="{:url('admin/admin/changeDefault')}";
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
		window.location.href="{:url('admin/admin/add')}";
	})
	
	$(".mod").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
	})
	
	$(".thumb").hover(function(){
		$(this).parents("li").css("z-index","901");
		$(this).parents("li").css("overflow","visible");
		$(this).parents("li").children(".avatar-box").show(100);
	},function(){
		$(this).parents("li").css("z-index","800");
		$(this).parents("li").css("overflow","hidden");
		$(this).parents("li").children(".avatar-box").hide(100);
	})
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<input type="hidden" name="dels" value="1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;管理员列表</div>
	<div class="tab-box">
		<ul>
			<li><a href="{:url('admin/admingroup/index')}">管理员分组</a></li>
			<li class="cur">管理员列表</li>
		</ul>
	</div>
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:10%">编号</li>
				<li style="width:15%">名称</li>
				<li style="width:15%">所属分组</li>
				<li style="width:15%">默认状态</li>
				<li style="width:15%">最后登陆时间</li>
				<li style="width:10%">最后登陆IP</li>
				<li style="width:10%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="list" id="list">
				{volist name="datas" id="data"}
				<ul>
					<a>
					<li style="width:10%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="{$data.id}"></li>
					<li style="width:10%">{$data.id}</li>
					<li style="width:15%;position:relative;z-index:800">
						<div class="left">
							<span  class="green thumb"  style="cursor:pointer;" url="__ROOT____UPLOADS__/{$data.avatar}">[头像]</span>&nbsp;{$data.adm_name}
						</div>
						{if condition="$data.avatar"}<div class="avatar-box"><img src="__ROOT____UPLOADS__/{$data.avatar}"></div>{else}<div class="avatar-box"><img src="__ROOT____ADMIN__/images/user-default.jpg"></div>{/if}</li>
					<li style="width:15%">{$data.group_cn}</li>
					<li style="width:15%"><div class="default_{$data.is_default} default" id="{$data.id}" ></div></li>
					<li style="width:15%;"><span >{$data.login_time!='1970-01-01'?$data.login_time:'暂无'}</span></li>
					<li style="width:10%">{$data.login_ip?$data.login_ip:'暂无'}</li>
					<li style="width:10%"><div class="mod-icon mod" url="{$data.mod_url}">编</div><div class="del-icon del" url="{$data.del_url}">删</div><div class="clear"></div></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				
				{/volist}
			
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
		<div class="page grey_l link">{$datas->render()}</div>
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->
</form>
</body>
</html>
