--Version:2.2.0
--Create time:2018-06-23 11:22:59
INSERT INTO `ls_adminclass`  VALUES ('385', '插件管理');
INSERT INTO `ls_adminnode` VALUES ('470', '安装插件', 'addons', 'install', '385');
INSERT INTO `ls_adminnode` VALUES ('471', '卸载插件', 'addons', 'uninstall', '385');
DROP TABLE IF EXISTS `ls_qiniu`;
CREATE TABLE `ls_qiniu` (
  `ACCESSKEY` varchar(50) NOT NULL,
  `SECRETKEY` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `BUCKET` varchar(50) NOT NULL,
  `DOMAIN` varchar(50) NOT NULL,
  `id` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
alter table ls_config add `is_qiniu` tinyint(1) not null;
alter table ls_adv add `is_qiniu` tinyint(1) not null;
alter table ls_brand add `is_qiniu` tinyint(1) not null;
alter table ls_link add `is_qiniu` tinyint(1) not null;
alter table ls_news add `is_qiniu` tinyint(1) not null;
alter table ls_product add `is_qiniu` tinyint(1) not null;
alter table ls_productspec add `is_qiniu` tinyint(1) not null;
alter table ls_productspec modify column img varchar(100);
INSERT INTO `ls_qiniu` (`ACCESSKEY`, `SECRETKEY`, `BUCKET`, `DOMAIN`, `id`) VALUES ('test', 'test', 'test', 'test', '1');