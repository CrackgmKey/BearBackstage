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
			<div class="tit">积分商品推荐</div>
			<div class="con">
				<ul>
					{Leesun:product name='v'  num='6' keywords='' recommend='1' type='4' sort='add_time desc'}
					<li>
						<div class="img"><a href="{$v.url}">{if condition="$v.thumb"}<img src="__ROOT____UPLOADS__/{$v.thumb}" id="img_{$v.id}" width='185' height='141' onload="DrawImg(this.id, 185,141)">{else}<img src="__ROOT____INDEX__/images/no-pic.jpg"  class="img"/>{/if}</a></div>
						<h1 class="dgrey_l"><a href="{$v.url}">{$v.name}</a></h1>
						<h2>{$v.symbol}:{$v.current_price}</h2>
					</li>
					{/Leesun:product}
				</ul>
			</div>
		</div>
	</div><!-- end of box -->
</div><!-- end of left -->
	