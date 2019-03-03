/*******js********/

	//好友数据
	var friend = [
		{'name':'小猫咪','img':'image/head_1.png'},
		{'name':'过年好','img':'image/head_2.png'},
		{'name':'小猫咪','img':'image/head_1.png'},
		{'name':'过年好','img':'image/head_2.png'},
		{'name':'小猫咪','img':'image/head_1.png'},
		{'name':'过年好','img':'image/head_2.png'},
		{'name':'小猫咪','img':'image/head_1.png'},
		{'name':'过年好','img':'image/head_2.png'},
		{'name':'小猫咪','img':'image/head_1.png'},
		{'name':'过年好','img':'image/head_2.png'},
		{'name':'小猫咪','img':'image/head_1.png'},
		{'name':'过年好','img':'image/head_2.png'},
		{'name':'小猫咪','img':'image/head_1.png'},
		{'name':'过年好','img':'image/head_2.png'},
		{'name':'小猫咪','img':'image/head_1.png'},
		{'name':'过年好','img':'image/head_2.png'},
		{'name':'小猫咪','img':'image/head_1.png'},
		{'name':'过年好','img':'image/head_2.png'},
		{'name':'小猫咪','img':'image/head_1.png'},
		{'name':'过年好','img':'image/head_2.png'},
		{'name':'小猫咪','img':'image/head_1.png'},
		{'name':'过年好','img':'image/head_2.png'}
	];
	
	var cont ='';
		cont +='<ul>';
		for(var i=0;i<friend.length;i++){
			cont +='<li><a href="javascript:void(0)" class="headimg"><img src="'+friend[i].img+'" /></a><span>'+friend[i].name+'</span></li>'
		}
		cont +='</ul>';


	$(document).on('click','.btns .__history__',function(){
		layer.open({
		    title: '好友助力榜单'
		    ,content: cont
		});
	});


	//点击驱赶按钮执行事件
	var __hit__ = document.getElementsByClassName('__hit__')[0];

	var $pao = document.getElementById('__box__');

	var __click__ = true;

	var __nian__src__ = 'image/nianshou.png';
	var __nian__cry__src__ = 'image/nianshou_cry.png';
	var __bao__zha__ = 'image/baozha.png';
	var __none__ = '';
    __hit__.onclick = function (evt) {
		// console.log(evt.pageX,evt.pageY)
		if(__click__){
			document.getElementById('__box__').style.display = 'block';
			$pao.style.top = evt.pageY+'px';
			$pao.style.left = evt.pageX+'px';
			$pao.style.transition = 'left 0s, top 0s';
			$pao.className = '_state_rotate_';
			var __nian__ = document.getElementsByClassName('__nian')[0];
			setTimeout(()=>{
				$pao.style.top = __nian__.offsetTop +'px';
				$pao.style.left = '350px';
				$pao.style.transition = 'left 1s linear, top 1s ease-in';
				var __nian__img__ = __nian__.childNodes[1];
				var timeId= setTimeout(()=>{
					__nian__img__.src = __nian__cry__src__;
					$pao.className = '__explosion__';
					document.getElementById('__pao__img__').src = __bao__zha__;
					__cry_hidden__();
				},1000);
				function __cry_hidden__(){
					setTimeout(()=>{
						__hit__.innerHTML = '已驱赶';
//						__nian__img__.src = __nian__src__;
						document.getElementById('__box__').style.display = 'none';
					},1000);
				}
				__click__ = false;
			}, 20)
		}else{
			layer.open({
				content: '您已经驱赶一次了，快请您的好友帮您驱赶吧',
				btn:'我知道了',
				yes:function(){
					layer.closeAll();
					__alert__show__();
				}
			});
		}
	}

	//点击分享分享按钮 邀请等按钮事件
	var __alert__btn__ = document.getElementById('__share__btn__');
	var __alert__ = document.getElementById('__invision__alert__c__');
	var __close__btn__ = document.getElementById('__close__btn__');
	
	__alert__btn__.onclick = function(){
		__alert__show__();
	}

	__close__btn__.onclick = function(){
		__alert__hide__();
	}

	function __alert__show__(){
		__alert__.className ='__invision__alert__ __state__alert__show__';
	}

	function __alert__hide__(){
		__alert__.className='__invision__alert__';	
	}


	//获取手机验证码
	var InterValObj; //timer变量，控制时间
	var count = 60; //间隔函数，1秒执行
	var curCount;//当前剩余秒数

	function sendMessage() {
	  　curCount = count;
	　　//设置button效果，开始计时
		 $("#__the__code__").attr("disabled", "true");
		 $("#__the__code__").html("" + curCount + "秒");
		 InterValObj = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
		 var dealType ="";
		 var uid = "";
		 var code = "";
	　　  //向后台发送处理数据
		 $.ajax({
		 　　type: "POST", //用POST方式传输
		 　　dataType: "JSON", //数据格式:JSON
		 　　url: '', //目标地址
		　　 data: "dealType=" + dealType +"&uid=" + uid + "&code=" + code,
		　　 error: function (data) { },
		 　　success: function (msg){ }
		 });
	}
	
	//timer处理函数
	function SetRemainTime() {
		if (curCount == 0) {                
			window.clearInterval(InterValObj);//停止计时器
			$("#__the__code__").removeAttr("disabled");//启用按钮
			$("#__the__code__").html("重新获取").css({"background-color":"#a82725"});
		}
		else {
			curCount--;
			$("#__the__code__").html("" + curCount + "秒").css({"background-color":"#D1D4D3"});
		}
	}
	

	var __phone__ = document.getElementById('__number__');	
	function __telphone(){
		var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
		if(!myreg.test(__phone__.value)) 
		{ 
			__layertest('请输入有效的手机号码');
			__phone__.className = '__error';
		    return false;
		}else{
			__phone__.className = '';
		}
	}
	__phone__.onblur = function(){
		__telphone();		
	}
	
	//code 验证
	var __the__code = document.getElementById('__the__code__input__');
	function __code_test(){
		if(__the__code.value==''){
			__layertest('验证码不能为空');
			__the__code.className = '__error';
		}else{
			__the__code.className = '';
		}
	}
	__the__code.onblur = function(){
		__code_test();
	}
	
	// layer modal
	function __layertest(content){
		layer.open({
		    content: content
		    ,btn: '我知道了'
		});
	}
	
	// update btn click
	//点击提交按钮事件
	var __update__ = document.getElementById('__update___');
	var __test__alert__ = document.getElementById('__test__alert__c__');
	__update__.onclick = function(){
		if($('.__error').length >0){
			__layertest('请您填写正确的资料')
		}else{
			__test__alert__.className = '__test__alert__';
		}
	}
	




	//gift click
	var __whole__ = document.getElementById('__whole');
	var __box__box__ = document.getElementById('__gift__box__');
	var __gift__img___ = document.getElementById('__gift__img');
	var __gift__title___ = document.getElementById('__gift__title__');
	var __gifts__gift__ = document.getElementById('__gifts__');
	var __gift__close = document.getElementById('__gift__close');
	var __num__ = true;
	__box__box__.onclick = function(){
		if(__num__) __gift__();
		__num__ = false;
	}
	

	 var gitf_ = [
	 	{one:'apple pro一台',gift_img:'image/1.png'},
	 	{one:'iphoneX一台',gift_img:'image/2.png'},
	 	{one:'现金666元',gift_img:'image/3.png'},
	 	{one:'铅笔盒一个',gift_img:'image/4.png'}
	 ];
	 function __gift__() {
	 	var rand = Math.random();
	 	if (rand < .1){
	 		__gift__img___.src = gitf_[0].gift_img;
	 		__gift__title___.innerHTML = gitf_[0].one;
	 	}else if (rand < .2){
	 		__gift__img___.src = gitf_[1].gift_img;
	 		__gift__title___.innerHTML = gitf_[1].one;
	 	}else if (rand < .3){
	 		__gift__img___.src = gitf_[2].gift_img;
	 		__gift__title___.innerHTML = gitf_[2].one;
	 	}else{
	 		__gift__img___.src = gitf_[3].gift_img;
	 		__gift__title___.innerHTML = gitf_[3].one;
	 	}
	 		
	 	__whole__.className = '_gift_box_ __state__gifts___ __state__gift__';
	}
	 
	 
	__gift__close.onclick = function(){
		__whole__.className = '_gift_box_ __state__gift__';
	}
