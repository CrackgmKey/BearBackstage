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
namespace app\admin\controller;

use app\admin\controller\AdminBase;

use think\Request;
use think\Db;
use app\common\model\Payment as PaymentModel;

class Payment extends AdminBase
{
	
	
    public function index(){
		
		$model=new PaymentModel;
		$datas=$model->order('sort asc')->paginate($this->gl_config['admin_page_num']);
		
		if(!empty($datas)){
			foreach($datas as $key=>$v){
				$d=$v->getData();
				$datas[$key]['mod_url']=url('admin/payment/mod','id='.$d['id']);
			}
		}
		$this->assign("datas",$datas);
        return $this->fetch();
    }
	
	
	
	
	public function batchSort(){
		
		$Model=new PaymentModel();
		parent::batchSorts($Model);
 		
	}
	
	public function mod($id = ''){
		
		if($this->request->isPost()){
			$data=$this->request->post();
			
			$Model=new PaymentModel;
			
			$up_dir="pem/";
			$pem3 = $this->request->file('parameter3');
			$pem4 = $this->request->file('parameter4');
			if (!empty($pem3)) {
				$info = $pem3->rule("get_rand")->validate(['size'=>$this->gl_config['upload_size'],'ext'=>'pem'])->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
				if($info){
					$data['parameter3']=$up_dir.$info->getFilename();
				} else {
					$this->error($pem3->getError());
				}
				
			}
			if (!empty($pem4)) {
				$info = $pem4->rule("get_rand")->validate(['size'=>$this->gl_config['upload_size'],'ext'=>'pem'])->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
				if($info){
					$data['parameter4']=$up_dir.$info->getFilename();
				} else {
					$this->error($pem4->getError());
				}
				
			}
			
			$domain=Request::instance()->domain();
			
			switch($data['id']){
				case 1:
					$filename=str_replace('/','\\',LS_ROOT.'\apps\extra\alipay.php');
					$writeData['app_id']=$data['partner_id'];
					$writeData['merchant_private_key']=$data['authkey'];
					$writeData['notify_url']=$domain.url("index/notifyurl/alipay");
					$writeData['return_url']=$domain.url("index/pay/ali_return_url");
					$writeData['charset']='UTF-8';
					$writeData['sign_type']='RSA2';
					$writeData['gatewayUrl']='https://openapi.alipay.com/gateway.do';
					$writeData['alipay_public_key']=$data['parameter1'];
					$this->write_to_file($writeData,$filename,1);
				break;
				case 2:
					$filename=str_replace('/','\\',LS_ROOT.'\extend\wxpay\lib\WxPayConfig.php');
					$d=PaymentModel::get(2);
					$t="<?php \r";
					$t.="class WxPayConfig {\r";
					$t.="const APPID     = '".$data['partner_id']."';\r";
					$t.="const MCHID     = '".$data['parameter1']."';\r";
					$t.="const KEY     = '".$data['authkey']."';\r";
					$t.="const APPSECRET     = '".$data['parameter2']."';\r";
					$t.="const WXPAY_DEBUG     = true;\r";
					$t.="const NOTIFY_URL     = '".$domain.url("index/notifyurl/wxpay")."';\r";
					$t.="const SSLCERT_PATH     = '".str_replace('\\','/',LS_ROOT).'public/uploads/'.$d->parameter3."';\r";
					$t.="const SSLKEY_PATH     = '".str_replace('\\','/',LS_ROOT).'public/uploads/'.$d->parameter4."';\r";
					$t.="const CURL_PROXY_HOST     = '0.0.0.0';\r";
					$t.="const CURL_PROXY_PORT     = 0;\r";
					$t.="const REPORT_LEVENL     = 1;\r";
					$t.="const WXPAY_LOG     = '/wxpay';\r";
					$t.='}';
					
					$this->write_to_file($t,$filename,2);
				break;
			}
			$res=$Model->isUpdate(true)->save($data);
			if($res!==false){
				
				$this->success("编辑成功",url('admin/payment/index'));
			} else {
				$this->error($this->getError());
			}
		} else {
			
			
			$data=PaymentModel::get($id);
			
			$t=$data->getData();
			switch($id){
				case 1:
					$data->byname='支付宝';
					$parameter2 = [0 => '', 1 => '即时到账收款', 2 => '担保交易收款', 3 => '双功能收款'];
					$data->parameter2_cn=$parameter2[$t['parameter2']];
					$tpl='alipay';
					
				break;
				case 2:
					$data->byname='微信支付';
					$tpl='weixinpay';
				break;
				case 3:
					$data->byname='货到付款';
					$tpl='cash';
				break;
			}
			
			
			$this->assign("data",$data);
			return $this->fetch($tpl.'-mod');
		}
	}
	
	
	function write_to_file($data,$filename,$type){
		if($type==1){
			$t='<?php return '. var_export($data,true).';?>';
		} else {
			$t=$data;
		}
		
		return file_put_contents($filename, $t);
	}
	
	
	
}
