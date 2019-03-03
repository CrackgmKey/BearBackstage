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
			<div class="tit">最热新闻</div>
			<div class="con">
				<ul class="dgrey_l" style="font-size:14px;color:#666">
					{Leesun:news name='nv'  num='8' sort='click desc'}
					<li style="list-style-type:decimal;list-style-position:inside;">
						<a href="{$nv.url}">{$nv.title|mb_substr=0,15,'utf-8'}</a>
					</li>
					{/Leesun:news}
				</ul>
			</div>
		</div>
	</div><!-- end of box -->
</div><!-- end of left -->
	
				