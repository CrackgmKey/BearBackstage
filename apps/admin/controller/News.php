<?php
// +----------------------------------------------------------------------
// | Leesuntech [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.leesuntech.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 李文 < 15919572@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\controller;

use app\admin\controller\AdminBase;
use think\Request;
use think\Db;
use app\common\model\News as NewsModel;
use app\common\model\Nav;
use app\common\model\Qiniu;
use Qiniu\Auth as Auth;
use Qiniu\Storage\BucketManager;
use Qiniu\Storage\UploadManager;

class News extends AdminBase
{
	protected $beforeActionList = [
       
        'checkUploadDir'  =>  ['only'=>'add,mod'],    //add,mod方法执行前先执行checkUploadDir方法
    ];
	public function _initialize(){
		parent::_initialize();
		
		$navModel=new Nav;
		$navDatas=$navModel->getNav(0,2);
		$nav_arr=[];
		foreach($navDatas['data'] as $k=>$v){
			$nav_arr[$k]=$v->getData();
			$nav_arr[$k]['go_url']=url('admin/news/index','id='.$v['id']);
			$sub=$navModel->getNav($nav_arr[$k]['id'],2);
			if($sub['data']){
				foreach($sub['data'] as $sk=>$sv){
					$nav_arr[$k]['sub'][$sk]=$sv->getData();
					$nav_arr[$k]['sub'][$sk]['go_url']=url('admin/news/index','id='.$sv['id']);
				}
				$nav_arr[$k]['has_sub']=1;
			} else {
				$nav_arr[$k]['has_sub']=0;
				$nav_arr[$k]['sub']=[];
			}
		}
		$this->assign("navDatas",$nav_arr);
	}
	
    public function index($id = ''){
		
		$model=new NewsModel;
		if($id){
			$datas=$model->getNews($id,$this->gl_config['admin_page_num']);
			$m=Nav::get($id);
			$currentData=$m->getData();
			$this->assign("currentName",$currentData['name']);
			
		} else {
			$datas=$model->getNews(0,$this->gl_config['admin_page_num']);
			$this->assign("currentName","请选择");
		}
		
		$newsarr=[];
		
		foreach($datas['data'] as $key=>$v){
			$d=$v->getData();
			$d['mod_url']=url('admin/news/mod','id='.$d['id']);
			$d['del_url']=url('admin/news/del','id='.$d['id']);
			
			$d['addtime']=$d['create_time']?$d['create_time']:'暂无';
			$d['uptime']=$d['update_time']?date("Y-m-d",$d['update_time']):'暂无';
			if($v->getNavName){
				$d['classname']=$v->getNavName->name;
			} else {
				$d['classname']='<span style="color:red">已无此分类</span>';
			}
			
			$newsarr[]=$d;
		}
		
		$this->assign("page",$datas['page']);
		$this->assign("datas",$newsarr);
		
        return $this->fetch();
    }
	
	public function batchRecommend($id = ''){
		$Model=new NewsModel();
		$value=$this->request->param('value');
		
		if($id){
			$updateData=array();
			foreach($id as $v){
				$updateData[]=['id'=>$v,'is_recommend'=>$value];
			}
			$res=$Model->saveAll($updateData);
			if($res!==false){
				$this->success("设置成功");
			} else {
				$this->error($this->getError());
			}
		} else {
			$this->error('没有选择数据');
		}
	}
	
	public function batchSort(){
		
		$Model=new NewsModel();
		parent::batchSorts($Model);
 		
	}
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			
			 // 数据验证
			$result = $this->validate($data,'News');
			if (true !== $result) {
				$this->error($result);
			}
			$up_dir=date("Ymd",time())."/";
			$thumb = $this->request->file('thumb');
			if (!empty($thumb)) {
				if(!$this->gl_config['is_qiniu']){
					$info = $thumb->rule("get_rand")->validate(['size'=>$this->gl_config['upload_size'],'ext'=>'jpg,png,gif'])->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
					if($info){
						$data['thumb']=$up_dir.$info->getFilename();
					} else {
						$this->error($thumb->getError());
					}
				} else {
					$qiniu=Qiniu::get(1);
					$auth = new Auth($qiniu->ACCESSKEY, $qiniu->SECRETKEY);
					$token = $auth->uploadToken($qiniu->BUCKET);
					// 初始化 UploadManager 对象并进行文件的上传
					$uploadMgr = new UploadManager();
					// 要上传图片的本地路径
					$filePath = $thumb->getRealPath();
					$ext = pathinfo($thumb->getInfo('name'), PATHINFO_EXTENSION);  //后缀
					// 上传到七牛后保存的文件名
					$key =substr(md5($filePath) , 0, 5). date('YmdHis') . rand(0, 9999) . '.' . $ext;
					// 调用 UploadManager 的 putFile 方法进行文件的上传
					list($ret, $err) = $uploadMgr->putFile($token, $key, $filePath);
					if ($err !== null) {
						$this->error($err);
					} else {
						//返回图片的完整URL
						$data['thumb']=$qiniu->DOMAIN.'/'.$ret['key'];
						$data['is_qiniu']=1;
					}
					
				}
			}
			$Model=new NewsModel;
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑成功",url('admin/news/index'));
			} else {
				$this->getError();
			}
		} else {
			
			$dataModel=NewsModel::get($id);
			$data=$dataModel->getData();
			if($dataModel->getNavName){
				$data['cate_cn']=$dataModel->getNavName->name;
			} else {
				$data['cate_cn']='已无此分类';
			}
			if(!$data['is_qiniu']){
				$data['thumb']=$this->request->root().'/public/uploads/'.$data['thumb'];
			} else {
				if(strpos($data['thumb'],'http://')){
					$data['thumb']=$data['thumb'];
				} else{
					$data['thumb']='http://'.$data['thumb'];
				}
				
			}
			$this->assign("data",$data);
			return $this->fetch();
		}
	}
	public function add(Request $request){
		
		if($this->request->isPost()){
		
			$data=$request->post();
			 // 数据验证
			$result = $this->validate($data,'News');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new NewsModel;
			$data['create_time']=time();
			
			$up_dir=date("Ymd",time())."/";
			$thumb = $request->file('thumb');
			if (!empty($thumb)) {
				if(!$this->gl_config['is_qiniu']){
					$info = $thumb->rule("get_rand")->validate(['size'=>$this->gl_config['upload_size'],'ext'=>'jpg,png,gif'])->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
					if($info){
						$data['thumb']=$up_dir.$info->getFilename();
					} else {
						$this->error($thumb->getError());
					}
				} else {
					$qiniu=Qiniu::get(1);
					$auth = new Auth($qiniu->ACCESSKEY, $qiniu->SECRETKEY);
					$token = $auth->uploadToken($qiniu->BUCKET);
					// 初始化 UploadManager 对象并进行文件的上传
					$uploadMgr = new UploadManager();
					// 要上传图片的本地路径
					$filePath = $thumb->getRealPath();
					$ext = pathinfo($thumb->getInfo('name'), PATHINFO_EXTENSION);  //后缀
					// 上传到七牛后保存的文件名
					$key =substr(md5($filePath) , 0, 5). date('YmdHis') . rand(0, 9999) . '.' . $ext;
					// 调用 UploadManager 的 putFile 方法进行文件的上传
					list($ret, $err) = $uploadMgr->putFile($token, $key, $filePath);
					if ($err !== null) {
						$this->error($err);
					} else {
						//返回图片的完整URL
						$data['thumb']=$qiniu->DOMAIN.'/'.$ret['key'];
						$data['is_qiniu']=1;
					}
					
				}
				
			}
			
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加成功",url('admin/news/index'));
			} else {
				$this->error("添加失败");
			}
		} else {
			
			
			$maxsort=NewsModel::order('sort desc')->value('sort');
			$this->assign("maxsort",$maxsort+1);
			
			return $this->fetch();
		}
		
	}
	
	public function del($id = ''){
		$Model=new NewsModel();
		parent::dels($id,$Model);
	}
	
	
	
}
