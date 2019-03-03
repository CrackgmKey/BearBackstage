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
use app\common\model\Pcate as PcateModel;


class Pcate extends AdminBase
{
	
	
    public function index(){
		
		$pcatemodel=new PcateModel;
		$datas=$pcatemodel->getPage(0,$this->gl_config['admin_page_num']);
		$arr=array();
		
		foreach($datas['data'] as $key=>$v){
			$d=$v->getData();
			$d['mod_url']=url('admin/pcate/mod','id='.$d['id']);
			$d['del_url']=url('admin/pcate/del','id='.$d['id']);
			$arr[]=$d;
			
		} 
		
		$this->assign("page",$datas['page']);
		$this->assign("datas",$arr);
        return $this->fetch();
    }
	
	public function batchSort(){
		
		$Model=new PcateModel();
		parent::batchSorts($Model);
 		
	}
	
	
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			
			 // 数据验证
			$result = $this->validate($data,'Pcate');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new PcateModel;
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑成功",url('admin/pcate/index'));
			} else {
				$this->error($this->getError());
			}
		} else {
			
			$dataModel=PcateModel::get($id);
			$data=$dataModel->getData();

			$this->assign("data",$data);
			return $this->fetch();
		}
	}
	public function add(Request $request){
		
		if($this->request->isPost()){
		
			$data=$request->post();
			 // 数据验证
			$result = $this->validate($data,'Pcate');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new PcateModel;
			
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加成功",url('admin/pcate/index'));
			} else {
				$this->error("添加失败");
			}
		} else {
			
			$maxsort=PcateModel::order('sort desc')->value('sort');
			$this->assign("maxsort",$maxsort+1);
			return $this->fetch();
		}
		
	}
	
	public function del($id = ''){
		$Model=new PcateModel();
		parent::dels($id,$Model);
	}
	
	
	
}
