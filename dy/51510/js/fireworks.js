var canvas = document.getElementById("fireworks");
var ocas = document.createElement("canvas");
var octx = ocas.getContext("2d");
var ctx = canvas.getContext("2d");
ocas.width = canvas.width = window.innerWidth;
//ocas.height = canvas.height = window.innerHeight;
ocas.height = canvas.height = 816;
var bigbooms = [];

window.onload = function(){
	initAnimate()
}

function initAnimate(){
	//drawBg();
	lastTime = new Date();
	animate();
}

var lastTime;
function animate(){
	ctx.save();
//			ctx.fillStyle = "rgba(255,76,14,.1)";
	ctx.fillStyle = "rgba(238,92,87,.1)";
	ctx.fillRect(0,0,canvas.width,canvas.height);
	ctx.restore();


	var newTime = new Date();
    if(newTime-lastTime>500+(window.innerHeight-767)/2){
		var random = Math.random()*100>2?true:false;
		var x = getRandom(canvas.width/5 , canvas.width*4/5);
		var y = getRandom(50 , 200);
		if(random){
			var bigboom = new Boom(getRandom(canvas.width/3,canvas.width*2/3) ,2,"red" , {x:x , y:y});
			bigbooms.push(bigboom)
		}
		lastTime = newTime;
//				console.log(bigbooms)
	}

	stars.foreach(function(){
		this.paint();
	})
	
	bigbooms.foreach(function(index){
		var that = this;
		if(!this.dead){
			this._move();
			this._drawLight();
		}
		else{
			this.booms.foreach(function(index){
				if(!this.dead) {
					this.moveTo(index);
				}
				else if(index === that.booms.length-1){
					bigbooms[bigbooms.indexOf(that)] = null;
				}
			})
		}
	});
	
	raf(animate);
}

Array.prototype.foreach = function(callback){
	for(var i=0;i<this.length;i++){
		if(this[i]!==null) callback.apply(this[i] , [i])
	}
}

var raf = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function (callback) { window.setTimeout(callback, 1000 / 60); };

canvas.onclick = function(){
	var x = event.clientX;
	var y = event.clientY;
	var bigboom = new Boom(getRandom(canvas.width/3,canvas.width*2/3) ,2,"#FFF" , {x:x , y:y});
	bigbooms.push(bigboom)
}

var Boom = function(x,r,c,boomArea,shape){
	this.booms = [];
	this.x = x;
	this.y = (canvas.height+r);
	this.r = r;
	this.c = c;
	this.shape = shape || false;
	this.boomArea = boomArea;
	this.theta = 0;
	this.dead = false;
	this.ba = parseInt(getRandom(80 , 200));
}
Boom.prototype = {
	_paint:function(){
		ctx.save();
		ctx.beginPath();
		ctx.arc(this.x,this.y,this.r,0,2*Math.PI);
		ctx.fillStyle = this.c;
		ctx.fill();
		ctx.restore();
	},
	_move:function(){
		var dx = this.boomArea.x - this.x , dy = this.boomArea.y - this.y;
		this.x = this.x+dx*0.01;//速度
		this.y = this.y+dy*0.01;//速度

		if(Math.abs(dx)<=this.ba && Math.abs(dy)<=this.ba){
			this._boom();
			this.dead = true;
		}
		else {
			this._paint();
		}
	},
	_drawLight:function(){
		ctx.save();
		ctx.fillStyle = "rgba(255,228,150,.2)";
		ctx.beginPath();
		ctx.arc(this.x , this.y , this.r+3*Math.random()+1 , 0 , 2*Math.PI);
		ctx.fill();
		ctx.restore();
	},
	_boom:function(){
		var fragNum = getRandom(30 , 200);
		var style = getRandom(0,30)>=5? 1 : 2;
		var color;
		if(style===1){
			color = {
				a:parseInt(getRandom(100,230)),
				b:parseInt(getRandom(100,230)),
				c:parseInt(getRandom(100,230))
			}
		}

		var fanwei = parseInt(getRandom(300, 400));
		for(var i=0;i<fragNum;i++){
			if(style===2){
				color = {
					a:parseInt(getRandom(100,230)),
					b:parseInt(getRandom(100,230)),
					c:parseInt(getRandom(100,230))
				}
			}
			var a = getRandom(-Math.PI, Math.PI);
			var x = getRandom(0, fanwei) * Math.cos(a) + this.x;//花瓣方向
			var y = getRandom(0, fanwei) * Math.sin(a) + this.y; //花瓣方向
			var radius = getRandom(0 , 3)//烟花花瓣大小
			var frag = new Frag(this.x , this.y , radius , color , x , y );
			this.booms.push(frag);
		}
	}
}

function getRandom(a , b){
	return Math.random()*(b-a)+a;
}

var maxRadius = 1 , stars=[];
//		function drawBg(){//背景星星点点
//			for(var i=0;i<10;i++){
//				var r = Math.random()*maxRadius;
//				var x = Math.random()*canvas.width;
//				var y = Math.random()*2*canvas.height - canvas.height;
//				var star = new Star(x , y , r);
//				stars.push(star);
//				star.paint()
//			}
//
//		}

var Star = function(x,y,r){
	this.x = x;this.y=y;this.r=r;
}
Star.prototype = {
	paint:function(){
		ctx.save();
		ctx.beginPath();
		ctx.arc(this.x , this.y , this.r , 0 , 2*Math.PI);
		ctx.fillStyle = "rgba(255,255,255,"+this.r+")";
		ctx.fill();
		ctx.restore();
	}
}

var focallength = 250;
var Frag = function(centerX , centerY , radius , color ,tx , ty){
	this.tx = tx;
	this.ty = ty;
	this.x = centerX;
	this.y = centerY;
	this.dead = false;
	this.centerX = centerX;
	this.centerY = centerY;
	this.radius = radius;
	this.color = color;
}

Frag.prototype = {
	paint:function(){
		ctx.save();
		ctx.beginPath();
		ctx.arc(this.x , this.y , this.radius , 0 , 2*Math.PI);
		ctx.fillStyle = "rgba("+this.color.a+","+this.color.b+","+this.color.c+",.8)";
		ctx.fill()
		ctx.restore();
	},
	moveTo:function(index){
		this.ty = this.ty+.5;//花瓣下落程度
		var dx = this.tx - this.x , dy = this.ty - this.y;
		this.x = Math.abs(dx)<0.08 ? this.tx : (this.x+dx*0.08);
		this.y = Math.abs(dy)<0.08 ? this.ty : (this.y+dy*0.08);
		if(dx===0 && Math.abs(dy)<=80){
			this.dead = true;
		}
		this.paint();
	}
}