<?php
namespace app\install\controller;
use think\Controller;
/**
 * 首页
 */
class Index extends Controller
{
  /*  //判断是否已安装
    protected function _initialize()
    {
        if (is_file(ROOT_PATH . 'public' . DS . 'install.lock')) {
            header('Location: ' . url('index/Index/index'));
            exit();
        }
        if (!defined('__ROOT__')) {
            $_root = rtrim(dirname(rtrim($_SERVER['SCRIPT_NAME'], '/')), '/');
            define('__ROOT__', (('/' == $_root || '\\' == $_root) ? '' : $_root));
        }
    }*/
    //首页
	public function index()
    {
        session('step', 1);
        session('error', false);
		return $this->fetch(':index');
    }
    public function step2()
    {
        if(session('step')!==1 && session('step')!==3 && session('step')!==2){
            $this->error('请按顺序安装！', url('install/Index/index'));
        }
        $data=array();
        $icon_correct='<i class="fa fa-check correct"></i> ';
        $icon_error='<i class="fa fa-close error"></i> ';
        //php版本、操作系统版本
        $data['phpversion'] = @phpversion();
        $data['os']=PHP_OS;
        //环境检测
        $err = 0;
        if (class_exists('pdo')) {
            $data['pdo'] = $icon_correct.'已开启';
        } else {
            $data['pdo'] = $icon_error.'未开启';
            $err++;
        }
        //扩展检测
        if (extension_loaded('pdo_mysql')) {
            $data['pdo_mysql'] = $icon_correct.'已开启';
        } else {
            $data['pdo_mysql'] =$icon_error.'未开启';
            $err++;
        }
        if (extension_loaded('curl')) {
            $data['curl'] = $icon_correct.'已开启';
        } else {
            $data['curl'] = $icon_error.'未开启';
            $err++;
        }
        if (extension_loaded('mbstring')) {
            $data['mbstring'] = $icon_correct.'已开启';
        } else {
            $data['mbstring'] = $icon_error.'未开启';
            $err++;
        }
        //设置获取
        if (ini_get('file_uploads')) {
            $data['upload_size'] = $icon_correct . ini_get('upload_max_filesize');
        } else {
            $data['upload_size'] = $icon_error.'禁止上传';
        }
        if (ini_get('allow_url_fopen')) {
            $data['allow_url_fopen'] = $icon_correct.'已开启';
        } else {
            $data['allow_url_fopen'] = $icon_error.'未开启';
            $err++;
        }
        //函数检测
        if (function_exists('file_get_contents')) {
            $data['file_get_contents'] = $icon_correct.'已开启';
        } else {
            $data['file_get_contents'] = $icon_error.'未开启';
            $err++;
        }
        if (function_exists('session_start')) {
            $data['session'] = $icon_correct.'已开启';
        } else {
            $data['session'] = $icon_error.'未开启';
            $err++;
        }
        //检测文件夹属性
        $checklist = array(
            'apps/database.php',
            'apps/install/data',
            'public',
            'runtime'
        );
        $new_checklist=array();
        foreach($checklist as $dir){
            if(is_dir($dir)){
                $testdir = "./".$dir;
                create_dir($testdir);
                if(testwrite($testdir)){
                    $new_checklist[$dir]['w']=true;
                }else{
                    $new_checklist[$dir]['w']=false;
                    $err++;
                }
                if(is_readable($testdir)){
                    $new_checklist[$dir]['r']=true;
                }else{
                    $new_checklist[$dir]['r']=false;
                    $err++;
                }
            }else{
                if(is_writable($dir)){
                    $new_checklist[$dir]['w']=true;
                }else{
                    $new_checklist[$dir]['w']=false;
                    $err++;
                }
                if(is_readable($dir)){
                    $new_checklist[$dir]['r']=true;
                }else{
                    $new_checklist[$dir]['r']=false;
                    $err++;
                }
            }
        }
        session('step', 2);
        $data['checklist']=$new_checklist;
        $this->assign($data);
        return $this->fetch(':step2');
    }
    public function step3()
    {
        if(session('step')!==2 ){
            $this->error('请按顺序安装！', url('install/Index/step2'));
        }else{
            session('step', 3);
            return $this->fetch(':step3');
        }
    }
    public function step4()
    {
        if(session('step')!==3){
            $this->error('请按顺序安装！', url('install/Index/step3'));
        }
        if(request()->isPost()){
            session("step",4);
            session('error',false);
            //创建数据库
            $dbconfig['type']="mysql";
            $dbconfig['hostname']=input('dbhost');
            $dbconfig['username']=input('dbuser');
            $dbconfig['password']=input('dbpw');
            $dbconfig['hostport']=input('dbport');
            $dbname=strtolower(input('dbname'));
            //连接数据库
            $dsn = "mysql:host={$dbconfig['hostname']};port={$dbconfig['hostport']};charset=utf8";
            try {
                $db = new \PDO($dsn, $dbconfig['username'], $dbconfig['password']);
            } catch (\PDOException $e) {
                $this->error('数据库连接失败', url('install/Index/step3'));
            }
            //建立数据库
            $sql = "CREATE DATABASE IF NOT EXISTS `{$dbname}` DEFAULT CHARACTER SET utf8";
            $db->exec($sql) || $this->error('数据库创建失败');
            //重新实例化
            $dsn = "mysql:dbname={$dbname};host={$dbconfig['hostname']};port={$dbconfig['hostport']};charset=utf8";
            try {
                $db = new \PDO($dsn, $dbconfig['username'], $dbconfig['password']);
            } catch (\PDOException $e) {
                $this->error('数据库连接失败', url('install/Index/step3'));
            }
            $dbconfig['database']=$dbname;
            $dbconfig['prefix']=trim(input('dbprefix'));
            $table_prefix=input("dbprefix");
            //显示模板
            echo $this->fetch(':step4');
            //运行sql
            execute_sql($db, "leesun.sql", $table_prefix);
            //更新配置信息
           // update_site_configs($db, $table_prefix);
            //创建管理员
            create_admin_account($db, $table_prefix);
            //生成网站配置文件
            create_config($dbconfig);
            if(session('error')){
                $this->error("安装失败",url('install/Index/step3'));
            }else{
                $this->success("即将安装完成",url('install/Index/step5'));
            }
        }else{
            exit;
        }
    }
    public function step5()
    {
        if(session('step')==4){
            @touch('./public/install.lock');
			cookie('think_var', 'zh-cn');
            session(null);
            return $this->fetch(':step5');
        }else{
            $this->error("非法安装！",url('install/Index/index'));
        }
    }
    public function testdb()
    {
        if(request()->isPost()){
            $dbconfig=input("post.");
            $dsn = "mysql:host={$dbconfig['hostname']};port={$dbconfig['hostport']};charset=utf8";
            try {
                $db = new \PDO($dsn, $dbconfig['username'], $dbconfig['password']);
            } catch (\PDOException $e) {
                die("");
            }
            try{
                $db->query("show databases;");
            }catch (\PDOException $e){
                die("");
            }
            exit("1");
        }else{
            exit("need post!");
        }
    }


  public function add(){
        $this->success('保存完成');
  /*  	   	 if (IS_GET){

         }else{
             $this->error('6666');
         }*/




    }

}
