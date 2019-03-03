<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>提示消息</title>

		<style type="text/css">
			body {font-family:"microsoft yahei"; background:#e8e8e8;}
			#notice { width: 650px; height:410px; background: #1d2225;	position: absolute; left: 50%; top: 50%; margin-left: -325px; margin-top: -205px; }
			#notice .title{height:48px; line-height:48px; text-indent:1em;  background:#ff7900;color:#fff;font-size:18px;}
			#notice .content{height:330px;background:#efefef;}
			#notice .content .sign{width:250px;height:250px;float:left;margin:30px}
			#notice .content .mess{width:310px;height:290px;float:right;line-height:20px;font-size:17px;}
			#notice .bot{height:30px;line-height:30px;text-align:center;font-size:12px;color:#fff;background: #1d2225;}
			#notice p { background: #FFF; margin: 0; padding: 0 0 20px; }
			a { color: #f00} a:hover { text-decoration: none; }
			
		</style>
	</head>
	<body>
    	<div id="notice">
        	<div class="title">{$config.site_name}提醒您</div>
            <div class="content">
            	<div class="sign"  <?php if($code){ ?>style="background:url(__ROOT____INDEX__/images/error_success.png) -250px 0px no-repeat;"  <?php } else { ?>style="background:url(__ROOT____ADMIN__/images/error_success.png) no-repeat;" <?php } ?>></div>
                <div class="mess">
				<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="5">
				  <tr>
					<td valign="middle"><?php echo(strip_tags($msg));?></td>
				  </tr>
				</table>
				</div>
				<div style="clear:both"></div>
            </div>
            <div class="bot">
            	在( <b id="wait"><?php echo($wait);?></b> )秒后自动跳转，或直接点击 <a id="href" href="<?php echo($url);?>">这里</a> 跳转
            </div>
        </div>
		
						
		<script type="text/javascript">
        (function(){
            var wait = document.getElementById('wait'),
                href = document.getElementById('href').href;
            var interval = setInterval(function(){
                var time = --wait.innerHTML;
                if(time <= 0) {
                    location.href = href;
                    clearInterval(interval);
                };
            }, 1000);
        })();
    </script>
	</body>
</html>
