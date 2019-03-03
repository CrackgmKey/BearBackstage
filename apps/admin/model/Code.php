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

namespace app\admin\model;

use think\Model;
use think\Session;


class Code extends Model {
	
	private $html_path;
	private $style_path;
	
	public function __construct(){
		$this->html_path=str_replace("\\","/",LS_ROOT.'apps/index/view/');
		$this->style_path=str_replace("\\","/",LS_ROOT.'public/static/index/');
	}
	
	public function getPath(){
		$data['html_path']=$this->html_path;
		$data['style_path']=$this->style_path;
		return $data;
	}
	
	public function html_dir(){
		$dir=array("index"=>"首页模板","pcate"=>"单页模板","news"=>"新闻模板","product"=>"商品模板","score"=>"积分商品模板","public"=>"公共模板","user"=>"会员模板","message"=>"意见反馈模板");
		return $dir;
	}
	public function res_dir(){
		$dir=array("tpl"=>"模版列表","js"=>"JS列表","css"=>"样式列表");
		return $dir;
	}
	public function html_list($template,$current_dir="tpl"){
		$datas=array();
		if($current_dir=="tpl"){
			$dir=$this->html_dir();
			foreach($dir as $k=>$v){
				$filelist=\files\Simfile::getSubFile($this->html_path.$template."/".$k);
				
				foreach($filelist as $key=>$var){
					$datas[$k][$key]['file']=basename($var);
					$datas[$k][$key]['size']=round((filesize($var)/(1024)),2).'kb';
					$datas[$k][$key]['time']=date("Y-m-d H:i:s",filemtime($var));
				}
			}
		}else{
			$filelist=\files\Simfile::getSubFile($this->style_path.$template."/".$current_dir);
			
			foreach($filelist as $key=>$var){
				$datas[$key]['file']=basename($var);
				$datas[$key]['size']=round((filesize($var)/(1024)),2).'kb';
				$datas[$key]['time']=date("Y-m-d H:i:s",filemtime($var));
			}
		}
		
		return $datas;
	}
	
	public function totals($template,$current_dir="tpl"){
		$num=0;
		if($current_dir=="tpl"){
			$dir=$this->html_dir();
			foreach($dir as $k=>$v){
				$num+=count(\files\Simfile::getSubFile($this->html_path.$template."/".$k));
			}
		} else {
			$num+=count(\files\Simfile::getSubFile($this->style_path.$template."/".$current_dir));
		}
		return $num;
	}
}