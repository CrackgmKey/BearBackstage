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

namespace app\common\model;

use think\Model;
use think\Session;
use think\Request;

class Nav extends Model {
	
	public function getNav($pid = '',$type = 0,$pagenum = 0,$order = 'sort asc',$num = '',$id = '',$display = 2){
		
		
		
		if($type){
			$where['type']=$type;
			if($type==1){
				$where['type']=[['=',1],['=',4],'or'];
			}
		}
		
		if($id){
			$where['id']=$id;
		} else {
			$data=self::get(['id'=>$pid]);
			
			
			if(!$data['pid']){
				$where['pid']=$pid;
			} else {
				$where['pid']=$data->pid;
			}
		}
		if($display!=2){
			$where['display']=$display;
		}
		if($pagenum){
			$d=self::where($where)->order($order)->limit($num)->paginate($pagenum);
			$page = $d->render();
			$datas['page']=$page;
		} else {
			$d=self::where($where)->order($order)->limit($num)->select();
			$datas['page']='';
		}
		
		
		foreach($d as $k=>$v){
			
			$selected=false;
			
			switch($v['type']){
				case 1:
					$type='product';
				break;
				case 2:
					$type='news';
				break;
				case 4:
					$type='score';
				break;
			}
			if($v['pid']){
				$a='lists';
			} else {
				$a='index';
			}
			$d[$k]['url']=url('index/'.$type.'/'.$a,array('id'=>$v['id'],'pid'=>$v['pid'],'mid'=>$v['module_id']));
			$d[$k]['is_sub']=self::where(['pid'=>$v['id']])->value('id');
			
			$data=self::get(['id'=>$pid]);
			if(!$data['pid']){
				$tid=$pid;
				$nav_id=$v['id'];
			} else {
				$tid=$data['id'];
				$nav_id=$v['id'];
			}
			
			if($tid==$nav_id){
				$selected=true;
			} 
			
			$d[$k]['selected']=$selected;
		}
		
		$datas['data']=$d;
		return $datas;
	}
	
}