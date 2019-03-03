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
use app\common\model\Consult as ConsultModel;

class Consult extends AdminBase
{
	
	
	
	
    public function index($id = 0){
		
		$model=new ConsultModel;
		$where['is_reply']=$id;
		$datas=$model->getConsult($where,$this->gl_config['admin_page_num']);
		$arr=array();
		
		foreach($datas['data'] as $key=>$v){
			
			$d=$v->getData();
			$d['ver_url']=url('admin/consult/verify','id='.$d['id']);
			$d['del_url']=url('admin/consult/del','id='.$d['id']);
			$d['rep_url']=url('admin/consult/reply',array('id'=>$d['id'],'is_reply'=>$d['is_reply']));
			$q_time=$v->q_time;
			if($d['a_time']){
				$a_time=$v->a_time;
				$d['a_time']=$a_time;
			}
			$d['q_time']=$q_time;
			
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
	
	
	public function verify($id = ''){
		
		if(empty($id) || $id==''){
			$this->error("未选择操作项");
		}
		
		
		if(is_array($id)){
			$Model=new ConsultModel;
			
			foreach($id as $k=>$v){
				$data[$k]['id']=$v;
				$dataModel=ConsultModel::get($v);
				$d=$dataModel->getData();
				$data[$k]['verify']=$d['verify']?0:1;
			}
			$res=$Model->saveAll($data);
		} else {
			$Model=ConsultModel::get($id);
			$d=$Model->getData();
			$data['verify']=$d['verify']?0:1;
			$res=$Model->save($data);
		}
		if($res!==false){
			$this->success("审核成功");
		} else {
			$this->error($this->getError());
		}
	}
	
	
	public function reply($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			
			$is_reply=$data['is_reply'];
			if(!$data['answer']){
				$this->error('请填写回复内容');
			}
			$Model=new ConsultModel;
			$data['id']=$id;
			$data['a_time']=time();
			$data['is_reply']=1;
			$data['admin_id']=$this->adm_id;
			$res=$Model->isUpdate(true)->allowField(true)->save($data);
			if($res!==false){
				$this->success("编辑成功");
			} else {
				$this->error($this->getError());
			}
		} else {
			
			$dataModel=ConsultModel::get($id);
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
			$q_time=$dataModel->q_time;
			if($data['a_time']){
				$a_time=$dataModel->a_time;
				$data['a_time']=$a_time;
			}
			if($data['q_time']){
				$data['q_time']=date('Y-m-d H:i:s',$q_time);
			}
			
			
			$this->assign("data",$data);
			return $this->fetch();
		}
	}
	
	
	public function del($id = ''){
		$Model=new ConsultModel();
		parent::dels($id,$Model);
	}
	
	
	
}
