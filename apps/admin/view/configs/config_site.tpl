<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
	<link href="__ROOT____ADMIN__/css/main.css" rel="stylesheet" type="text/css" />
	<link href="__ROOT____PUBLIC__/ueditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
	<script type="text/javascript" src="__ROOT____ADMIN__/js/jquery.jclock.js"></script>
	<script type="text/javascript" charset="utf-8" src="__ROOT____PUBLIC__/ueditor/umeditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="__ROOT____PUBLIC__/ueditor/umeditor.min.js"></script>
	<script type="text/javascript" src="__ROOT____PUBLIC__/ueditor/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript" src="__ROOT____ADMIN__/js/common.js"></script>
	<title>main</title>
	<script type="text/javascript">
        $(document).ready(function(){

            $("#back").click(function(){
                window.location.href="{:url('admin/index/index')}";
            })

            $("#mod").click(function(){
                $("#form1").attr("action","{:url('admin/configs/mod')}");
                $("#form1").submit();
            })

            $(".radio-box1 .radio").click(function(){
                var id=$(this).attr("id");
                if($(this).hasClass("radio-n")){

                    //去除同级选中状态
                    $(this).siblings(".radio").removeClass("radio-s");
                    $(this).siblings(".radio").addClass("radio-n");
                    //添加本状态
                    $(this).removeClass("radio-n");
                    $(this).addClass("radio-s");

                    $(this).siblings("input").val(id);
                }
            })
            $(".radio-box2 .radio").click(function(){
                var id=$(this).attr("id");
                if($(this).hasClass("radio-n")){

                    //去除同级选中状态
                    $(this).siblings(".radio").removeClass("radio-s");
                    $(this).siblings(".radio").addClass("radio-n");
                    //添加本状态
                    $(this).removeClass("radio-n");
                    $(this).addClass("radio-s");

                    $(this).siblings("input").val(id);
                }
            })
        })
	</script>
</head>

<body>
{include file="index/top" }
<form enctype="multipart/form-data" action="" method="post" id="form1">
	<div class="main" id="main">
		<div class="position link grey_l"><a href="" target="_top">首页</a>&nbsp;>&nbsp;系统管理&nbsp;>&nbsp;App设置</div>
		<div class="tab-box">
			<ul>
				<li class="cur">App设置</li>
			</ul>
		</div>
		<div class="add-box">
			<ul>
				<li><div class="title">当前模板</div><div class="input-box"><input name="template" type="text" class="input" value="{$datas.template}" /></div><div class="clear"></div></li>
				<li><div class="title">客服QQ</div><div class="input-box"><input name="qq_num" type="text" class="input" value="{$datas.qq_num}"  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></div><div class="clear"></div></li>
				<li><div class="title">最新版本</div><div class="input-box"><input name="home_page_num" type="text" class="input" value="{$datas.home_page_num}"/></div><div class="clear"></div></li>
				<li>
					<div class="title">是否强制更新</div>
					<div class="radio-box2">
						<div class="{if condition="$datas.is_lottery==1"}radio-s{else}radio-n{/if}  radio" id="1"></div><div class="radio-t">是</div>
						<div class="{if condition="$datas.is_lottery==0"}radio-s{else}radio-n{/if}  radio" id="0" style="margin-left:30px;"></div><div class="radio-t">否</div>
						<input type="hidden" name="is_lottery" value="{$datas.is_lottery}">
					</div>
					<div class="clear"></div>
				</li>
				<li class="textarea"><div class="title">更新公告</div><div class="textarea-box" ><textarea name="filter_keyword" id="filter_keyword" cols="80" rows="5" style="width:800px;height:270px;">{$datas.filter_keyword}</textarea></div><div class="clear"></div></li>
			</ul>
		</div>
		<script type="text/javascript">
            var um = UM.getEditor('agreement');
		</script>
		<div class="fun-box" style="margin-left:30px;">
			<div class="button">
				<ul>
					<li class="add" id="mod">提交</li>
					<div class="clear"></div>
				</ul>
			</div>

			<div class="clear"></div>
		</div>

	</div><!-- end of main -->

</form>
</body>
</html>
