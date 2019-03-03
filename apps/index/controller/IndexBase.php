<?php
namespace app\index\controller;

use app\common\controller\Base;
use think\Request;
use think\Session;
use think\Db;
use think\Config as ConfigModel;
use app\admin\model\Config;
use app\admin\model\User;

class IndexBase extends Base
{
	
	
	protected $gl_config='';
	protected $uid='';
	protected $userInfo='';
	protected $dir_path='';
	
    protected function _initialize(){
        parent::_initialize();
		if (!is_file(ROOT_PATH . 'public' . DS . 'install.lock')) {
			$this->redirect(\think\Url::build('install/index/index'));
		}
		$lsroot=str_replace("\\",'/',LS_ROOT);
		$this->dir_path=str_replace($_SERVER['DOCUMENT_ROOT'],'',$lsroot);
		
		$config=Config::get(1);
		$this->gl_config=$config->getData();
		
		$this->uid=Session::get('uid','index');
		
		if($this->uid){
			$this->userInfo=User::get($this->uid);
			if($this->userInfo){
				$this->userInfo->log_time=$this->userInfo->log_time?date('Y-m-d H:i:s',$this->userInfo->log_time):'暂无';
				$this->userInfo->group_name=db("group")->where(['id'=>$this->userInfo->group_id])->value('name');
				$this->assign("userInfo",$this->userInfo->getData());
			} 
		} else {
			$this->assign("userInfo",0);
		}
		
		
		$this->assign("controller",$this->request->controller());
		$this->assign("action",$this->request->action());
		$this->assign('config',$this->gl_config);
		$this->assign("uid",$this->uid);
    }
	
	
}
