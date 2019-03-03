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
use app\common\model\Comment as CommentModel;
use app\admin\model\Group;

class Comment extends AdminBase
{
	
	
    public function index(){
		
		$datas=CommentModel::order('create_time desc')->paginate($this->gl_config['admin_page_num']);
		
		
		foreach($datas as $key=>$v){
			
			$datas[$key]['mod_url']=url('admin/comment/mod','id='.$v['id']);
			$datas[$key]['del_url']=url('admin/comment/del','id='.$v['id']);
			
			
			if($v->getNewsName){
				$datas[$key]['newsname']=$v->getNewsName->title;
			} else {
				$datas[$key]['newsname']='<span style="color:red">已无此新闻</span>';
			}
			
			if($v->getUserInfo){
				$datas[$key]['user_name']=$v->getUserInfo->user_name;
				$datas[$key]['photo']=$v->getUserInfo->photo;
			} else {
				$datas[$key]['user_name']='<span style="color:red">已无此用户</span>';
			}
			
		}
		$this->assign("datas",$datas);
		
        return $this->fetch();
    }
	
	
	
	
	
	public function del($id = ''){
		$Model=new CommentModel();
		parent::dels($id,$Model);
	}
	
	
	
}
