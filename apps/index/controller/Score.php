<?php
// +----------------------------------------------------------------------
// | Leesuntech [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.leesuntech.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 李文 <15919572@qq.com>
// +----------------------------------------------------------------------

namespace app\index\controller;
use app\index\controller\IndexBase;
use app\common\model\Nav;
use app\common\model\Product as ProductModel;
use app\admin\model\Module;
use app\admin\model\Productspec;
use app\common\model\Qrcode;
use think\Cookie;

class Score extends IndexBase
{
	private $classname='';
	
	protected function _initialize(){
		parent::_initialize();
		$mid=$this->request->param('mid');
		$this->classname=Module::where(['id'=>$mid])->value('classname');
	}
    public function index()
    {
		
		
		return $this->fetch($this->classname);
    }
	
	public function lists()
    {
		clert_temp_cache();
		return $this->fetch($this->classname.'_list');
    }
	
	public function search($keywords='')
    {
		
		if($this->request->isPost()){
			
			
			return $this->redirect('search',array('keywords'=>urlencode($keywords)));  
		} else{
			clert_temp_cache();
			$this->assign('keywords',$keywords);
			return $this->fetch();
		}
		
		
    }
	
	public function show($id='',$pid='',$mid='')
    {
		
		
		$IPaddress=request()->ip();
		if(Cookie::get('product_click'.$id)!=$IPaddress){
			Cookie::set('product_click'.$id,$IPaddress,3600);
			ProductModel::where('id',$id)->setInc('click');
		}
		$url='http://'.$_SERVER['SERVER_NAME'].url('index/score/show',['id'=>$id,'pid'=>$pid,'mid'=>$mid]);
		$url=str_replace('/','_',$url);
		$img=url('index/qrcode/create',['value'=>$url,'size'=>80]);
		
		$this->assign('qrcode',$img);
		return $this->fetch($this->classname.'_show');
    }
	
	function ajaxPrice(){
		$arr=$this->request->param('arr');
		$arr=explode(",",$arr);
		
		$id=$this->request->param('id');
		
		$pro_specs=Productspec::all(['pid'=>$id]);
		$pro_specs=collection($pro_specs)->toArray();
		
		$target='';
		if($pro_specs){
			
			foreach($pro_specs as $k=>$v){
				$specs=unserialize($v['specs']);
				
				if(!array_diff($arr,$specs)){
					$target['origin_price']=$v['origin_price'];
					$target['current_price']=$v['current_price'];
					$target['inventory']=$v['inventory'];
					$target['img']=$v['img'];
				}
			}
			
		} 
		
		
		return json($target);
	}
}
