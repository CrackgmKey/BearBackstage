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
use app\common\model\Adv as AdvModel;

class Adv extends IndexBase
{
    public function jump($id='')
    {
		$where['id']=$id;
		
		$url=AdvModel::where($where)->value('url');
		
		AdvModel::where($where)->setInc('click');
		$this->redirect($url);
    }
	
	
}
