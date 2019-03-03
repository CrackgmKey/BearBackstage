<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件

/**
 * 系统邮件发送函数
 * @param string $tomail 接收邮件者邮箱
 * @param string $name 接收邮件者名称
 * @param string $subject 邮件主题
 * @param string $body 邮件内容
 * @param string $attachment 附件列表
 * @return boolean
 * @author static7 <static7@qq.com>
 */

function send_mail($tomail, $name, $subject = '', $body = '', $attachment = null, $config) {
	
    $mail = new \PHPMailer();           //实例化PHPMailer对象
    $mail->CharSet = 'UTF-8';           //设定邮件编码，默认ISO-8859-1，如果发中文此项必须设置，否则乱码
    $mail->IsSMTP();                    // 设定使用SMTP服务
    $mail->SMTPDebug = 0;               // SMTP调试功能 0=关闭 1 = 错误和消息 2 = 消息
    $mail->SMTPAuth = true;             // 启用 SMTP 验证功能
    $mail->SMTPSecure = 'ssl';          // 使用安全协议
    $mail->Host = $config['mail_host']; // SMTP 服务器
    $mail->Port = $config['port'];                  // SMTP服务器的端口号
    $mail->Username = $config['user_name'];    // SMTP服务器用户名
    $mail->Password = $config['password'];     // SMTP服务器密码
    $mail->SetFrom($config['user_name'], 'Author');
    $replyEmail = '';                   //留空则为发件人EMAIL
    $replyName = '';                    //回复名称（留空则为发件人名称）
    $mail->AddReplyTo($replyEmail, $replyName);
    $mail->Subject = $subject;
    $mail->MsgHTML($body);
    $mail->AddAddress($tomail, $name);
    if (is_array($attachment)) { // 添加附件
        foreach ($attachment as $file) {
            is_file($file) && $mail->AddAttachment($file);
        }
    }
    return $mail->Send() ? true : $mail->ErrorInfo;
}
//微信浏览器判断
function is_weixin(){
    if ( strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false ) {
            return true;
    }  
    return false;
}
//==========================================
// 函数: expression()
// 功能: 显示QQ表情包
// 参数: 无
//==========================================

function expression(){
	$s = '"0","微笑"],["1","撇嘴"],["2","色"],["3","发呆"],["4","得意"],["5","流泪"],["6","害羞"],["7","闭嘴"],["8","睡"],["9","大哭"],["10","尴尬"],["11","发怒"],["12","调皮"],["13","呲牙"],["14","惊讶"],["15","难过"],["16","酷"],["17","冷汗"],["18","抓狂"],["19","吐"],["20","偷笑"],["21","可爱"],["22","白眼"],["23","傲慢"],["24","饥饿"],["25","困"],["26","惊恐"],["27","流汗"],["28","憨笑"],["29","大兵"],["30","奋斗"],["31","咒骂"],["32","疑问"],["33","嘘..."],["34","晕"],["35","折磨"],["36","衰"],["37","骷髅"],["38","敲打"],["39","再见"],["40","擦汗"],["41","抠鼻"],["42","鼓掌"],["43","糗大了"],["44","坏笑"],["45","左哼哼"],["46","右哼哼"],["47","哈欠"],["48","鄙视"],["49","委屈"],["50","快哭了"],["51","阴险"],["52","亲亲"],["53","吓"],["54","可怜"],["55","菜刀"],["56","西瓜"],["57","啤酒"],["58","篮球"],["59","乒乓"],["60","咖啡"],["61","饭"],["62","猪头"],["63","玫瑰"],["64","凋谢"],["65","示爱"],["66","爱心"],["67","心碎"],["68","蛋糕"],["69","闪电"],["70","炸弹"],["71","刀"],["72","足球"],["73","瓢虫"],["74","便便"],["75","月亮"],["76","太阳"],["77","礼物"],["78","拥抱"],["79","强"],["80","弱"],["81","握手"],["82","胜利"],["83","抱拳"],["84","勾引"],["85","拳头"],["86","差劲"],["87","爱你"],["88","NO"],["89","OK"],["90","爱情"],["91","飞吻"],["92","跳跳"],["93","发抖"],["94","怄火"],["95","转圈"],["96","磕头"],["97","回头"],["98","跳绳"],["99","挥手"],["100","激动"],["101","街舞"],["102","献吻"],["103","左太极"],["104","右太极"';
	$a = explode('],[', $s);
	$html="<div class='qq_expression'><ul>";
	foreach($a as $v) {
		$b = explode(',', $v);
		$vv = str_replace('"', '', $b[0]);
		$f = 'http://res.mail.qq.com/zh_CN/images/mo/DEFAULT2/' . $vv . '.gif';
		$img_html='[exp]'.$b[1].'[/exp]';
		$html.="<li class='expression left' id='".$img_html."' style='cursor:pointer'><img src='".$f."' title=".$b[1]." /></li>";
	}
	
	$html.="</ul></div>";
	$datas=array("value"=>$a,"html"=>$html);
	return $datas;
}

function get_exp_num($str){
	$exp_datas=expression();
	foreach($exp_datas['value'] as $v) {
		$v=str_replace('"','',$v);
		$b = explode(',', $v);
		if($str==$b[1]){
			$vv = str_replace('"', '', $b[0]);
			return $vv;
			
		}
	}
	
	
}

function get_curl_json($url){
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,true);
	$result = curl_exec($ch);
	if(curl_errno($ch)){
		print_r(curl_error($ch));
	}
	curl_close($ch);
	return json_decode($result,TRUE);
}
//随机生成器
function get_rand(){
    $now = $_SERVER['REQUEST_TIME'];//当前系统时间，比time()多5秒
    return rand().$now;
}