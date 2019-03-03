<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=7">
<title>{$config.site_name}</title>
<meta name="keywords" content="{$config.key_word}" />
<meta name="description" content="{$config.description}" />
<meta name="author" content="乐尚商城" />
<meta name="copyright" content="leesuntech.com" />
<link rel="shortcut icon" href="__ROOT____UPLOADS__/{$config.favicon}" />

<link href="__ROOT____COMMON__/css/global.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/common.css" rel="stylesheet" type="text/css" />
<link href="__ROOT____INDEX__/css/layout.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="__ROOT____COMMON__/layui/css/layui.css" media="all">
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/js/jquery.pngfix.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="__ROOT____COMMON__/layui/layui.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/unslider.min.js"></script>
<script type="text/javascript" src="__ROOT____INDEX__/js/common.js"></script>
{Leesun:news_1 name='newsData' id="$Request.param.id" /}
<script>
var uid="{$uid}";
$(function(){
	$("#news-box:nth-child(2n)").css('margin-right','0');
	
		$("#add").click(function(){
			 if(!uid){
				open_url="{Leesun:url name='ajaxLogin' /}";
				layui.use(['layer', 'form'], function(){
					layer.open({
					  type: 2,
					  area: ['590px', '350px'],
					  title:'用户登陆',
					  fixed: false, //不固定
					  maxmin: false,
					  content: open_url
					  
					});
				});
				return false;
			}else
			if($("#content").val()==""){
				
				layui.use(['layer'], function(){
					layer.msg('请填写评论内容', {time: 3000, icon:2});
				});
				return false;
			} 
			var article_id="{$newsData.id}";
			var pid="{$newsData.m_cate}";
			var cate="{$newsData.cate}";
			var content=$("#content").val();
			$.post("{Leesun:url name='addComment' /}",{article_id:article_id,pid:pid,cate:cate,content:content},function(d){
				
				layui.use(['layer'], function(){
					layer.msg(d.msg, {time: 3000, icon:d.code},function(){$("#content").val('');});
				});
			})
			
		});
		
		$(".friend").click(
			function(){
				if(!uid){
					
					
					open_url="{Leesun:url name='ajaxLogin' /}";
					layui.use(['layer', 'form'], function(){
						layer.open({
						  type: 2,
						  area: ['590px', '350px'],
						  title:'用户登陆',
						  fixed: false, //不固定
						  maxmin: false,
						  content: open_url
						  
						});
					});
					return false;
					
				} else {
					open_url=$(this).attr("url");
					title="加好友";
					
					layui.use(['layer', 'form'], function(){
						layer.open({
						  type: 2,
						  area: ['590px', '470px'],
						  title: title,
						  fixed: false, //不固定
						  maxmin: false,
						  content: open_url
						  
						});
					});
				}
			}
		);
		
		$(".letter").click(
			function(){
				
				
				if(!uid){
					open_url="{Leesun:url name='ajaxLogin' /}";
					layui.use(['layer', 'form'], function(){
						layer.open({
						  type: 2,
						  area: ['590px', '350px'],
						  title:'用户登陆',
						  fixed: false, //不固定
						  maxmin: false,
						  content: open_url
						  
						});
					});
					return false;
				} else {
					open_url=$(this).attr("url");
					user_name=$(this).attr("data-name");
					title="给"+user_name+"发私信";
					
					layui.use(['layer', 'form'], function(){
						layer.open({
						  type: 2,
						  area: ['590px', '470px'],
						  title: title,
						  fixed: false, //不固定
						  maxmin: false,
						  content: open_url
						  
						});
					});
				}
				
			}
		);
		
		$(".reply").click(
			function(){
				var u_id=$(this).attr("id");
				var u_se="{$userInfo.user_name}";
				if(u_id!=u_se){
					var reply="#"+$(this).parent().find(".floor").attr("id")+"楼 @"+u_id+" ";
					$("html,body").animate({scrollTop:$("#submit").offset().top},500);
					$("#content").val(reply);
				} else {
					layui.use(['layer'], function(){
						layer.msg('不能回复自己', {time: 3000, icon:2});
					});
				}
			}
		)
		
		//分享按钮
		$("#weixin").click(function(){
			
			var html='<img src="{$qrcode}">';
			layui.use('layer', function(){
			  var layer = layui.layer;
			  layer.open({
				  type: 1, 
				  offset:'100px',
				 
				  maxWidth:'500px',
				  title:'微信分享',
				  content: '<div style="padding:20px">'+ html +'</div>' //这里content是一个普通的String
				});
			});   
		});
		
		$("#twitter").click(
			function(){
				var url="http://v.t.sina.com.cn/share/share.php?url="+encodeURIComponent('{$url}')+"&title="+encodeURIComponent('{$newsData.title}')+"&appkey=433903842&pic";
				window.open(url);
			}
		)
		$("#qq").click(
			function(){
				var url="http://connect.qq.com/widget/shareqq/index.html?url="+encodeURIComponent('{$url}')+"&title="+encodeURIComponent('{$newsData.title}')+"&source=shareqq&desc=刚看到这篇文章不错，推荐给你看看～";
				window.open(url);
			}
		)
		
		var t=0;
		$(".top").click(
			function(){
				if(t==0){
					var status=1;
					var id=$(this).attr("id");
					var url="{Leesun:url name='commentTop' /}";
					$(this).removeClass();
					$(this).addClass("top_1");
					$.ajax({   
						type:"post",     
						url:url,
						data:{status:status,id:id},
						success:function(msg){
							
							
						},   
						error:function(){   
							layui.use(['layer'], function(){
								layer.msg('顶失败', {time: 3000, icon:2});
							});
						}   
					});   
					t=1;
				} else {
					var status=0;
					var id=$(this).attr("id");
					var url="{Leesun:url name='commentTop' /}";
					$(this).removeClass();
					$(this).addClass("top");
					$.ajax({   
						type:"post",     
						url:url,
						data:{status:status,id:id},
						success:function(msg){
							
						},   
						error:function(){   
							layui.use(['layer'], function(){
								layer.msg('顶失败', {time: 3000, icon:2});
							});
						}   
					});
					t=0;
				}
			})
		var i=0;
		//文章推荐
		$("#recommand").click(
			function(){
				if(i==0){
					var status=1;
					var num=$("#re_num").html();
					var num=num*1+1*1;
					$("#re_num").html(num);
					var article_id="{$newsData.id}";
					var url="{Leesun:url name='newsRec' /}";
					$(this).removeClass();
					$(this).addClass("recommand_1");
					$.ajax({   
						type:"post",     
						url:url,
						data:{status:status,article_id:article_id},
						success:function(msg){
						},   
						error:function(){
							layui.use(['layer'], function(){
								layer.msg('推荐失败', {time: 3000, icon:2});
							});
						}   
					}); 
					i=1;
				} else {
					var status=0;
					var num=$("#re_num").html();
					var num=num*1-1*1;
					$("#re_num").html(num);
					var article_id="{$newsData.id}";
					var url="{Leesun:url name='newsRec' /}";
					$(this).removeClass();
					$(this).addClass("recommand");
					$.ajax({   
						type:"post",     
						url:url,
						data:{status:status,article_id:article_id},
						success:function(msg){
						},   
						error:function(){   
							layui.use(['layer'], function(){
								layer.msg('推荐失败', {time: 3000, icon:2});
							});
						}   
					}); 
					i=0;
				}
			})
		//文章收藏
		function add_fav(){
			var status=1;
			var article_id="{$newsData.id}";
			
			var url="{Leesun:url name='addNewsFav' /}";
			$("#fav").removeClass();
			$("#fav").addClass("fav_1");
			$.ajax({   
				type:"post",     
				url:url,
				data:{status:status,article_id:article_id,user_id:uid},
				success:function(msg){
				},   
				error:function(){
					layui.use(['layer'], function(){
						layer.msg('收藏失败', {time: 3000, icon:2});
					});
				}   
			});  
		}
		
		function del_fav(){
			var status=0;
			var article_id="{$newsData.id}";
			var uid="{$userInfo.id}";
			var url="{Leesun:url name='addNewsFav' /}";
			$("#fav").removeClass();
			$("#fav").addClass("fav");
			$.ajax({   
				type:"post",     
				url:url,
				data:{status:status,article_id:article_id,user_id:uid},
				success:function(msg){
				},   
				error:function(){
					layui.use(['layer'], function(){
						layer.msg('收藏失败', {time: 3000, icon:2});
					});
				}   
			});  
		}
		var j=0;
		var status=$("#fav").attr("status");
		if(status=="1"){
			//$("#fav").toggle(del_fav,add_fav);
			$("#fav").click(function(){
				if(j==0){
					del_fav();
					j=1;
				} else {
					add_fav();
					j=0;
				}
			})
		} else {
			//$("#fav").toggle(add_fav,del_fav);
			$("#fav").click(function(){
				if(j==0){
					add_fav();
					j=1;
				} else {
					del_fav();
					j=0;
				}
			})
		}
});
</script>
</head>

<body>
{include file="public/header" /}
<div class="web_body">
	
	<div class="left">
		
		<div class="box">
			<div class="rec-box">
				<div class="tit">相关新闻</div>
				<div class="con">
					<ul class="dgrey_l" style="font-size:14px;color:#666">
						{Leesun:news name='v' sort='create_time desc' num='10' pid="$Request.param.pid"}
						<li style="list-style-type:decimal;list-style-position:inside;">
							<a href="{$v.url}">{$v.title|mb_substr=0,10,'utf-8'}</a>
						</li>
						{/Leesun:news}
					</ul>
				</div>
			</div>
		</div><!-- end of box -->
	</div><!-- end of left -->


	<div class="right">
		
		<div class="box">
			<div class="position dgrey_l"></div>
		</div>
		
		<div class="box" >
			<div class="news-box" id="news-box">
				<div class="content">
					<h1>{$newsData.title}</h1>
					<h2>创建时间：{$newsData.create_time}&nbsp;&nbsp;点击次数：{$newsData.click}次</h2>
					<h3>{if ($newsData.thumb)}<img src="{$newsData.thumb}" align="left">{/if}{$newsData.content}</h3>
				</div>
			</div>
		</div>
		
		
		<div class="box">
			 <div class="share_box">
             	<div class="left">
                	<span class="recommand" id="recommand" title="推荐这篇文章"></span>
                    <span class="re_num" id="re_num">{$newsData.recommand}</span>
                    {if ($userInfo.id)}
                    	{if ($newsData.isFav)}
                        	<span class="fav_1" id="fav" status="1" title="取消收藏"></span>
                        {else}
                        	<span class="fav" id="fav" status="0" title="收藏这篇文章"></span>
                        {/if}
                    {/if}
                </div>
                <div class="right">
                	<span class="twitter" id="twitter">分享到微博</span>
                    <span class="weixin" id="weixin">分享到微信</span>
                    <span class="qq" id="qq">分享到QQ</span>
                </div>
                <div class="clear"></div>
             </div>
		</div>
		
		<div class="box">
			
             <div class="comments">
             
            
				{Leesun:comment name='v' pid='$Request.param.id'}
             	<div class="lists">
                	<div class="photo">{if ($v.user.photo)}<img src="__ROOT____UPLOADS__/{$v.user.photo}"  class="img"/>{else}<img src="__ROOT____INDEX__/images/user_default.gif"  class="img">{/if}</div>
                    <div class="info">
                    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td class="uname"><span class="uname_box"><a class="uname uname_area" target="_blank">{$v.user.user_name}</a><div class="user_private_list"><ul><li><a class="letter" data-name="{$v.user.user_name}" url="{$v.url}">发私信</a></li><li><a class="friend" url="{$v.friend_url}" >加好友</a></li></ul></div></span> • <abbr class="timeago" title="{$v.create_time}">{$v.create_time}</abbr> </td>
                          </tr>
                          <tr>
                            <td>{$v.content}</td>
                          </tr>
                          <tr>
                            <td class="icon"><div class="top" id="{$v.id}"></div><div class="top_t">顶</div><div class="reply" id="{$v.user.user_name}"></div><div class="reply_t">回复</div><div class="floor" id="{$key+1}">{$key+1}楼</div></td>
                          </tr>
                        </table>

                    </div>
                    <div class="clear"></div>
                </div>
                {/Leesun:comment}
                
             	<div class="submit" id="submit">
                	<div class="title">文章评论({$newsData.commentNum})</div>
                    <div class="comment_box"><textarea name="content" id="content"></textarea></div>
                    <div class="comment_button"><input type="button" name="add" id="add"  value="提交评论" /></div>
                </div>
             </div>
             
		</div>
		
	</div><!-- end of right -->
	<div class="clear"></div>
</div><!-- end of web_body -->

<div class="clear"></div>
{include file="public/footer" /}


</body>
</html>
