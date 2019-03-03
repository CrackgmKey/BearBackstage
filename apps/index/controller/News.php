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
use app\common\model\Nav;
use app\common\model\News as NewsModel;
use app\admin\model\User;
use app\common\model\Comment;
use app\common\model\Hotword;
use app\admin\model\Module;

class News extends IndexBase
{
	private $classname='';
	
	protected function _initialize(){
		parent::_initialize();
		$mid=$this->request->param('mid');
		$this->classname=Module::where(['id'=>$mid])->value('classname');
	}
    public function index()
    {
		
		
		return $this->fetch($this->classname);
    }
	
	public function search($keywords='')
    {
		
		if($this->request->isPost()){
			
			$id=Hotword::where(['keyword'=>$keywords,'type'=>2])->value('id');
			if($id){
				Hotword::where('id',$id)->setInc('times');
			}
			return $this->redirect('search',array('keywords'=>urlencode($keywords)));  
		} else{
			clert_temp_cache();
			$this->assign('keywords',$keywords);
			return $this->fetch();
		}
		
		
    }
	
	public function recommand(){
		$data=$this->request->param();
		if($data['status']){
			$res=NewsModel::where('id',$data['article_id'])->setInc('recommand');
		} else {
			$res=NewsModel::where('id',$data['article_id'])->setDec('recommand');
		}
		if($res){
			return true;
		} else {
			return false;
		}
	}
	
	public function addFav(){
		$data=$this->request->param();
		$user=new User;
		if(!$user->isLogin()){
			if($this->request->isAjax()){
				return json(['code'=>2,'msg'=>'未登录会员']);
			} else {
				$this->redirect('index/user/login');
			}
		} 
		if($data['status']){
			$res=db('fav')->insert(['article_id'=>$data['article_id'],'user_id'=>$data['user_id']]);
		} else {
			$res=db('fav')->where(['article_id'=>$data['article_id'],'user_id'=>$data['user_id']])->delete();
		}
		if($res){
			return true;
		} else {
			return false;
		}
	}
	
	public function addComment(){
		$data=$this->request->param();
		$user=new User;
		$comment=new Comment;
		if(!$user->isLogin()){
			if($this->request->isAjax()){
				return json(['code'=>2,'msg'=>'未登录会员']);
			} else {
				$this->redirect('index/user/login');
			}
		} 
		$data['user_id']=$this->uid;
		$data['create_time']=time();
		$res=$comment->allowField(true)->save($data);
		if($res){
			return json(['code'=>1,'msg'=>'评论成功']);
		} else {
			return json(['code'=>2,'msg'=>'评论失败']);
		}
	}
	
	public function commentTop(){
		$data=$this->request->param();
		
		if($data['status']){
			$res=Comment::where('id',$data['id'])->setInc('top');
		} else {
			$res=Comment::where('id',$data['id'])->setDec('top');
		}
		if($res){
			return true;
		} else {
			return false;
		}
	}
	public function lists()
    {
		return $this->fetch($this->classname.'_list');
    }
	
	public function article($id='',$pid='',$mid='')
    {
		$url='http://'.$_SERVER['SERVER_NAME'].url('index/news/article',['id'=>$id,'pid'=>$pid,'mid'=>$mid]);
		
		$this->assign('url',$url);
		$url=str_replace('/','=',$url);
		$url=str_replace('.html','',$url);
		if($this->gl_config['is_html']){
			$url=$url.'@html';
		}
		$img=url('index/qrcode/create',['value'=>$url,'size'=>200]);
		$this->assign('qrcode',$img);
		
		return $this->fetch($this->classname.'_article');
    }
}
