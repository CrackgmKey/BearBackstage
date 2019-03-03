<link href="__ROOT____INDEX__/css/layout.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script>
	$(document).ready(function(){
		 $(".sub_button").click(function(){
			var tel=$("#tel").val();
			var address=$("#address").val();
			var id=$("#id").val();
			$.post("{Leesun:url name='lotteryMod' /}",{tel:tel,address:address,id:id},function(d){
				if(d=='1'){
					alert("提交成功，请等待管理员联系您!");
				} else {
					
					alert("提交失败!");
				}
			})
		 })
	})
</script>
<div id="user_box">
	<div id="login_box">
	<div class="title" style="text-align:center;color:green">恭喜您中奖,请您核对地址！</div>
    <div class="content">
    	
   	  	<table width="100%" border="0" cellspacing="0" cellpadding="12">
          <tr>
            <td width="23%" align="right">电话：</td>
            <td width="77%"><input type="text" class="input_box" name="tel" id="tel" value="{$lotterywinData.tel}" /></td>
          </tr>
          <tr>
            <td align="right" >地址：</td>
            <td><input type="text" class="input_box" name="address" id="address" value="{$lotterywinData.address}" /></td>
          </tr>
          <tr>
            <td align="right" ></td>
            <td><input type="hidden" name="id" id="id" value="{$lotterywinData.id}"><input type="button" class="sub_button"  value="修改"/></td>
          </tr>
          
        </table>
		
    </div>
    </div>
    
    
</div>
