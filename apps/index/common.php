<?php
if (request()->isMobile()) {
	config('template.view_path','apps/index/view/wap/'.config('index_theme').'/');
}

function clert_temp_cache()
{
	$has_file=\files\Simfile::getSubFile(TEMP_PATH);
	if($has_file){
		array_map('unlink', glob(TEMP_PATH . '/*.php'));
		rmdir(TEMP_PATH);
	}
}
/* 
Utf-8、gb2312都支持的汉字截取函数 
cut_str(字符串, 截取长度, 开始长度, 编码); 
编码默认为 utf-8 
开始长度默认为 0 
*/ 

function cut_str($string, $sublen, $start = 0, $code = 'UTF-8'){ 
	if($code == 'UTF-8') { 
		$pa = "/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|\xe0[\xa0-\xbf][\x80-\xbf]|[\xe1-\xef][\x80-\xbf][\x80-\xbf]|\xf0[\x90-\xbf][\x80-\xbf][\x80-\xbf]|[\xf1-\xf7][\x80-\xbf][\x80-\xbf][\x80-\xbf]/"; 
		preg_match_all($pa, $string, $t_string); 
		
		if(count($t_string[0]) - $start > $sublen) return join('', array_slice($t_string[0], $start, $sublen))."..."; 
		return join('', array_slice($t_string[0], $start, $sublen)); 
		} 
		else 
		{ 
		$start = $start*2; 
		$sublen = $sublen*2; 
		$strlen = strlen($string); 
		$tmpstr = ''; 
		
		for($i=0; $i< $strlen; $i++) 
		{ 
		if($i>=$start && $i< ($start+$sublen)) 
		{ 
		if(ord(substr($string, $i, 1))>129) 
		{ 
		$tmpstr.= substr($string, $i, 2); 
		} 
		else 
		{ 
		$tmpstr.= substr($string, $i, 1); 
		} 
		} 
		if(ord(substr($string, $i, 1))>129) $i++; 
		} 
		if(strlen($tmpstr)< $strlen ) $tmpstr.= "..."; 
		return $tmpstr; 
	} 
}