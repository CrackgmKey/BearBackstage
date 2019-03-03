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
use app\common\model\Letter as LetterModel;
use app\admin\model\Group;

class Letter extends AdminBase
{
	
	
    public function index(){
		
		$datas=LetterModel::order('create_time desc')->paginate($this->gl_config['admin_page_num']);
		
		
		foreach($datas as $key=>$v){
			
			$datas[$key]['del_url']=url('admin/letter/del','id='.$v['id']);
			
			if($v->getUserInfoFrom){
				$datas[$key]['user_name_from']=$v->getUserInfoFrom->user_name;
				$datas[$key]['photo_from']=$v->getUserInfoFrom->photo;
			} else {
				$datas[$key]['user_name_from']='<span style="color:red">已无此用户</span>';
			}
			
			
			if($v->getUserInfo){
				$datas[$key]['user_name']=$v->getUserInfo->user_name;
				$datas[$key]['photo']=$v->getUserInfo->photo;
			} else {
				$datas[$key]['user_name']='<span style="color:red">已无此用户</span>';
			}
			
			$datas[$key]['message_']=$this->preg_message($datas[$key]['message']);
		}
		$this->assign("datas",$datas);
		
        return $this->fetch();
    }
	
	private function preg_message($message){
		$pa = '/\[exp\](.*?)\[\/exp\]/';
		preg_match_all($pa,$message,$match);
		foreach($match as $kk=>$vv){
			foreach($vv as $k=>$v){
				if($kk){
					$v=str_replace('&quot;','',$v);
					$exp_num=get_exp_num($v);
					$html="<img src='http://res.mail.qq.com/zh_CN/images/mo/DEFAULT2/".$exp_num.".gif' />";
					$message=str_replace($match[0][$k],$html,$message);
				}
			}
		}
		return $message;
	}
	
	
	
	public function del($id = ''){
		$Model=new LetterModel();
		parent::dels($id,$Model);
	}
	
	
	
}
