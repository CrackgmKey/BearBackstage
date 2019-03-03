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
use think\Db;


class Backup extends Model {
	
	
	
	public function getTablesData($tabName){
		$allData=array();
		$sql="select * from {$tabName}";
		$result=Db::query($sql);
		if(!$result){
			return false;
		}
		$num=Db::query($sql);
		
		array_push($allData,count($num),$result);
		return $allData;
	}
	
	public function getTablesName($prefix){ 
		$temp=array();
		$result=Db::query("show table status like '".$prefix."%'"); 
		if(!$result){
			return false;
		} else {
			foreach($result as $var){
				$temp[]=$var["Name"]; 
			}
			return $temp; 
		}
	}
	public function removeComments($sql){
		/* 删除SQL行注释，行注释不匹配换行符 */
		$sql = preg_replace('/^\s*(?:--|#).*/m', '', $sql);

		/* 删除SQL块注释，匹配换行符，且为非贪婪匹配 */
		//$sql = preg_replace('/^\s*\/\*(?:.|\n)*\*\//m', '', $sql);
		$sql = preg_replace('/^\s*\/\*.*?\*\//ms', '', $sql);

		return $sql;
	 }
	
	public function getSqlInfo($head){
		$file_info = array('cms_ver'=>'', 'add_time'=>'');
		$head=str_replace("--","",$head);
		$arr = explode("\n", $head);
		
		foreach($arr as $var){
			$temp = explode(":", $var);
			switch($temp[0]){
				case 'Version':
					$file_info['cms_ver']=trim($temp[1]);
				break;
				
				case 'Create time':
					$file_info['add_time']=trim($temp[1]);
				break;
			}
		}
		return $file_info;
	}
	
}