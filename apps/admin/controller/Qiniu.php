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
use app\common\model\Qiniu as QiniuModel;



class Qiniu extends AdminBase
{
	
	
    public function index(){
		
		$data=QiniuModel::get(1);
		$this->assign("data",$data);
        return $this->fetch();
    }
	
	public function mod(Request $request){
		$Model=new QiniuModel();
		$input=$request->post();
		$id=QiniuModel::where(['id'=>1])->value('id');
		
		if($id){
			$res=$Model->isUpdate(true)->save($input);
		} else {
			$res=$Model->save($input);
		}
		if($res!==false){
			$this->success("编辑成功");
		} else {
			$this->error($this->getError());
		}
	}
	
	
	
}
