<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

return [
    '__pattern__' => [
        'name' => '\w+',
    ],
    '[hello]'     => [
        ':id'   => ['index/hello', ['method' => 'get'], ['id' => '\d+']],
        ':name' => ['index/hello', ['method' => 'post']],
    ],
	
	
	'index' =>  'index/index/index',
	'login' =>  'index/user/login',
	'reg' =>  'index/user/reg',
	'index-ajaxlist' =>  'index/index/ajaxlist',
	'adv_<id>' => ['index/adv/jump', ['ext' => 'html', 'method' => 'get'], ['id' => '[A-Za-z0-9]+']],
	'user-index' =>  'index/user/index',
	'cart' =>  'index/cart/index',
	'logout' =>  'index/user/logout',
	'message' =>  'index/message/index',
	'message_add' =>  'index/message/add',
	'captcha' =>  'index/user/getcaptcha',
	'product-search' =>  'index/product/search',
	'news-search' =>  'index/news/search',
	'score-search' =>  'index/score/search',
	'product_<id>_<pid>_<mid>' => ['index/product/index', ['ext' => 'html', 'method' => 'get'], ['id' => '[A-Za-z0-9]+','pid' => '[A-Za-z0-9]+','mid' => '[A-Za-z0-9]+']],
	'productlist_<id>_<pid>_<mid>' => ['index/product/lists', ['ext' => 'html', 'method' => 'get'], ['id' => '[A-Za-z0-9]+','pid' => '[A-Za-z0-9]+','mid' => '[A-Za-z0-9]+']],
	'show_<id>_<pid>_<mid>' => ['index/product/show', ['ext' => 'html', 'method' => 'get'], ['id' => '[A-Za-z0-9]+','pid' => '[A-Za-z0-9]+','mid' => '[A-Za-z0-9]+']],
	'score_<id>_<pid>_<mid>' => ['index/score/index', ['ext' => 'html', 'method' => 'get'], ['id' => '[A-Za-z0-9]+','pid' => '[A-Za-z0-9]+','mid' => '[A-Za-z0-9]+']],
	'scorelist_<id>_<pid>_<mid>' => ['index/score/lists', ['ext' => 'html', 'method' => 'get'], ['id' => '[A-Za-z0-9]+','pid' => '[A-Za-z0-9]+','mid' => '[A-Za-z0-9]+']],
	'scoreshow_<id>_<pid>_<mid>' => ['index/score/show', ['ext' => 'html', 'method' => 'get'], ['id' => '[A-Za-z0-9]+','pid' => '[A-Za-z0-9]+','mid' => '[A-Za-z0-9]+']],
	'ajaxprice' =>  'index/product/ajaxprice',
	'ajaxdistrict' =>  'index/district/ajaxdistrict',
	'checkinput' =>  'index/orders/checkinput',
	'addcart' =>  'index/cart/addcart',
	'addscorecart' =>  'index/cart/addscorecart',
	'score-index' =>  'index/cart/scoreindex',
	'addfav' =>  'index/user/addfav',
	'question' =>  'index/consult/question',
	'publish/:pid' => ['index/appraise/publish', ['ext' => 'html', 'method' => 'get'], ['pid' => '\d+']],
	'orders-add' =>  'index/orders/add',
	'orders-addscore' =>  'index/orders/addscore',
	'orders-index/:id' => ['index/orders/index', ['ext' => 'html', 'method' => 'get'], ['id' => '\d+']],
	'appraise-mod/:id' => ['index/appraise/mod', ['ext' => 'html', 'method' => 'get'], ['id' => '\d+']],
	'mod-appraise' => 'index/appraise/modappraise',
	'myconsult' => 'index/consult/index',
	'consult-mod/:id' => ['index/consult/mod', ['ext' => 'html', 'method' => 'get'], ['id' => '\d+']],
	'consult-del/:id' => ['index/consult/del', ['ext' => 'html', 'method' => 'post'], ['id' => '\d+']],
	'fav-del/:id' => ['index/fav/del', ['ext' => 'html', 'method' => 'post'], ['id' => '\d+']],
	'myprofav' =>  'index/fav/profav',
	'appraisetimes' =>  'index/user/appraisetimes',
	'pay-alipay' =>  'index/pay/pay_alipay',
	'listen' =>  'index/pay/listen',
	'myorders' =>  'index/orders/myorders',
	'myappraise' =>  'index/appraise/index',
	'mycomment' =>  'index/comment/index',
	'comment-del/:id' => ['index/comment/del', ['ext' => 'html', 'method' => 'post'], ['id' => '\d+']],
	'mynewsfav' =>  'index/fav/newsfav',
	'fav-newdel/:id' => ['index/fav/newdel', ['ext' => 'html', 'method' => 'post'], ['id' => '\d+']],
	'user-mod' => 'index/user/modinfo',
	'myletter' =>  'index/letter/index',
	'letter-detail/:id' => ['index/letter/detail', ['ext' => 'html', 'method' => 'get'], ['id' => '\d+']],
	'letter-reply/:id' => ['index/letter/reply', ['ext' => 'html', 'method' => 'get'], ['id' => '\d+']],
	'letter-del/:id' => ['index/letter/del', ['ext' => 'html', 'method' => 'post'], ['id' => '\d+']],
	'letter-reply' =>  'index/letter/reply',
	'privateletter' =>  'index/letter/privateletter',
	'mylottery' =>  'index/lottery/index',
	'getlottery' =>  'index/lottery/getlottery',
	'getresult' =>  'index/lottery/getresult',
	'lottery-mod' =>  'index/lottery/mod',
	'mylotterywin' =>  'index/lotterywin/index',
	'modlogo' =>  'index/user/modlogo',
	'myfriendmess' =>  'index/friend/message',
	'myfriend' =>  'index/friend/myfriend',
	'friend-detail/:id' => ['index/friend/detail', ['ext' => 'html', 'method' => 'get'], ['id' => '\d+']],
	'friend-del/:id' => ['index/friend/del', ['ext' => 'html', 'method' => 'post'], ['id' => '\d+']],
	'agreefriendmessage' =>  'index/friend/agreefriendmessage',
	
	
	'myorders-list/:payment_id/:pay_status/:order_status' => ['index/orders/myorders', ['ext' => 'html', 'method' => 'get'], ['payment_id' => '[A-Za-z0-9]+','pay_status' => '[A-Za-z0-9]+','order_status' => '[A-Za-z0-9]+']],
	'orders-detail/:id' => ['index/orders/detail', ['ext' => 'html', 'method' => 'get'], ['id' => '\d+']],
	'take-delivery/:id' => ['index/orders/takeDelivery', ['ext' => 'html', 'method' => 'post'], ['id' => '\d+']],
	
	
	'pcate/:id' => ['index/pcate/show', ['ext' => 'html', 'method' => 'get'], ['id' => '[A-Za-z0-9]+']],
	'news_<id>_<pid>_<mid>' => ['index/news/index', ['ext' => 'html', 'method' => 'get'], ['id' => '[A-Za-z0-9]+','pid' => '[A-Za-z0-9]+','mid' => '[A-Za-z0-9]+']],
	'newslist_<id>_<pid>_<mid>' => ['index/news/lists', ['ext' => 'html', 'method' => 'get'], ['id' => '[A-Za-z0-9]+','pid' => '[A-Za-z0-9]+','mid' => '[A-Za-z0-9]+']],
	'article_<id>_<pid>_<mid>' => ['index/news/article', ['ext' => 'html', 'method' => 'get'], ['id' => '[A-Za-z0-9]+','pid' => '[A-Za-z0-9]+','mid' => '[A-Za-z0-9]+']],
	'qrcode' =>  'index/qrcode/create',
	'ajaxlogin' =>  'index/user/ajaxlogin',
	'addcomment' =>  'index/news/addcomment',
	'commenttop' =>  'index/news/commenttop',
	'newsrec' =>  'index/news/recommand',
	'newsaddfav' =>  'index/news/addfav',
	'privateletter/:user_id' => ['index/letter/privateletter', ['ext' => 'html', 'method' => 'get'], ['user_id' => '\d+']],
	'friend/:user_id' => ['index/friend/index', ['ext' => 'html', 'method' => 'get'], ['user_id' => '\d+']],
	'sendfriend' =>  'index/friend/sendfriend',
];
