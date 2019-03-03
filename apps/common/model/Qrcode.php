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

class Qrcode extends Model {
	
	
	public function generate($url,$size=100,$text='',$fontSize='10'){
		$qrCode = new \Endroid\QrCode\QrCode();
        //$url = url($value,'',true,true);
		$url=str_replace('=','/',$url);
		if(strpos($url,'@')){
			$url=str_replace('@','.',$url);
			
		}
		$qrCode->setText($url)
			->setSize($size)
			->setPadding(10)
			->setErrorCorrection('high')
			->setForegroundColor(array('r' => 0, 'g' => 0, 'b' => 0, 'a' => 0))
			->setBackgroundColor(array('r' => 255, 'g' => 255, 'b' => 255, 'a' => 0))
			->setLabel($text)
			->setLabelFontSize($fontSize)
			->setImageType(\Endroid\QrCode\QrCode::IMAGE_TYPE_PNG);
		$qrCode->render();
		 //>>>>>>>>>保存文件>>>>>>>>>>>
		//$qrCode->save(ROOT_PATH . 'public' . DS . 'uploads'.DS.'qr.png'); //保存文件
		//>>>>>>>>>保存文件>>>>>>>>>>>
	}
	
}