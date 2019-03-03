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
use app\admin\model\Mailrules as MailrulesModel;
use think\config as ConfigModel;


class Mailrules extends AdminBase
{
	
	
    public function index(){
		
		$datas=MailrulesModel::paginate($this->gl_config['admin_page_num']);
		foreach($datas as $key=>$v){
			$d=$v->getData();
			$datas[$key]['mod_url']=url('admin/mailrules/mod','id='.$d['id']);
		}
		$this->assign("datas",$datas);
        echo $this->fetch();
    }
	
	public function changeNotice(Request $request){
		$id=$request->get('id');
		
		$mailrulesModel=MailrulesModel::get($id);
		$d=$mailrulesModel->getData();
		$data['value']=$d['value']?0:1;
		$res=$mailrulesModel->save($data);
		
		if($res!==false){
			
			exit("{$data['value']}");
		} else {
			exit("err");
		}
	}
	
	public function batchSet($id = ''){
		
		$Model=new MailrulesModel();
		if($id){
			
			$updateData=array();
			foreach($id as $v){
				$d=MailrulesModel::get($v);
				$value=$d['value']?0:1;
				$updateData[]=['id'=>$v,'value'=>$value];
			}
			$res=$Model->saveAll($updateData);
			if($res!==false){
				$this->success("批量设置成功");
			} else {
				$this->getError();
			}
		} else {
			$this->error('没有选择数据');
		}
		
	}
	public function mod($id = ''){
		
		if(!$this->request->isPost()){
			ConfigModel::set('default_ajax_return','html');
			$data=MailrulesModel::get($id);
			$labels=array("{sitename}"=>"网站名称","{domain}"=>"网站域名","{username}"=>"用户名","{password}"=>"用户密码","{score}"=>"用户积分","{address}"=>"用户地址");
			
			$this->assign("labels",$labels);
			$this->assign("data",$data);
			return $this->fetch();
		} else {
			$Model=new MailrulesModel();
			$input=$this->request->post();
			$res=$Model->isUpdate(true)->save($input);
			if($res!==false){
				$this->success("编辑成功");
			} else {
				$this->error($this->getError());
			}
		}
	}
	
	
}
