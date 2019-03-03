<div class="left">
	<div class="box">
		<div class="class-box">
			{Leesun:nav name='dv' id='$Request.param.id' num='1' display='1'}
			<span class="{if condition="$dv.is_sub"}icon-s{else}icon-n{/if}"></span><h1>{$dv.name}</h1>
			{/Leesun:nav}
			<div class="clear"></div>
		</div>
		
		<div class="sclass-box" id="sclass-box">
			<ul>
				{Leesun:nav name='sv' pid='$Request.param.id' display='1'}
				<li  {if condition="$sv.selected"}class="cur"{/if}><a href="{$sv.url}">{$sv.name}</a></li>
				{/Leesun:nav}
			</ul>
		</div>
		
	</div><!-- end of box -->
	<div class="box">
		<div class="rec-box">
			<div class="tit">商品推荐</div>
			<div class="con">
				<ul>
					{Leesun:product name='v'  num='6' keywords='' recommend='1' type='1' sort='add_time desc'}
					<li>
						<div class="img"><a href="{$v.url}">{if condition="$v.thumb"}<img src="__ROOT____UPLOADS__/{$v.thumb}" id="img_{$v.id}" onload='AutoResizeImage(185,141,this)'>{else}<img src="__ROOT____INDEX__/images/no-pic.jpg"  class="img"/>{/if}</a></div>
						<h1 class="dgrey_l"><a href="{$v.url}">{$v.name}</a></h1>
						<h2>&yen;{$v.current_price}</h2>
					</li>
					{/Leesun:product}
				</ul>
			</div>
		</div>
	</div><!-- end of box -->
</div><!-- end of left -->
	