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
use app\admin\model\Group as GroupModel;

class Group extends AdminBase
{
	
	
    public function index(){
		
		$model=new GroupModel;
		$datas=$model->getGroup(0,$this->gl_config['admin_page_num']);
		$arr=[];
		foreach($datas['data'] as $key=>$v){
			$d=$v->getData();
			$d['mod_url']=url('admin/group/mod','id='.$d['id']);
			$d['del_url']=url('admin/group/del','id='.$d['id']);
			$arr[]=$d;
		}
		foreach($arr as $k=>$v){
			
			$subdata=$model->getGroup($v['id']);
			if($subdata['data']){
				foreach($subdata['data'] as $sk=>$sv){
					$d=$sv->getData();
					$d['mod_url']=url('admin/group/mod','id='.$d['id']);
					$d['del_url']=url('admin/group/del','id='.$d['id']);
					$arr[$k]['sub'][]=$d;
				}
				$arr[$k]['is_sub']=1;
			} else {
				
				$arr[$k]['is_sub']=0;
			}
			
		}
		
		$this->assign("page",$datas['page']);
		$this->assign("datas",$arr);
        return $this->fetch();
    }
	
	public function changeDefault(Request $request){
		$id=$request->get('id');
		Db::name('group')->where('is_default', 1)->update(['is_default' => "0"]);
		$Model=GroupModel::get($id);
		$d=$Model->getData();
		$data['is_default']=$d['is_default']?0:1;
		$res=$Model->save($data);
		
		if($res!==false){
			
			exit("success");
		} else {
			exit("err");
		}
	}
	
	public function batchSort(){
		
		$Model=new GroupModel();
		parent::batchSorts($Model);
 		
	}
	
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			
			 // 数据验证
			$result = $this->validate($data,'Group');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new GroupModel;
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑成功",url('admin/group/index'));
			} else {
				$this->error($this->getError());
			}
		} else {
			
			$dataModel=GroupModel::get($id);
			$data=$dataModel->getData();

			$Model=new GroupModel;
			$datas=$Model->getGroup(0);
			foreach($datas['data'] as $key=>$v){
				$d=$v->getData();
				$arr[]=$d;
			}
			
			
			if($data['pid']){
				$current=GroupModel::get($data['pid'])->getData();
				$data['currentName']=$current['name'];
			} else {
				$data['currentName']='顶级栏目';
			}
			
			
			
			$this->assign("datas",$arr);
			$this->assign("data",$data);
			return $this->fetch();
		}
	}
	public function add(Request $request){
		
		if($this->request->isPost()){
		
			$data=$request->post();
			 // 数据验证
			$result = $this->validate($data,'Group');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new GroupModel;
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加成功",url('admin/group/index'));
			} else {
				$this->error("添加失败");
			}
		} else {
			$Model=new GroupModel;
			
			$datas=$Model->getGroup(0);
			$maxsort=GroupModel::order('sort desc')->value('sort');
			foreach($datas['data'] as $key=>$v){
				$d=$v->getData();
				$arr[]=$d;
			}
			if(empty($arr)){
				$arr='';
			}
			$this->assign("datas",$arr);
			$this->assign("maxsort",$maxsort+1);
			return $this->fetch();
		}
		
	}
	
	public function del($id = ''){
		$Model=new GroupModel();
		parent::dels($id,$Model);
	}
	
	
	
}
