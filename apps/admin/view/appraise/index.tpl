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
			 $("#form1").attr("action","{:url('admin/appraise/del')}");
			 $("#form1").submit();
			  layer.close(index);
			});
		});
	})
	$(".del").click(function(){
		var id=$(this).attr("id");
	
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 window.location.href=url;
			  layer.close(index);
			});
		});
		
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
	
	$(".mod").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
	})
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<input type="hidden" name="dels" value="1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;商品管理&nbsp;>&nbsp;评价管理</div>
	<div class="tab-box">
		<ul>
			<li {if condition="$Request.param.id==0"}class="cur"{/if}><a href="{:url('admin/appraise/index','id=0')}">未回复</a></li>
			<li {if condition="$Request.param.id==1"}class="cur"{/if}><a href="{:url('admin/appraise/index','id=1')}">已回复</a></li>
		</ul>
	</div>
	<div class="list-box">
		<div class="title">
			<ul>
				<li style="width:6%">&nbsp;&nbsp;<input type="checkbox" id="all_select" class="check-style" ></li>
				<li style="width:10%">用户名</li>
				<li style="width:24%">商品信息</li>
				<li style="width:25%">评价信息</li>
				<li style="width:25%">回复信息</li>
				<li style="width:10%">操作</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="list" id="list">
				{volist name="datas" id="data"}
				<ul>
					<a>
					<li style="width:6%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="{$data.id}"></li>
					<li style="width:10%">{$data.username}</li>
					<li style="width:24%;position:relative;z-index:900">
						<div class="left">
							{if condition="$data.thumb"}<span  class="green thumb"  style="cursor:pointer;" url="{$data.thumb}">[商品图]</span>{else}<span class="red">[无商品图]</span>{/if}&nbsp;
							{if condition="$data.has_product"}
							<span title="{$data.productname}">{$data.productname|mb_substr=0,13,'utf-8'}</span>
							{else}
							<span>{$data.productname}</span>
							{/if}
						</div>
						{if condition="$data.thumb"}<div class="thumb-box"><img src="__ROOT____UPLOADS__/{$data.thumb}"></div>{/if}
					</li>
					<li style="width:25%;">{$data.level_cn}{if condition="$data.content"}<span title="{$data.content}">{$data.content|mb_substr=0,13,'utf-8'}</span><span class="green">[{$data.content_time}]</span>{else}<span class="red">暂无</span>{/if}</li>
					<li style="width:25%;">{if condition="$data.reply"}<span title="{$data.reply}">{$data.reply|mb_substr=0,13,'utf-8'}</span><span class="green">[{$data.reply_time}]</span>{else}<span class="red">暂无</span>{/if}</li>
					<li style="width:10%"><div class="mod-icon mod" url="{$data.rep_url}">回</div><div class="del-icon del" url="{$data.del_url}"  >删</div><div class="clear"></div></li>
					<div class="clear"></div>
					</a>
					
				</ul>
				
				{/volist}
			
		</div>
	</div><!-- end of list-box -->
	
	<div class="fun-box">
		<div class="button">
			<ul>
				<li class="dels"  id="dels">删除</li>
				<div class="clear"></div>
			</ul>
		</div>
		<div class="page grey_l link">{$page}</div>
		<div class="clear"></div>
	</div>
	
</div><!-- end of main -->
</form>
</body>
</html>
