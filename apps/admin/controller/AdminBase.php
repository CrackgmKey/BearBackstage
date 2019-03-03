<?php
namespace app\admin\controller;

use app\common\controller\Base;
use think\Request;
use think\Session;
use think\Db;
use app\admin\model\Admingroup;
use app\admin\model\Config;
use app\admin\model\Adminactlog;
use app\admin\model\Admin;
vendor('Qiniu.autoload');


class AdminBase extends Base
{
	
	
	protected $gl_config='';
	protected $adm_id='';
	private $controller='';
	private $module='';
	private $action='';
	
    protected function _initialize(){
        parent::_initialize();
		
		
		$config=Config::get(1);
		$this->gl_config=$config->getData();
		
		$adminModel=new Admin;
		
		
		if($adminModel->isLogin()){
			$this->adm_id=Session::get('adm_id','admin');
		} else {
			$this->redirect('admin/login/index');
		}
		
		
		$this->controller=$this->request->controller();
		$this->module=$this->request->module();
		$this->action=$this->request->action();
		
		$id=Db::name('adminnode')->where(['model'=>$this->controller,'action'=>$this->action])->value('id');
		
		if($id){
			
			$admingroup=Admingroup::get(Session::get('group_id','admin'));
			if($admingroup){
				$group_data=$admingroup->getData();
				$auth=unserialize($group_data['auth']);
			
				if(!in_array($id,$auth)){
					if($this->request->isAjax()){
						exit('auth_err');
					} else {
						$this->error("对不起，您无权操作此项目");
					}
				}
			}
			
		}
		
		$allowAction=['add','mod','del','batchsort','batchset','verify',
					  'changeaudit','changedisplay','changenotice','changestatus','test','restore','dobackup'];
		if(in_array($this->action,$allowAction) && $this->controller!='Logs'){
			if(!$this->request->isGet()){
				$this->writeLog();
			} else if($this->request->isGet() && $this->action=='del'){
				$this->writeLog();
				
			}
		}
		
		$this->assign("adm_name",Session::get('adm_name','admin'));
		$this->assign("adm_avatar",Session::get('avatar','admin'));
		$this->assign("group_cn",Session::get('group_cn','admin'));
    }
	
	protected function checkUploadDir(){
		$upDir=date("Ymd",time());
		$saveDir=ROOT_PATH . 'public' . DS . 'uploads'.DS.$upDir;
		if (!file_exists($saveDir)){
            mkdir($saveDir);
        }
	}
	
	private function writeLog(){
		//写入管理员日志
		$Adminactlog=new Adminactlog;
		$data['admin_id']=$this->adm_id;
		$data['model']=$this->controller;
		$data['action']=$this->action;
		
		$Adminactlog->addLog($data);
	}
	
	
	protected function batchSorts($Model){
		
		
		$data=$this->request->post();
		
		if($data){
			$updateData=array();
			foreach($data['sort'] as $k=>$v){
				$updateData[]=['id'=>$k,'sort'=>$v];
			}
			$res=$Model->saveAll($updateData);
			if($res!==false){
				$this->success("更新排序成功");
			} else {
				$this->error($this->getError());
			}
		} else {
			$this->error('没有更新数据');
		}
 		
	}
	
	protected function dels($id = '',$Model){
		
		if(empty($id) || $id==''){
			$this->error("未选择操作项");
		}
		if(is_array($id)){
			$ids=implode(",",$id);
			$map['id']=array('in',$ids);
			
			$res=$Model->where($map)->delete();
		} else {
			$res=$Model->where('id='.$id)->delete();
		}
		if($res!==false){
			$this->success("删除成功");
		} else {
			$this->error("删除失败");
		}
	}
}
