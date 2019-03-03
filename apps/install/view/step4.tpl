<!DOCTYPE html>
<html>
<head>
{include file="public:head" /}
<!--[if !IE]> -->
<script src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<!-- <![endif]-->
<!-- 如果为IE,则引入jq1.12.1 -->
<!--[if IE]>
<script src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<![endif]-->
</head>
<body>
	<div class="wrap">
		{include file="public:header" /}
		<section class="section">
			<div class="step">
				<ul class="unstyled">
					<li class="on"><em>1</em>检测环境</li>
					<li class="on"><em>2</em>创建数据</li>
					<li class="current"><em>3</em>完成安装</li>
				</ul>
			</div>
			<div class="install" id="log">
				<ul id="loginner" class="unstyled"></ul>
			</div>
			<div class="bottom text-center">
				<a href="javascript:;"><i class="fa fa-refresh fa-spin"></i>&nbsp;正在安装...</a>
			</div>
		</section>
		<script type="text/javascript">
			function showmsg(content,status){
				var icon='<i class="fa fa-check correct"></i> ';
				if(status=="error"){
					icon ='<i class="fa fa-remove error"></i> ';
				}
				$('#loginner').append("<li>"+icon+content+"</li>");
				$("#log").scrollTop(1000000000);
			}
		</script>
	</div>
	{include file="public:footer" /}
</body>
</html>