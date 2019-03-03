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

	
	
	$("#update").click(function(){
		$("#form1").attr("action","{:url('admin/news/batchSort')}");
		$("#form1").submit();
	})
	
	$("#dels").click(function(){
		
		layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 $("#form1").attr("action","{:url('admin/news/del')}");
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
		window.location.href="{:url('admin/news/add')}";
	})
	
	$(".mod").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
	})
	$("#recommend").click(function(){
		
		$("#form1").attr("action","{:url('admin/news/batchRecommend','value=1')}");
		$("#form1").submit();
	});
	$("#cancel").click(function(){
		
		$("#form1").attr("action","{:url('admin/news/batchRecommend','value=2')}");
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
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<input type="hidden" name="dels" value="1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;内容管理&nbsp;>&nbsp;新闻管理</div>
	<div class="search-box">
		<div class="input-box-s left" style="z-index:900"><span class="select-title">{$currentName}</span>
			<div class="select-box">
					<ul>
						<li url="{:url('admin/news/index')}">所有类别</li>
						{volist name="navDatas" id="v"}
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
				{volist name="datas" id="data"}
				<ul>
					<a>
					<li style="width:5%">&nbsp;&nbsp;<input type="checkbox" class="check-style" name="id[]"  value="{$data.id}"></li>
					<li style="width:7%">{$data.id}</li>
					<li style="width:35%;position:relative;z-index:899">
						<div class="left" title="{$data.title}">
							<span class="green">[点击:{$data.click}]</span>&nbsp;{if condition="$data.is_recommend=='1'"}<span class="green">[已推]</span>{elseif condition="$data.is_recommend=='2'"}<span class="red">[未推]</span>{/if}&nbsp;{if condition="$data.thumb"}<span  class="green thumb"  style="cursor:pointer;" url="{$data.thumb}">[图]</span>{/if}&nbsp;{$data.title}
						</div>
						{if condition="$data.thumb"}<div class="thumb-box"><img src="{$data.thumb}"></div>{/if}
					</li>
					<li style="width:13%"><div class="left" >{$data.classname}</div></li>
					<li style="width:20%"><div class="left" ><span class="sienna">{$data.addtime}</span>&nbsp;/&nbsp;<span class="green">{$data.uptime}</span></div></li>
					<li style="width:10%;"><input type="text" name="sort[{$data.id}]" value="{$data.sort}" class="input" maxlength="3"></li>
					<li style="width:10%"><div class="mod-icon mod" url="{$data.mod_url}">编</div><div class="del-icon del" url="{$data.del_url}" >删</div><div class="clear"></div></li>
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
				<li class="update"  id="update">更新排序</li>
				<li class="import"  id="recommend">设置推荐</li>
				<li class="export"  id="cancel">取消推荐</li>
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
