<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>{$config.site_name}</title>
<meta name="keywords" content="{$config.key_word}" />
<meta name="description" content="{$config.description}" />
<meta name="author" content="乐尚商城" />
<meta name="copyright" content="leesuntech.com" />

<link rel="shortcut icon" href="__ROOT____UPLOADS__/{$config.favicon}" />
<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/common.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/layout.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/user.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script>

$(function(){
	$(".userlist-box ul li:odd").css({"background":"#f4f4f4"});
	
	$("#is_new ul li").click(function(){
		 var url=$(this).attr("url");
		
		 window.location.href=url;
	  })
	  
	  $(".detail").click(function(){
		
		var url=$(this).attr("url");
		layui.use(['layer', 'form'], function(){
			layer.open({
			  type: 2,
			  area: ['590px', '450px'],
			  title:'私信详情',
			  fixed: false, //不固定
			  maxmin: false,
			  content: url,
			  end: function () {
				location.reload();
			  }
			});
		});
		
	});
	
	 $(".letter").click(function(){
		
		var url=$(this).attr("url");
		user_name=$(this).attr("data-name");
		title="给"+user_name+"发私信";
		layui.use(['layer', 'form'], function(){
			layer.open({
			  type: 2,
			  area: ['590px', '510px'],
			  title:title,
			  fixed: false, //不固定
			  maxmin: false,
			  content: url
			 
			});
		});
		
	});
	  
	  $(".del").click(function(){
		var url=$(this).attr("url");
		 layui.use(['layer', 'form'], function(){
			layer.confirm('你确定要删除吗?', {icon: 3, title:'提示'}, function(index){
			 $.post(url,function(d){
				if(d=='1'){
					layer.msg('删除成功',{icon: 1},function(){location.reload();});
					layer.close(index);
				}
			 })
			});
		});
	});
});
</script>
</head>

<body>
{include file="public/header" /}
<div class="web_body">
	
	{include file="user/left" /}
	<div class="right">
		
		<div class="box">
			<div class="title-box">
				<div class="tit">我的私信</div>
				<div class="icon"></div>
			</div>
		</div>
		
		<div class="box">
			<div class="filter-box">
				<div class="tit">是否查看</div>
				<div class="list" id="is_new">
					<ul>
						<li {if condition="$Request.param.is_new=='' || $Request.param.is_new=='-1'"}class="cur"{/if} url="{:url('index/letter/index')}">全部</li>
						<li url="{:url('index/letter/index','is_new=0')}" {if condition="$Request.param.is_new=='0'"}class="cur"{/if}>已查看</li>
						<li url="{:url('index/letter/index','is_new=1')}" {if condition="$Request.param.is_new=='1'"}class="cur"{/if}>未查看</li>
						<div class="clear"></div>
					</ul>
				</div>
				<div class="clear"></div>
			</div>
			
		</div>
		
		<div class="box">
			<div class="userlist-box">
				<ul>
					{Leesun:letter name='v' uid='$uid' is_new='$Request.param.is_new' page='1'}
					<li>
						<span style="width:450px" class="dgrey_l">发信人：{$v.user_name_from}</span>
						<span style="width:260px">发送时间：<label title="{$v.create_time}" class="green">{$v.create_time}</label></span>
						<span style="width:100px">{if condition="$v.is_new"}<label class="red">未查看</label>{else}<label class="green">已查看</label>{/if}</span>
						<span style="width:30px"><div class="circle-but detail" url="{$v.det_url}" >详</div></span>
						<span style="width:30px"><div class="circle-but letter" data-name="{$v.user_name}" url="{$v.rep_url}">回</div></span>
						<span><div class="circle-but-b del" url="{$v.del_url}" >删</div></span>
						<div class="clear"></div>
					</li>
					<div class="clear"></div>
					{/Leesun:letter}
					
				</ul>
			</div>
		</div>
		
		<div class="box">
			<div class="page">{$page}</div>
		</div>
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>
{include file="public/footer" /}


</body>
</html>
