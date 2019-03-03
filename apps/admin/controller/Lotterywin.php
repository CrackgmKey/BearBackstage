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
use app\common\model\Lotterywin as LotterywinModel;
use app\common\model\Lotteryitem;

class Lotterywin extends AdminBase
{
	
	
    public function index(){
		
		$model=new LotterywinModel;
		$datas=$model->getLotterywin(0,0,$this->gl_config['admin_page_num']);
		$arr=array();
		
		
		foreach($datas['data'] as $key=>$v){
			$d=$v->getData();
			if($v->getUserName){
				$d['user_name']=$v->getUserName->user_name;
			} else {
				$d['user_name']='<span style="color:red">已无此会员</span>';
			}
			$d['create_time']=$v->create_time;
			if($v->getItemName){
				$d['item_name']=$v->getItemName->name;
			} else {
				$d['item_name']='<span style="color:red">已无此奖项</span>';
			}
			
			
			$d['del_url']=url('admin/lotterywin/del','id='.$d['id']);
			$arr[]=$d;
		} 
		
		$this->assign("page",$datas['page']);
		$this->assign("datas",$arr);
        return $this->fetch();
    }
	
	
	
	public function del($id = ''){
		$Model=new LotterywinModel();
		parent::dels($id,$Model);
	}
	
	
	
}
