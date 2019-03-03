<?php
namespace app\api\controller;
use think\Controller;

class IndexController extends Controller{
	

    public function index(){
	$User=M('tourist');   //大M方法访问数据表
 	$data['userId'] = 'ThinkPHP';
	$data['tel'] = '1171628833';
	$data['mess'] = 'ThinkPHP';
	$data['alipay'] = '841505511@qq.com';
	$data['add_time'] = '15248550823';
	$data['state'] = '0';
	$User->data($data)->add();
    }

    public function addht(){
        $this->success('保存完成');
  /*  	   	 if (IS_GET){

         }else{
             $this->error('6666');
         }*/

/*
        $User=M('tourist');   //大M方法访问数据表
        $data['userId'] = '我试试';
        $data['tel'] = '1171628833';
        $data['mess'] = 'ThinkPHP';
        $data['alipay'] = '841505511@qq.com';
        $data['add_time'] = '15248550823';
        $data['state'] = '0';
        $User->data($data)->add();
        $this->success('保存完成');*/


    }
}