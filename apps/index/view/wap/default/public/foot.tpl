<script>
$(document).ready(function(){
	
	$(".config").on('click',function(){
		layer.open({
			content: '移动端后台管理制作中'
			,skin: 'msg'
			,time: 2 //2秒后自动关闭
		  });
	})
	$("#home").on("click",function(){
		window.location.href="{Leesun:url name='home' /}";
	})
	var i=0;
	var action="{Leesun:url name='searchPro' keywords='key__'/}";
	$("#search-type").click(
		function(){
			var t=$(this).html();
			var key=$("#search_box").val();
			
			var arr=['商品','新闻','积分商品'];
			i++;
			if(i>2) i=0;
			$(this).html(arr[i]);
			switch(i){
				case 0:
					action="{Leesun:url name='searchPro' keywords='key__'/}";
				break;
				case 1:
					action="{Leesun:url name='searchNew' keywords='key__'/}";
				break;
				case 2:
					action="{Leesun:url name='searchScore' keywords='key__'/}";
				break;
			}
			
			
	})
	$("#search_form").submit(function(){
		var key=$("#search_box").val();
		action = action.replace('key__',key);
		window.location.href=action;
		return false;
	})
})
</script>
<footer>
	<div class="side-box">
		<div class="home" id="home">
			<img src="__WAP__/images/home-icon.png">
		</div>
	</div>
	<div class="mid-box" id="search-bar">
		<div class="search">
			点击输入关键字
		</div>
	</div>
	<div class="side-box">
		<div class="config">
			<img src="__WAP__/images/config-icon.png">
		</div>
	</div>
</footer>
<div class="mask" id="mask"></div>
<div class="back-to-top" id="returnTop" draggable="true"></div>


<div class="search-box" id="search-page">
	<form method='post' id="search_form">
	<div class="tit-bar">
		<div class="bar">
			<div class="type" id="search-type">商品</div>
			<div class="input"><input type="text" name="keywords" id="search_box" placeholder="请输入搜索关键字" data-role='none'></div>
		</div>
		<div class="close" id="search-close">×</div>
	</div>
	</form>
	
	<div class="hotwords">
		<ul>
			
			{Leesun:hotword name='v' num='7'}
				<li url="{$v.url}" class="url">{$v.keyword}</li>
			{/Leesun:hotword}
		</ul>
	</div>
</div>