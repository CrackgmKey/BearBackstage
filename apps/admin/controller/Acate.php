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
use app\admin\model\Acate as AcateModel;

class Acate extends AdminBase
{
	
	
    public function index(){
		
		$acatemodel=new AcateModel;
		$datas=$acatemodel->order('sort asc')->paginate($this->gl_config['admin_page_num']);
		
		if(!empty($datas)){
			foreach($datas as $key=>$v){
				$d=$v->getData();
				$datas[$key]['mod_url']=url('admin/acate/mod','id='.$d['id']);
				$datas[$key]['del_url']=url('admin/acate/del','id='.$d['id']);
			}
		}
		$this->assign("datas",$datas);
        return $this->fetch();
    }
	
	
	public function batchSort(){
		
		$Model=new AcateModel();
		parent::batchSorts($Model);
 		
	}
	
	
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			 // 数据验证
			$result = $this->validate($data,'Acate');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new AcateModel;
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑成功",url('admin/acate/index'));
			} else {
				$this->error($this->getError());
			}
		} else {
			
			$dataModel=AcateModel::get($id);
			$data=$dataModel->getData();

			$this->assign("data",$data);
			return $this->fetch();
		}
	}
	public function add(Request $request){
		
		if($this->request->isPost()){
		
			$data=$request->post();
			 // 数据验证
			$result = $this->validate($data,'Acate');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new AcateModel;
			
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加成功",url('admin/acate/index'));
			} else {
				$this->error("添加失败");
			}
		} else {
			
			$maxsort=AcateModel::order('sort desc')->value('sort');
			$this->assign("maxsort",$maxsort+1);
			return $this->fetch();
		}
		
	}
	
	public function del($id = ''){
		$Model=new AcateModel();
		parent::dels($id,$Model);
	}
	
}
