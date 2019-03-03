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
use app\common\model\Product;


class Index extends IndexBase
{
    public function index()
    {
		
		if($this->gl_config['closed']){
			return $this->fetch('public/closed');
		} else {
			return $this->fetch();
		}
		
    }
	public function ajaxList($id=''){
		$html="";
		
		$nav=Nav::get($id);
		if($nav->pid){
			$where['cate_id']=$id;
			
		} else {
			$allData=Nav::all(['pid'=>$nav->id]);
			$ids=[];
			foreach($allData as $v){
				$ids[]=$v['id'];
			}
			$where['cate_id']=['in',$ids];
			
		}
		$where['is_recommend']=1;
		
		$datas=Product::where($where)->order('sort asc')->select();
		
		if(!empty($datas)){
			foreach($datas as $k=>$v){
				$url='';
				$html.="<dl>";
				$html.='<dt>';
				$html.='<a href="'.$url.'" target="_blank">';
				if($v['thumb']){
					$html.='<img src="'.$this->dir_path.'public/uploads/'.$v['thumb'].'" onload="AutoResizeImage(181,138,this)"/>';
				} else {
					$html.='<img src="'.$this->dir_path.'public/static/index/images/no-pic.jpg" />';
				}
				$html.='</a>';
				$html.='</dt>';
				$html.='<dd>';
				$html.='<h2 class="dgrey_l"><a href="'.$url.'">'.cut_str($v['name'],30).'</a></h2>';
				$html.='<h1>&yen;'.$v['current_price'].'</h1>';
				$html.='</dd>';
				$html.='</dl>';
			}
		} else {
			$html="";
		}
		return response($html);
	}
}
