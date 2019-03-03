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
use app\admin\model\User as UserModel;
use app\admin\model\Group;
use app\common\model\Profav;
use app\common\model\Appraise;
use app\common\model\Comment;
use app\common\model\Mails;
use think\captcha\Captcha;
use think\config;
use think\Request;
use think\Session;
use think\Validate;

class User extends IndexBase
{
	protected $beforeActionList = [
        
        'checkLogin'  =>  ['except'=>'login,ajaxlogin,reg,getcaptcha'],
    ];
	
	protected function checkLogin(){
		
		$user=new UserModel;
		if($user->isLogin()){
			
			$this->uid=Session::get('uid','index');
		} else {
			$this->redirect('index/user/login');
		}
	}
	
    public function index()
    {
		
		$profav=Profav::where(['user_id'=>$this->uid])->value('id');
		$appraise=Appraise::where(['uid'=>$this->uid,'is_reply'=>1])->order('reply_time desc')->value('id');
		$comment=Comment::where(['user_id'=>$this->uid])->order('create_time desc')->value('id');
		$this->assign('profav',$profav);
		$this->assign('appraise',$appraise);
		$this->assign('comment',$comment);
		return $this->fetch();
    }
	public function modLogo(Request $request){
		if($request->isAjax()){
			$data=$request->get();
			$src = ROOT_PATH . 'public' . DS . 'uploads'.DS.$data['src'];
			$crop = new \crop\Crop();
			$crop->initialize($src, $src, $data['x'], $data['y'], 161, 161, $data['w'], $data['h']);
			$success = $crop->generate_shot();
			
			if($success){
				return json('1');
			} else {
				return json('2');
			}
			
		} else {
			return $this->fetch('user/modlogo');
		}
		
	}
	public function login(){
		if($this->uid){
			$this->redirect('index/user/index');
		}
		if($this->request->isPost()){
			$data=$this->request->post();
		
			$rule = [
				'user_name'  => 'require',
				'password'   => 'require',
				'captcha' => 'require',
			];

			$msg = [
				'user_name.require' => '请填写用户名',
				'password.require'     => '请填写密码',
				'captcha.require'   => '请填写验证码',
			];
			$validate = new Validate($rule, $msg);
			$result   = $validate->batch()->check($data);
			
			if(!$result){
				return json($validate->getError());
			}
			$captcha = new Captcha();
			if (!$captcha->check($data['captcha'])) {
			   return json('2');
			}
			$model=new UserModel;
			if($uid=$model->login($data['user_name'],md5($data['password']))){
				UserModel::where('id',$uid)->update(['log_time'  => time()]);
				return json('1');
			} else {
				return json('3');
			}
			
		
		} else {
			return $this->fetch();
		}
	}
	
	public function ajaxLogin(){
		if($this->request->isPost()){
			$data=$this->request->post();
			$rule = [
				'user_name'  => 'require',
				'password'   => 'require',
			];

			$msg = [
				'user_name.require' => '请填写用户名',
				'password.require'     => '请填写密码',
			];
			$validate = new Validate($rule, $msg);
			$result   = $validate->batch()->check($data);
			
			if(!$result){
				return json($validate->getError());
			}
			$model=new UserModel;
			if($uid=$model->login($data['user_name'],md5($data['password']))){
				UserModel::where('id',$uid)->update(['log_time'  => time()]);
				return json('1');
			} else {
				return json('3');
			}
		} else {
			return $this->fetch('user/ajaxlogin');
		}
		
	}
	
	public function modphoto(){
		$userModel=new UserModel;
		$up_dir=date("Ymd",time())."/";
		$photo = $this->request->file('photo');
		
		if (!empty($photo)) {
			$info = $photo->rule("get_rand")->validate(['size'=>$this->gl_config['upload_size'],'ext'=>'jpg,png,gif,bmp,jpeg'])->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
			if($info){
				$photoData['photo']=$up_dir.$info->getFilename();
			} else {
				$result['msg']=$photo->getError();
				$result['photo']='';
				return json($result);
			}
		}
		$photoData['id']=$this->uid;
		$res=$userModel->isUpdate(true)->save($photoData);
		
		if($res!==false){
			$result['msg']='保存成功';
			$result['photo']=$photoData['photo'];
			return json($result);
		} else {
			return json($this->getError());
		}
	}
	
	
	public function modInfo(){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			 // 数据验证
			
			$msg=[];
			$result = $this->validate($data,'ModUser');
			if(is_array($result)){
				return json($result);
			}
			
			$up_dir=date("Ymd",time())."/";
			$photo = $this->request->file('photo');
			
			if ($photo) {
				
				$info = $photo->rule("get_rand")->validate(['size'=>$this->gl_config['upload_size'],'ext'=>'jpg,png,gif'])->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
				if($info){
					$data['photo']=$up_dir.$info->getFilename();
				} else {
					$msg['code']=3;
					$msg['msg']=$photo->getError();
					return json($msg);
				}
			} else {
				unset($data['photo']);
			}
			if($data['password']){
				$data['password']=md5($data['password']);
			} else {
				unset($data['password']);
			}
			
			$Model=new UserModel;
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$msg['code']=1;
				$msg['msg']="修改成功";
				return json($msg);
			} else {
				$msg['code']=2;
				$msg['msg']="修改失败";
				return json($msg);
			}
		} else {
			$data=UserModel::get(['id'=>$this->uid]);
			$this->assign('data',$data);
			return $this->fetch('user/modinfo');
		}
	}
	
	public function myLetter(){
		return $this->fetch();
	}
	
	public function addFav($pid='',$user_id=''){
		$data['pid']=$pid;
		$data['user_id']=$user_id;
		$id=db('profav')->where(['pid'=>$pid,'user_id'=>$user_id])->value('id');
		if($id){
			return json('3');
		}
		$res=db('profav')->insert($data);
		if($res!=false){
			return json('1');
		} else {
			return json('2');
		}
	}
	
	public function appraisetimes($id=''){
		$data=db('appraisetimes')->where(['pid'=>$id,'uid'=>$this->uid])->find();
		if(!$data){
			$data['times']=0;
		}
		
		return json($data);
	}
	
	public function reg()
    {
		
		if($this->request->isPost()){
			$data=$this->request->post();
			 // 数据验证
			$result = $this->validate($data,'User');
			if(is_array($result)){
				return json($result);
			} 
			unset($data['confirm_pass']);
			$group=Group::get(['is_default'=>1]);
			$data['group_id']=$group['id'];
			$data['score']=$group['score'];
			$password=$data['password'];
			$data['password']=md5($data['password']);
			$data['ran_code']=get_rand();
			$data['reg_time']=time();
			
			$Model=new UserModel;
			
			$res=$Model->save($data);
			if($res!==false){
				$Model->login($data['user_name'],$data['password']);
				$this->uid=$Model->id;
				//send email
				$mail=new Mails;
				$mail->sendByRules($this->uid,'set_reg',$password);
				return json("1");
			} else {
				return json("2");
			}
		} else {
			return $this->fetch();
		}
    }
	
	public function getCaptcha($id = "")
    {
        $captcha = new Captcha((array)Config::get('captcha'));
        return $captcha->entry($id);
    }
	
	public function logout(){
		Session::clear('index');
		$this->redirect('index/index/index');
	}
	
	
	
}
