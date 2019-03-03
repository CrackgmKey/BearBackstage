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
use think\Image;
use app\common\model\Product as ProductModel;
use app\common\model\Nav;
use app\common\model\Brand;
use app\common\model\Spec;
use app\admin\model\Productspec;
use app\common\model\Qiniu;
use Qiniu\Auth as Auth;
use Qiniu\Storage\BucketManager;
use Qiniu\Storage\UploadManager;

class Product extends AdminBase
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
			$sub=$navModel->getNav($nav_arr[$k]['id'],1);
			if($sub['data']){
				foreach($sub['data'] as $sk=>$sv){
					$nav_arr[$k]['sub'][$sk]=$sv->getData();
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
		
		$model=new ProductModel;
		$param=[];
		$param['recommend']=$this->request->param('recommend')?$this->request->param('recommend'):0;
		$param['status']=$this->request->param('status')?$this->request->param('status'):0;
		$param['pid']=$id?$id:0;
		$param['bid']=0;
		$param['keywords']=NULL;
		
		if($id){
			$m=Nav::get($id);
			$currentData=$m->getData();
			$this->assign("currentName",$currentData['name']);
		} else {
			$this->assign("currentName","请选择");
		}
		if($param['recommend']){
			switch($param['recommend']){
				case 0:
					$currentRecName="不限推荐";
				break;
				case 1:
					$currentRecName="已推荐";
				break;
				case 2:
					$currentRecName="未推荐";
				break;
			}
		} else {
			$currentRecName="请选择";
			
		}
		if($param['status']){
			switch($param['status']){
				case 0:
					$currentStatusName="未上架";
				break;
				case 1:
					$currentStatusName="已上架";
				break;
				case 2:
					$currentStatusName="不限上下架";
				break;
				
			}
		}else {
			$currentStatusName="请选择";
			
		}
		
		$this->assign("currentStatusName",$currentStatusName);
		$this->assign("currentRecName",$currentRecName);
		$datas=$model->getProduct($param,$this->gl_config['admin_page_num']);
		
		$productarr=[];
		
		foreach($datas['data'] as $key=>$v){
			$d=$v->getData();
			$d['mod_url']=url('admin/product/mod','id='.$d['id']);
			$d['del_url']=url('admin/product/del','id='.$d['id']);
			$d['addtime']=$d['add_time']?date("Y-m-d",$d['add_time']):'暂无';
			$d['uptime']=$d['update_time']?date("Y-m-d",$d['update_time']):'暂无';
			if($v->getNavName){
				$d['classname']=$v->getNavName->name;
			} else {
				$d['classname']='<span style="color:red">已无此分类</span>';
			}
			$productarr[]=$d;
		}
		
		$this->assign("page",$datas['page']);
		$this->assign("datas",$productarr);
        return $this->fetch();
    }
	
	public function changeStatus(Request $request){
		$id=$request->get('id');
		
		$Model=ProductModel::get($id);
		$d=$Model->getData();
		$data['status']=$d['status']==1?2:1;
		$res=$Model->save($data);
		
		if($res!==false){
			
			exit("{$data['status']}");
		} else {
			exit("err");
		}
	}
	
	public function batchRecommend($id = ''){
		$Model=new ProductModel();
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
				$this->getError();
			}
		} else {
			$this->error('没有选择数据');
		}
	}
	
	public function batchSet($id = ''){
		$Model=new ProductModel();
		if($id){
			$updateData=array();
			foreach($id as $v){
				$status=$Model->where(['id'=>$v])->value('status');
				$status==1?$status=2:$status=1;
				$updateData[]=['id'=>$v,'status'=>$status];
			}
			$res=$Model->saveAll($updateData);
			if($res!==false){
				$this->success("设置成功");
			} else {
				$this->getError();
			}
		} else {
			$this->error('没有选择数据');
		}
	}
	public function batchSort(){
		
		$Model=new ProductModel();
		parent::batchSorts($Model);
 		
	}
	
	public function getSpecs($id = ''){
		
		$html='<ul>';
		$datas=Spec::all(['cate_id'=>$id,'pid'=>0]);
		if(!empty($datas)){
			foreach($datas as $k=>$v){
				$html.='<li>';
				$html.='<input type="checkbox" name="spec_main[]" class="spec_main" value="'.$v['id'].'" data="'.$v['name'].'">'.$v['name'].'</li>';
				$html.='</li>';
			}
		} else {
			$html.='<li>';
			$html.='暂无';
			$html.='</li>';
		}
		$html.='</ul>';
		return response($html);
	}
		
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			 // 数据验证
			
			$result = $this->validate($data,'Product');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new ProductModel;
			$PsModel=new Productspec;
			$up_dir=date("Ymd",time())."/";
			$img = $this->request->file('img');
			$imgs = $this->request->file('imgs');
			
			//echo "<pre>";print_r($data);print_r($imgs);exit;
			if ($img) {
				if(!$this->gl_config['is_qiniu']){
					
					$info = $img->rule("get_rand")->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
					$data['img']=$up_dir.$info->getFilename();
					
					$image = Image::open($info->getRealPath());
					$imgSrc=ROOT_PATH . 'public' . DS . 'uploads'.DS.$up_dir.'thumb_'.$info->getFilename();
				
					$image->thumb($this->gl_config['thumb_width'], $this->gl_config['thumb_height'],1)->save($imgSrc);//生成缩略图、删除原图以及添加水印
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
						$image = Image::open($img->getRealPath());
						$imgSrc=ROOT_PATH . 'public' . DS . 'uploads'.DS.$up_dir.'thumb_'.$ret['key'];
						$image->thumb($this->gl_config['thumb_width'], $this->gl_config['thumb_height'],1)->save($imgSrc);//生成缩略图、删除原图以及添加水印
						$data['thumb']=$up_dir.'thumb_'.$ret['key'];
						
					}
					
				}
				
				
				
			}
			if ($imgs) {
				if(!$this->gl_config['is_qiniu']){
					foreach($imgs as $k=>$v){
						$info = $v->rule("get_rand")->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
						if(isset($data['imgSort'][$k])){
							$imgSort=$data['imgSort'][$k]-1;
							$imgs_arr[$imgSort]=$up_dir.$info->getFilename();
							$water_img=$imgs_arr[$imgSort];
						} elseif(isset($data['spec_ids'])) {
							$imgSort=count($data['spec_ids']);
							$imgs_arr[$imgSort]=$up_dir.$info->getFilename();
							$water_img=$imgs_arr[$imgSort];
						} else {
							$imgs_arr[$k]=$up_dir.$info->getFilename();
							$water_img=$imgs_arr[$k];
						}
						if($this->gl_config['water_marked']){
							if($this->gl_config['water_position']){
								$water_position=$this->gl_config['water_position'];
							} else {
								$water_position=rand(1,9);
							}
							$water_image = Image::open(ROOT_PATH . 'public' . DS . 'uploads'.DS.$water_img);
							$water_image->water(ROOT_PATH . 'public' . DS . 'uploads'.DS.$this->gl_config['water_mark'],$water_position)->save(ROOT_PATH . 'public' . DS . 'uploads'.DS.$water_img);
						}
						
					}
				} else {
					$qiniu=Qiniu::get(1);
					$auth = new Auth($qiniu->ACCESSKEY, $qiniu->SECRETKEY);
					$token = $auth->uploadToken($qiniu->BUCKET);
					// 初始化 UploadManager 对象并进行文件的上传
					$uploadMgr = new UploadManager();
					foreach($imgs as $k=>$v){
						// 要上传图片的本地路径
						$filePath = $v->getRealPath();
						$ext = pathinfo($v->getInfo('name'), PATHINFO_EXTENSION);  //后缀
						// 上传到七牛后保存的文件名
						$key =substr(md5($filePath) , 0, 5). date('YmdHis') . rand(0, 9999) . '.' . $ext;
						// 调用 UploadManager 的 putFile 方法进行文件的上传
						list($ret, $err) = $uploadMgr->putFile($token, $key, $filePath);
						if ($err !== null) {
							$this->error($err);
						} else {
							//返回图片的完整URL
							if(isset($data['imgSort'][$k])){
								$imgSort=$data['imgSort'][$k]-1;
								$imgs_arr[$imgSort]=$qiniu->DOMAIN.'/'.$ret['key'];
							} elseif(isset($data['spec_ids'])) {
								$imgSort=count($data['spec_ids']);
								$imgs_arr[$imgSort]=$qiniu->DOMAIN.'/'.$ret['key'];
							} else {
								$imgs_arr[$k]=$qiniu->DOMAIN.'/'.$ret['key'];
							}
							
							
						}
					}
				}
			}
			
			
			$data['update_time']=time();
			
			if(isset($data['spec_ids'])){
				$this->clearProductSpecs($id,$data['spec_ids']);
			} else {
				$this->clearProductSpecs($id,NULL);
			}
			
			if(isset($data['spec_main']) && isset($data['spec_sub'])){
				foreach($data['spec_sub'] as $k=>$v){
					foreach($v as $kk=>$vv){
						foreach($data['spec_main'] as $sk=>$sv){
							//$specs_arr[$kk][$sk]=$sv.",".$_POST['spec_sub'][$sv][$kk];
							$specs_arr[$kk][$sv]=$data['spec_sub'][$sv][$kk];
							$specs_origin[$kk]=$data['origin_prices'][$kk];
							$specs_current[$kk]=$data['current_prices'][$kk];
							$specs_inventories[$kk]=$data['inventories'][$kk];
							if(isset($data['spec_ids'][$kk])){
								$spec_ids[$kk]=$data['spec_ids'][$kk];
							}
						}
					}
				}
				if($data['spec_main']){
					$data['spec_main']=serialize($data['spec_main']);
				}
				
				unset($data['spec_sub']);
				unset($data['spec_ids']);
			} else {
				$data['spec_main']='';
			}
			
			if(isset($data['imgSort'])){
				unset($data['imgSort']);
			}
			if(isset($data['origin_prices'])){
				unset($data['origin_prices']);
			}
			if(isset($data['current_prices'])){
				unset($data['current_prices']);
			}
			if(isset($data['inventories'])){
				unset($data['inventories']);
			}
			
			
			
			
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				if(!empty($specs_arr)){
					foreach($specs_arr as $k=>$v){
						if(isset($spec_ids[$k])){
							$post[$k]['id']=$spec_ids[$k];
						}
						$post[$k]['specs']=serialize($v);
						$post[$k]['origin_price']=$specs_origin[$k];
						$post[$k]['current_price']=$specs_current[$k];
						$post[$k]['inventory']=$specs_inventories[$k];
						if(isset($imgs_arr[$k])){
							$post[$k]['img']=$imgs_arr[$k];
						}
						
						$post[$k]['pid']=$data['id'];
						$post[$k]['is_qiniu']=$this->gl_config['is_qiniu'];
					}
					if(!$PsModel->saveAll($post)){
						$this->error("规格参数不完整,规格填加失败!");
					}
				}
				$this->success("编辑成功",url('admin/product/index'));
			} else {
				$this->error($this->getError());
			}
		} else {
			
			$dataModel=ProductModel::get($id);
			$data=$dataModel->getData();
			if($data['spec_main']){
				$data['spec_main']=unserialize($data['spec_main']);
			}
			$spec_datas=Productspec::all(['pid'=>$id]);
			
			
			if($dataModel->getNavName){
				$data['cate_cn']=$dataModel->getNavName->name;
			} else {
				$data['cate_cn']='已无此分类';
			}
			
			if($data['brand_id']){
				if($dataModel->getBrandName){
					$data['brand_cn']=$dataModel->getBrandName->name;
				} else {
					$data['brand_cn']='已无此分类';
				}
			} else {
				$data['brand_cn']='非品牌商品';
			}
			//echo "<pre>";print_r($data);
			
			$brand_datas=Brand::all();
			$spec_main=Spec::all(['pid'=>0]);
			$spec_sub=Spec::where('pid','NEQ','0')->select();
			$maxsort=ProductModel::order('sort desc')->value('sort');
			if($spec_datas){
				foreach($spec_datas as $k=>$v){
					$spec_datas[$k]['specs']=unserialize($v->specs);
					if(!$v['is_qiniu']){
						$spec_datas[$k]['img']=$this->request->root().'/public/uploads/'.$v['img'];
					} else {
						if(strpos($v['img'],'http://')){
							$spec_datas[$k]['img']=$v['img'];
						} else{
							$spec_datas[$k]['img']='http://'.$v['img'];
						}
						
					}
				}
				$data['has_spec']=1;
			} else {
				$data['has_spec']=0;
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
			
			
			$this->assign("spec_main",$spec_main);
			$this->assign("spec_sub",$spec_sub);
			$this->assign("brand_datas",$brand_datas);
			$this->assign("data",$data);
			$this->assign("spec_datas",$spec_datas);
			return $this->fetch();
		}
	}
	
	private function clearProductSpecs($pid,$spec_ids){//编辑时清除规格项目
		$model=new Productspec;
		if(!isset($spec_ids) || empty($spec_ids)){
			$model->where(['pid'=>$pid])->delete();
		} else {
			
			$spec_datas=Productspec::all(['pid'=>$pid]);
			$spec_datas=collection($spec_datas)->toArray();
			foreach($spec_datas as $v){
				$arr[]=$v['id'];
			}
			
			foreach($arr as $v){
				if(!in_array($v,$spec_ids)){
					$model->where(['id'=>$v])->delete();
				}
			}
		}
		
		
	}
	
	public function add(Request $request){
		
		if($this->request->isPost()){
			
			$data=$request->post();
			 // 数据验证
			$result = $this->validate($data,'Product');
			if (true !== $result) {
				$this->error($result);
			}
			
			$Model=new ProductModel;
			$PsModel=new Productspec;
			$up_dir=date("Ymd",time())."/";
			$img = $this->request->file('img');
			$imgs = $this->request->file('imgs');
			if (!empty($img)) {
				if(!$this->gl_config['is_qiniu']){
					$info = $img->rule("get_rand")->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
					$data['img']=$up_dir.$info->getFilename();
					
					$image = Image::open($info->getRealPath());
					$imgSrc=ROOT_PATH . 'public' . DS . 'uploads'.DS.$up_dir.'thumb_'.$info->getFilename();
					$image->thumb($this->gl_config['thumb_width'], $this->gl_config['thumb_height'],1)->save($imgSrc);//生成缩略图、删除原图以及添加水印
					if($this->gl_config['water_marked']){
						if($this->gl_config['water_position']){
							$water_position=$this->gl_config['water_position'];
						} else {
							$water_position=rand(1,9);
						}
						$water_image = Image::open(ROOT_PATH . 'public' . DS . 'uploads'.DS.$data['img']);
						$water_image->water(ROOT_PATH . 'public' . DS . 'uploads'.DS.$this->gl_config['water_mark'],$water_position)->save(ROOT_PATH . 'public' . DS . 'uploads'.DS.$data['img']);
					}
					// 成功上传后 获取上传信息
					$data['thumb']=$up_dir.'thumb_'.$info->getFilename();
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
						$image = Image::open($img->getRealPath());
						$imgSrc=ROOT_PATH . 'public' . DS . 'uploads'.DS.$up_dir.'thumb_'.$ret['key'];
						$image->thumb($this->gl_config['thumb_width'], $this->gl_config['thumb_height'],1)->save($imgSrc);//生成缩略图、删除原图以及添加水印
						$data['thumb']=$up_dir.'thumb_'.$ret['key'];
						
					}
					
				}
				
			}
			if (!empty($imgs)) {
				
				if(!$this->gl_config['is_qiniu']){
					foreach($imgs as $k=>$v){
						$info = $v->rule("get_rand")->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
						$imgs_arr[$k]=$up_dir.$info->getFilename();
						
						if($this->gl_config['water_marked']){
							if($this->gl_config['water_position']){
								$water_position=$this->gl_config['water_position'];
							} else {
								$water_position=rand(1,9);
							}
							$water_image = Image::open(ROOT_PATH . 'public' . DS . 'uploads'.DS.$imgs_arr[$k]);
							$water_image->water(ROOT_PATH . 'public' . DS . 'uploads'.DS.$this->gl_config['water_mark'],$water_position)->save(ROOT_PATH . 'public' . DS . 'uploads'.DS.$imgs_arr[$k]);
						}
					}
				} else {
					$qiniu=Qiniu::get(1);
					$auth = new Auth($qiniu->ACCESSKEY, $qiniu->SECRETKEY);
					$token = $auth->uploadToken($qiniu->BUCKET);
					// 初始化 UploadManager 对象并进行文件的上传
					$uploadMgr = new UploadManager();
					foreach($imgs as $k=>$v){
						// 要上传图片的本地路径
						$filePath = $v->getRealPath();
						$ext = pathinfo($v->getInfo('name'), PATHINFO_EXTENSION);  //后缀
						// 上传到七牛后保存的文件名
						$key =substr(md5($filePath) , 0, 5). date('YmdHis') . rand(0, 9999) . '.' . $ext;
						// 调用 UploadManager 的 putFile 方法进行文件的上传
						list($ret, $err) = $uploadMgr->putFile($token, $key, $filePath);
						if ($err !== null) {
							$this->error($err);
						} else {
							//返回图片的完整URL
							$imgs_arr[$k]=$qiniu->DOMAIN.'/'.$ret['key'];
							
							
						}
					}
				}
			}
			$data['status']=2;
			$data['is_recommend']=2;
			$data['add_time']=time();
			
			if(isset($data['spec_main']) && isset($data['spec_sub'])){
				foreach($data['spec_sub'] as $k=>$v){
					foreach($v as $kk=>$vv){
						foreach($data['spec_main'] as $sk=>$sv){
							//$specs_arr[$kk][$sk]=$sv.",".$_POST['spec_sub'][$sv][$kk];
							$specs_arr[$kk][$sv]=$data['spec_sub'][$sv][$kk];
							$specs_origin[$kk]=$data['origin_prices'][$kk];
							$specs_current[$kk]=$data['current_prices'][$kk];
							$specs_inventories[$kk]=$data['inventories'][$kk];
						}
					}
				}
				$data['spec_main']=serialize($data['spec_main']);
				unset($data['spec_sub']);
			}
			
			if(isset($data['origin_prices'])){
				unset($data['origin_prices']);
			}
			if(isset($data['current_prices'])){
				unset($data['current_prices']);
			}
			if(isset($data['inventories'])){
				unset($data['inventories']);
			}
			
			if(trim($data['serial_no'])==""){
				$data['serial_no']=date("Ymdhis").rand(100,999);
			} 
			
			$res=$Model->save($data);
			
			if($res!==false){
				if(!empty($specs_arr)){
					foreach($specs_arr as $k=>$v){
						$post[$k]['specs']=serialize($v);
						$post[$k]['origin_price']=$specs_origin[$k];
						$post[$k]['current_price']=$specs_current[$k];
						$post[$k]['inventory']=$specs_inventories[$k];
						if(isset($imgs_arr[$k])){
							$post[$k]['img']=$imgs_arr[$k];
						}
						
						$post[$k]['pid']=$Model->id;
						$post[$k]['is_qiniu']=$this->gl_config['is_qiniu'];
					}
					if(!$PsModel->saveAll($post)){
						$this->error("规格参数不完整,规格填加失败!");
					}
				}
				
				$this->success("添加成功",url('admin/product/index'));
			} else {
				$this->error("添加失败");
			}
		} else {
			
			$brand_datas=Brand::all();
			$spec_main=Spec::all(['pid'=>0]);
			$spec_sub=Spec::where('pid','NEQ','0')->select();
			$maxsort=ProductModel::order('sort desc')->value('sort');
			
			$this->assign("spec_main",$spec_main);
			$this->assign("spec_sub",$spec_sub);
			$this->assign("brand_datas",$brand_datas);
			$this->assign("maxsort",$maxsort+1);
			return $this->fetch();
		}
		
	}
	public function del($id = ''){
		$Model=new ProductModel();
		parent::dels($id,$Model);
	}
}
