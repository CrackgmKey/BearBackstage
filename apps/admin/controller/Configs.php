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
use think\config;
use app\admin\model\Config as ConfigModel;

class Configs extends AdminBase
{
	private $alias=array("","config_site","config_img","config_fun");
	
    public function index($id = ''){
		
		$config=ConfigModel::get(1);
		$datas=$config->append(['water_position'])->find();
		switch($config->urlrewrite){
			case '':
			case 'original.php':
				$datas['ch_name']='原生规则';
			break;
			case 'rule1.php':
				$datas['ch_name']='静态规则1';
			break;
		}
		$path=str_replace("\\","/",LS_ROOT.'public/urlrewrite');
		$filelist=\files\Simfile::getSubFile($path);
		foreach($filelist as $k=>$v){
			$filelist[$k]=array('name'=>basename($v));
			switch(basename($v)){
				case 'original.php':
					$filelist[$k]['ch_name']='原生规则';
				break;
				case 'rule1.php':
					$filelist[$k]['ch_name']='静态规则1';
				break;
			}
		}
		$this->assign("filelist",$filelist);
		$this->assign("datas",$datas);
        return $this->fetch($this->alias[$id]);
    }
	
	public function mod(Request $request){
		
		$config = ConfigModel::get(1);
		$data=$request->param();
		$up_dir=date("Ymd",time())."/";
		$logo = $request->file('logo');
        if (!empty($logo)) {
            $info = $logo->rule("get_rand")->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
			$data['logo']=$up_dir.$info->getFilename();
        }
		$favicon = $request->file('favicon');
        if (!empty($favicon)) {
            $info = $favicon->rule("get_rand")->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
			$data['favicon']=$up_dir.$info->getFilename();
        }
		$water_mark = $request->file('water_mark');
        if (!empty($water_mark)) {
            $info = $water_mark->rule("get_rand")->move(ROOT_PATH . 'public' . DS . 'uploads/'.$up_dir);
			$data['water_mark']=$up_dir.$info->getFilename();
        }
		
		$configData['version']=Config::get('version');
		if(isset($data['template'])){
			$configData['index_theme']=$data['template'];
		} else {
			$configData['index_theme']=$config->template;
		}
		if(isset($data['is_html'])){
			$configData['url_html_suffix']=$data['is_html']?'html':'';
			//$configData['pathinfo_depr']=$data['is_html']?'__':'/';
			$configData['pathinfo_depr']='/';
			if($data['is_html']){
				$path=str_replace("\\","/",LS_ROOT.'public/urlrewrite/'.$data['urlrewrite']);
				
			} else {
				$path=str_replace("\\","/",LS_ROOT.'public/urlrewrite/original.php');
				
			}
			$rewriteUrlData=file_get_contents($path);
			$this->writeUrl($rewriteUrlData);
		} else {
			$configData['url_html_suffix']=$config->is_html?'html':'';
			$configData['pathinfo_depr']='/';
		}
		
		$res=$config->allowField(true)->save($data);
		if($res!==false){
			$this->writeConfig($configData);
			$this->success("更改配置成功");
		} else {
			$this->error("更改配置失败");
		}
		
	}
	
	public function writeUrl($data){
		
		//写入文件 
		$file=LS_ROOT."apps/route.php"; 
		\files\Simfile::write($file,$data);
		
	}
	
	public function writeConfig($data){
		$aString = '<?php $define_config = '.var_export($data, true).';return $define_config;';  
		//写入文件 
		$file=LS_ROOT."public/config.php"; 
		\files\Simfile::write($file,$aString);
		
	}
}
