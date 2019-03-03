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
var n=0;
function delTr(e){
	var tr=$(e).parent("td").parent("tr").attr("id");
	$("#"+tr).remove();
}
$(document).ready(function(){

	$("#back").click(function(){
		window.location.href="{:url('admin/product/index')}";
	})
	$(".input-box-s").click(function(){
		
		$(this).children(".select-box").slideToggle("fast");
	})
	
	
	$(".product-list ul li.can_select").click(function(){
		var id=$(this).attr("id");
		var text=$(this).text();
		$(this).parent("ul").parents(".input-box-s").children(".select-title").html(text);
		$(this).parent("ul").children("input").val(id);
		if(id){
			$("#specs-box").slideDown("fast");
			$.get("{:url('admin/product/getSpecs')}",{id:id},function(data){
				$("#specs-select-box").html(data);
			})
			$("#spec-options").slideUp("fast");
			$("#op_td .add_opt").remove();
		} else {
			$("#specs-box").slideUp("fast");
		}
	})
	$(".brand-list ul li.can_select").click(function(){
		var id=$(this).attr("id");
		var text=$(this).text();
		$(this).parent("ul").parents(".input-box-s").children(".select-title").html(text);
		$(this).parent("ul").children("input").val(id);
		
	})
	$("#add").click(function(){
		$(".add-box,.fun-box").hide();
		$(".loading").show();
		$("#form1").attr("action","{:url('admin/product/add')}");
		$("#form1").submit();
	})
	
	$("#thumb").change(function(){
		$("#img-path").html($(this).val());
	})
	
	
	$("#add_spec").click(function(){
			n++;
			var num=$("#op_td td").length;
			$("#op_tr").append("<tr id=\"ot"+n+"\" ");
			for(var i=0;i<num;i++){
				var id=$("#op_td td:eq("+i+")").attr("id");
				var content=$("#con #add_"+id).html();
				$("#ot"+n).append("<td align=center height='40'  id="+id+">"+content+"</td>");
			}
			$("#op_tr").append("</tr>");
	})
		
	$("#specs-select-box").on("click",".spec_main",function(){
		var num=$("#specs-select-box input:checkbox:checked").length;
		if(num){
			var id=$(this).val();
			$("#add_spec").slideDown(100);
			$("#spec-options").slideDown(100);
		} else {
			var id=$(this).val();
			$("#add_spec").slideUp(100);
			$("#spec-options").slideUp(100);
		}
		
		if($(this).prop("checked")){
			h=$("#op_tr tr").length;//行数
			l=$("#op_td td").length;//列数
			$("#op_tr tr:gt(0)").remove();
			$("#op_td").prepend("<td width=\"70\" align=\"center\" class=\"add_opt\" height='30'  bgcolor=\"#F3F3F3\" id=ob"+id+">"+$(this).attr("data")+"</td>");
		} else {
			$("#op_tr tr:gt(0)").remove();
			$("#ob"+id).remove();
		}
	})
	
	
})
</script>
</head>

<body>
{include file="index/top" /}
<form enctype="multipart/form-data" action="" method="post" id="form1">
<div class="main" id="main">
	<div class="position link grey_l"><a href="{:url('admin/index/index')}" target="_top">首页</a>&nbsp;>&nbsp;商品管理&nbsp;>&nbsp;添加商品</div>
	<div class="loading">乐尚商城提示您，请稍候！</div>
	<div class="add-box">
		<ul>
			<li><div class="title">商品名称</div><div class="input-box"><input name="name" type="text" class="input"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li><div class="title">商品货号</div><div class="input-box"><input name="serial_no" type="text" class="input"/></div><div class="tips">为空自动生成</div><div class="clear"></div></li>
			<li>
				<div class="title">商品分类</div>
				<div class="input-box-s" style="z-index:900"><span class="select-title">选择分类</span>
					<div class="select-box product-list"  style="height:300px;overflow-y:scroll">
						<ul>
							<input type="hidden" name="cate_id" value="">
							{volist name="navDatas" id="v"}
								<li id="{$v.id}" style="text-indent:1em;text-align:left;" {if condition="$v.has_sub==1"}class="read_only"{else}class="can_select"{/if}><strong>{$v.name}</strong></li>
								{if condition="$v.has_sub==1"}
								{volist name="v.sub" id="sv"}
									<li id="{$sv.id}" style="text-indent:2em;text-align:left;" class="can_select">{$sv.name}</li>
								{/volist}
								{/if}
							{/volist}
						</ul>
					</div>
				</div>
				<div class="tip">*</div>
				<div class="clear"></div>
			</li>
			
			<li id="specs-box" style="display:none">
				<div class="title">规格选择</div>
				<div class="specs left" id="specs-select-box">
					
				</div>
				<div class="setOpt left" id="add_spec">添加规格项目</div>
				<div class="clear"></div>
			</li>
			
			<li id="spec-options" style="display:none">
				<div class="title">规格项目</div>
				<div class="opt-table left">
					<table width="100%" border="0" cellpadding="5" cellspacing="1" id="op_tr">
					<tr id="op_td">
						<td width="70" align="center" bgcolor="#F3F3F3" id="origin_price">原价</td>
						<td width="70" align="center" bgcolor="#F3F3F3" id="current_price">现价</td>
						<td width="70" align="center" bgcolor="#F3F3F3" id="inventory">库存</td>
						<td width="70" align="center" bgcolor="#F3F3F3" id="img">图片</td>
						<td width="70" align="center" bgcolor="#F3F3F3" id="oper">操作</td>
					</tr>
					</table>
				</div>
				<div class="clear"></div>
			</li>
			<li>
				<div class="title">品牌类型</div>
				<div class="input-box-s" style="z-index:899"><span class="select-title">选择品牌</span>
					<div class="select-box brand-list" >
						<ul>
							
							<input type="hidden" name="brand_id" value="0">
							<li id="0" style="text-indent:1em;text-align:left;" class="can_select">非品牌商品</li>
							{volist name="brand_datas" id="v"}
								<li id="{$v.id}" style="text-indent:1em;text-align:left;" class="can_select">{$v.name}</li>
							{/volist}
						</ul>
					</div>
				</div>
				<div class="tip">*</div>
				<div class="clear"></div>
			</li>
			<li><div class="title">商品原价</div><div class="input-box"><input name="origin_price" type="text" class="input"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li><div class="title">商品现价</div><div class="input-box"><input name="current_price" type="text" class="input"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li><div class="title">商品库存</div><div class="input-box"><input name="inventory" type="text" class="input"/></div><div class="tip">*</div><div class="clear"></div></li>
			<li><div class="title">商品运费</div><div class="input-box"><input name="delivery_fee" type="text" class="input"/></div><div class="tips">0元为卖家包邮</div><div class="clear"></div></li>
			<li>
				<div class="title">商品主图</div>
				<div class="upload-box">
					<input name="img" type="file" id="thumb"/>
					
				</div>
				<div class="img-path" id="img-path"></div>
				<div class="clear"></div>
			</li>
			<li class="textarea"><div class="title">商品详情</div><div class="textarea-box" ><textarea name="brief" id="brief" cols="80" rows="5" style="width:800px;height:370px;"></textarea></div><div class="tip">*</div><div class="clear"></div></li>
			<li class="textarea"><div class="title">规格详情</div><div class="textarea-box" ><textarea name="specifications" id="specifications" cols="80" rows="5" style="width:800px;height:370px;"></textarea></div><div class="tip">*</div><div class="clear"></div></li>
			<li><div class="title">商品排序</div><div class="input-box"><input name="sort" type="text" class="input" value="{$maxsort}"/></div><div class="tip">*</div><div class="clear"></div></li>
			
		</ul>
	</div>
	<script type="text/javascript">  
		 var um = UM.getEditor('brief');
		  var um = UM.getEditor('specifications');
         </script>
	<div class="fun-box" style="margin-left:30px;">
		<div class="button">
			<ul>
				<li class="add" id="add">添加</li>
				<li class="dels"  id="back">返回</li>
				<div class="clear"></div>
			</ul>
		</div>
		
		<div class="clear"></div>
	</div>
	
	

</div><!-- end of main -->

</form>
<div style="display:none;" id="con">
	{volist name="spec_main" id="main"}
    	<div id="add_ob{$main.id}">
        	<select name="spec_sub[{$main.id}][]" class="p_select">
            	
				{volist name="spec_sub" id="sub"}
                {if condition="$main.id==$sub.pid"}
					<option value="{$sub.id}">{$sub.name}</option>
                {/if}
                
				{/volist}
            </select>
        </div>
	{/volist}
    <div id="add_origin_price">
    	<input type="text" name="origin_prices[]" class="p_input"/>
    </div>
	<div id="add_current_price">
    	<input type="text" name="current_prices[]" class="p_input"/>
    </div>
    <div id="add_inventory">
    	<input type="text" name="inventories[]" class="p_input"/>
    </div>
	<div id="add_img">
		<input type="file" name="imgs[]" class="product-img"/>
    </div>
	<div id="add_oper">
    	<a class="del_tr" style="cursor:pointer" onclick="delTr(this)">删除</a>
    </div>
</div>
</body>
</html>
