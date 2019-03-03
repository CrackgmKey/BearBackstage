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
use app\common\model\Qrcode as QrcodeModel;

class Qrcode extends IndexBase
{
    public function create($value='',$size=100,$text='',$fontSize='10')
    {
		$qr=new QrcodeModel;
		return $qr->generate($value,$size,$text,$fontSize);
    }
	
	
}
