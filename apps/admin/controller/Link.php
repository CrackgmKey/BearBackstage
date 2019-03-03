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
use app\common\model\Link as LinkModel;
use app\common\model\Qiniu;
use Qiniu\Auth as Auth;
use Qiniu\Storage\BucketManager;
use Qiniu\Storage\UploadManager;

class Link extends AdminBase
{
	
	protected $beforeActionList = [
       
        'checkUploadDir'  =>  ['only'=>'add,mod'],    //add,mod方法执行前先执行checkUploadDir方法
    ];
    public function index(){
		
		$model=new LinkModel;
		$datas=$model->order('sort asc')->paginate($this->gl_config['admin_page_num']);
		
		if(!empty($datas)){
			foreach($datas as $key=>$v){
				$d=$v->getData();
				$datas[$key]['mod_url']=url('admin/link/mod','id='.$d['id']);
				$datas[$key]['del_url']=url('admin/link/del','id='.$d['id']);
				if(!$v['is_qiniu']){
					
					if($v['img']){
						$datas[$key]['img']=Request::instance()->root().'/public/uploads/'.$v['img'];
					}
				} else {
					if(strpos($v['img'],'http://')){
						$datas[$key]['img']=$v['img'];
					} else{
						$datas[$key]['img']='http://'.$v['img'];
					}
					
				}
			}
		}
		$this->assign("datas",$datas);
        return $this->fetch();
    }
	
	
	
	
	public function batchSort(){
		
		$Model=new LinkModel();
		parent::batchSorts($Model);
 		
	}
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			 // 数据验证
			$result = $this->validate($data,'Link');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new LinkModel;
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
				$this->success("编辑成功",url('admin/link/index'));
			} else {
				
				$this->error($this->getError());
			}
		} else {
			
			$dataModel=LinkModel::get($id);
			$data=$dataModel->getData();
			if(!$data['is_qiniu']){
				if($data['img']){
					$data['img']=$this->request->root().'/public/uploads/'.$data['img'];
				}
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
			$result = $this->validate($data,'Link');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new LinkModel;
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
			
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加成功",url('admin/link/index'));
			} else {
				$this->error("添加失败");
			}
		} else {
			
			$maxsort=LinkModel::order('sort desc')->value('sort');
			$this->assign("maxsort",$maxsort+1);
			return $this->fetch();
		}
		
	}
	public function del($id = ''){
		$Model=new LinkModel();
		parent::dels($id,$Model);
	}
}
