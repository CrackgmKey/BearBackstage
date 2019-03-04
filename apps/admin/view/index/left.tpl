<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>后台导航</title>

<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____ADMIN__/css/left.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript">
$(document).ready(
	function(){
		
		var last_num=0;
		$("#nav ul li").click(function(){
		
			$("#nav ul li").css({"background":""});
			$("#nav ul li").find("a").css({"color":"#576165"});
			var num=$(this).attr("id");
			if(num!=last_num){
				$("#"+last_num).children(".icon").removeClass("icon-"+last_num+"-h");
				$("#"+last_num).children(".icon").addClass("icon-"+last_num);
				$(".sub-nav").hide();
				$(".s"+num).show();
			} else {
				//$(".s"+num).hide();
			}
			
			$(this).children(".icon").removeClass("icon-"+num);
			var classname="icon-"+num;
			$(this).children(".icon").addClass(classname);
			
			
			$("#nav ul li").removeClass("cur");
			$(this).addClass("cur");
			$(this).css("background","#444c4f");
			$(this).find("a").css({"color":"#1d2225"});
			last_num=num;
		})
		
	
		$("#nav ul li").hover(function(){
			var cur=$(this).attr("class");
			if(!cur){
				$(this).css({"background":"#444c4f"});
				$(this).find("a").css({"color":"#1d2225"});
				var num=$(this).attr("id");
				
				
				$(this).children(".icon").removeClass("icon-"+num);
				var classname="icon-"+num+"-h";
				$(this).children(".icon").addClass(classname);
			}
		},function(){
			var cur=$(this).attr("class");
			if(!cur){
				$(this).css({"background":""});
				$(this).find("a").css({"color":"#576165"});
				var num=$(this).attr("id");
				$(this).children(".icon").removeClass("icon-"+num+"-h");
				var classname="icon-"+num;
				$(this).children(".icon").addClass(classname);
			}
		})
		
		$(".sub-nav span").click(function(){
			$(".sub-nav span").removeClass("cur");
			$(this).addClass("cur");
		})
		
		var i=0;
		$(".slide").click(function(){
			if(!i){
				$(this).parents(".user-info").animate({height:"10px"},"slow");
				$(this).removeClass("up");
				$(this).addClass("down");
				i=1;
			} else {
				$(this).parents(".user-info").animate({height:"180px"},"slow");
				$(this).addClass("up");
				$(this).removeClass("down");
				i=0;
			}
		})
		var bw=$(".avatar").width()+$(".u1").width()+$(".u2").width()+20;
		$(".box").width(bw);
		
	}
)
</script>
</head>
<body>

<div class="title">小熊优品后台管理</div>
<div class="brief">
	<div class="box" style="margin:0 auto;">
		<div class="avatar">
			<div class="mask"><img src="__ROOT____ADMIN__/images/avatar-bg.png"></div>
			<div class="avatar-img">
			{if condition="$adm_avatar"}
				<img src="__ROOT____UPLOADS__/{$adm_avatar}">
			{else/}
				<img src="__ROOT____ADMIN__/images/user-default.jpg">
			{/if}
			</div>
		</div>
		<div class="uname u1">{$adm_name}</div>
		<div class="uname u2">{$group_cn}</div>
		<div class="clear"></div>
	</div>
</div>


<div class="nav" id="nav">
	<ul>
		<li id="1">
			<div class="icon icon-1"></div><div class="t"><a href="javascript:;">内容管理</a></div><div class="clear"></div>
		</li>
	</ul>
	
		<div class="sub-nav s1">
			<span><a href="{:url('admin/nav/index')}" target="main">分类导航</a></span>
			<span><a href="{:url('admin/news/index')}" target="main">新闻管理</a></span>
			<span  class="last"><a href="{:url('admin/acate/index')}" target="main">广告管理</a></span>
		</div>

	<ul>
		<li  id="4"><div class="icon icon-4"></div><div class="t"><a href="javascript:;">用户管理</a></div><div class="clear"></div></li>
	</ul>
	<div class="sub-nav s4">
			<span><a href="{:url('admin/user/index')}" target="main">会员用户</a></span>
			<span><a href="{:url('admin/hotword/index')}" target="main">搜索热词</a></span>
			<span class="last"><a href="{:url('admin/lottery/index')}" target="main">积分抽奖</a></span>
		</div>
	
	<ul>
		<li  id="3"><div class="icon icon-3"></div><div class="t"><a href="javascript:;">日志管理</a></div><div class="clear"></div></li>
	</ul>
	<div class="sub-nav s3">
			<span><a href="{:url('admin/logs/index',array('type'=>1))}" target="main">会员登陆</a></span>
			<span><a href="{:url('admin/logs/index',array('type'=>2))}" target="main">管理员登陆</a></span>
			<span  class="last"><a href="{:url('admin/logs/index',array('type'=>3))}" target="main">管理员操作</a></span>
			
		</div>
	<ul>
		<li  id="6"><div class="icon icon-6"></div><div class="t"><a href="javascript:;">系统管理</a></div><div class="clear"></div></li>
	</ul>
		<div class="sub-nav s6">
			<span><a href="{:url('admin/admingroup/index')}" target="main">管理员设置</a></span>
			<span class="last"><a href="{:url('admin/configs/index',array('id'=>1))}" target="main">网站设置</a></span>

		</div>
</div>

</body>
</html>