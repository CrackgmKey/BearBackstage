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
	
	$(".lot-btn").click(function() {
		var rotation=Math.floor(Math.random()*360);
		var lottery_score=parseInt("{$config.lottery_score}");
		var score=parseInt($("#cur_score").html());
	    $.get("{Leesun:url name='getLottery' /}",{rotation:rotation,lottery_score:lottery_score},function(data){
			var angle=360*3;
		//	alert($("#imgs").getRotateAngle());
		/*	if($("#imgs").getRotateAngle()<0){
				
				var offset=parseInt($("#imgs").getRotateAngle())+angle;
				
				//offset=360+offset;
			} else {
				var offset=0;
			}
			*/
			if(data=="not enough"){
				layui.use(['layer', 'form'], function(){
					layer.msg('对不起，您的积分不足!',{icon: 2});
				});
				return false;
			}
			if(data=="total not enough"){
				layui.use(['layer', 'form'], function(){
					layer.msg('奖品已抽完!',{icon: 2});
				});
				return false;
			}
			var dis=Math.floor(Math.random()*51);
			var x=(data-1)*51;
			x-=dis;
			angle+=x;
			//angle-=offset;
			
			$(".lot-btn").hide();
			for (var i = 0; i <= angle; i++) {
				$("#imgs").rotate({
					angle:0, 
					animateTo: -i,
					duration: 10000,
					callback:function(){
						$(".lot-btn").show();
						var result=score-lottery_score;
						$("#cur_score").html(result);
						//open_url=APP_PATH+'/lottery/get_result/sort/'+data;
						open_url="{Leesun:url name='getResult' sort='data' /}";
						open_url=open_url.replace('data',data);
						
						layui.use(['layer', 'form'], function(){
							layer.open({
							  type: 2,
							  area: ['590px', '350px'],
							  title:'',
							  fixed: false, //不固定
							  maxmin: false,
							  content: open_url
							});
						});
						
					}
				});
			}
		});
	
	
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
				<div class="tit">积分抽奖</div>
				<div class="icon"></div>
			</div>
		</div>
		
		<div class="box">
			<div class="info-bar">
				<span>您目前积分：<label id="cur_score">{$userInfo.score}</label></span><span>每次抽奖使用积分：{$config.lottery_score}</span>
			</div>
		</div>
		
		<div class="box">
			<div class="lottery-item">
				<ul>
					{volist name="items" id="data"}
					<li>{if ($data.win)}<span class="red">{$data.name}&nbsp;[奖]</span>{else}{$data.name}{/if}</li>
					{/volist}
				</ul>
			</div>
			<div class="lottery-box">
				<div id="lottery" >
					<img id="imgs" src="__ROOT____INDEX__/images/disc-rotate.gif" viewbox="0 0 352 30" style="position: absolute; left: 47px; top: 47px; width: 352px; height: 352px;" id="imgs" class="image" />
					<div class="arrow">
					</div>
					<div class="lot-btn first">
						<span></span></div>
				</div>
			</div>
			<div class="clear"></div>
		</div>
		
		
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>
{include file="public/footer" /}


</body>
</html>
