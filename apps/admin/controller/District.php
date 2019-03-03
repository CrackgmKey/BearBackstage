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
use app\common\model\District as DistrictModel;

class District extends AdminBase
{
	
	
    public function index(){
		
		$model=new DistrictModel;
		$datas=$model->getDistrict(['pid'=>0,'id'=>null],$this->gl_config['admin_page_num']);
		$arr=[];
		foreach($datas['data'] as $key=>$v){
			$d=$v->getData();
			$d['mod_url']=url('admin/district/mod','id='.$d['id']);
			$d['del_url']=url('admin/district/del','id='.$d['id']);
			$arr[]=$d;
		}
		foreach($arr as $k=>$v){
			
			$subdata=$model->getDistrict(['pid'=>$v['id'],'id'=>null]);
			if($subdata['data']){
				foreach($subdata['data'] as $sk=>$sv){
					$d=$sv->getData();
					$d['mod_url']=url('admin/district/mod','id='.$d['id']);
					$d['del_url']=url('admin/district/del','id='.$d['id']);
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
	
	
	
	public function batchSort(){
		
		$Model=new DistrictModel();
		parent::batchSorts($Model);
 		
	}
	
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			
			 // 数据验证
			$result = $this->validate($data,'District');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new DistrictModel;
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑成功",url('admin/district/index'));
			} else {
				$this->error($this->getError());
			}
		} else {
			
			$dataModel=DistrictModel::get($id);
			$data=$dataModel->getData();

			$DistrictModel=new DistrictModel;
			$disdatas=$DistrictModel->getDistrict(['pid'=>0,'id'=>null]);
			foreach($disdatas['data'] as $key=>$v){
				$d=$v->getData();
				$arr[]=$d;
			}
			
			
			
			if($data['pid']){
				$current=DistrictModel::get($data['pid'])->getData();
				$data['currentName']=$current['district_name'];
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
			$result = $this->validate($data,'District');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new DistrictModel;
			
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加成功",url('admin/district/index'));
			} else {
				$this->error("添加失败");
			}
		} else {
			$DistrictModel=new DistrictModel;
			
			$disdatas=$DistrictModel->getDistrict(['pid'=>0,'id'=>null]);
			
			$maxsort=DistrictModel::order('sort desc')->value('sort');
			foreach($disdatas['data'] as $key=>$v){
				$d=$v->getData();
				$arr[]=$d;
			}
			
			$this->assign("datas",$arr);
			$this->assign("maxsort",$maxsort+1);
			return $this->fetch();
		}
		
	}
	
	
	
	public function del($id = ''){
		$Model=new DistrictModel();
		parent::dels($id,$Model);
	}
	
	
	
}
