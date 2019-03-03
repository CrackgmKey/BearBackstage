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
use app\common\model\Hotword as HotwordModel;
use app\common\model\Nav;

class Hotword extends AdminBase
{
	
	
    public function index(){
		
		$model=new HotwordModel;
		$datas=$model->getHotword(0,$this->gl_config['admin_page_num']);
		$arr=array();
		
		
		foreach($datas['data'] as $key=>$v){
			
			$d=$v->getData();
			
			$d['mod_url']=url('admin/hotword/mod','id='.$d['id']);
			$d['del_url']=url('admin/hotword/del','id='.$d['id']);
			switch($d['type']){
				case 1:
					$type_cn='商品';
				break;
				case 2:
					$type_cn='资讯';
				break;
				case 4:
					$type_cn='积分商品';
				break;
			}
			$d['type_cn']=$type_cn;
			$arr[]=$d;
		} 
		
		$this->assign("page",$datas['page']);
		$this->assign("datas",$arr);
        return $this->fetch();
    }
	
	
	
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			
			 // 数据验证
			$result = $this->validate($data,'Hotword');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new HotwordModel;
			
			
			
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑成功",url('admin/hotword/index'));
			} else {
				$this->error($this->getError());
			}
		} else {
			
			$dataModel=HotwordModel::get($id);
			$data=$dataModel->getData();
			switch($data['type']){
				case 1:
					$type_cn='商品';
				break;
				case 2:
					$type_cn='资讯';
				break;
				case 4:
					$type_cn='积分商品';
				break;
			}
			$data['type_cn']=$type_cn;
			
			$this->assign("data",$data);
			return $this->fetch();
		}
	}
	public function add(Request $request){
		
		if($this->request->isPost()){
		
			$data=$request->post();
			 // 数据验证
			$result = $this->validate($data,'Hotword');
			
			if (true !== $result) {
				
				$this->error($result);
			}
			$Model=new HotwordModel;
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加成功",url('admin/hotword/index'));
			} else {
				$this->error("添加失败");
			}
		} else {
			
			
			return $this->fetch();
		}
		
	}
	
	public function del($id = ''){
		$Model=new HotwordModel();
		parent::dels($id,$Model);
	}
	
	
	
}
