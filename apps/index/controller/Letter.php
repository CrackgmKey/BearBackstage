<?php
// +----------------------------------------------------------------------
// | Leesuntech [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.leesuntech.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 李文 <15919572@qq.com>
// +----------------------------------------------------------------------

namespace app\index\controller;
use app\index\controller\IndexBase;
use app\common\model\Letter as LetterModel;
use app\admin\model\User;
use app\common\model\Friend;
use think\Session;

class Letter extends IndexBase
{
	private $classname='';
	
	protected function _initialize(){
		parent::_initialize();
		$user=new User;
		if($user->isLogin()){
			$this->uid=Session::get('uid','index');
		} else {
			$this->redirect('index/user/login');
		}
	}
	
    public function index()
    {
		
		
		return $this->fetch('user/myletter');
    }
	
	public function privateLetter(){
		if($this->request->isPost()){
			$input=$this->request->param();
			$msg=[];
			$friend=new Friend;
			if($input['user_id']==$this->uid){
				$msg['code']=2;
				$msg['msg']="对不起，不能自己给自己发私信!";
				return json($msg);
				
			} elseif(!$input['user_id']){
				$msg['code']=2;
				$msg['msg']="不能给管理员发私信!";
				return json($msg);
			} elseif(!$friend->check($input['user_id'],$this->uid,1)){
				$msg['code']=2;
				$msg['msg']="对不起,还不是好友,不能发私信!";
				return json($msg);
			}else {
				$data['user_id']=$input['user_id'];
				$data['from_id']=$this->uid;
				$data['message']=$input['message'];
				$data['is_new']=1;
				$data['create_time']=time();
				$result=LetterModel::insert($data);
				if(false !== $result){
					$msg['code']=1;
					$msg['msg']="发送成功!";
					
				} else {
					$msg['code']=2;
					$msg['msg']="发送失败!";
				}
				return json($msg);
			}
			
		} else {
			$id=$this->request->param('user_id');
			$expression=$this->expression();
			$this->assign('expression',$expression['html']);
			$this->assign("id", $id);
			return $this->fetch('user/privateLetter');
		}
		
	}
	
	public function detail($id = 0)
    {
		LetterModel::update(['is_new'=>0,'id'=>$id]);
		if($this->request->isAjax()){
			return json(1);
		} else {
			$data=LetterModel::get($id);
			$data->message=$this->preg_message($data->message);
			$this->assign('data',$data);
			return $this->fetch('user/letter_detail');
		}
    }
	
	public function reply($id = 0){
		if($this->request->isPost()){
			$data=$this->request->param();
			$data['message']=htmlspecialchars($data['message']);
			$data['from_id']=$this->uid;
			$data['is_new']=1;
			$data['create_time']=time();
			$res=LetterModel::insert($data);
			
			if($res!==false){
				
				return json(1);
			} else {
				return json(2);
			}
		} else {
			$expression=$this->expression();
			$this->assign('expression',$expression['html']);
			$this->assign('id',$id);
			return $this->fetch('user/letterReply');
		}
		
	}
	
	
	
	public function del($id = 0){
		$res=LetterModel::where(['id'=>$id])->delete();
		if($res!==false){
			return json('1');
		} else {
			return json('2');
		}
	}
	
	
	private function expression(){
		$s = '"0","微笑"],["1","撇嘴"],["2","色"],["3","发呆"],["4","得意"],["5","流泪"],["6","害羞"],["7","闭嘴"],["8","睡"],["9","大哭"],["10","尴尬"],["11","发怒"],["12","调皮"],["13","呲牙"],["14","惊讶"],["15","难过"],["16","酷"],["17","冷汗"],["18","抓狂"],["19","吐"],["20","偷笑"],["21","可爱"],["22","白眼"],["23","傲慢"],["24","饥饿"],["25","困"],["26","惊恐"],["27","流汗"],["28","憨笑"],["29","大兵"],["30","奋斗"],["31","咒骂"],["32","疑问"],["33","嘘..."],["34","晕"],["35","折磨"],["36","衰"],["37","骷髅"],["38","敲打"],["39","再见"],["40","擦汗"],["41","抠鼻"],["42","鼓掌"],["43","糗大了"],["44","坏笑"],["45","左哼哼"],["46","右哼哼"],["47","哈欠"],["48","鄙视"],["49","委屈"],["50","快哭了"],["51","阴险"],["52","亲亲"],["53","吓"],["54","可怜"],["55","菜刀"],["56","西瓜"],["57","啤酒"],["58","篮球"],["59","乒乓"],["60","咖啡"],["61","饭"],["62","猪头"],["63","玫瑰"],["64","凋谢"],["65","示爱"],["66","爱心"],["67","心碎"],["68","蛋糕"],["69","闪电"],["70","炸弹"],["71","刀"],["72","足球"],["73","瓢虫"],["74","便便"],["75","月亮"],["76","太阳"],["77","礼物"],["78","拥抱"],["79","强"],["80","弱"],["81","握手"],["82","胜利"],["83","抱拳"],["84","勾引"],["85","拳头"],["86","差劲"],["87","爱你"],["88","NO"],["89","OK"],["90","爱情"],["91","飞吻"],["92","跳跳"],["93","发抖"],["94","怄火"],["95","转圈"],["96","磕头"],["97","回头"],["98","跳绳"],["99","挥手"],["100","激动"],["101","街舞"],["102","献吻"],["103","左太极"],["104","右太极"';
		$a = explode('],[', $s);
		$html="<div class='qq_expression'><ul>";
		foreach($a as $v) {
			$b = explode(',', $v);
			$vv = str_replace('"', '', $b[0]);
			$f = 'http://res.mail.qq.com/zh_CN/images/mo/DEFAULT2/' . $vv . '.gif';
			$img_html='[exp]'.$b[1].'[/exp]';
			$html.="<li class='expression left' id='".$img_html."' style='cursor:pointer'><img src='".$f."' title=".$b[1]." /></li>";
		}
		
		$html.="</ul></div>";
		$datas=array("value"=>$a,"html"=>$html);
		return $datas;
	}
		
	private function preg_message($message){
		$pa = '/\[exp\](.*?)\[\/exp\]/';
		preg_match_all($pa,$message,$match);
		foreach($match as $kk=>$vv){
			foreach($vv as $k=>$v){
				if($kk){
					$v=str_replace('"','',$v);
					$exp_num=$this->get_exp_num($v);
					$html="<img src='http://res.mail.qq.com/zh_CN/images/mo/DEFAULT2/".$exp_num.".gif' />";
					$message=str_replace($match[0][$k],$html,$message);
				}
			}
		}
		return $message;
	}
	
	private function get_exp_num($str){
			$exp_datas=expression();
			foreach($exp_datas['value'] as $v) {
				$v=str_replace('"','',$v);
				$b = explode(',', $v);
				if($str==$b[1]){
					$vv = str_replace('"', '', $b[0]);
					return $vv;
					
				}
			}
		}
}
