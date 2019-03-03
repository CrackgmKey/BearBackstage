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
use app\admin\model\Userlog;
use app\admin\model\User;
use app\admin\model\Adminlog;
use app\admin\model\Admin;
use app\admin\model\Adminactlog;
use app\admin\model\Adminnode;

class Logs extends AdminBase
{
	
	
    public function index($type = ''){
		
		switch($type){
			case 1:
				$tpl="userlog";
				$mod=new Userlog;
				$order='log_time desc';
			break;
			case 2:
				$tpl="adminlog";
				$mod=new Adminlog;
				$order='log_time desc';
			break;
			case 3:
				$tpl="adminactlog";
				$mod=new Adminactlog;
				$node=new Adminnode();
				$order='act_time desc';
			break;
		}
		
		$datas=$mod->order($order)->paginate($this->gl_config['admin_page_num']);
		
		foreach($datas as $key=>$var){
			if($type==1){
				$d=User::get($var['uid']);
				$datas[$key]['user_name']=$d['user_name'];
				$datas[$key]['del_url']=url('admin/Logs/del',array('id'=>$var['id'],'type'=>$type));
			} elseif($type==2){
				$d=Admin::get($var['admin_id']);
				$datas[$key]['adm_name']=$d['adm_name'];
				$datas[$key]['del_url']=url('admin/Logs/del',array('id'=>$var['id'],'type'=>$type));
			} elseif($type==3){
				$d=Admin::get($var['admin_id']);
				
				$node_data=$node->where(['action'=>$var['action'],'model'=>$var['model']])->find();
				$datas[$key]['act_name']=$node_data['name'];
				$datas[$key]['adm_name']=$d['adm_name'];
				$datas[$key]['del_url']=url('admin/Logs/del',array('id'=>$var['id'],'type'=>$type));
				
			} 
			
		}
		$this->assign("datas",$datas);
        return $this->fetch($tpl);
    }
	
	public function ajaxGetInfo($ip=''){
		$url="http://ip.taobao.com/service/getIpInfo.php?ip=".$ip;
		return get_curl_json($url);
	}
	
	public function del($id = '',$type = ''){
		
		if($this->request->isPost()){
			
			switch($this->request->post('type')){
				case 1:
					$Model=new Userlog();
				break;
				case 2:
					$Model=new Adminlog();
				break;
				case 3:
					$Model=new Adminactlog();
				break;
			}
		} else {
			switch($type){
				case 1:
					$Model=new Userlog();
				break;
				case 2:
					$Model=new Adminlog();
				break;
				case 3:
					$Model=new Adminactlog();
				break;
			}
		}
		
		parent::dels($id,$Model);
		
	}
	
}
