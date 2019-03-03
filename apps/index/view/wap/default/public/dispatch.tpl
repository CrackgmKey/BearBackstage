<!DOCTYPE html> 
<html>
<head>
	<title>提示消息</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=device-dpi" />
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<script type="text/javascript" src="__ROOT____COMMON__/js/jquery-1.11.1.min.js"></script>
	<style type="text/css">
	body { background:#ededed; font-family:"microsoft yahei"; height:100% }
	.msg-box{
		width:80%;
		
		border:0.5rem solid #ddd;
		border-radius:1rem;
		background-color:#fff;
		position:absolute;
		top:50%;
		left:50%;
		margin-top:-12rem;
		margin-left:-40%;
	}
	.icon{
		width:10rem;
		height:10rem;
		margin:2rem auto;
	}
	.mess{
		line-height:25px;
		text-align:center;
	}
	.bot{
		line-height:30px;
		text-align:center;
		font-size:0.9rem;
	}
	</style>
	<script>
		
		
	</script>
</head>
<body>

<div class="msg-box">
	<div class="icon"  <?php if($code){ ?>style="background:url(__WAP__/images/error_success.jpg)  no-repeat; background-size:20rem 10rem"   <?php } else { ?>style="background:url(__WAP__/images/error_success.jpg) -10rem 0 no-repeat; background-size:20rem 10rem" <?php } ?>>
	</div>
	<div class="mess"><?php echo(strip_tags($msg));?></div>
	<div class="bot">
		乐尚商城提示您，在( <span id="wait" style="color:#ff0000;font-weight:bold"><?php echo($wait);?></span> )秒后自动跳转，或直接点击 <a id="href" href="<?php echo($url);?>">这里</a> 跳转
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
