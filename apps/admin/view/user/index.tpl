<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/main.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.jclock.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/common.js"></script>
<title>main</title>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){
	layui.use('laydate', function(){
		var laydate = layui.laydate;
		laydate.render({
		  elem: '#dateRange'
		  ,type: 'month'
		  ,range: true
		});
	});
	$(".audit").click(function(){
		
		var url="{:url('admin/user/changeAudit')}";
		var id=$(this).attr("id");
		var obj=$(this);
		$.get(url,{"id":id},function(d){
			
			if(d=='auth_err'){
				layui.use(['layer', 'form'], function(){
					layer.msg('对不起，您无权操作此项目');
				});
			}else if(d!="err"){
				var last_status=d?"0":"1";
				$(obj).removeClass("audit_"+last_status);
				$(obj).addClass("audit_"+d);
			}
		})
	})
	
	$("#setForbidden").click(function(){
		$("#form1").attr("action","{:url('admin/user/batchSet','audit=1')}");
		$("#form1").submit();
	})
	$("#setAllow").click(function(){
		$("#form1").attr("action","{:url('admin/user/batchSet','audit=0')}");
		$("#form1").submit();
	})
	
	$("#dels").click(function(){
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			  $("#form1").attr("action","{:url('admin/user/del')}");
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
	
	$("#search").click(function(){
		$("#form1").attr("action","{:url('admin/user/index')}");
		$("#form1").submit();
	})
	
	$("#add").click(function(){
		window.location.href="{:url('admin/user/add')}";
	})
	
	$(".mod").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
	})
	$(".manage").click(function(){
		var url=$(this).attr("url");
		window.open(url);
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
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;用户管理&nbsp;>&nbsp;会员管理</div>
	<div class="search-box">
		<div class="input-box-s left" style="z-index:900"><span class="select-title">{$currentName}</span>
			<div class="select-box navclass">
					<ul>
						<li url="{:url('admin/user/index')}"  style="text-indent:1em;text-align:left;"><strong>所有分组</strong></li>
						{volist name="groupDatas" id="v"}
							<li id="{$v.id}" style="text-indent:1em;text-align:left;" {if condition="$v.has_sub==1"}class="read_only"{else} url="{$v.go_url}" class="can_select"{/if}><strong>{$v.name}</strong></li>
							{if condition="$v.has_sub==1"}
							{volist name="v.sub" id="sv"}
								<li id="{$sv.id}" style="text-indent:2em;text-align:left;" url="{$sv.go_url}" class="can_select">{$sv.name}</li>
							{/volist}
							{/if}
						{/volist}
					</ul>
				</div>
		</div>
		<div class="input-box-t left" style="z-index:900"><input type="text" name="dateRange" id="dateRange" placeholder="注册日期范围" value="{$dateRange}"></div>
		<div class="input-box-t left" style="z-index:900"><input type="text" name="key" placeholder="用户名/电话/邮箱"></div>
		<div class="search-but left" style="z-index:900" id="search">搜索</div>
		<div class="clear"></div>
	</div>
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style"></li>
				<li style="width:7%">编号</li>
				<li style="width:15%">会员名称</li>
				<li style="width:13%">手机号</li>
				<li style="width:13%">是否禁止</li>
				<li style="width:13%">用户分组</li>
				<li style="width:16%">注册/登陆时间</li>
			
				<li style="width:14%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="list" id="list">
				{volist name="datas" id="data"}
				<ul>
					<a>
					<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="{$data.id}"></li>
					<li style="width:7%">{$data.id}</li>
					<li style="width:15%;position:relative;z-index:800">
						<span  class="green thumb"  style="cursor:pointer;" ">&nbsp;{$data.user_name}
								
							</span>
					</li>
					<li style="width:13%"><div class="left" >{$data.phone}</div></li>
					<li style="width:13%;"><div class="audit_{$data.audit} audit" id="{$data.id}" ></div></li>
					<li style="width:13%"><div class="left" >{$data.groupname}</div></li>
					<li style="width:16%"><div class="left" ><span class="sienna">{$data.reg_time}</span></div></li>
					<li style="width:14%"><div class="mod-icon mod" url="{$data.mod_url}">编</div><div class="del-icon del" url="{$data.del_url}" >删</div><div class="green-icon manage" title="进入前台会员中心" url="{$data.man_url}" >管</div><div class="clear"></div></li>
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
				<li class="update"  id="setForbidden">批量禁止</li>
				<li class="set"  id="setAllow">批量允许</li>
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
