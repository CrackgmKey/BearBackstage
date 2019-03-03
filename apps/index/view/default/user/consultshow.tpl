<link href="__ROOT____INDEX__/css/common.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/layout.css" rel="stylesheet" type="text/css" />
<div id="user_box">
    <div id="reg_box">
        <div class="content">
            
            <table width="100%" border="0" cellspacing="0" cellpadding="12">
          <tr>
            <td width="23%" align="right">咨询：</td>
            <td width="77%"style="font-size:14px;"><div style="overflow-y:scroll;width:350px;height:130px;border:1px solid #ccc;">{$data.question}</div></td>
          </tr>
		  {if ($data.is_reply)}
          <tr>
            <td width="23%" align="right">回复：</td>
            <td width="77%" style="font-size:14px;"><div style="overflow-y:scroll;width:350px;height:130px;border:1px solid #ccc;">{$data.answer}</div></td>
          </tr>
		  {/if}
        </table>
        </div>
    </div>
</div>
