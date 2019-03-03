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
<script type="text/javascript" src="__ROOT____ADMIN__/js/common.js"></script>
<title>main</title>
<script type="text/javascript">
$(document).ready(function(){
	$("#consult_reply").click(function(){
		var answer=$("#answer").val();
		var id=$(this).attr("data");
		var url="{:url('admin/consult/reply','id=consult_id')}";
		url = url.replace('consult_id',id);
		if(answer!=""){
			$("#form1").attr("action",url);
			$("#form1").submit();
		} else {
			
			layui.use(['layer'], function(){
				layer.msg('请填写回复内容', {time: 3000, icon:2});
			});
		}
	})
	
	$("#appraise_reply").click(function(){
		var answer=$("#reply").val();
		var id=$(this).attr("data");
		var url="{:url('admin/appraise/reply','id=appraise_id')}";
		url = url.replace('appraise_id',id);
		if(answer!=""){
			$("#form2").attr("action",url);
			$("#form2").submit();
		} else {
			layui.use(['layer'], function(){
				layer.msg('请填写回复内容', {time: 3000, icon:2});
			});
		}
	})
})
</script>
</head>

<body>
{include file="index/top" /}

<div class="main" id="main">
	<div class="position link grey_l"><a href="__ROOT__"  target="_top">首页</a>&nbsp;>&nbsp;小熊优品</div>
	<div class="result-box">
	
		<div class="box">
			<div class="icon-1"></div>
			<div class="title">
				<h1>会员统计</h1>
				<h2>Member Result</h2>
			</div>
			<div class="con">
				<ul>
					<li><div class="name left">注册会员总数：</div><div class="num right">{$member.total}人</div><div class="clear"></div></li>
					<li><div class="name left">今天注册会员数：</div><div class="num right">{$member.today_total}人</div><div class="clear"></div></li>
					<li><div class="name left">昨天注册会员数：</div><div class="num right">{$member.yestoday_total}人</div><div class="clear"></div></li>
					<li><div class="name left">当月注册会员数： </div><div class="num right">{$member.month_total}人</div><div class="clear"></div></li>
					<li><div class="name left">可登录用户数：</div><div class="num right">{$member.log_total}人</div><div class="clear"></div></li>
					<li><div class="name left">禁止登录用户数：</div><div class="num right">{$member.audit_total}人</div><div class="clear"></div></li>
				</ul>
			</div>
		</div><!-- end of box -->
		

		

		
		<div class="box">
			<div class="icon-5"></div>
			<div class="title">
				<h1>系统信息</h1>
				<h2>System Result</h2>
			</div>
			<div class="con">
				<ul>
					<li><div class="name left">操作系统：</div><div class="num right">{$info.os}</div><div class="clear"></div></li>
					<li><div class="name left">运行环境：</div><div class="num right">{$info.env}</div><div class="clear"></div></li>
					<li><div class="name left">TP版本：</div><div class="num right">{$info.ver}</div><div class="clear"></div></li>
					<li><div class="name left">上传大小：</div><div class="num right">{$info.upload}</div><div class="clear"></div></li>
					<li><div class="name left">当前域名： </div><div class="num right">{$info.dns}</div><div class="clear"></div></li>
					<li><div class="name left">目录位置： </div><div class="num right">{$info.pos}</div><div class="clear"></div></li>
				</ul>
			</div>
		</div><!-- end of box -->
		
		<div class="clear"></div>
	</div><!-- end of result-box -->
	
	

		</form>
		<div class="clear"></div>
	</div><!-- end of reply-box -->
	
</div><!-- end of main -->



</body>
</html>
