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
			<div style="padding: 40px 20px;">
				<div class="text-center">
					<a style="font-size: 18px;">恭喜您，安装完成！</a>
					<br>
					<br>
					<div class="alert alert-danger" style="width: 350px;display: inline-block;">
						为了您站点的安全，安装完成后即可将网站app目录下的“install”文件夹删除!
						另请对/网站目录/app/conf/database.php文件做好备份，以防丢失！
					</div>
					<br>
					<a class="btn btn-success" href="{:url('index/Index/index')}">进入前台</a>
					<a class="btn btn-success" href="{:url('admin/index/index')}">进入后台</a>
				</div>
			</div>
		</section>
	</div>
	{include file="public:footer" /}
</body>
</html>