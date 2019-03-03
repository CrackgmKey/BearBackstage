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
use app\common\model\Brand as BrandModel;
use app\common\model\Nav;
use app\common\model\Qiniu;
use Qiniu\Auth as Auth;
use Qiniu\Storage\BucketManager;
use Qiniu\Storage\UploadManager;

class Brand extends AdminBase
{
	protected $beforeActionList = [
       
        'checkUploadDir'  =>  ['only'=>'add,mod'],    //add,mod方法执行前先执行checkUploadDir方法
    ];
	
	public function _initialize(){
		parent::_initialize();
		
		$navModel=new Nav;
		$navDatas=$navModel->getNav(0,1);
		$nav_arr=[];
		
		foreach($navDatas['data'] as $k=>$v){
			$nav_arr[$k]=$v->getData();
			$nav_arr[$k]['go_url']=url('admin/brand/index','id='.$v['id']);
			$sub=$navModel->getNav($nav_arr[$k]['id'],1);
			if($sub['data']){
				foreach($sub['data'] as $sk=>$sv){
					$nav_arr[$k]['sub'][$sk]=$sv->getData();
					$nav_arr[$k]['sub'][$sk]['go_url']=url('admin/brand/index','id='.$sv['id']);
				}
				$nav_arr[$k]['has_sub']=1;
			} else {
				$nav_arr[$k]['has_sub']=0;
				$nav_arr[$k]['sub']=[];
			}
		}
		$this->assign("navDatas",$nav_arr);
	}
	
    public function index($id = 0){
		
		$model=new BrandModel;
		$datas=$model->getBrand($id,$this->gl_config['admin_page_num']);
		$arr=array();
		
		if($id){
			$m=Nav::get($id);
			$currentData=$m->getData();
			$this->assign("currentName",$currentData['name']);
		} else {
			$this->assign("currentName","请选择");
		}
		
		foreach($datas['data'] as $key=>$v){
			$d=$v->getData();
			$d['mod_url']=url('admin/brand/mod','id='.$d['id']);
			$d['del_url']=url('admin/brand/del','id='.$d['id']);
			
			if($v->getNavName){
				$d['classname']=$v->getNavName->name;
			} else {
				$d['classname']='<span style="color:red">已无此分类</span>';
			}
			
			$arr[]=$d;
			
		} 
		
		$this->assign("page",$datas['page']);
		$this->assign("datas",$arr);
        return $this->fetch();
    }
	
	public function batchSort(){
		
		$Model=new BrandModel();
		parent::batchSorts($Model);
 		
	}
	
	
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			
			 // 数据验证
			$result = $this->validate($data,'Brand');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new BrandModel;
			
			$up_dir=date("Ymd",time())."/";
			$img = $this->request->file('img');
			if (!empty($img)) {
				
				if(!$this->gl_config['is_qiniu']){
					$info = $img->rule("get_rand")->validate(['size'=>$this->gl_config['upload_size'],'ext'=>'jpg,png,gif'])->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
					if($info){
						$data['img']=$up_dir.$info->getFilename();
					} else {
						$this->error($img->getError());
					}
				} else {
					$qiniu=Qiniu::get(1);
					$auth = new Auth($qiniu->ACCESSKEY, $qiniu->SECRETKEY);
					$token = $auth->uploadToken($qiniu->BUCKET);
					// 初始化 UploadManager 对象并进行文件的上传
					$uploadMgr = new UploadManager();
					// 要上传图片的本地路径
					$filePath = $img->getRealPath();
					$ext = pathinfo($img->getInfo('name'), PATHINFO_EXTENSION);  //后缀
					// 上传到七牛后保存的文件名
					$key =substr(md5($filePath) , 0, 5). date('YmdHis') . rand(0, 9999) . '.' . $ext;
					// 调用 UploadManager 的 putFile 方法进行文件的上传
					list($ret, $err) = $uploadMgr->putFile($token, $key, $filePath);
					if ($err !== null) {
						$this->error($err);
					} else {
						//返回图片的完整URL
						$data['img']=$qiniu->DOMAIN.'/'.$ret['key'];
						$data['is_qiniu']=1;
					}
					
				}
			}
			
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑成功",url('admin/brand/index'));
			} else {
				$this->error($this->getError());
			}
		} else {
			
			$dataModel=BrandModel::get($id);
			$data=$dataModel->getData();
			if($dataModel->getNavName){
				$data['cate_cn']=$dataModel->getNavName->name;
			} else {
				$data['cate_cn']='已无此分类';
			}
			if(!$data['is_qiniu']){
				$data['img']=$this->request->root().'/public/uploads/'.$data['img'];
			} else {
				if(strpos($data['img'],'http://')){
					$data['img']=$data['img'];
				} else{
					$data['img']='http://'.$data['img'];
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
			$result = $this->validate($data,'Brand');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new BrandModel;
			
			$up_dir=date("Ymd",time())."/";
			$img = $request->file('img');
			if (!empty($img)) {
				
				if(!$this->gl_config['is_qiniu']){
					$info = $img->rule("get_rand")->validate(['size'=>$this->gl_config['upload_size'],'ext'=>'jpg,png,gif'])->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
					if($info){
						$data['img']=$up_dir.$info->getFilename();
					} else {
						$this->error($img->getError());
					}
				} else {
					$qiniu=Qiniu::get(1);
					$auth = new Auth($qiniu->ACCESSKEY, $qiniu->SECRETKEY);
					$token = $auth->uploadToken($qiniu->BUCKET);
					// 初始化 UploadManager 对象并进行文件的上传
					$uploadMgr = new UploadManager();
					// 要上传图片的本地路径
					$filePath = $img->getRealPath();
					$ext = pathinfo($img->getInfo('name'), PATHINFO_EXTENSION);  //后缀
					// 上传到七牛后保存的文件名
					$key =substr(md5($filePath) , 0, 5). date('YmdHis') . rand(0, 9999) . '.' . $ext;
					// 调用 UploadManager 的 putFile 方法进行文件的上传
					list($ret, $err) = $uploadMgr->putFile($token, $key, $filePath);
					if ($err !== null) {
						$this->error($err);
					} else {
						//返回图片的完整URL
						$data['img']=$qiniu->DOMAIN.'/'.$ret['key'];
						$data['is_qiniu']=1;
					}
					
				}
			}
			
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加成功",url('admin/brand/index'));
			} else {
				$this->error("添加失败");
			}
		} else {
			
			$maxsort=BrandModel::order('sort desc')->value('sort');
			$this->assign("maxsort",$maxsort+1);
			return $this->fetch();
		}
		
	}
	
	public function del($id = ''){
		$Model=new BrandModel();
		parent::dels($id,$Model);
	}
	
	
	
}
