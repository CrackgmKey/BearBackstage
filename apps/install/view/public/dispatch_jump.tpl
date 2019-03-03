<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>抱歉，出现错误了！</title>
    <link type="text/css" rel="stylesheet" href="__PUBLIC__/jump_style/base.css">
    <link type="text/css" rel="stylesheet" href="__PUBLIC__/jump_style/global.css">
    <link type="text/css" rel="stylesheet" href="__PUBLIC__/jump_style/404.css">
</head>
<body>
<div class="wrap">
    <div class="errors">
        <div class="text">
            <h4>无法访问页面的原因：</h4>
            <h4><?php echo($error); ?>!</h4>
            <p>YFCMF：页面自动 <a id="href" href="<?php echo($jumpUrl); ?>">跳转</a> 等待时间： <b id="wait"><?php echo($waitSecond); ?></b></p>
            <!--<p>如果您的浏览器没有自动跳转，请<span onclick="turnUrl()">点击此链接</span>。</p>-->
        </div>
    </div>
</div>

<script type="text/javascript">
    (function(){
        var wait = document.getElementById('wait'),href = document.getElementById('href').href;
        var interval = setInterval(function(){
            var time = --wait.innerHTML;
            if(time <= 0) {
                location.href = href;
                clearInterval(interval);
            };
        }, 1000);
    })();
</script>
</body></html>