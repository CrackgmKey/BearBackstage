<?php
namespace app\common\taglib;
use think\template\TagLib;
use app\common\model\Adv;
use app\common\model\News;
use app\common\model\Link;
use app\common\model\Hotword;
use app\common\model\Pcate;
use app\common\model\Profav;
use app\common\model\Product;
use app\common\model\Appraise;
use app\common\model\Consult;
use app\common\model\Comment;
use app\common\model\Nav;
use app\common\model\Fav;
use app\common\model\Letter;
use app\common\model\Friend;
use app\common\model\Brand;
use app\common\model\Payment;
use app\admin\model\User;
use app\index\model\Cart;
use app\admin\model\Config;
use app\common\model\Qrcode;
use app\common\model\Orders;
use think\Session;
use think\Request;

class Leesun extends TagLib{
    /**
     * 定义标签列表
     */
    protected $tags   =  [
        // 标签定义： attr 属性列表 close 是否闭合（0 或者1 默认1） alias 标签别名 level 嵌套层次
        'adv'      => ['attr' => 'pid,page,order,name,num', 'close' => 1], 
        'news'     => ['attr' => 'pid,page,order,name,num', 'close' => 1],
		'news_1'   => ['attr' => 'id,name', 'close' => 0],
		'link'     => ['attr' => 'page,order,name,num', 'close' => 1],
		'nav'      => ['attr' => 'pid,type,page,order,name,num,id,display', 'close' => 1],
		'hotword'  => ['attr' => 'type,page,order,name,num', 'close' => 1],
		'page'     => ['attr' => 'id,page,order,name,num', 'close' => 1],
		'page_1'   => ['attr' => 'id,name', 'close' => 0],
		'product'  => ['attr' => 'keywords,pid,bid,recommend,status,type,page,order,name,num', 'close' => 1],
		'product_1'=> ['attr' => 'id,name', 'close' => 0],
		'brand'    => ['attr' => 'pid,page,order,name,num', 'close' => 1],
		'lotterywin'=> ['attr' => 'pid,uid,page,order,name', 'close' => 1],
		'letter'   => ['attr' => 'uid,is_new,page,order,name,num', 'close' => 1],
		'spec'     => ['attr' => 'pid,cate_id,product_id,page,order,name,num', 'close' => 1],
		'profav'   => ['attr' => 'uid,page,order,name', 'close' => 1],
		'newsfav'  => ['attr' => 'uid,page,order,name', 'close' => 1],
		'friend'   => ['attr' => 'uid,verify,page,order,name', 'close' => 1],
		'appraise' => ['attr' => 'page,is_reply,uid,pid,level,order,name,num', 'close' => 1],
		'consult'  => ['attr' => 'page,is_reply,verify,pid,order,name,num', 'close' => 1],
		'comment'  => ['attr' => 'pid,uid,page,order,name,num', 'close' => 1],
		'cart'     => ['attr' => 'uid,page,order,name', 'close' => 1],
		'scorecart'=> ['attr' => 'uid,page,order,name', 'close' => 1],
		'orders'   => ['attr' => 'uid,pay_status,order_status,order_sn,payment_id,page,order,name,type', 'close' => 1],
		'payment'  => ['attr' => 'page,order,name', 'close' => 1],
		'district' => ['attr' => 'pid,page,order,name', 'close' => 1],
		'count'    => ['attr' => 'name', 'close' => 0],
		'url'      => ['attr' => 'name,uid,pid,sort,keywords', 'close' => 0],
    ];

    /**
     * 这是一个非闭合标签
     */
	 
	public function tagLotterywin($tag, $content)
    {
		
		$home_page_num=Config::where(['id'=>1])->value('home_page_num');
		
		$pid           = !isset($tag['pid']) ? 0 : $this->autoBuildVar($tag['pid']);
		$uid           = !isset($tag['uid']) ? 0 : $this->autoBuildVar($tag['uid']);
		$order         = !isset($tag['order']) ? "create_time desc" : $tag['order'];
		if(!isset($tag['page'])){
			$page=0;
		} else {
			if($tag['page']){
				$page=$home_page_num;
			} else {
				$page=0;
			}
		}
        $parse = '<?php $model=new app\common\model\Lotterywin;';
		$parse .= "\$pid={$pid};";
		$parse .= "\$uid={$uid};";
		$parse .= "\$__datas__= \$model->getLotterywin(\$pid,\$uid,{$page},'{$order}');";
		$parse .="\$page=\$__datas__['page'];";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
	 
	public function tagNav($tag, $content)
    {
		
		$pid           = !isset($tag['pid']) ? 0 :$this->autoBuildVar($tag['pid']);;
		$type          = !isset($tag['type']) ? 0 : $tag['type'];
		$order         = !isset($tag['order']) ? "sort asc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		$num           = !isset($tag['num']) ? '0' : $tag['num'];
		$id            = !isset($tag['id']) ? '0' : $this->autoBuildVar($tag['id']);
		$display       = !isset($tag['display']) ? '2' : $tag['display'];
		
		
        $parse = '<?php $model=new app\common\model\Nav;';
		$parse .= "\$__datas__= \$model->getNav({$pid},{$type},{$page},'{$order}',{$num},{$id},{$display});";
		$parse .= "\$__datas__=collection(\$__datas__['data'])->toArray();";
        $parse .= '?>';
        $parse .= '{volist name="__datas__" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
		
        return $parse;
    }
	
	
	public function tagProduct($tag, $content)
    {
		
		$home_page_num=Config::where(['id'=>1])->value('home_page_num');
		
		
		$pid           = !isset($tag['pid']) ? 0 : $this->autoBuildVar($tag['pid']);
		$bid           = !isset($tag['bid']) ? 0 : $this->autoBuildVar($tag['bid']);
		$recommend     = !isset($tag['recommend']) ? 0 : $tag['recommend'];
		$status        = !isset($tag['status']) ? 0 : $tag['status'];
		$type          = !isset($tag['type']) ? 0 : $tag['type'];
		$order         = !isset($tag['order']) ? "sort desc" : $tag['order'];
		$num           = !isset($tag['num']) ? '0' : $this->autoBuildVar($tag['num']);
		
		
		$sort=urldecode(Request::instance()->param('sort'));
		
		switch($sort){
			case '1':
				$order='add_time desc';
			break;
			case '2':
				$order='current_price asc';
			break;
			case '3':
				$order='current_price desc';
			break;
			case '4':
				$order='click desc';
			break;
			default:
				$order='sort asc';
		}
		$num           = !isset($tag['num']) ? '0' : $tag['num'];
		
		if(!isset($tag['page'])){
			$page=0;
		} else {
			if($tag['page']){
				$page=$home_page_num;
			} else {
				$page=0;
			}
		}
		if(isset($tag['keywords'])){
			$keywords='';
		} else {
			$keywords=urldecode(Request::instance()->param('keywords'));
		}
		
        $parse = '<?php $model=new app\common\model\Product;';
		$parse .= "\$w['pid']={$pid};";
		$parse .= "\$w['bid']={$bid};";
		$parse .= "\$w['recommend']={$recommend};";
		$parse .= "\$w['status']={$status};";
		if($type){
			$parse .= "\$w['type']={$type};";
		}
		$parse .= "\$w['keywords']='{$keywords}';";
		$parse .= "\$order='{$order}';";
		$parse .= "\$num='{$num}';";
		$parse .= "\$__datas__= \$model->getProduct(\$w,{$page},\$order,\$num);";
		//$parse .= "think\View::share('page',\$__datas__['page']);";
		$parse .="\$page=\$__datas__['page'];";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
	
	public function tagProduct_1($tag, $content)
    {
		
		
		$id           = !isset($tag['id']) ? 0 : $this->autoBuildVar($tag['id']);
		
        $parse = '<?php $model=new app\common\model\Product;';
		$parse .= "\$id={$id};";
		$parse .= "\$__data__= \$model->getProduct_1(\$id);";
		$parse .= "\${$tag['name']}=\$__data__";
        $parse .= '?>';
        
        return $parse;
    }
	
	public function tagPage($tag, $content)
    {
        $Model=new Pcate;
		$id            = !isset($tag['id']) ? '' : $tag['id'];
		$order         = !isset($tag['order']) ? "sort asc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		$num           = !isset($tag['num']) ? '' : $tag['num'];
		
		$datas=$Model->getPage($id,$page,$order,$num);
		$datas=collection($datas['data'])->toArray();
		
		
        $parse = '<?php ';
        $parse .= '$datas='.var_export($datas,true).';'; // 这里是模拟数据
        $parse .= ' ?>';
        $parse .= '{volist name="datas" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
	public function tagPage_1($tag, $content)
    {
		
		
		$id           = !isset($tag['id']) ? 0 : $this->autoBuildVar($tag['id']);
		
        $parse = '<?php $model=new app\common\model\Pcate;';
		$parse .= "\$id={$id};";
		$parse .= "\$__data__= \$model->getPage_1(\$id);";
		$parse .= "\${$tag['name']}=\$__data__";
        $parse .= '?>';
        
        return $parse;
    }
	public function tagHotword($tag, $content)
    {
        $Model=new Hotword;
		$type          = !isset($tag['type']) ? 0 : $tag['type'];
		$order         = !isset($tag['order']) ? "id desc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		$num           = !isset($tag['num']) ? '' : $tag['num'];
		
		$datas=$Model->getHotword($type,$page,$order,$num);
		$datas=collection($datas['data'])->toArray();
		
		
        $parse = '<?php ';
        $parse .= '$datas='.var_export($datas,true).';'; // 这里是模拟数据
        $parse .= ' ?>';
        $parse .= '{volist name="datas" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
	
    public function tagAdv($tag, $content)
    {
        $Model=new Adv;
		
		$order         = !isset($tag['order']) ? "sort asc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		$num           = !isset($tag['num']) ? '' : $tag['num'];
		
		$datas=$Model->getAdv($tag['pid'],$page,$order,$num);
		$datas=collection($datas['data'])->toArray();
		foreach($datas as $k=>$v){
			$datas[$k]['go']=url('index/adv/jump','id='.$v['id']);
		}
		
        $parse = '<?php ';
        $parse .= '$datas='.var_export($datas,true).';'; // 这里是模拟数据
        $parse .= ' ?>';
        $parse .= '{volist name="datas" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
   
   
	
	 public function tagNews($tag, $content)
    {
		$home_page_num=Config::where(['id'=>1])->value('home_page_num');
		
		$pid           = !isset($tag['pid']) ? 0 : $this->autoBuildVar($tag['pid']);
		$order         = !isset($tag['order']) ? "sort asc" : $tag['order'];
		$num           = !isset($tag['num']) ? '' : $tag['num'];
		
		if(!isset($tag['page'])){
			$page=0;
		} else {
			if($tag['page']){
				$page=$home_page_num;
			} else {
				$page=0;
			}
		}
		$keywords=urldecode(Request::instance()->param('keywords'));
		$parse = '<?php $newsModel=new app\common\model\News;';
		$parse .= "\$__datas__= \$newsModel->getNews({$pid},{$page},'{$order}',{$num},'{$keywords}');";
		$parse .= "\$page=\$__datas__['page'];";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
	
	public function tagNews_1($tag, $content)
    {
		
		
		$id           = !isset($tag['id']) ? 0 : $this->autoBuildVar($tag['id']);
		
        $parse = '<?php $model=new app\common\model\News;';
		$parse .= "\$id={$id};";
		$parse .= "\$__data__= \$model->getNews_1(\$id);";
		$parse .= "\${$tag['name']}=\$__data__";
        $parse .= '?>';
        
        return $parse;
    }
	
	public function tagBrand($tag, $content)
    {
		$pid           = !isset($tag['pid']) ? 0 : $this->autoBuildVar($tag['pid']);
		$bid           = !isset($tag['bid']) ? 0 : $this->autoBuildVar($tag['bid']);
		$order         = !isset($tag['order']) ? "sort asc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		$num           = !isset($tag['num']) ? 0 : $tag['num'];
		
		$parse = '<?php $model=new app\common\model\Brand;';
		$parse .= "\$pid={$pid};";
		$parse .= "\$bid={$bid};";
		
		
		$parse .= "\$__datas__= \$model->getBrand({$pid},{$page},'{$order}',{$num},{$bid});";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
	
	
	public function tagLetter($tag, $content)
    {
		
		$home_page_num=Config::where(['id'=>1])->value('home_page_num');
		
		
		$uid           = !isset($tag['uid']) ? 0 : $this->autoBuildVar($tag['uid']);
		$is_new        = is_null($tag['is_new']) ? 0 : $this->autoBuildVar($tag['is_new']);
		$order         = !isset($tag['order']) ? "create_time desc" : $tag['order'];
		if(!isset($tag['page'])){
			$page=0;
		} else {
			if($tag['page']){
				$page=$home_page_num;
			} else {
				$page=0;
			}
		}
		
        $parse = '<?php $model=new app\common\model\Letter;';
		$parse .= "\$w['user_id']={$uid};";
		$parse .= "\$w['is_new']={$is_new};";
		$parse .= "\$__datas__= \$model->getLetter(\$w,{$page},'{$order}');";
		$parse .="\$page=\$__datas__['page'];";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
	
	
	public function tagSpec($tag, $content)
    {
		$pid           = !isset($tag['pid']) ? 0 : $this->autoBuildVar($tag['pid']);
		$cate_id       = !isset($tag['cate_id']) ? 0 : $this->autoBuildVar($tag['cate_id']);
		$product_id    = !isset($tag['product_id']) ? 0 : $this->autoBuildVar($tag['product_id']);
		$order         = !isset($tag['order']) ? "sort asc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		$num           = !isset($tag['num']) ? 0 : $tag['num'];
		
		$parse = '<?php $model=new app\common\model\Spec;';
		$parse .= "\$pid={$pid};";
		$parse .= "\$cate_id={$cate_id};";
		
		
		$parse .= "\$__datas__= \$model->getSpec({$pid},{$cate_id},{$product_id},{$page},'{$order}',{$num});";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
	
	
	public function tagLink($tag, $content)
    {
        $Model=new Link;
		
		
		$order         = !isset($tag['order']) ? "sort asc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		$num           = !isset($tag['num']) ? '' : $tag['num'];
		
		$datas=$Model->getLink($page,$order,$num);
		$datas=collection($datas['data'])->toArray();
		
		
        $parse = '<?php ';
        $parse .= '$datas='.var_export($datas,true).';'; // 这里是模拟数据
        $parse .= ' ?>';
        $parse .= '{volist name="datas" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
	
	public function tagProfav($tag, $content)
    {
        
		$home_page_num=Config::where(['id'=>1])->value('home_page_num');
		$uid           = !isset($tag['uid']) ? Session::get('uid','index') : $tag['uid'];
		$order         = !isset($tag['order']) ? "id desc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		
		if(!isset($tag['page'])){
			$page=0;
		} else {
			if($tag['page']){
				$page=$home_page_num;
			} else {
				$page=0;
			}
		}
		
		$parse = '<?php $model=new app\common\model\Profav;';
		
		$parse .= "\$__datas__= \$model->getProfav({$uid},{$page},'{$order}');";
		$parse .="\$page=\$__datas__['page'];";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
		
        return $parse;
    }
	
	public function tagNewsfav($tag, $content)
    {
        
		$home_page_num=Config::where(['id'=>1])->value('home_page_num');
		
		$uid           = !isset($tag['uid']) ? Session::get('uid','index') : $tag['uid'];
		$order         = !isset($tag['order']) ? "id desc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		
		if(!isset($tag['page'])){
			$page=0;
		} else {
			if($tag['page']){
				$page=$home_page_num;
			} else {
				$page=0;
			}
		}
		
		$parse = '<?php $model=new app\common\model\Fav;';
		
		$parse .= "\$__datas__= \$model->getNewsfav({$uid},{$page},'{$order}');";
		$parse .="\$page=\$__datas__['page'];";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
		
        return $parse;
    }
	
	public function tagFriend($tag, $content)
    {
        
		$home_page_num=Config::where(['id'=>1])->value('home_page_num');
		
		$uid           = !isset($tag['uid']) ? Session::get('uid','index') : $tag['uid'];
		$order         = !isset($tag['order']) ? "id desc" : $tag['order'];
		$verify        = !isset($tag['verify']) ? 0 : $this->autoBuildVar($tag['verify']);
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		
		if(!isset($tag['page'])){
			$page=0;
		} else {
			if($tag['page']){
				$page=$home_page_num;
			} else {
				$page=0;
			}
		}
		
		$parse = '<?php $model=new app\common\model\Friend;';
		
		$parse .= "\$__datas__= \$model->getFriend({$uid},{$verify},{$page},'{$order}');";
		$parse .="\$page=\$__datas__['page'];";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
		
        return $parse;
    }
	
	public function tagAppraise($tag, $content)
    {
        $home_page_num=Config::where(['id'=>1])->value('home_page_num');
		
		$pid           = !isset($tag['pid']) ? 0 : $this->autoBuildVar($tag['pid']);
		$uid           = !isset($tag['uid']) ? 0 : $this->autoBuildVar($tag['uid']);
		$level         = !isset($tag['level']) ? 0 : $this->autoBuildVar($tag['level']);
		$is_reply      = !isset($tag['is_reply']) ? 0 : $this->autoBuildVar($tag['is_reply']);
		$order         = !isset($tag['order']) ? "id desc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		$num           = !isset($tag['num']) ? '' : $tag['num'];
		
		if(!isset($tag['page'])){
			$page=0;
		} else {
			if($tag['page']){
				$page=$home_page_num;
			} else {
				$page=0;
			}
		}
		
		$parse = '<?php $appraiseModel=new app\common\model\Appraise;';
		$parse .= "\$appraiseMap['pid']={$pid};";
		$parse .= "\$appraiseMap['level']={$level};";
		$parse .= "\$appraiseMap['uid']={$uid};";
		$parse .= "\$appraiseMap['is_reply']={$is_reply};";
		$parse .= "\$__datas__= \$appraiseModel->getAppraise(\$appraiseMap,'{$page}','{$order}','{$num}');";
		//$parse .= "think\View::share('page',\$__datas__['page']);";
		$parse .="\$page=\$__datas__['page'];";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
		
    }
	
	public function tagConsult($tag, $content)
    {
       
		$home_page_num=Config::where(['id'=>1])->value('home_page_num');
		
		$uid           = !isset($tag['uid']) ? 0 : $this->autoBuildVar($tag['uid']);
		$pid           = !isset($tag['pid']) ? 0 : $this->autoBuildVar($tag['pid']);
		$order         = !isset($tag['order']) ? "id desc" : $tag['order'];
		$verify        = !isset($tag['verify']) ? 0 : $this->autoBuildVar($tag['verify']);
		$is_reply      = !isset($tag['is_reply']) ? 0 : $this->autoBuildVar($tag['is_reply']);
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		$num           = !isset($tag['num']) ? '' : $tag['num'];
		
		if(!isset($tag['page'])){
			$page=0;
		} else {
			if($tag['page']){
				$page=$home_page_num;
			} else {
				$page=0;
			}
		}
		
		$parse = '<?php $consultModel=new app\common\model\Consult;';
		$parse .= "\$consultMap['pid']={$pid};";
		$parse .= "\$consultMap['verify']={$verify};";
		$parse .= "\$consultMap['uid']={$uid};";
		$parse .= "\$consultMap['is_reply']={$is_reply};";
		$parse .= "\$__datas__= \$consultModel->getConsult(\$consultMap,'{$page}','{$order}','{$num}');";
		$parse .= "\$page=\$__datas__['page'];";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
		
    }
	
	public function tagComment($tag, $content)
    {
       
		$home_page_num=Config::where(['id'=>1])->value('home_page_num');
		
		$pid           = !isset($tag['pid']) ? 0 : $this->autoBuildVar($tag['pid']);
		$uid           = !isset($tag['uid']) ? 0 : $this->autoBuildVar($tag['uid']);
		$order         = !isset($tag['order']) ? "id desc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		$num           = !isset($tag['num']) ? '' : $tag['num'];
		
		if(!isset($tag['page'])){
			$page=0;
		} else {
			if($tag['page']){
				$page=$home_page_num;
			} else {
				$page=0;
			}
		}
		
		$parse = '<?php $commentModel=new app\common\model\Comment;';
		$parse .= "\$commentMap['article_id']={$pid};";
		$parse .= "\$commentMap['user_id']={$uid};";
		$parse .= "\$__datas__= \$commentModel->getComment(\$commentMap,'{$page}','{$order}','{$num}');";
		$parse .= "\$page=\$__datas__['page'];";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
		
    }
	
	
	
	public function tagCart($tag, $content)
    {
		$uid           = !isset($tag['uid']) ? 0 : $this->autoBuildVar($tag['uid']);
		$order         = !isset($tag['order']) ? "add_time desc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		$num           = !isset($tag['num']) ? 0 : $tag['num'];
		
		$parse = '<?php $model=new app\common\model\Cart;';
		$parse .= "\$uid={$uid};";
		
		
		$parse .= "\$__datas__= \$model->getCart({$uid},{$page},'{$order}');";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
	
	public function tagScorecart($tag, $content)
    {
		$uid           = !isset($tag['uid']) ? 0 : $this->autoBuildVar($tag['uid']);
		$order         = !isset($tag['order']) ? "add_time desc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		$num           = !isset($tag['num']) ? 0 : $tag['num'];
		
		$parse = '<?php $model=new app\common\model\Scorecart;';
		$parse .= "\$uid={$uid};";
		
		
		$parse .= "\$__datas__= \$model->getCart({$uid},{$page},'{$order}');";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
	
	public function tagOrders($tag, $content)
    {
		$home_page_num=Config::where(['id'=>1])->value('home_page_num');
		
		$uid           = !isset($tag['uid']) ? 0 : $this->autoBuildVar($tag['uid']);
		$pay_status    = !isset($tag['pay_status']) ? 0 : $this->autoBuildVar($tag['pay_status']);
		$order_status  = !isset($tag['order_status']) ? 0 : $this->autoBuildVar($tag['order_status']);
		$order_sn      = !isset($tag['order_sn']) ? '' : $this->autoBuildVar($tag['order_sn']);
		$payment_id    = !isset($tag['payment_id']) ? 0 : $this->autoBuildVar($tag['payment_id']);
		$order         = !isset($tag['order']) ? "create_time desc" : $tag['order'];
		$type          = !isset($tag['type']) ? 0 : $this->autoBuildVar($tag['type']);
		if(!isset($tag['page'])){
			$page=0;
		} else {
			if($tag['page']){
				$page=$home_page_num;
			} else {
				$page=0;
			}
		}
		
		$parse = '<?php $model=new app\common\model\Orders;';
		$parse .= "\$w['uid']={$uid};";
		$parse .= "\$w['pay_status']={$pay_status};";
		$parse .= "\$w['order_status']={$order_status};";
		$parse .= "\$w['payment_id']={$payment_id};";
		$parse .= "\$w['order_sn']={$order_sn};";
		$parse .= "\$w['type']={$type};";
		$parse .= "\$__datas__= \$model->getOrders(\$w,{$page},'{$order}');";
		$parse .="\$page=\$__datas__['page'];";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
	
	public function tagPayment($tag, $content)
    {
        $Model=new Payment;
		
		
		$order         = !isset($tag['order']) ? "sort asc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		
		$datas=$Model->getPayment($page,$order);
		$datas=collection($datas['data'])->toArray();
		
		
        $parse = '<?php ';
        $parse .= '$datas='.var_export($datas,true).';'; // 这里是模拟数据
        $parse .= ' ?>';
        $parse .= '{volist name="datas" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
	
	public function tagDistrict($tag, $content)
    {
		$pid           = !isset($tag['pid']) ? 0 : $this->autoBuildVar($tag['pid']);
		$order         = !isset($tag['order']) ? "sort asc" : $tag['order'];
		$page          = !isset($tag['page']) ? 0 : $tag['page'];
		
		$parse = '<?php $model=new app\common\model\District;';
		$parse .= "\$disMap['pid']={$pid};";
		$parse .= "\$disMap['id']=NULL;";
		$parse .= "\$__datas__= \$model->getDistrict(\$disMap,{$page},'{$order}');";
        $parse .= ' ?>';
        $parse .= '{volist name="__datas__[\'data\']" id="' . $tag['name'] . '"}';
        $parse .= $content;
        $parse .= '{/volist}';
        return $parse;
    }
	
	public function tagCount($tag, $content)  
    {  
		
        if(isset($tag['name']) && !empty($tag['name']))  
        {  
		   $uid=Session::get('uid','index');
           if($tag['name']=='cart'){
			   $num=Cart::where(['uid'=>$uid])->cache(0)->count();
			   $parseStr =  "{$num}" ; 
		   }
		   if($tag['name']=='order'){
			   $num=Orders::where(['uid'=>$uid,'order_status'=>0])->cache(0)->count();
			   $parseStr =  "{$num}" ; 
		   }
		   if($tag['name']=='appNoReply'){
			   $num=Appraise::where(['uid'=>$uid,'is_reply'=>0])->cache(0)->count();
			   $parseStr =  "{$num}" ; 
		   }
		   if($tag['name']=='appReply'){
			   $num=Appraise::where(['uid'=>$uid,'is_reply'=>1])->cache(0)->count();
			   $parseStr =  "{$num}" ; 
		   }
		   if($tag['name']=='profav'){
			   $num=Profav::where(['user_id'=>$uid])->cache(0)->count();
			   $parseStr =  "{$num}" ; 
		   }
		   if($tag['name']=='fav'){
			   $num=Fav::where(['user_id'=>$uid])->cache(0)->count();
			   $parseStr =  "{$num}" ; 
		   }
		   if($tag['name']=='comment'){
			   $num=Comment::where(['user_id'=>$uid])->cache(0)->count();
			   $parseStr =  "{$num}" ; 
		   }
		   if($tag['name']=='letter'){
			   $num=Letter::where(['user_id'=>$uid])->cache(0)->count();
			   $parseStr =  "{$num}" ; 
		   }
		   if($tag['name']=='friend'){
			   $num=Friend::where(['user_id'=>$uid,'verify'=>0])->cache(0)->count();
			   $parseStr =  "{$num}" ; 
		   }
		   
        }  else {
			 $parseStr =  '必须有name参数' ; 
		}
        
        
        return $parseStr;  
    }  
	
	
	
	public function tagUrl($tag, $content)  
    {  
		
        if(isset($tag['name']) && !empty($tag['name']))  
        {  
          $pid           = !isset($tag['pid']) ? 0 : $this->autoBuildVar($tag['pid']);
		  $uid           = !isset($tag['uid']) ? 0 : $this->autoBuildVar($tag['uid']);
		  $sort          = !isset($tag['sort']) ? 0 : $this->autoBuildVar($tag['sort']);
		  $keywords      = !isset($tag['keywords']) ? '' : trim($tag['keywords']);
		  
		   switch($tag['name']){
			 case 'home':
				$url=url('index/index/index');
			 break;
			 case 'product':
				$url=url('index/product/index');
			 break;
			 case 'searchPro':
				$url=url('index/product/search','keywords='.urlencode($keywords));
			 break;
			 case 'searchNew':
				$url=url('index/news/search','keywords='.urlencode($keywords));
			 break;
			 case 'searchScore':
				$url=url('index/score/search','keywords='.urlencode($keywords));
			 break;
			 case 'myFriend':
				$url=url('index/friend/myfriend');
			 break;
			 case 'myAppraise':
				$url=url('index/appraise/index');
			 break;
			 case 'myFriendMessage':
				$url=url('index/friend/message');
			 break;
			 case 'letter':
				$url=url('index/letter/index');
			 break;
			 case 'reply':
				$url=url('index/letter/reply');
			 break;
			 case 'lottery':
				$url=url('index/lottery/index');
			 break;
			 case 'getLottery':
				$url=url('index/lottery/getLottery');
			 break;
			 case 'getResult':
				$url=url('index/lottery/getResult',array('sort'=>$sort));
			 break;
			 case 'lotteryMod':
				$url=url('index/lottery/mod');
			 break;
			 case 'ajaxPrice':
				$url=url('index/product/ajaxPrice');
			 break;
			 case 'cart':
				$url=url('index/cart/index');
			 break;
			 case 'addCart':
				$url=url('index/cart/addCart');
			 break;
			 case 'addScoreCart':
				$url=url('index/cart/addScoreCart');
			 break;
			 case 'scoreCart':
				$url=url('index/cart/scoreIndex');
			 break;
			 case 'addFav':
				$url=url('index/user/addFav');
			 break;
			 case 'appraisetimes':
				$url=url('index/user/appraisetimes');
			 break;
			 case 'appraiseAdd':
				$url=url('index/appraise/add');
			 break;
			 case 'addOrder':
				$url=url('index/orders/add');
			 break;
			 case 'addScoreOrder':
				$url=url('index/orders/addScore');
			 break;
			 case 'myOrders':
				$url=url('index/orders/myOrders');
			 break;
			 case 'myProfav':
				$url=url('index/fav/profav');
			 break;
			 case 'user':
				$url=url('index/user/index');
			 break;
			 case 'reg':
				$url=url('index/user/reg');
			 break;
			 case 'message':
				$url=url('index/message/index');
			 break;
			 case 'message_add':
				$url=url('index/message/add');
			 break;
			 case 'ajaxLogin':
				$url=url('index/user/ajaxLogin');
			 break;
			 case 'login':
				$url=url('index/user/login');
			 break;
			 case 'logout':
				$url=url('index/user/logout');
			 break;
			 case 'getPass':
				$url=url('index/user/getPass');
			 break;
			 case 'commentTop':
				$url=url('index/news/commentTop');
			 break;
			 case 'newsRec':
				$url=url('index/news/recommand');
			 break;
			 case 'addNewsFav':
				$url=url('index/news/addFav');
			 break;
			 case 'sendFriend':
				$url=url('index/friend/sendFriend');
			 break;
			 case 'agreeFriendMessage':
				$url=url('index/friend/agreeFriendMessage');
			 break;
			 case 'addComment':
				$url=url('index/news/addComment');
			 break;
			 case 'comment':
				$url=url('index/comment/index');
			 break;
			 case 'appraisePublish':
				$url=url('index/appraise/publish',array('pid'=>Request::instance()->param('id')));
			 break;
			 case 'ajaxDistrict':
				$url=url('index/district/ajaxDistrict');
			 break;
			 case 'privateLetter':
				$url=url('index/letter/privateLetter');
			 break;
			
			 
		   }
		   
		   $parseStr =  "{$url}" ; 
        }  else {
			 $parseStr =  '必须有name参数' ; 
		}
        
        
        return $parseStr;  
    }  
	
	
	 
	
}