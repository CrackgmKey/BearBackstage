<?php
namespace app\api\controller;
use think\Controller;
use think\Db;
use think\Exception;

/** 用户注册登陆 等等
 * Class User
 * @package app\api\controller
 */
class User extends Controller{
    /**
     * 用户注册接口
     */
    public function addUser(){
        $password =input('password');$phone =input('phone');$code =input('code');
        //判断账号是否存在
        $userexist = db('user')->where('phone',$phone)->find();
        if($userexist != null){
            return json(['result'=>'手机号被注册,快换个手机号吧','status'=>"201"]);
        }
        //添加数据
        $data = ['user_name' =>'咸蛋超人', 'password' => $password,'signature' => '努力每一天','email' => '1171628833@qq.cm','phone' => $phone,'address' => $code,'ran_code' => time(),'score' => '100','group_id' => '1','reg_time' => time(),'log_time' => time(),'account' => '0','audit' => '0'];
        $result = Db::table('ls_user')->insert($data);
        if($result){
            return json(['result'=>'恭喜您,注册成功','status'=>200]);
        }else{
            return json(['result'=>'注册失败啦','status'=>202]);
        }
    }
    /**
     * 用户登录接口
     */
    public function userLogin(){
        $password =input('password');$phone =input('phone');
       // $userexist = db('user')->where('phone',$phone)->where('password',$password)->find();
        $userexist = Db::table('ls_user')->where("phone='$phone' and password='$password'")->find();
        if($userexist == null){
            return json(['status'=>203,'result'=>'用户名或密码错误']);
        }else{
            return json(['status'=>200,'result'=>'尊敬的'.$phone.'恭喜您登录成功','data'=>$userexist]);
        }
    }

    /**
     * 获取积分商品
     */
    public function luckyCommodity(){
        //获取全部商品
        $commodityList = db("product")->order("id","desc")->select();
        $array =   $this->getData($commodityList);
        return json($array);
    }

    /**
     * 计算积分商品过程
     * @param $commodityList 过程
     * @return array 返回集合
     */
    public function getData($commodityList){
        $array = array();
        // 遍历数据集
        foreach($commodityList as $commodity){
            //获取商品Id
            $scId = $commodity["id"];
            //查询是否开启积分购
            $jifengou = Db::table('ls_lotteryrules')->where('commodityId',$scId)->where('lotterytnum','=',0)->find();
            if($jifengou != null){
                //开启积分够
                $commodity["isstart"] = '1';
            }else {
                $commodity["isstart"] = '0';
            }
            //设置开奖时间
            $commodity["lotterytime"] = $jifengou['lotterytime'];
            //设置当前购买次数
            $commodity["currenttimes"] = $jifengou['currenttimes'];
            //设置总次数
            $commodity["maxsize"] = $jifengou['max'];
            array_push($array,$commodity);
        }
        return $array;
    }

    /**
     * 用户购买积分商品
     */
    public function getBuying(){
        //用户Id
        $userId = input('userId');
        //积分商品Id
        $commodityId =input('commodityId');
        //期数
        $qishu = input("qishu");
        //购买次数
        $size =  input('size');
        //得到当前商品最大值
        $maxsize = db('lotteryrules')->where("commodityId",$commodityId)->find();
        //获取当前商品已经购买了的
        $goumajilu = db('purchase')->where("commodityId",$commodityId)->where('qishu',$qishu)->order("number",'DESC')->select();
        if(empty($goumajilu)){
            $maxgoumaisize = 100000000;
        }else {
            $maxgoumaisize =  $goumajilu[0]['number'];
        }
        //循环购买次数添加数据
        for ($x=0; $x<$size; $x++) {
            $maxgoumaisize++;
            $data1 = ["commodityId"=> $commodityId,'number' => $maxgoumaisize,"userId" =>$userId,"qishu" =>$qishu];
            db('purchase')->insert($data1);
        }

        $xianDb = db('purchase')->where("commodityId",$commodityId)->where('qishu',$qishu)->order("number",'DESC')->select();
        $count = count($xianDb);
        Db::table('ls_lotteryrules')->where('commodityId', $commodityId)->update(['currenttimes' => $count]);
        return json(['status'=>200,'result'=>'成功']);
    }

    /**
     * 获取首页广告
     */
    public function getAdvertising(){
        //分类ID
        $cid =  input('cid');
        $data = db('adv')->where('cate',$cid)->order("id","ASC")->select();
        return json(['status'=>200,'result'=>$data]);
    }

    /**
     * 获取首页轮动消息
     */
    public function getOutHheNews(){
     //   $data = db('news')->select();
        $data = db('news')->where('cate',72)->select();
        return json(['status'=>200,'result'=>$data]);
    }

    /**
     * 获取更新以及客户消息
     */
    public function getUpdata(){
        $data = db('config')->select();
        return json($this ->getArray($data));
    }

    public function getArray($data){
        $array = array();
        foreach ($data as $config){
            $array['update'] = $config['is_lottery'] == 1 ? true:false;
            $array['new_version'] = $config['home_page_num'];
            $array['apk_file_url'] = $config['home_page_num'].'.apk';
            $array['update_log'] = $config['filter_keyword'];
            $array['qq_num'] = $config['qq_num'];
        }
        return $array;
    }


    public function getEverydayGood(){

    }


    
}