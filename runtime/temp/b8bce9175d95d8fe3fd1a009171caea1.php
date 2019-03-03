<?php if (!defined('THINK_PATH')) exit(); /*a:3:{s:58:"D:\phpStudy\WWW\yg/apps/index/view/default/index\index.tpl";i:1530266635;s:60:"D:\phpStudy\WWW\yg\apps\index\view\default\public\header.tpl";i:1530266667;s:60:"D:\phpStudy\WWW\yg\apps\index\view\default\public\footer.tpl";i:1515506268;}*/ ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=7">
<title><?php echo $config['site_name']; ?></title>
<meta name="keywords" content="<?php echo $config['key_word']; ?>" />
<meta name="description" content="<?php echo $config['description']; ?>" />
<meta name="author" content="乐尚商城" />
<meta name="copyright" content="leesuntech.com" />
<link rel="shortcut icon" href="/yg/public/uploads/<?php echo $config['favicon']; ?>" />
<link href="/yg/public/static/common/css/global.css" rel="stylesheet" type="text/css" />
<link href="/yg/public/static/index/default/css/common.css" rel="stylesheet" type="text/css" />
<link href="/yg/public/static/index/default/css/index.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/yg/public/static/common/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/yg/public/static/common/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="/yg/public/static/index/default/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="/yg/public/static/common/layui/layui.js"></script>
<script type="text/javascript" src="/yg/public/static/index/default/js/unslider.min.js"></script>
<script type="text/javascript" src="/yg/public/static/index/default/js/common.js"></script>
<script type="text/javascript" src="/yg/public/static/common/js/jQuery.autoIMG.js"></script>
<script>
$(function(){
	
	$(".product dl:nth-child(6n)").css('margin-right','0');
	$(".link-box ul li:nth-child(9n)").css('margin-right','0');
	 $('.mainbanner').unslider({
		speed: 500,               //  滚动速度
		delay: 3000,              //  动画延迟
		complete: function() {},  //  动画完成的回调函数
		keys: true,               //  启动键盘导航
		dots: true,               //  显示点导航
		fluid: false              //  支持响应式设计
	});
	
	$(".product-class").click(function(){
		var id=$(this).attr("id");
		var data=$(this).attr("data");
		$(this).parent("ul").children("li").removeClass("cur");
		$(this).addClass("cur");
		
		$(".product_"+data).fadeOut("fast",function(){
			$(".loading_"+data).fadeIn("fast",function(){
				$.get("<?php echo url('index/index/ajaxList'); ?>",{id:id},function(datas){
					
					$(".loading_"+data).fadeOut("fast",function(){
						
						$(".product_"+data).html(datas);
						$(".product dl:nth-child(6n)").css('margin-right','0');
						if(datas!=""){
							$(".product_"+data).fadeIn("fast");
						}
					});
				})
			});
		});
	})
	
	
	$("#index-user-nav dl").click(function(){
		var url=$(this).attr("url");
		window.location.href=url;
	})
	//$('.box .product-box .product dl dt a').autoIMG();
	
});
</script>
</head>

<body>
<script>
	
	$(document).ready(function(){
		$(".logout").on("click",function(){
			layui.use(['layer'], function(){
				layer.msg('再见会员：<?php echo $userInfo['user_name']; ?>', {time: 3000, icon:1},function(){ window.location.href="/yg/index/user/logout"; });
				
			});
		})
		
		$(".s_but").on("click",function(){
			var key=$("#search_box").val();
			if(key==''){
				layui.use(['layer'], function(){
					layer.msg('请输入关键字', {time: 3000, icon:2});
				});
				return false;
			}
			var url=$('#search_form').attr('action');
			var value=$('#search_form').attr('value');
			switch(value){
				case '1':
					url="/yg/index/product/search/keywords/key__"
				break;
				case '2':
					url="/yg/index/news/search/keywords/key__"
				break;
				case '4':
					url="/yg/index/score/search/keywords/key__"
				break;
			}
			url = url.replace('key__',key);
			window.location.href=url;
		})
		
		var i=0;
		$("#txt").click(
			function(){
				var t=$(this).html();
				var arr=['商品','新闻','积分商品'];
				i++;
				if(i>2) i=0;
				$(this).html(arr[i]);
				switch(i){
					case 0:
						$("#search_form").attr("value","1");
					break;
					case 1:
						$("#search_form").attr("value","2");
					break;
					case 2:
						$("#search_form").attr("value","4");
					break;
				}
				
			}
		)
	})
</script>
<div id="top">
	<div class="bar">
		<div class="web_body">
			<div class="left">欢迎光临<?php echo $config['site_name']; ?></div>
			<div class="right">
				<div class="top-nav">
					<ul>
						<?php if(!$uid): ?>
						<li><a href="/yg/index/user/login">登录</a></li>
						<li><a href="/yg/index/user/reg">注册</a></li>
						<li><a href="/yg/index/message/index">意见反馈</a></li>
						<?php else: ?>
						<li class="username"><a href="/yg/index/user/index"><?php echo $userInfo['user_name']; ?></a></li>
						<li class="cart"><a href="/yg/index/cart/index">我的购物车[0]</a></li>
						<li><a href="javascript:;" class="logout">退出</a></li>
						<?php endif; ?>
						<div class="clear"></div>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="banner">
		<div class="web_body">
		 
		 <?php $datas=array (
); if(is_array($datas) || $datas instanceof \think\Collection || $datas instanceof \think\Paginator): $i = 0; $__LIST__ = $datas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
			<a target="_blank" href="<?php echo $v['go']; ?>"><img src="<?php echo $v['pic']; ?>" style="opacity: 1; "></a>
		 <?php endforeach; endif; else: echo "" ;endif; ?>
		 </div>
	</div>
	<div class="main-box">
		<div class="web_body">
			<div class="logo left" ><a href="/yg/index/index/index" title="回首页"><img src="/yg/public/uploads/<?php echo $config['logo']; ?>"></a></div>
			<div class="right-box right">
				<form id="search_form" action="/yg/index/product/search" method="post" value="1">
				<div class="search-box">
					<ul>
						<li class="input"><input type="text" name="keywords" class="search" id="search_box" value="" /></li>
						<li class="classname" id="txt">商品</li>
						<li class="but s_but">搜索</li>
						<div class="clear"></div>
					</ul>
				</div>
				</form>
				<div class="hotword-box">
					热门搜索：
					
					<?php $datas=array (
); if(is_array($datas) || $datas instanceof \think\Collection || $datas instanceof \think\Paginator): $i = 0; $__LIST__ = $datas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
						<a href="<?php echo $v['url']; ?>"><?php echo $v['keyword']; ?></a>
					<?php endforeach; endif; else: echo "" ;endif; ?>
				</div>
			</div>
		</div>
	</div><!-- end of main-box -->
	<div class="web_body">
		<div class="nav-box left">
			<h1>商城导航分类</h1>
			<div class="nav">
				<ul>
					<li <?php if(!\think\Request::instance()->param('id')): ?>class="selected"<?php endif; ?>><a href="/yg/index/index/index">网站首页</a></li>
					<?php $model=new app\common\model\Nav;$__datas__= $model->getNav(0,0,0,'sort asc',10,0,1);$__datas__=collection($__datas__['data'])->toArray();if(is_array($__datas__) || $__datas__ instanceof \think\Collection || $__datas__ instanceof \think\Paginator): $i = 0; $__LIST__ = $__datas__;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
                        <li <?php if($v['selected']): ?>class="selected"<?php endif; ?>>
                        <a href="<?php echo $v['url']; ?>"><?php echo $v['name']; ?></a>
                    </li>
                	<?php endforeach; endif; else: echo "" ;endif; ?>
				</ul>
			</div>
		</div>
		<div class="notice-box right" id="notice-box">
			<ul>
				
				<?php $newsModel=new app\common\model\News;$__datas__= $newsModel->getNews(73,0,'sort asc',10,'');$page=$__datas__['page']; if(is_array($__datas__['data']) || $__datas__['data'] instanceof \think\Collection || $__datas__['data'] instanceof \think\Paginator): $i = 0; $__LIST__ = $__datas__['data'];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
				<li><a href="<?php echo $v['url']; ?>"><?php echo $v['title']; ?></a>&nbsp;[<span style="color:#006600"><?php echo $v['create_time']; ?></span>]</li>
				<?php endforeach; endif; else: echo "" ;endif; ?>
			</ul>
		</div>
		<div class="clear"></div>
	</div>
</div>

<div class="web_body">
	<div class="box">
		<div class="index-user-box left" id="index-user-nav">
			<dl class="l" url="/yg/index/orders/myorders">
				<dt class="icon-1"></dt>
				<dd>我的订单</dd>
			</dl>
			<dl class="r" url="/yg/index/friend/myfriend">
				<dt class="icon-2"></dt>
				<dd>朋友圈</dd>
			</dl>
			<dl class="l" url="/yg/index/friend/message">
				<dt class="icon-3"></dt>
				<dd>添加好友</dd>
			</dl>
			<dl class="r" url="/yg/index/lottery/index">
				<dt class="icon-4"></dt>
				<dd>积分抽奖</dd>
			</dl>
			<dl class="lb" url="/yg/index/cart/index">
				<dt class="icon-5"></dt>
				<dd>购物车</dd>
			</dl>
			<dl class="rb" url="/yg/index/letter/index">
				<dt class="icon-6"></dt>
				<dd>我的私信</dd>
			</dl>
			<div class="clear"></div>
		</div><!-- end of index-user-box -->
		
		<div class="mainbanner left">
			<ul>
				<?php $datas=array (
  0 => 
  array (
    'id' => 29,
    'name' => '夏日小清新',
    'cate' => 23,
    'url' => 'http://www.leesuntech.com',
    'intro' => '35831891036',
    'pic' => '/yg/public/uploads/20171001/9691506871612.jpg',
    'sort' => 1,
    'user_id' => 0,
    'click' => 1,
    'is_qiniu' => 0,
    'go' => '/yg/index/adv/jump/id/29',
  ),
  1 => 
  array (
    'id' => 31,
    'name' => '品味时尚',
    'cate' => 23,
    'url' => 'http://www.leesuntech.com',
    'intro' => '品味时尚',
    'pic' => '/yg/public/uploads/20171001/27661506871623.jpg',
    'sort' => 2,
    'user_id' => 0,
    'click' => 2,
    'is_qiniu' => 0,
    'go' => '/yg/index/adv/jump/id/31',
  ),
  2 => 
  array (
    'id' => 30,
    'name' => '时尚都市',
    'cate' => 23,
    'url' => 'http://www.leesuntech.com',
    'intro' => '时尚都市',
    'pic' => '/yg/public/uploads/20171001/35671506871629.jpg',
    'sort' => 3,
    'user_id' => 0,
    'click' => 0,
    'is_qiniu' => 0,
    'go' => '/yg/index/adv/jump/id/30',
  ),
); if(is_array($datas) || $datas instanceof \think\Collection || $datas instanceof \think\Paginator): $i = 0; $__LIST__ = $datas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
					<li><a target="_blank" href="<?php echo $v['go']; ?>"><img class="sliderimg" src="<?php echo $v['pic']; ?>" alt="" width="100%"></a></li>
				<?php endforeach; endif; else: echo "" ;endif; ?>
			
			 </ul>
		</div><!-- end of banner -->
		
		<div class="right">
			<div class="news-box">
				<div class="tit">
					<h1 class="left">最新消息</h1>
					<!--<h3 class="right more"><a href="">更多...</a></h3>-->
				</div>
				<div class="list grey_l">
					<ul>
						
						<?php $newsModel=new app\common\model\News;$__datas__= $newsModel->getNews(0,0,'sort asc',7,'');$page=$__datas__['page']; if(is_array($__datas__['data']) || $__datas__['data'] instanceof \think\Collection || $__datas__['data'] instanceof \think\Paginator): $i = 0; $__LIST__ = $__datas__['data'];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
						<li><a href="<?php echo $v['url']; ?>">·<?php echo mb_substr($v['title'],0,10,'utf-8'); ?></a>&nbsp;&nbsp;[<span style="color:#006600"><?php echo mb_substr($v['create_time'],0,10,'utf-8'); ?></span>]</li>
						<?php endforeach; endif; else: echo "" ;endif; ?>
					</ul>
				</div>
			</div>
			<div class="sbanner">
				 <?php $datas=array (
); if(is_array($datas) || $datas instanceof \think\Collection || $datas instanceof \think\Paginator): $i = 0; $__LIST__ = $datas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
					<a target="_blank" href="<?php echo $v['go']; ?>"><img class="sliderimg" src="<?php echo $v['pic']; ?>" alt="" width="100%"  class="img"></a>
				 <?php endforeach; endif; else: echo "" ;endif; ?>
			</div>
		</div>
		
		<div class="clear"></div>
	</div><!-- end of box -->
	
	<?php $model=new app\common\model\Nav;$__datas__= $model->getNav(0,1,0,'sort asc',0,0,1);$__datas__=collection($__datas__['data'])->toArray();if(is_array($__datas__) || $__datas__ instanceof \think\Collection || $__datas__ instanceof \think\Paginator): $i = 0; $__LIST__ = $__datas__;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
		<div class="box" style="margin-bottom:20px;">
		
			<div class="product-box">
				<div class="tit">
					<div class="floor left"><?php echo $key+1; ?>F</div>
					<div class="name left"><h1><?php echo $v['name']; ?><h1></div>
					<div class="pnav right">
						<ul>
							<li id="<?php echo $v['id']; ?>" class="product-class cur" data="<?php echo $v['id']; ?>">所有</li>
							<?php $model=new app\common\model\Nav;$__datas__= $model->getNav($v['id'],0,0,'sort asc',0,0,2);$__datas__=collection($__datas__['data'])->toArray();if(is_array($__datas__) || $__datas__ instanceof \think\Collection || $__datas__ instanceof \think\Paginator): $i = 0; $__LIST__ = $__datas__;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$sv): $mod = ($i % 2 );++$i;?>
							<li id="<?php echo $sv['id']; ?>" class="product-class" data="<?php echo $v['id']; ?>"><?php echo $sv['name']; ?></li>
							<?php endforeach; endif; else: echo "" ;endif; ?>
							<div class="clear"></div>
						</ul>
					</div>
				</div>
				<div class="product">
					<div class="loading loading_<?php echo $v['id']; ?>" style="height:206px;"></div>
					<div class="product_<?php echo $v['id']; ?>">
					
					
					<?php $model=new app\common\model\Product;$w['pid']=$v['id'];$w['bid']=0;$w['recommend']=1;$w['status']=1;$w['keywords']='';$order='sort asc';$num='0';$__datas__= $model->getProduct($w,0,$order,$num);$page=$__datas__['page']; if(is_array($__datas__['data']) || $__datas__['data'] instanceof \think\Collection || $__datas__['data'] instanceof \think\Paginator): $i = 0; $__LIST__ = $__datas__['data'];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$pv): $mod = ($i % 2 );++$i;?>
					<dl>
						<dt><a href="<?php echo $pv['url']; ?>"><?php if($pv['thumb']): ?><img src="/yg/public/uploads/<?php echo $pv['thumb']; ?>"   onload='AutoResizeImage(181,138,this)'/><?php else: ?><img src="/yg/public/static/index/default/no-pic.jpg" class="img"/><?php endif; ?></a></dt>
						<dd>
							<h2 class="dgrey_l"><a href="<?php echo $pv['url']; ?>"><?php echo mb_substr($pv['name'],0,30,'utf-8'); ?></a></h2>
							<h1><?php echo $pv['symbol']; ?>&nbsp;<?php echo $pv['current_price']; ?></h1>
						</dd>
					</dl>
					<?php endforeach; endif; else: echo "" ;endif; ?>
					<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
			
		</div>
	<?php endforeach; endif; else: echo "" ;endif; ?>
	
	
	
	<div class="box">
		<?php $datas=array (
); if(is_array($datas) || $datas instanceof \think\Collection || $datas instanceof \think\Paginator): $i = 0; $__LIST__ = $datas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
			<div class="b-banner">
				<a target="_blank" href="<?php echo $v['go']; ?>"><img  src="<?php echo $v['pic']; ?>"  class="img"></a>
			</div>
		<?php endforeach; endif; else: echo "" ;endif; ?>
	</div>
	
	<div class="box">
		<div class="link-box">
			<div class="tit">友情链接</div>
			<div class="list">
				<ul class="grey_l">
					<?php $datas=array (
); if(is_array($datas) || $datas instanceof \think\Collection || $datas instanceof \think\Paginator): $i = 0; $__LIST__ = $datas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
					<li><a href="<?php echo $v['url']; ?>" target="_blank"><?php echo $v['name']; ?></a></li>
					<?php endforeach; endif; else: echo "" ;endif; ?>
					
					<div class="clear"></div>
				</ul>
			</div>
		</div>
	</div>
	
</div>
<div class="clear"></div>

<div id="footer" class="dgrey_l">
	<div class="f_line web_body ">
		 <?php $datas=array (
  0 => 
  array (
    'id' => 23,
    'name' => '关于我们',
    'content' => '<p><span style="color: rgb(88, 86, 86); font-family: Simsun; font-size: 14px; line-height: 25px; text-indent: 28px; white-space: normal;">乐尚商城系统，是一项基于PHP+MYSQL为核心开发的一套免费 + 开源专业商城系统。软件具执行效率高、模板自由切换、后台管理功能方便等诸多优秀特点。<br/></span><span style="color: rgb(88, 86, 86); font-family: Simsun; font-size: 14px; line-height: 25px; text-indent: 28px; white-space: normal;"></span></p><p style="color: rgb(88, 86, 86); font-family: Simsun; font-size: 14px; line-height: 25px; text-indent: 28px; white-space: normal;">&nbsp; &nbsp; 本软件是基于Web应用的B/S架构的商城网站建设解决方案的建站系统。它可以让用户高效、快速、低成本的构建个性化、专业化、强大功能的团购网站。从技术层面来看，本程序采用目前软件开发IT业界较为流行的PHP和MYSQL数据库开发技术，基于面向对象的编程，模版与代码分离MVC架构。从功能层面来看，分为模块管理，可以将您发布的新闻或商品增加权限，通过积分等级形式访问，具有评论，私信、好友，评价等功能。本软件管理员后台具有人性化的参数配置、支付管理、邮件服务器配置、各模式权限管理，迅速的帮助有热情、有志向投入运营商城网站的客户建立属于自己的商城网站。从而在你当地抢得先机。再则你也有多余的时间和精力放在网站的宣传和业务运营上。 乐尚商城软件不只是帮你建立商城网站，作为我们的用户，我们还将提供网站安装、使用指导、网站故障排除、BUG提交及时解决；当然在功能、模版升级以及定制方面用户都可以得到很好的技术保障。另外在以后功能以及风格样式的升级方面，我们都将虚心听从用户的建议和指导。希望我们能与运营团购网站的您携手共同提高，共同进步。</p><p style="color: rgb(88, 86, 86); font-family: Simsun; font-size: 14px; line-height: 25px; text-indent: 28px; white-space: normal;">&nbsp; &nbsp; &nbsp;我们一直坚持“以人才为根本，以市场为导向，以质量为保证，以服务为宗旨”的理念。致力为用户提供最优秀的网站和商城系统平台建设以及相关咨询、培训和实时服务提供整体解决方案。<br/>&nbsp; &nbsp; &nbsp;QQ群:307867520<br/><br/>版本:1.0.5--------------------------------------//版本:1.0.5--------------------------------------//<br/>1.后台增加会员搜索功能（用户名、邮箱、电话）;<br/>2.后台增加会员修改功能（密码、邮箱、积分等);<br/>3.加入会员注册时间以及登陆时间<br/>4.修复安装程序新建数据库错误<br/>5.修复商品评价管理员回复后不更新回复时间问题<br/>6.修复购物车提交订单后依然存在的错误<br/>7.后台文章管理增加推荐次数显示<br/>8.修复后台管理员分组新增分组的样式排列以及增加全选按钮问题<br/>9.修复新会员发布商品不为空的错误<br/>10.增加新注册会员直接登陆进入会员中心功能<br/>11.修复新闻一级分类不显示的错误以及网站位置链接的错误<br/>12.增加导航显示与隐藏设置<br/>13.修复了部分后台空白的错误<br/>14.修改了后台登陆提示时间过长<br/>15.修复前台原价与现价错误<br/>16.后台增加在线升级模块（一键升级）<br/>17.修复后台数据还原错误<br/><br/><br/>版本:1.1.0-------------------------------------//<br/>1.添加后台还原数据进行版本比较<br/>2.修复缓存开启后后台广告列表不能翻页的错误<br/>3.增加友情链接功能<br/>4.修复后台模块管理修改时不能修改类型的问题<br/>5.后台模块管理增加普通商品与品牌商品模块<br/>6.增加后台结束订单删除功能<br/>7.修复后台导航隐藏后前台依然显示的问题<br/>8.后台增加搜索关键字管理<br/>9.后台网站设置增加收藏夹图标上传<br/>10.修复后台无效图片管理ICO图标显示为无效错误<br/>11.后台模块增加品牌商品类型<br/>12.后台增加清除即时运行缓存功能<br/>13.后台增加发送测试邮件功能<br/>14.优化前台会员查找密码发邮件功能<br/>15.后台邮件服务器增加发送测试邮件功能<br/>16.后台增加发送邮件规则<br/>17.前台增加按邮件规则发送邮件<br/>18.前台修复顶部LOGO后台不能更改的问题<br/><br/><br/>版本:1.1.3-------------------------------------//<br/>1.修复提交订单时不填用户留言时的错误<br/>2.修复返回购物车时收货地区不显示的错误<br/>3.增加未安装系统时直接进入安装界面<br/>4.后台增加会员统计功能<br/>5.后台增加在线模板编辑功能<br/>6.后台增加用户统计功能<br/>7.增加前台品牌栏目<br/><br/><br/><br/><br/>版本:1.1.4-------------------------------------//<br/>1.紧急修复支付宝不能支付的错误<br/>2.修复还原数据错误<br/>3.后台网站设置增加网站关闭与设置关闭内容功能<br/>4.增加安装时如果有备份直接恢复备份数据功能<br/>18.前台修复顶部LOGO后台不能更改的问题<br/><br/>版本:1.1.4.1-------------------------------------//<br/>1.紧急修复前台会员注册不成功的错误<br/>2.紧急修复安装时选择备份文件后安装不成功的错误</p><p style="color: rgb(88, 86, 86); font-family: Simsun; font-size: 14px; line-height: 25px; text-indent: 28px; white-space: normal;"><br/></p><p style="color: rgb(88, 86, 86); font-family: Simsun; font-size: 14px; line-height: 25px; text-indent: 28px; white-space: normal;">乐尚商城 v1.1.7 更新日志：</p><p style="color: rgb(88, 86, 86); font-family: Simsun; font-size: 14px; line-height: 25px; text-indent: 28px; white-space: normal;">1.修改首页与商品索引页显示推荐商品<br/><span style="line-height: 1.5;">2.修复后台管理员会话到期直接退出框架到登陆窗口<br/></span><span style="line-height: 1.5;">3.增加管理员可以对用户是否禁用登陆<br/></span><span style="line-height: 1.5;">4.后台无效图片管理更名为无效文件管理并优化<br/></span><span style="line-height: 1.5;">5.增加咨询电话、QQ、ICP备案内容设置及前端显示<br/></span><span style="line-height: 1.5;">6.修复安装默认超级管理员权限不足的错误<br/></span><span style="line-height: 1.5;">7.增加商品自动生成图片缩略图功能，提升页面访问速度<br/></span><span style="line-height: 1.5;">8.后台设置增加缩略图尺寸设置<br/></span><span style="line-height: 1.5;">9.后台设置可否增加水印以及水印位置<br/></span><span style="line-height: 1.5;">10.增加转盘积分抽奖功能</span></p><p><br/></p>',
    'sort' => 1,
    'url' => '/yg/index/pcate/show/id/23',
  ),
  1 => 
  array (
    'id' => 24,
    'name' => '帮助中心',
    'content' => '<p>帮助中心</p>',
    'sort' => 2,
    'url' => '/yg/index/pcate/show/id/24',
  ),
  2 => 
  array (
    'id' => 25,
    'name' => '诚聘英才',
    'content' => '&lt;p&gt;&lt;span style=&quot;font-family: &amp;#39;microsoft yahei&amp;#39;; font-size: 12px; text-align: -webkit-center; white-space: normal;&quot;&gt;诚聘英才&lt;/span&gt;&lt;/p&gt;',
    'sort' => 3,
    'url' => '/yg/index/pcate/show/id/25',
  ),
  3 => 
  array (
    'id' => 26,
    'name' => '联系我们',
    'content' => '&lt;p&gt;&lt;span style=&quot;font-family: &amp;#39;microsoft yahei&amp;#39;; font-size: 12px; text-align: -webkit-center; white-space: normal;&quot;&gt;联系我们&lt;/span&gt;&lt;/p&gt;',
    'sort' => 4,
    'url' => '/yg/index/pcate/show/id/26',
  ),
  4 => 
  array (
    'id' => 27,
    'name' => '网站合作',
    'content' => '&lt;p&gt;&lt;span style=&quot;font-family: &amp;#39;microsoft yahei&amp;#39;; font-size: 12px; text-align: -webkit-center; white-space: normal;&quot;&gt;网站合作&lt;/span&gt;&lt;/p&gt;',
    'sort' => 5,
    'url' => '/yg/index/pcate/show/id/27',
  ),
  5 => 
  array (
    'id' => 28,
    'name' => '版权说明',
    'content' => '<p><span style="font-family: &#39;microsoft yahei&#39;; font-size: 12px; text-align: -webkit-center; white-space: normal;"><img src="http://localhost/lsnew/public/ueditor/php/upload/20170805/15019442121169.jpg" _src="http://localhost/lsnew/public/ueditor/php/upload/20170805/15019442121169.jpg"/>版权说明1</span></p>',
    'sort' => 6,
    'url' => '/yg/index/pcate/show/id/28',
  ),
); if(is_array($datas) || $datas instanceof \think\Collection || $datas instanceof \think\Paginator): $i = 0; $__LIST__ = $datas;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?>
    		<a href="<?php echo $v['url']; ?>"><?php echo $v['name']; ?></a>&nbsp;&nbsp;&nbsp;
    	<?php endforeach; endif; else: echo "" ;endif; ?>
    </div>
    <div class="copyright web_body">
    	Copyright &copy; <a href="http://www.leesuntech.com" target="_blank">乐尚商城</a> All Rights Reserved&nbsp;<a href="http://www.miibeian.gov.cn/" target="_blank"><?php echo $config['icp_number']; ?></a>&nbsp;&nbsp;咨询热线：<?php echo $config['telephone']; ?>&nbsp;&nbsp;咨询QQ：<?php echo $config['qq_num']; ?><br /><a href="http://www.leesuntech.com">Powered by leesuntech</a>
    </div>
</div>

</body>
</html>
