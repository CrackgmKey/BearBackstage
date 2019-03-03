<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/main.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.jclock.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.caretInsert.js"></script>
<script type="text/javascript" src="__ROOT____ADMIN__/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){

	$(".notice").click(function(){
		
		var url="{:url('admin/smsrules/changeNotice')}";
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
		$("#form1").attr("action","{:url('admin/smsrules/batchSet')}");
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
						  title:'编辑短信规则',
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
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<input type="hidden" name="dels" value="1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;短信规则</div>
	<div class="tab-box">
		<ul>
			<li><a href="{:url('admin/sms/index')}">阿里大鱼服务商</a></li>
			<li><a href="{:url('admin/sms/test')}">测试短信</a></li>
			<li class="cur">短信规则</li>
			
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
				{volist name="datas" id="data"}
				<ul>
					<a>
					<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="{$data.id}"></li>
					<li style="width:7%">{$data.id}</li>
					<li style="width:30%">{$data.name}</li>
					<li style="width:10%;"><div class="notice_{$data.value} notice" id="{$data.id}" ></div></li>
					<li style="width:41%"><div class="green" >{$data.description}</div></li>
					<li style="width:7%"><div class="mod-icon mod"  data="{$data.name}" url="{$data.mod_url}">编</div><div class="clear"></div></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				
				{/volist}
			
		</div>
	</div><!-- end of list-box -->
	
	<div class="fun-box">
		<div class="button">
			<ul>
				<li class="set"  id="set">设置通知</li>
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
