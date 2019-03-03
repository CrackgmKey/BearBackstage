<?php
namespace app\common\controller;

use think\Controller;
use think\Lang;
use app\admin\model\Config;


class Base extends Controller
{
	protected $gl_config=array();
	
    protected function _initialize(){
		
        parent::_initialize();
		
    }
}
