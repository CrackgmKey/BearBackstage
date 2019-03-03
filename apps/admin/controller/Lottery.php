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
use app\common\model\Lottery as LotteryModel;
use app\common\model\Lotteryitem;

class Lottery extends AdminBase
{
	
	
    public function index(){
		
		$model=new LotteryModel;
		$datas=$model->getLottery(0,$this->gl_config['admin_page_num']);
		$arr=array();
		
		
		foreach($datas['data'] as $key=>$v){
			
			$d=$v->getData();
			
			$d['mod_url']=url('admin/lottery/mod','id='.$d['id']);
			$d['del_url']=url('admin/lottery/del','id='.$d['id']);
			$d['ite_url']=url('admin/lottery/item_index','id='.$d['id']);
			$d['category_cn']=$d['category']==1?'幸运转盘':'';
			$arr[]=$d;
		} 
		
		$this->assign("page",$datas['page']);
		$this->assign("datas",$arr);
        return $this->fetch();
    }
	
	public function changeDefault(Request $request){
		$id=$request->get('id');
		Db::name('lottery')->where('is_default', 1)->update(['is_default' => "0"]);
		$Model=LotteryModel::get($id);
		$d=$Model->getData();
		$data['is_default']=$d['is_default']?0:1;
		$res=$Model->save($data);
		
		if($res!==false){
			
			response("success");
		} else {
			response("err");
		}
	}
	
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			
			 // 数据验证
			$result = $this->validate($data,'Lottery');
			if (true !== $result) {
				$this->error($result);
			}
			$Model=new LotteryModel;
			
			
			
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				$this->success("编辑成功",url('admin/lottery/index'));
			} else {
				$this->error($this->getError());
			}
		} else {
			
			$dataModel=LotteryModel::get($id);
			$data=$dataModel->getData();
			$data['category_cn']=$data['category']==1?'幸运转盘':'';
			
			
			$this->assign("data",$data);
			return $this->fetch();
		}
	}
	
	public function item_index($id = ''){
		$datas=Lotteryitem::all(function($query)use($id){
			$query->order('sort asc')->where(['pid'=>$id]);
		});
		$this->assign("datas",$datas);
		$this->assign("pid",$id);
		return $this->fetch();
	}
	
	public function moditem(){
		$datas=$this->request->post();
		$updateDatas=[];
		foreach($datas['id'] as $k=>$v){
			$updateDatas[$k]['id']=$v;
			$updateDatas[$k]['name']=$datas['name'][$v];
			$updateDatas[$k]['percent']=$datas['percent'][$v];
			if(isset($datas['win'][$v])){
				$updateDatas[$k]['win']=$datas['win'][$v];
			} else {
				$updateDatas[$k]['win']=0;
			}
		}
		
		$Model=new Lotteryitem;
		if(!$Model->saveAll($updateDatas)){
			$this->error("修改失败!");
		} else {
			$this->success("修改成功",url('admin/lottery/item_index','id='.$datas['pid']));
		}
	}
	
	public function add(Request $request){
		
		if($this->request->isPost()){
		
			$data=$request->post();
			 // 数据验证
			$result = $this->validate($data,'Lottery');
			
			if (true !== $result) {
				
				$this->error($result);
			}
			$Model=new LotteryModel;
			$res=$Model->save($data);
			if($res!==false){
				$this->success("添加成功",url('admin/lottery/index'));
			} else {
				$this->error("添加失败");
			}
		} else {
			
			
			return $this->fetch();
		}
		
	}
	
	public function del($id = ''){
		$Model=new LotteryModel();
		parent::dels($id,$Model);
	}
	
	
	
}
