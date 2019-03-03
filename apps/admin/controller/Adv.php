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
use app\admin\model\Acate;
use app\common\model\Adv as AdvModel;
use app\common\model\Qiniu;
use Qiniu\Auth as Auth;
use Qiniu\Storage\BucketManager;
use Qiniu\Storage\UploadManager;

class Adv extends AdminBase
{
	
	protected $beforeActionList = [
       
        'checkUploadDir'  =>  ['only'=>'add,mod'],    //add,mod方法执行前先执行checkUploadDir方法
    ];
    
	
	
	public function index($id = ''){
		
		$model=new AdvModel;
		
		if($id){
			$datas=$model->getAdv($id,$this->gl_config['admin_page_num']);
			$m=Acate::get($id);
			$currentData=$m->getData();
			$this->assign("currentName",$currentData['name']);
			
		} else {
			$datas=$model->getAdv(0,$this->gl_config['admin_page_num']);
			$this->assign("currentName","请选择");
		}
		$acateData=[];
		$acate=Acate::all();
		foreach($acate as $k=>$v){
			$acateData[$k]=$v->getData();
			$acateData[$k]['go_url']=url('admin/adv/index','id='.$v['id']);
		}
		$advArr=[];
		
		
		
		foreach($datas['data'] as $key=>$v){
			$d=$v->getData();
			$d['mod_url']=url('admin/adv/mod','id='.$d['id']);
			$d['del_url']=url('admin/adv/del','id='.$d['id']);
			if(!$v['is_qiniu']){
				if($v['pic']){
					$d[$k]['pic']=Request::instance()->root().'/public/uploads/'.$v['pic'];
				}
				
			} else {
				if(strpos($v['pic'],'http://')){
					$d[$k]['pic']=$v['pic'];
				} else{
					$d[$k]['pic']='http://'.$v['pic'];
				}
				
			}
			if($v->getCateName){
				$d['classname']=$v->getCateName->name;
			} else {
				$d['classname']='<span style="color:red">已无此分类</span>';
			}
			
			
			$advArr[]=$d;
		}
		
		
		$this->assign("page",$datas['page']);
		$this->assign("datas",$advArr);
		$this->assign("acateData",$acateData);
		
        return $this->fetch();
    }
	
	
	
	
	public function batchSort(){
		
		$Model=new AdvModel();
		parent::batchSorts($Model);
 		
	}
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			 // 数据验证
			$result = $this->validate($data,'Adv');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new AdvModel;
			$up_dir=date("Ymd",time())."/";
			$pic = $this->request->file('pic');
			if (!empty($pic)) {
				if(!$this->gl_config['is_qiniu']){
					$info = $pic->rule("get_rand")->validate(['size'=>$this->gl_config['upload_size'],'ext'=>'jpg,png,gif'])->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
					if($info){
						$data['pic']=$up_dir.$info->getFilename();
					} else {
						$this->error($pic->getError());
					}
				} else {
					$qiniu=Qiniu::get(1);
					$auth = new Auth($qiniu->ACCESSKEY, $qiniu->SECRETKEY);
					$token = $auth->uploadToken($qiniu->BUCKET);
					// 初始化 UploadManager 对象并进行文件的上传
					$uploadMgr = new UploadManager();
					// 要上传图片的本地路径
					$filePath = $pic->getRealPath();
					$ext = pathinfo($pic->getInfo('name'), PATHINFO_EXTENSION);  //后缀
					// 上传到七牛后保存的文件名
					$key =substr(md5($filePath) , 0, 5). date('YmdHis') . rand(0, 9999) . '.' . $ext;
					// 调用 UploadManager 的 putFile 方法进行文件的上传
					list($ret, $err) = $uploadMgr->putFile($token, $key, $filePath);
					if ($err !== null) {
						$this->error($err);
					} else {
						//返回图片的完整URL
						$data['pic']=$qiniu->DOMAIN.'/'.$ret['key'];
						$data['is_qiniu']=1;
					}
					
				}
			}
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑成功",url('admin/adv/index'));
			} else {
				$this->error($this->getError());
			}
		} else {
			
			$acateData=Acate::all();
			$dataModel=AdvModel::get($id);
			$data=$dataModel->getData();
			$data['cate_cn']=$dataModel->getCateName->name;
			
			if(!$data['is_qiniu']){
				$data['pic']=$this->request->root().'/public/uploads/'.$data['pic'];
			} else {
				if(strpos($data['pic'],'http://')){
					$data['pic']=$data['pic'];
				} else{
					$data['pic']='http://'.$data['pic'];
				}
				
			}
			$this->assign("data",$data);
			$this->assign("acateData",$acateData);
			return $this->fetch();
		}
	}
	public function add(Request $request){
		
		if($this->request->isPost()){
		
			$data=$request->post();
			 // 数据验证
			$result = $this->validate($data,'Adv');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new AdvModel;
			
			$up_dir=date("Ymd",time())."/";
			$pic = $this->request->file('pic');
			if (!empty($pic)) {
				if(!$this->gl_config['is_qiniu']){
					$info = $pic->rule("get_rand")->validate(['size'=>$this->gl_config['upload_size'],'ext'=>'jpg,png,gif'])->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
					if($info){
						$data['pic']=$up_dir.$info->getFilename();
					} else {
						$this->error($pic->getError());
					}
				} else {
					$qiniu=Qiniu::get(1);
					$auth = new Auth($qiniu->ACCESSKEY, $qiniu->SECRETKEY);
					$token = $auth->uploadToken($qiniu->BUCKET);
					// 初始化 UploadManager 对象并进行文件的上传
					$uploadMgr = new UploadManager();
					// 要上传图片的本地路径
					$filePath = $pic->getRealPath();
					$ext = pathinfo($pic->getInfo('name'), PATHINFO_EXTENSION);  //后缀
					// 上传到七牛后保存的文件名
					$key =substr(md5($filePath) , 0, 5). date('YmdHis') . rand(0, 9999) . '.' . $ext;
					// 调用 UploadManager 的 putFile 方法进行文件的上传
					list($ret, $err) = $uploadMgr->putFile($token, $key, $filePath);
					if ($err !== null) {
						$this->error($err);
					} else {
						//返回图片的完整URL
						$data['pic']=$qiniu->DOMAIN.'/'.$ret['key'];
						$data['is_qiniu']=1;
					}
					
				}
				
			}
			
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加成功",url('admin/adv/index'));
			} else {
				$this->error("添加失败");
			}
		} else {
			
			$acateData=Acate::all();
			
			$maxsort=AdvModel::order('sort desc')->value('sort');
			$this->assign("maxsort",$maxsort+1);
			$this->assign("acateData",$acateData);
			return $this->fetch();
		}
		
	}
	
	public function del($id = ''){
		$Model=new AdvModel();
		parent::dels($id,$Model);
	}
	
	
}
