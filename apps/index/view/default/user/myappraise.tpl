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
<link href="__ROOT____INDEX__/css/lottery.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jQueryRotate.2.2.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
<script>
$(function(){
	$(".userlist-box ul li:odd").css({"background":"#f4f4f4"});
	$(".mod").click(function(){
		var id=$(this).attr("id");
		var is_reply=$(this).attr("is_reply");
		if(is_reply=="1"){
			var h=400;
		} else {
			var h=300;
		}
		 var url=$(this).attr("url");
		  layui.use(['layer', 'form'], function(){
			layer.open({
			  type: 2,
			  area: ['590px', '480px'],
			  title:'修改评价',
			  fixed: false, //不固定
			  maxmin: false,
			  content: url,
			  end: function () {
				location.reload();
			  }
			});
		});
			
	});
	  
	$("#reply ul li").click(function(){
		 var url=$(this).attr("url");
		
		 window.location.href=url;
	  })
	  
	  
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
				<div class="tit">我的评价</div>
				<div class="icon"></div>
			</div>
		</div>
		
		<div class="box">
			<div class="filter-box">
				<div class="tit">回复状态</div>
				<div class="list" id="reply">
					<ul>
						<li {if ($Request.param.is_reply=="" || $Request.param.is_reply=="-1")}class="cur"{/if} url="{:url('index/appraise/index')}">全部</li>
						<li url="{:url('index/appraise/index',array('is_reply'=>'0'))}" {if ($Request.param.is_reply=="0")}class="cur"{/if}>未回复</li>
						<li url="{:url('index/appraise/index',array('is_reply'=>'1'))}" {if ($Request.param.is_reply=="1")}class="cur"{/if}>已回复</li>
						<div class="clear"></div>
					</ul>
				</div>
				<div class="clear"></div>
			</div>
			
		</div>
		
		<div class="box">
			<div class="userlist-box">
				<ul>
					
					{Leesun:appraise name='v' uid='$uid' is_reply='$Request.param.is_reply' page='1'}
					<li>
						<span style="width:230px" class="dgrey_l">评价商品：<label title="{$v.product.name}"><a href="{$v.url}" target="_blank">{$v.product.name|mb_substr=0,15,'utf-8'}</a></label></span>
						<span style="width:110px">等级：{$v.level_cn}</span>
						<span style="width:190px">评价时间：{$v.content_time}</span>
						<span style="width:160px">回复状态：{if($v.is_reply)}<i style="color:green">已回复</i>{else}<i style="color:red">未回复</i>{/if}</span>
						<span style="width:190px">回复时间：{if ($v.is_reply)}{$v.reply_time}{else}<label style='color:red'>暂无</label>{/if}</span>
						<span><div class="circle-but mod" url="{$v.mod_url}" >详</div></span>
						<div class="clear"></div>
					</li>
					<div class="clear"></div>
					{/Leesun:appraise}
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
