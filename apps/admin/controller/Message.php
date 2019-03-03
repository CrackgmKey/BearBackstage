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
use app\admin\model\Message as MessageModel;
use app\admin\model\Group;

class Message extends AdminBase
{
	
	
    public function index(){
		
		$datas=MessageModel::order('create_time desc')->paginate($this->gl_config['admin_page_num']);
		
		
		foreach($datas as $key=>$v){
			
			$datas[$key]['del_url']=url('admin/message/del','id='.$v['id']);
		}
		$this->assign("datas",$datas);
		
        return $this->fetch();
    }
	
	
	
	
	
	public function del($id = ''){
		$Model=new MessageModel();
		parent::dels($id,$Model);
	}
	
	
	
}
