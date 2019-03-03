<?php
namespace app\admin\controller;
use app\admin\controller\AdminBase;
use app\admin\model\User;
use app\common\model\Product;
use app\common\model\Consult;
use app\common\model\Orders;
use app\common\model\Appraise;

class Index extends AdminBase
{
	public function _initialize(){
		parent::_initialize();
	}
    public function index(){
		
		return $this->fetch();
    }
	public function left(){
		$is_phactory=db('addons')->where(['name'=>'phactory'])->value('id');
		$this->assign('is_phactory',$is_phactory);
		return $this->fetch();
	}
	public function main(){
		
		$this->assign('member',$this->memeber());
		$this->assign('info',$this->info());
		$this->assign('product',$this->product());
		$this->assign('consult',$this->consult());
		$this->assign('appraise',$this->appraise());
		$this->assign('orders',$this->orders());
		return $this->fetch();
	}
	public function top(){
		return $this->fetch();
	}
	
	
	private function consult(){
		$data=Consult::where(['is_reply'=>0])->order('q_time desc')->find();
		if($data){
			$data['user_name']=$data->getUser->user_name;
			$data['signature']=$data->getUser->signature;
			$data['photo']=$data->getUser->photo;
			$data['thumb']=$data->getProduct->thumb;
		}
		
		return $data;
	}
	
	private function orders(){
		$unpaid=Orders::where(['pay_status'=>0])->count();
		$paid=Orders::where(['pay_status'=>1])->count();
		$finish=Orders::where(['pay_status'=>1,'delivery_status'=>2,'order_status'=>1])->count();
		$failed=Orders::where(['order_status'=>5])->count();
		$online=Orders::where(['payment_id'=>['neq',3]])->count();
		$cash=Orders::where(['payment_id'=>3])->count();
		$info=array(
			'unpaid'=>$unpaid,
			'paid'=>$paid,
			'finish'=>$finish,
			'failed'=>$failed,
			'online'=>$online,
			'cash'=>$cash
		);
		
		return $info;
	}
	private function appraise(){
		$data=Appraise::where(['is_reply'=>0])->order('content_time desc')->find();
		if($data){
			$data['user_name']=$data->getUser->user_name;
			$data['signature']=$data->getUser->signature;
			$data['photo']=$data->getUser->photo;
			$data['thumb']=$data->getProduct->thumb;
		}
		
		return $data;
	}
	
	private function memeber(){
		$total=User::count();
		$today_total=User::where('reg_time','between',[strtotime(date("Y-m-d",time())),strtotime(date('Y-m-d',strtotime('+1 day')))])->count();
		$yestoday_total=User::where('reg_time','between',[strtotime(date('Y-m-d',strtotime('-1 day'))),strtotime(date("Y-m-d",time()))])->count();
		$month_total=User::where('reg_time','between',[strtotime(date('Y-m-01',time())),strtotime(date("Y-m-t",time()))])->count();
		$log_total=User::where(['audit'=>0])->count();
		$audit_total=User::where(['audit'=>1])->count();
		$info=array(
			'total'=>$total,
			'today_total'=>$today_total,
			'yestoday_total'=>$yestoday_total,
			'month_total'=>$month_total,
			'log_total'=>$log_total,
			'audit_total'=>$audit_total
		);
		return $info;
	}
	
	private function product(){
		$on_total=Product::where(['status'=>1])->count();
		$off_total=Product::where(['status'=>0])->count();
		$rec_total=Product::where(['is_recommend'=>1])->count();
		$inventory_total=Product::where(array("inventory"=>0))->count();
		$consult_total=Consult::count();
		$appraise_total=Appraise::count();
		$info=array(
			'on_total'=>$on_total,
			'off_total'=>$off_total,
			'inventory_total'=>$inventory_total,
			'rec_total'=>$rec_total,
			'consult_total'=>$consult_total,
			'appraise_total'=>$appraise_total
		);
		return $info;
	}
	
	private function info(){
		$info = array(
			'os'=>PHP_OS,
			'env'=>substr($_SERVER["SERVER_SOFTWARE"],0,8),
			'ver'=>THINK_VERSION,
			'upload'=>ini_get('upload_max_filesize'),
			'dns'=>gethostbyname($_SERVER['SERVER_NAME']),
			'pos'=>$this->request->root(),
		);
		return $info;
	}
}
