<style>
.tab{
	font-size:14px;
	font-family:'microsoft yahei';
}
.input_box{
	padding:6px;
	border-radius:3px;
} 
</style>
<form enctype="multipart/form-data" name="form1"  action="{:url('admin/lottery/moditem')}" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="9" class="tab">
 {volist name="datas" id="data"}
  <tr>
	<td width="15%" align="right"  style="border-bottom:1px solid #ccc">项目名称：</td>
	<td width="33%" style="border-bottom:1px solid #ccc"><input name="name[{$data.id}]" type="text" class="input_box" value="{$data.name}" style="width:180px;"/>&nbsp;&nbsp;是否中奖：<input type="checkbox" name="win[{$data.id}]" value="1" {if condition="$data.win"}checked{/if} ></td>
	<td width="13%" align="right"  style="border-bottom:1px solid #ccc">概率：</td>
	<td width="27%" style="border-bottom:1px solid #ccc"><input name="percent[{$data.id}]" type="text" class="input_box" value="{$data.percent}" style="width:100px;"/>&nbsp;%</td>
	<input type="hidden" name="id[]" value="{$data.id}"/>
  </tr>
 {/volist}
  <tr>
	<td align="right"></td>
	<td colspan="4"><input type="hidden" name="pid" value="{$pid}"/><input type="submit" class="submit_button"  value="编辑"/></td>
  </tr>
  
</table>
</form>