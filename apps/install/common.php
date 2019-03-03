<?php
use think\Db;
use think\Request;
use think\Response;
/*
*	测试是否可写
*	rainfer <81818832@qq.com>
*/
function testwrite($d)
{
    $tfile = "_test.txt";
    $fp = @fopen($d . "/" . $tfile, "w");
    if (!$fp) {
        return false;
    }
    fclose($fp);
    $rs = @unlink($d . "/" . $tfile);
    if ($rs) {
        return true;
    }
    return false;
}
/*
*	建立文件夹
*	rainfer <81818832@qq.com>
*/
function create_dir($path)
{
    if (is_dir($path))
        return true;
    $path = dir_path($path);
    $temp = explode('/', $path);
    $cur_dir = '';
    $max = count($temp) - 1;
    for ($i = 0; $i < $max; $i++) {
        $cur_dir .= $temp[$i] . '/';
        if (@is_dir($cur_dir))
            continue;
        @mkdir($cur_dir, 0777, true);
        @chmod($cur_dir, 0777);
    }
    return is_dir($path);
}
/*
*	返回路径
*	rainfer <81818832@qq.com>
*/
function dir_path($path)
{
    $path = str_replace('\\', '/', $path);
    if (substr($path, -1) != '/')
        $path = $path . '/';
    return $path;
}
/*
*	执行sql文件
*	rainfer <81818832@qq.com>
*/
function execute_sql($db,$file,$tablepre)
{
    //读取SQL文件
    $sql = file_get_contents(APP_PATH. request()->module().'/data/'.$file);
    $sql = str_replace("\r", "\n", $sql);
    $sql = explode(";\n", $sql);
    //替换表前缀
    $default_tablepre = "ls_";
    $sql = str_replace(" `{$default_tablepre}", " `{$tablepre}", $sql);
    //开始安装
    showmsg('开始安装数据库...');
    foreach ($sql as $item) {
        $item = trim($item);
        if(empty($item)) continue;
        preg_match('/CREATE TABLE `([^ ]*)`/', $item, $matches);
        if($matches) {
            $table_name = $matches[1];
            $msg  = "创建数据表{$table_name}";
            if(false !== $db->exec($item)){
                showmsg($msg . ' 完成');
            } else {
                session('error', true);
                showmsg($msg . ' 失败！', 'error');
            }
        } else {
            $db->exec($item);
        }
    
    }
}

function showmsg($msg, $class = '')
{
    echo "<script type=\"text/javascript\">showmsg(\"{$msg}\", \"{$class}\")</script>";
    flush();
    ob_flush();
}
/*
*	更新系统设置
*	rainfer <81818832@qq.com>
*/
function update_site_configs($db,$table_prefix)
{
    $sitename=input("sitename");
    $siteurl=input("siteurl");
    $seo_keywords=input("sitekeywords");
    $seo_description=input("siteinfo");
    $site_options=<<<helllo
            {
            		"site_name":"$sitename",
					"key_word":"$seo_keywords",
					"description":"$seo_description"
        }
		
helllo;
    $sql="INSERT INTO `{$table_prefix}config` (option_value,option_name) VALUES ('$site_options','site_options')";
    $db->exec($sql);
    
    showmsg("网站信息配置成功!");
}
/*
*	创建管理员
*	rainfer <81818832@qq.com>
*/
function create_admin_account($db,$table_prefix)
{
    $username=input("manager");
    $password=md5(input("manager_pwd"));
    $email=input("manager_email");
    $create_date=time();
    $ip=request()->ip();
    $sql =<<<hello
    INSERT INTO `{$table_prefix}admin` 
    (id, adm_name, adm_password, login_time,login_ip, is_default, group_id, avatar) VALUES
    ('1', '{$username}', '{$password}','','{$ip}','1', '2','');
	
hello;
    $db->exec($sql);
    showmsg("管理员账号创建成功!");
}

/**
 * 返回带协议的域名
 * @author rainfer <81818832@qq.com>
 */
function get_host()
{
    $host=$_SERVER["HTTP_HOST"];
    $protocol=Request::instance()->isSsl()?"https://":"http://";
    return $protocol.$host;
}
/*
*	写入配置
*	rainfer <81818832@qq.com>
*/
function create_config($config)
{
    if(is_array($config)){
        //读取配置内容
        $conf = file_get_contents(APP_PATH. request()->module(). '/data/database.php');
        //替换配置项
        foreach ($config as $key => $value) {
            $conf = str_replace("#{$key}#", $value, $conf);
        }
        //写入应用配置文件
        if(file_put_contents(APP_PATH. 'database.php', $conf)){
            showmsg('配置文件写入成功');
        } else {
            session('error', true);
            showmsg('配置文件写入失败！', 'error');
        }
        return '';
    }
}