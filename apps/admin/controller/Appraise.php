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
use app\common\model\Appraise as AppraiseModel;

class Appraise extends AdminBase
{
	
	
	
	
    public function index($id = 0){
		
		$model=new AppraiseModel;
		$where['is_reply']=$id;
		$datas=$model->getAppraise($where,$this->gl_config['admin_page_num']);
		$arr=array();
		
		foreach($datas['data'] as $key=>$v){
			
			$d=$v->getData();
			$d['del_url']=url('admin/appraise/del','id='.$d['id']);
			$d['rep_url']=url('admin/appraise/reply',array('id'=>$d['id'],'is_reply'=>$d['is_reply']));
			$content_time=$v->content_time;
			if($d['reply_time']){
				$reply_time=$v->reply_time;
				$d['reply_time']=$reply_time;
			}
			$d['content_time']=$content_time;
			switch($d['level']){
				case 1:
					$d['level_cn']="<span class='red'>[好评]</span>";
				break;
				case 2:
					$d['level_cn']="<span class='sienna'>[中评]</span>";
				break;
				case 3:
					$d['level_cn']="<span class='green'>[差评]</span>";
				break;
			}
			if($v->getUser){
				$d['username']=$v->getUser->user_name;
			} else {
				$d['username']='<span style="color:red">已无此用户</span>';
			}
			if($v->getProduct){
				$d['productname']=$v->getProduct->name;
				$d['thumb']=$v->getProduct->thumb;
				$d['has_product']=1;
			} else {
				$d['productname']='<span style="color:red">商品不存在</span>';
				$d['thumb']='';
				$d['has_product']=0;
			}
			
			$arr[]=$d;
			
		} 
		$this->assign("page",$datas['page']);
		$this->assign("datas",$arr);
        return $this->fetch();
    }
	
	
	
	
	
	public function reply($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			$is_reply=$data['is_reply'];
			if(!$data['reply']){
				$this->error('请填写回复内容');
			}
			$Model=new AppraiseModel;
			$data['id']=$id;
			$data['reply_time']=time();
			$data['is_reply']=1;
			$data['admin_id']=$this->adm_id;
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑成功");
			} else {
				$this->error($this->getError());
			}
		} else {
			
			$dataModel=AppraiseModel::get($id);
			$data=$dataModel->getData();
			if($dataModel->getUser){
				$data['username']=$dataModel->getUser->user_name;
			} else {
				$data['username']='<span style="color:red">已无此用户</span>';
			}
			if($dataModel->getProduct){
				$data['productname']=$dataModel->getProduct->name;
			} else {
				$data['productname']='<span style="color:red">商品不存在</span>';
				
			}
			$content_time=$dataModel->content_time;
			if($data['reply_time']){
				$reply_time=$dataModel->reply_time;
				$data['reply_time']=$reply_time;
			}
			$data['content_time']=$content_time;
			
			switch($data['level']){
				case 1:
					$data['level_cn']="好评";
				break;
				case 2:
					$data['level_cn']="中评";
				break;
				case 3:
					$data['level_cn']="差评";
				break;
			}
			
			$this->assign("data",$data);
			return $this->fetch();
		}
	}
	
	
	public function del($id = ''){
		$Model=new AppraiseModel();
		parent::dels($id,$Model);
	}
	
	
	
}
