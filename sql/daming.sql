/*
Navicat MySQL Data Transfer

Source Server         : 本机
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : daming

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-03-03 10:21:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for ls_acate
-- ----------------------------
DROP TABLE IF EXISTS `ls_acate`;
CREATE TABLE `ls_acate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_acate
-- ----------------------------
INSERT INTO `ls_acate` VALUES ('23', '首页商品轮播', '2');
INSERT INTO `ls_acate` VALUES ('30', '开屏广告', '4');

-- ----------------------------
-- Table structure for ls_addons
-- ----------------------------
DROP TABLE IF EXISTS `ls_addons`;
CREATE TABLE `ls_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `author` varchar(30) NOT NULL,
  `version` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_addons
-- ----------------------------

-- ----------------------------
-- Table structure for ls_admin
-- ----------------------------
DROP TABLE IF EXISTS `ls_admin`;
CREATE TABLE `ls_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `adm_name` varchar(255) NOT NULL,
  `adm_password` varchar(255) NOT NULL,
  `login_time` int(11) NOT NULL,
  `login_ip` varchar(255) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `group_id` int(11) NOT NULL,
  `avatar` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_adm_name` (`adm_name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_admin
-- ----------------------------
INSERT INTO `ls_admin` VALUES ('1', 'admin', '21232f297a57a5a743894a0e4a801fc3', '1551156180', '127.0.0.1', '1', '2', '');

-- ----------------------------
-- Table structure for ls_adminactlog
-- ----------------------------
DROP TABLE IF EXISTS `ls_adminactlog`;
CREATE TABLE `ls_adminactlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) NOT NULL,
  `action` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `act_time` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2016 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_adminactlog
-- ----------------------------
INSERT INTO `ls_adminactlog` VALUES ('1942', '1', 'add', 'User', '1542860646');
INSERT INTO `ls_adminactlog` VALUES ('1943', '1', 'add', 'User', '1542860661');
INSERT INTO `ls_adminactlog` VALUES ('1944', '1', 'add', 'User', '1542860674');
INSERT INTO `ls_adminactlog` VALUES ('1945', '1', 'add', 'User', '1542864907');
INSERT INTO `ls_adminactlog` VALUES ('1946', '1', 'del', 'Group', '1542864993');
INSERT INTO `ls_adminactlog` VALUES ('1947', '1', 'add', 'User', '1543214963');
INSERT INTO `ls_adminactlog` VALUES ('1948', '1', 'mod', 'User', '1543295817');
INSERT INTO `ls_adminactlog` VALUES ('1949', '1', 'mod', 'User', '1543295821');
INSERT INTO `ls_adminactlog` VALUES ('1950', '1', 'del', 'User', '1543296082');
INSERT INTO `ls_adminactlog` VALUES ('1951', '1', 'mod', 'Group', '1543296190');
INSERT INTO `ls_adminactlog` VALUES ('1952', '1', 'mod', 'Group', '1543296204');
INSERT INTO `ls_adminactlog` VALUES ('1953', '1', 'mod', 'Configs', '1543296265');
INSERT INTO `ls_adminactlog` VALUES ('1954', '1', 'mod', 'User', '1543302087');
INSERT INTO `ls_adminactlog` VALUES ('1955', '1', 'mod', 'User', '1543462843');
INSERT INTO `ls_adminactlog` VALUES ('1956', '1', 'add', 'Nav', '1543463016');
INSERT INTO `ls_adminactlog` VALUES ('1957', '1', 'add', 'Product', '1543463057');
INSERT INTO `ls_adminactlog` VALUES ('1958', '1', 'add', 'Product', '1543473032');
INSERT INTO `ls_adminactlog` VALUES ('1959', '1', 'mod', 'Product', '1543543355');
INSERT INTO `ls_adminactlog` VALUES ('1960', '1', 'mod', 'Product', '1543543376');
INSERT INTO `ls_adminactlog` VALUES ('1961', '1', 'mod', 'User', '1545356362');
INSERT INTO `ls_adminactlog` VALUES ('1962', '1', 'mod', 'User', '1545356372');
INSERT INTO `ls_adminactlog` VALUES ('1963', '1', 'add', 'News', '1545359511');
INSERT INTO `ls_adminactlog` VALUES ('1964', '1', 'add', 'Nav', '1545359522');
INSERT INTO `ls_adminactlog` VALUES ('1965', '1', 'mod', 'Nav', '1545359609');
INSERT INTO `ls_adminactlog` VALUES ('1966', '1', 'mod', 'Adv', '1545359664');
INSERT INTO `ls_adminactlog` VALUES ('1967', '1', 'del', 'Adv', '1545360724');
INSERT INTO `ls_adminactlog` VALUES ('1968', '1', 'del', 'Adv', '1545360735');
INSERT INTO `ls_adminactlog` VALUES ('1969', '1', 'del', 'Adv', '1545360739');
INSERT INTO `ls_adminactlog` VALUES ('1970', '1', 'del', 'Adv', '1545360743');
INSERT INTO `ls_adminactlog` VALUES ('1971', '1', 'mod', 'Acate', '1545454420');
INSERT INTO `ls_adminactlog` VALUES ('1972', '1', 'add', 'Nav', '1545454503');
INSERT INTO `ls_adminactlog` VALUES ('1973', '1', 'add', 'Nav', '1545454508');
INSERT INTO `ls_adminactlog` VALUES ('1974', '1', 'add', 'News', '1545454613');
INSERT INTO `ls_adminactlog` VALUES ('1975', '1', 'del', 'Adv', '1545457294');
INSERT INTO `ls_adminactlog` VALUES ('1976', '1', 'mod', 'Adv', '1547777869');
INSERT INTO `ls_adminactlog` VALUES ('1977', '1', 'mod', 'News', '1547778322');
INSERT INTO `ls_adminactlog` VALUES ('1978', '1', 'mod', 'News', '1547778326');
INSERT INTO `ls_adminactlog` VALUES ('1979', '1', 'add', 'News', '1547778379');
INSERT INTO `ls_adminactlog` VALUES ('1980', '1', 'add', 'News', '1547778394');
INSERT INTO `ls_adminactlog` VALUES ('1981', '1', 'add', 'News', '1547778399');
INSERT INTO `ls_adminactlog` VALUES ('1982', '1', 'add', 'News', '1547778411');
INSERT INTO `ls_adminactlog` VALUES ('1983', '1', 'mod', 'Configs', '1550128399');
INSERT INTO `ls_adminactlog` VALUES ('1984', '1', 'mod', 'Configs', '1550128576');
INSERT INTO `ls_adminactlog` VALUES ('1985', '1', 'mod', 'Configs', '1550128759');
INSERT INTO `ls_adminactlog` VALUES ('1986', '1', 'mod', 'Configs', '1550128769');
INSERT INTO `ls_adminactlog` VALUES ('1987', '1', 'mod', 'Configs', '1550128931');
INSERT INTO `ls_adminactlog` VALUES ('1988', '1', 'mod', 'Configs', '1550128956');
INSERT INTO `ls_adminactlog` VALUES ('1989', '1', 'mod', 'Configs', '1550129045');
INSERT INTO `ls_adminactlog` VALUES ('1990', '1', 'mod', 'Configs', '1550130295');
INSERT INTO `ls_adminactlog` VALUES ('1991', '1', 'mod', 'Configs', '1550132141');
INSERT INTO `ls_adminactlog` VALUES ('1992', '1', 'mod', 'Configs', '1550134981');
INSERT INTO `ls_adminactlog` VALUES ('1993', '1', 'mod', 'Configs', '1550209475');
INSERT INTO `ls_adminactlog` VALUES ('1994', '1', 'mod', 'Configs', '1550472021');
INSERT INTO `ls_adminactlog` VALUES ('1995', '1', 'mod', 'Configs', '1550551989');
INSERT INTO `ls_adminactlog` VALUES ('1996', '1', 'mod', 'Mails', '1550552042');
INSERT INTO `ls_adminactlog` VALUES ('1997', '1', 'test', 'Mails', '1550552050');
INSERT INTO `ls_adminactlog` VALUES ('1998', '1', 'del', 'Acate', '1551060965');
INSERT INTO `ls_adminactlog` VALUES ('1999', '1', 'del', 'Acate', '1551060969');
INSERT INTO `ls_adminactlog` VALUES ('2000', '1', 'del', 'Acate', '1551060973');
INSERT INTO `ls_adminactlog` VALUES ('2001', '1', 'del', 'Acate', '1551060978');
INSERT INTO `ls_adminactlog` VALUES ('2002', '1', 'add', 'Acate', '1551060998');
INSERT INTO `ls_adminactlog` VALUES ('2003', '1', 'mod', 'Acate', '1551061344');
INSERT INTO `ls_adminactlog` VALUES ('2004', '1', 'mod', 'Adv', '1551061371');
INSERT INTO `ls_adminactlog` VALUES ('2005', '1', 'mod', 'Adv', '1551064631');
INSERT INTO `ls_adminactlog` VALUES ('2006', '1', 'mod', 'Adv', '1551064636');
INSERT INTO `ls_adminactlog` VALUES ('2007', '1', 'mod', 'Adv', '1551064640');
INSERT INTO `ls_adminactlog` VALUES ('2008', '1', 'mod', 'Configs', '1551066005');
INSERT INTO `ls_adminactlog` VALUES ('2009', '1', 'mod', 'Configs', '1551078300');
INSERT INTO `ls_adminactlog` VALUES ('2010', '1', 'mod', 'Configs', '1551080333');
INSERT INTO `ls_adminactlog` VALUES ('2011', '1', 'add', 'News', '1551081703');
INSERT INTO `ls_adminactlog` VALUES ('2012', '1', 'add', 'Nav', '1551081756');
INSERT INTO `ls_adminactlog` VALUES ('2013', '1', 'mod', 'Nav', '1551081770');
INSERT INTO `ls_adminactlog` VALUES ('2014', '1', 'mod', 'News', '1551081783');
INSERT INTO `ls_adminactlog` VALUES ('2015', '1', 'del', 'Acate', '1551156235');

-- ----------------------------
-- Table structure for ls_adminclass
-- ----------------------------
DROP TABLE IF EXISTS `ls_adminclass`;
CREATE TABLE `ls_adminclass` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_adminclass
-- ----------------------------
INSERT INTO `ls_adminclass` VALUES ('100', '导航管理');
INSERT INTO `ls_adminclass` VALUES ('110', '单页管理');
INSERT INTO `ls_adminclass` VALUES ('120', '新闻管理');
INSERT INTO `ls_adminclass` VALUES ('130', '广告分类管理');
INSERT INTO `ls_adminclass` VALUES ('140', '广告管理');
INSERT INTO `ls_adminclass` VALUES ('150', '调查管理');
INSERT INTO `ls_adminclass` VALUES ('160', '友情链接管理');
INSERT INTO `ls_adminclass` VALUES ('170', '商品管理');
INSERT INTO `ls_adminclass` VALUES ('180', '品牌管理');
INSERT INTO `ls_adminclass` VALUES ('190', '规格管理');
INSERT INTO `ls_adminclass` VALUES ('200', '订单管理');
INSERT INTO `ls_adminclass` VALUES ('210', '支付管理');
INSERT INTO `ls_adminclass` VALUES ('220', '商品咨询');
INSERT INTO `ls_adminclass` VALUES ('230', '商品评价');
INSERT INTO `ls_adminclass` VALUES ('240', '快递管理');
INSERT INTO `ls_adminclass` VALUES ('250', '用户管理');
INSERT INTO `ls_adminclass` VALUES ('260', '用户分组管理');
INSERT INTO `ls_adminclass` VALUES ('270', '用户统计');
INSERT INTO `ls_adminclass` VALUES ('280', '评论管理');
INSERT INTO `ls_adminclass` VALUES ('290', '私信管理');
INSERT INTO `ls_adminclass` VALUES ('300', '意见反馈');
INSERT INTO `ls_adminclass` VALUES ('320', '关键字管理');
INSERT INTO `ls_adminclass` VALUES ('330', '积分抽奖');
INSERT INTO `ls_adminclass` VALUES ('340', '中奖列表');
INSERT INTO `ls_adminclass` VALUES ('346', '日志管理');
INSERT INTO `ls_adminclass` VALUES ('350', '网站设置管理');
INSERT INTO `ls_adminclass` VALUES ('360', '管理员分组管理');
INSERT INTO `ls_adminclass` VALUES ('370', '管理员设置');
INSERT INTO `ls_adminclass` VALUES ('380', '模块管理');
INSERT INTO `ls_adminclass` VALUES ('385', '插件管理');
INSERT INTO `ls_adminclass` VALUES ('390', '邮件服务器');
INSERT INTO `ls_adminclass` VALUES ('400', '邮件规则管理');
INSERT INTO `ls_adminclass` VALUES ('410', '上传文件管理');
INSERT INTO `ls_adminclass` VALUES ('420', '在线模版编辑');
INSERT INTO `ls_adminclass` VALUES ('430', '数据备份');
INSERT INTO `ls_adminclass` VALUES ('401', '短信服务器');
INSERT INTO `ls_adminclass` VALUES ('402', '短信规则管理');
INSERT INTO `ls_adminclass` VALUES ('403', '七牛云设置');

-- ----------------------------
-- Table structure for ls_admingroup
-- ----------------------------
DROP TABLE IF EXISTS `ls_admingroup`;
CREATE TABLE `ls_admingroup` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_admingroup
-- ----------------------------
INSERT INTO `ls_admingroup` VALUES ('1', '录入员', 'a:5:{i:0;s:3:\"114\";i:1;s:3:\"115\";i:2;s:3:\"116\";i:3;s:3:\"117\";i:4;s:3:\"118\";}');
INSERT INTO `ls_admingroup` VALUES ('2', '主管理员', 'a:126:{i:0;s:3:\"114\";i:1;s:3:\"115\";i:2;s:3:\"116\";i:3;s:3:\"117\";i:4;s:3:\"118\";i:5;s:3:\"120\";i:6;s:3:\"121\";i:7;s:3:\"122\";i:8;s:3:\"123\";i:9;s:3:\"131\";i:10;s:3:\"132\";i:11;s:3:\"133\";i:12;s:3:\"134\";i:13;s:3:\"141\";i:14;s:3:\"142\";i:15;s:3:\"143\";i:16;s:3:\"144\";i:17;s:3:\"151\";i:18;s:3:\"152\";i:19;s:3:\"153\";i:20;s:3:\"154\";i:21;s:3:\"161\";i:22;s:3:\"162\";i:23;s:3:\"163\";i:24;s:3:\"171\";i:25;s:3:\"172\";i:26;s:3:\"173\";i:27;s:3:\"174\";i:28;s:3:\"175\";i:29;s:3:\"181\";i:30;s:3:\"182\";i:31;s:3:\"183\";i:32;s:3:\"184\";i:33;s:3:\"185\";i:34;s:3:\"186\";i:35;s:3:\"187\";i:36;s:3:\"465\";i:37;s:3:\"191\";i:38;s:3:\"192\";i:39;s:3:\"193\";i:40;s:3:\"194\";i:41;s:3:\"195\";i:42;s:3:\"201\";i:43;s:3:\"202\";i:44;s:3:\"203\";i:45;s:3:\"204\";i:46;s:3:\"205\";i:47;s:3:\"210\";i:48;s:3:\"211\";i:49;s:3:\"212\";i:50;s:3:\"221\";i:51;s:3:\"222\";i:52;s:3:\"224\";i:53;s:3:\"231\";i:54;s:3:\"232\";i:55;s:3:\"233\";i:56;s:3:\"234\";i:57;s:3:\"462\";i:58;s:3:\"241\";i:59;s:3:\"242\";i:60;s:3:\"243\";i:61;s:3:\"460\";i:62;s:3:\"251\";i:63;s:3:\"252\";i:64;s:3:\"253\";i:65;s:3:\"254\";i:66;s:3:\"261\";i:67;s:3:\"262\";i:68;s:3:\"263\";i:69;s:3:\"264\";i:70;s:3:\"271\";i:71;s:3:\"272\";i:72;s:3:\"273\";i:73;s:3:\"274\";i:74;s:3:\"275\";i:75;s:3:\"281\";i:76;s:3:\"291\";i:77;s:3:\"292\";i:78;s:3:\"301\";i:79;s:3:\"302\";i:80;s:3:\"311\";i:81;s:3:\"312\";i:82;s:3:\"470\";i:83;s:3:\"471\";i:84;s:3:\"331\";i:85;s:3:\"332\";i:86;s:3:\"334\";i:87;s:3:\"345\";i:88;s:3:\"341\";i:89;s:3:\"342\";i:90;s:3:\"343\";i:91;s:3:\"344\";i:92;s:3:\"351\";i:93;s:3:\"352\";i:94;s:3:\"455\";i:95;s:3:\"361\";i:96;s:3:\"370\";i:97;s:3:\"371\";i:98;s:3:\"372\";i:99;s:3:\"373\";i:100;s:3:\"401\";i:101;s:3:\"402\";i:102;s:3:\"403\";i:103;s:3:\"404\";i:104;s:3:\"391\";i:105;s:3:\"392\";i:106;s:3:\"393\";i:107;s:3:\"394\";i:108;s:3:\"411\";i:109;s:3:\"412\";i:110;s:3:\"422\";i:111;s:3:\"424\";i:112;s:3:\"461\";i:113;s:3:\"432\";i:114;s:3:\"441\";i:115;s:3:\"442\";i:116;s:3:\"451\";i:117;s:3:\"452\";i:118;s:3:\"453\";i:119;s:3:\"464\";i:120;s:3:\"463\";i:121;s:3:\"466\";i:122;s:3:\"467\";i:123;s:3:\"468\";i:124;s:3:\"469\";i:125;s:3:\"472\";}');

-- ----------------------------
-- Table structure for ls_adminlog
-- ----------------------------
DROP TABLE IF EXISTS `ls_adminlog`;
CREATE TABLE `ls_adminlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) NOT NULL,
  `log_time` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `log_ip` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=387 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_adminlog
-- ----------------------------
INSERT INTO `ls_adminlog` VALUES ('374', '1', '1542860540', '127.0.0.1');
INSERT INTO `ls_adminlog` VALUES ('375', '1', '1543214927', '127.0.0.1');
INSERT INTO `ls_adminlog` VALUES ('376', '1', '1543295680', '127.0.0.1');
INSERT INTO `ls_adminlog` VALUES ('377', '1', '1543301262', '127.0.0.1');
INSERT INTO `ls_adminlog` VALUES ('378', '1', '1543462832', '127.0.0.1');
INSERT INTO `ls_adminlog` VALUES ('379', '1', '1545356348', '192.168.1.151');
INSERT INTO `ls_adminlog` VALUES ('380', '1', '1547777836', '192.168.1.134');
INSERT INTO `ls_adminlog` VALUES ('381', '1', '1550127986', '127.0.0.1');
INSERT INTO `ls_adminlog` VALUES ('382', '1', '1550209456', '127.0.0.1');
INSERT INTO `ls_adminlog` VALUES ('383', '1', '1550472009', '0.0.0.0');
INSERT INTO `ls_adminlog` VALUES ('384', '1', '1550551469', '127.0.0.1');
INSERT INTO `ls_adminlog` VALUES ('385', '1', '1551060944', '127.0.0.1');
INSERT INTO `ls_adminlog` VALUES ('386', '1', '1551156180', '127.0.0.1');

-- ----------------------------
-- Table structure for ls_adminnode
-- ----------------------------
DROP TABLE IF EXISTS `ls_adminnode`;
CREATE TABLE `ls_adminnode` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `action` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `class_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_adminnode
-- ----------------------------
INSERT INTO `ls_adminnode` VALUES ('114', '添加导航', 'nav', 'add', '100');
INSERT INTO `ls_adminnode` VALUES ('115', '编辑导航', 'nav', 'mod', '100');
INSERT INTO `ls_adminnode` VALUES ('116', '删除导航', 'nav', 'del', '100');
INSERT INTO `ls_adminnode` VALUES ('117', '更新导航排序', 'nav', 'batchSort', '100');
INSERT INTO `ls_adminnode` VALUES ('118', '修改导航显示状态', 'nav', 'changeDisplay', '100');
INSERT INTO `ls_adminnode` VALUES ('120', '添加单页', 'pcate', 'add', '110');
INSERT INTO `ls_adminnode` VALUES ('121', '编辑单页', 'pcate', 'mod', '110');
INSERT INTO `ls_adminnode` VALUES ('122', '删除单页', 'pcate', 'del', '110');
INSERT INTO `ls_adminnode` VALUES ('123', '更新单页排序', 'pcate', 'batchSort', '110');
INSERT INTO `ls_adminnode` VALUES ('131', '添加新闻', 'news', 'add', '120');
INSERT INTO `ls_adminnode` VALUES ('132', '编辑新闻', 'news', 'mod', '120');
INSERT INTO `ls_adminnode` VALUES ('133', '删除新闻', 'news', 'del', '120');
INSERT INTO `ls_adminnode` VALUES ('134', '更新新闻排序', 'news', 'batchSort', '120');
INSERT INTO `ls_adminnode` VALUES ('141', '添加广告分类', 'acate', 'add', '130');
INSERT INTO `ls_adminnode` VALUES ('142', '编辑广告分类', 'acate', 'mod', '130');
INSERT INTO `ls_adminnode` VALUES ('143', '删除广告分类', 'acate', 'del', '130');
INSERT INTO `ls_adminnode` VALUES ('144', '更新广告分类排序', 'acate', 'batchSort', '130');
INSERT INTO `ls_adminnode` VALUES ('151', '添加广告', 'adv', 'add', '140');
INSERT INTO `ls_adminnode` VALUES ('152', '编辑广告', 'adv', 'mod', '140');
INSERT INTO `ls_adminnode` VALUES ('153', '删除广告', 'adv', 'del', '140');
INSERT INTO `ls_adminnode` VALUES ('154', '更新排序', 'adv', 'batchSort', '140');
INSERT INTO `ls_adminnode` VALUES ('161', '添加调查', 'survey', 'add', '150');
INSERT INTO `ls_adminnode` VALUES ('162', '编辑调查', 'survey', 'mod', '150');
INSERT INTO `ls_adminnode` VALUES ('163', '删除调查', 'survey', 'del', '150');
INSERT INTO `ls_adminnode` VALUES ('171', '友情链接列表', 'link', 'index', '160');
INSERT INTO `ls_adminnode` VALUES ('172', '添加友情链接', 'link', 'add', '160');
INSERT INTO `ls_adminnode` VALUES ('173', '编辑友情链接', 'link', 'mod', '160');
INSERT INTO `ls_adminnode` VALUES ('174', '删除友情链接', 'link', 'del', '160');
INSERT INTO `ls_adminnode` VALUES ('175', '更新友情链接排序', 'link', 'batchSort', '160');
INSERT INTO `ls_adminnode` VALUES ('181', '商品列表', 'product', 'index', '170');
INSERT INTO `ls_adminnode` VALUES ('182', '编辑商品', 'product', 'mod', '170');
INSERT INTO `ls_adminnode` VALUES ('183', '删除商品', 'product', 'del', '170');
INSERT INTO `ls_adminnode` VALUES ('184', '添加商品', 'product', 'add', '170');
INSERT INTO `ls_adminnode` VALUES ('185', '更新商品排序', 'product', 'batchSort', '170');
INSERT INTO `ls_adminnode` VALUES ('186', '批量设置上下架', 'product', 'batchSet', '170');
INSERT INTO `ls_adminnode` VALUES ('187', '设置推荐', 'product', 'batchRecommend', '170');
INSERT INTO `ls_adminnode` VALUES ('191', '品牌列表', 'brand', 'index', '180');
INSERT INTO `ls_adminnode` VALUES ('192', '编辑品牌', 'brand', 'mod', '180');
INSERT INTO `ls_adminnode` VALUES ('193', '删除品牌', 'brand', 'del', '180');
INSERT INTO `ls_adminnode` VALUES ('194', '添加品牌', 'brand', 'add', '180');
INSERT INTO `ls_adminnode` VALUES ('195', '更新品牌排序', 'brand', 'batchSort', '180');
INSERT INTO `ls_adminnode` VALUES ('201', '规格列表', 'spec', 'index', '190');
INSERT INTO `ls_adminnode` VALUES ('202', '编辑规格', 'spec', 'mod', '190');
INSERT INTO `ls_adminnode` VALUES ('203', '删除规格', 'spec', 'del', '190');
INSERT INTO `ls_adminnode` VALUES ('204', '添加规格', 'spec', 'add', '190');
INSERT INTO `ls_adminnode` VALUES ('205', '更新规格排序', 'spec', 'batchSort', '190');
INSERT INTO `ls_adminnode` VALUES ('210', '订单列表', 'orders', 'index', '200');
INSERT INTO `ls_adminnode` VALUES ('211', '操作订单', 'orders', 'show', '200');
INSERT INTO `ls_adminnode` VALUES ('212', '删除订单', 'orders', 'del', '200');
INSERT INTO `ls_adminnode` VALUES ('221', '支付列表', 'payment', 'index', '210');
INSERT INTO `ls_adminnode` VALUES ('222', '编辑支付', 'payment', 'mod', '210');
INSERT INTO `ls_adminnode` VALUES ('224', '更新支付排序', 'payment', 'batchSort', '210');
INSERT INTO `ls_adminnode` VALUES ('231', '咨询列表', 'consult', 'index', '220');
INSERT INTO `ls_adminnode` VALUES ('232', '回复咨询', 'consult', 'feedback', '220');
INSERT INTO `ls_adminnode` VALUES ('233', '删除咨询', 'consult', 'del', '220');
INSERT INTO `ls_adminnode` VALUES ('234', '审核咨询', 'consult', 'verify', '220');
INSERT INTO `ls_adminnode` VALUES ('241', '评价列表', 'appraise', 'index', '230');
INSERT INTO `ls_adminnode` VALUES ('242', '回复评价', 'appraise', 'feedback', '230');
INSERT INTO `ls_adminnode` VALUES ('243', '删除评价', 'appraise', 'del', '230');
INSERT INTO `ls_adminnode` VALUES ('251', '快递列表', 'express', 'index', '240');
INSERT INTO `ls_adminnode` VALUES ('252', '编辑快递', 'express', 'mod', '240');
INSERT INTO `ls_adminnode` VALUES ('253', '删除快递', 'express', 'del', '240');
INSERT INTO `ls_adminnode` VALUES ('254', '添加快递', 'express', 'add', '240');
INSERT INTO `ls_adminnode` VALUES ('261', '编辑用户', 'user', 'mod', '250');
INSERT INTO `ls_adminnode` VALUES ('262', '删除用户', 'user', 'del', '250');
INSERT INTO `ls_adminnode` VALUES ('263', '批量用户设置', 'user', 'batchSet', '250');
INSERT INTO `ls_adminnode` VALUES ('264', '禁止登陆', 'user', 'changeAudit', '250');
INSERT INTO `ls_adminnode` VALUES ('271', '添加用户分组', 'group', 'add', '260');
INSERT INTO `ls_adminnode` VALUES ('272', '编辑用户分组', 'group', 'mod', '260');
INSERT INTO `ls_adminnode` VALUES ('273', '删除用户分组', 'group', 'del', '260');
INSERT INTO `ls_adminnode` VALUES ('274', '设置默认用户分组', 'group', 'changedefault', '260');
INSERT INTO `ls_adminnode` VALUES ('275', '更新用户分组排序', 'group', 'batchSort', '260');
INSERT INTO `ls_adminnode` VALUES ('281', '统计列表', 'statistic', 'index', '270');
INSERT INTO `ls_adminnode` VALUES ('291', '评论列表', 'comment', 'index', '280');
INSERT INTO `ls_adminnode` VALUES ('292', '删除评论', 'comment', 'del', '280');
INSERT INTO `ls_adminnode` VALUES ('301', '私信列表', 'letter', 'index', '290');
INSERT INTO `ls_adminnode` VALUES ('302', '删除私信', 'letter', 'del', '290');
INSERT INTO `ls_adminnode` VALUES ('311', '留言查看', 'message', 'index', '300');
INSERT INTO `ls_adminnode` VALUES ('312', '留言删除', 'message', 'del', '300');
INSERT INTO `ls_adminnode` VALUES ('331', '关键字列表', 'hotword', 'index', '320');
INSERT INTO `ls_adminnode` VALUES ('332', '编辑关键字', 'hotword', 'mod', '320');
INSERT INTO `ls_adminnode` VALUES ('333', '删除关键字', 'hotword', 'del', '320');
INSERT INTO `ls_adminnode` VALUES ('334', '添加关键字', 'hotword', 'add', '320');
INSERT INTO `ls_adminnode` VALUES ('341', '抽奖管理', 'lottery', 'index', '330');
INSERT INTO `ls_adminnode` VALUES ('342', '编辑抽奖', 'lottery', 'mod', '330');
INSERT INTO `ls_adminnode` VALUES ('343', '编辑项目', 'lotteryitem', 'mod', '330');
INSERT INTO `ls_adminnode` VALUES ('344', '删除抽奖', 'lottery', 'del', '330');
INSERT INTO `ls_adminnode` VALUES ('351', '中奖列表', 'lotterywin', 'index', '340');
INSERT INTO `ls_adminnode` VALUES ('352', '删除中奖项', 'lotterywin', 'del', '340');
INSERT INTO `ls_adminnode` VALUES ('361', '编辑网站设置', 'configs', 'mod', '350');
INSERT INTO `ls_adminnode` VALUES ('370', '管理员分组列表', 'admingroup', 'index', '360');
INSERT INTO `ls_adminnode` VALUES ('371', '添加管理员分组', 'admingroup', 'add', '360');
INSERT INTO `ls_adminnode` VALUES ('372', '编辑管理员分组', 'admingroup', 'mod', '360');
INSERT INTO `ls_adminnode` VALUES ('373', '删除管理员分组', 'admingroup', 'del', '360');
INSERT INTO `ls_adminnode` VALUES ('391', '添加模块', 'module', 'add', '380');
INSERT INTO `ls_adminnode` VALUES ('392', '编辑模块', 'module', 'mod', '380');
INSERT INTO `ls_adminnode` VALUES ('393', '删除模块', 'module', 'del', '380');
INSERT INTO `ls_adminnode` VALUES ('394', '更新模块排序', 'module', 'batchSort', '380');
INSERT INTO `ls_adminnode` VALUES ('401', '管理员列表', 'admin', 'index', '370');
INSERT INTO `ls_adminnode` VALUES ('402', '添加管理员', 'admin', 'add', '370');
INSERT INTO `ls_adminnode` VALUES ('403', '编辑管理员', 'admin', 'mod', '370');
INSERT INTO `ls_adminnode` VALUES ('404', '删除管理员', 'admin', 'del', '370');
INSERT INTO `ls_adminnode` VALUES ('411', '编辑邮件服务器', 'mails', 'mod', '390');
INSERT INTO `ls_adminnode` VALUES ('412', '发送测试邮件', 'mails', 'test', '390');
INSERT INTO `ls_adminnode` VALUES ('422', '编辑邮件规则', 'mailRules', 'mod', '400');
INSERT INTO `ls_adminnode` VALUES ('424', '批量模版设置', 'mailRules', 'batchset', '400');
INSERT INTO `ls_adminnode` VALUES ('432', '删除文件', 'invalid', 'del', '410');
INSERT INTO `ls_adminnode` VALUES ('441', '编辑列表', 'code', 'index', '420');
INSERT INTO `ls_adminnode` VALUES ('442', '编辑模版', 'code', 'mod', '420');
INSERT INTO `ls_adminnode` VALUES ('451', '添加备份', 'backup', 'dobackup', '430');
INSERT INTO `ls_adminnode` VALUES ('452', '删除备份', 'backup', 'del', '430');
INSERT INTO `ls_adminnode` VALUES ('453', '还原备份', 'backup', 'restore', '430');
INSERT INTO `ls_adminnode` VALUES ('455', '删除会员登陆日志', 'logs', 'del', '346');
INSERT INTO `ls_adminnode` VALUES ('458', '管理员操作日志列表', 'adminactlog', 'index', '348');
INSERT INTO `ls_adminnode` VALUES ('459', '删除管理员操作日志', 'adminactlog', 'del', '348');
INSERT INTO `ls_adminnode` VALUES ('460', '回复评价', 'appraise', 'mod', '230');
INSERT INTO `ls_adminnode` VALUES ('461', '是否通知设置', 'mailRules', 'changeNotice', '400');
INSERT INTO `ls_adminnode` VALUES ('462', '回复咨询', 'consult', 'mod', '220');
INSERT INTO `ls_adminnode` VALUES ('463', '数据表优化', 'backup', 'optimize', '430');
INSERT INTO `ls_adminnode` VALUES ('464', '数据表修复', 'backup', 'repair', '430');
INSERT INTO `ls_adminnode` VALUES ('465', '商品上下架', 'product', 'changestatus', '170');
INSERT INTO `ls_adminnode` VALUES ('466', '编辑短信设置', 'sms', 'mod', '401');
INSERT INTO `ls_adminnode` VALUES ('467', '发送测试短信', 'sms', 'test', '401');
INSERT INTO `ls_adminnode` VALUES ('468', '编辑短信规则', 'smsrules', 'mod', '402');
INSERT INTO `ls_adminnode` VALUES ('469', '批量模版设置', 'smsrules', 'batchset', '402');
INSERT INTO `ls_adminnode` VALUES ('345', '添加抽奖', 'Lottery', 'add', '330');
INSERT INTO `ls_adminnode` VALUES ('470', '安装插件', 'addons', 'install', '385');
INSERT INTO `ls_adminnode` VALUES ('471', '卸载插件', 'addons', 'uninstall', '385');
INSERT INTO `ls_adminnode` VALUES ('472', '编辑七牛云', 'qiniu', 'mod', '403');

-- ----------------------------
-- Table structure for ls_adv
-- ----------------------------
DROP TABLE IF EXISTS `ls_adv`;
CREATE TABLE `ls_adv` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `cate` int(11) NOT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `intro` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sort` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `click` int(10) NOT NULL,
  `is_qiniu` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_adv
-- ----------------------------
INSERT INTO `ls_adv` VALUES ('31', '品味时尚', '23', '553757100845', '品味时尚', '20171001/27661506871623.jpg', '2', '0', '2', '0');
INSERT INTO `ls_adv` VALUES ('30', '时尚都市', '23', '553757100845', '时尚都市', '20171001/35671506871629.jpg', '3', '0', '0', '0');
INSERT INTO `ls_adv` VALUES ('29', '夏日小清新', '23', '553757100845', '35831891036', '20171001/9691506871612.jpg', '1', '0', '1', '0');

-- ----------------------------
-- Table structure for ls_appraise
-- ----------------------------
DROP TABLE IF EXISTS `ls_appraise`;
CREATE TABLE `ls_appraise` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL,
  `pid` int(10) NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `reply` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `level` tinyint(1) NOT NULL COMMENT '1:好，2中，3差',
  `is_reply` tinyint(1) NOT NULL,
  `content_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `reply_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `mod_appraise_num` smallint(3) NOT NULL,
  `admin_id` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_appraise
-- ----------------------------

-- ----------------------------
-- Table structure for ls_appraisetimes
-- ----------------------------
DROP TABLE IF EXISTS `ls_appraisetimes`;
CREATE TABLE `ls_appraisetimes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) NOT NULL,
  `uid` int(10) NOT NULL,
  `times` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_appraisetimes
-- ----------------------------

-- ----------------------------
-- Table structure for ls_brand
-- ----------------------------
DROP TABLE IF EXISTS `ls_brand`;
CREATE TABLE `ls_brand` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sort` int(10) NOT NULL,
  `cate_id` int(10) NOT NULL,
  `is_qiniu` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_brand
-- ----------------------------

-- ----------------------------
-- Table structure for ls_cart
-- ----------------------------
DROP TABLE IF EXISTS `ls_cart`;
CREATE TABLE `ls_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) NOT NULL,
  `uid` int(10) NOT NULL,
  `amount` int(10) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `specs` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `add_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_cart
-- ----------------------------

-- ----------------------------
-- Table structure for ls_comment
-- ----------------------------
DROP TABLE IF EXISTS `ls_comment`;
CREATE TABLE `ls_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `top` tinyint(1) unsigned NOT NULL,
  `article_id` int(11) NOT NULL,
  `create_time` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_comment
-- ----------------------------

-- ----------------------------
-- Table structure for ls_config
-- ----------------------------
DROP TABLE IF EXISTS `ls_config`;
CREATE TABLE `ls_config` (
  `id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `site_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `key_word` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `auto_news_verify` tinyint(1) unsigned NOT NULL,
  `auto_pro_verify` tinyint(1) NOT NULL,
  `pub_news_score` int(11) NOT NULL,
  `pub_pro_score` int(11) NOT NULL,
  `score_money` int(10) NOT NULL,
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `favicon` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `water_mark` varchar(100) NOT NULL,
  `water_marked` tinyint(1) NOT NULL,
  `water_position` tinyint(1) NOT NULL,
  `thumb_width` int(4) NOT NULL,
  `thumb_height` int(4) NOT NULL,
  `template` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `home_page_num` char(5) NOT NULL,
  `admin_page_num` char(5) NOT NULL,
  `mod_appraise` smallint(3) NOT NULL,
  `every_max_score` int(11) NOT NULL,
  `closed` tinyint(1) NOT NULL,
  `site_close_html` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `telephone` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `qq_num` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `icp_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lottery_score` int(10) NOT NULL,
  `is_lottery` tinyint(1) NOT NULL,
  `filter_keyword` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `agreement` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `is_html` tinyint(1) NOT NULL,
  `score_name` varchar(100) NOT NULL,
  `upload_size` varchar(30) NOT NULL,
  `urlrewrite` varchar(30) NOT NULL,
  `is_qiniu` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_config
-- ----------------------------
INSERT INTO `ls_config` VALUES ('1', '乐尚商城开源系统', '商城,开源,cms,乐尚,网购', '乐尚商城系统，是一项基于PHP+MYSQL为核心开发的一套免费 + 开源专业商城系统。软件具执行效率高、模板自由切换、后台管理功能方便等诸多优秀特点。', '0', '0', '10', '80', '100', '20171001/198111506866672.png', 'favicon.ico', '20171001/198111506866672.png', '5', '0', '200', '200', 'default', '1.1', '20', '3', '1000', '0', '<div class=\"closed_box\"><div class=\"closed_body_top\">&nbsp;</div><div class=\"closed_body\"><div class=\"content\">网站已关闭<br/>请您稍后访问</div></div><div class=\"closed_shadow\">&nbsp;</div><div class=\"clear\">&nbsp;</div></div>', '123123123', '1171628833', '晋ICP备09007422号', '10', '0', '     1，添加删除信用卡接口。\r\n     2，添加vip认证。\r\n     3，区分自定义消费，\r\n     4，添加放弃任务接口\r\n     5，消费任务手动生成。', '<p>EWEWE</p>', '0', '积分', '1000000', 'rule1.php', '0');

-- ----------------------------
-- Table structure for ls_consult
-- ----------------------------
DROP TABLE IF EXISTS `ls_consult`;
CREATE TABLE `ls_consult` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL,
  `pid` int(10) NOT NULL,
  `question` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `answer` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `q_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `a_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_reply` tinyint(1) NOT NULL,
  `verify` tinyint(1) NOT NULL,
  `admin_id` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_consult
-- ----------------------------

-- ----------------------------
-- Table structure for ls_district
-- ----------------------------
DROP TABLE IF EXISTS `ls_district`;
CREATE TABLE `ls_district` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0',
  `district_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `sort` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=540 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_district
-- ----------------------------
INSERT INTO `ls_district` VALUES ('1', '0', '北京市', '0');
INSERT INTO `ls_district` VALUES ('2', '0', '上海市', '0');
INSERT INTO `ls_district` VALUES ('3', '0', '天津市', '0');
INSERT INTO `ls_district` VALUES ('4', '0', '重庆市', '0');
INSERT INTO `ls_district` VALUES ('5', '0', '河北省', '0');
INSERT INTO `ls_district` VALUES ('6', '0', '山西省', '0');
INSERT INTO `ls_district` VALUES ('7', '0', '内蒙古', '0');
INSERT INTO `ls_district` VALUES ('8', '0', '辽宁省', '0');
INSERT INTO `ls_district` VALUES ('9', '0', '吉林省', '0');
INSERT INTO `ls_district` VALUES ('10', '0', '黑龙江省', '0');
INSERT INTO `ls_district` VALUES ('11', '0', '江苏省', '0');
INSERT INTO `ls_district` VALUES ('12', '0', '浙江省', '0');
INSERT INTO `ls_district` VALUES ('13', '0', '安徽省', '0');
INSERT INTO `ls_district` VALUES ('14', '0', '福建省', '0');
INSERT INTO `ls_district` VALUES ('15', '0', '江西省', '0');
INSERT INTO `ls_district` VALUES ('16', '0', '山东省', '0');
INSERT INTO `ls_district` VALUES ('17', '0', '河南省', '0');
INSERT INTO `ls_district` VALUES ('18', '0', '湖北省', '0');
INSERT INTO `ls_district` VALUES ('19', '0', '湖南省', '0');
INSERT INTO `ls_district` VALUES ('20', '0', '广东省', '0');
INSERT INTO `ls_district` VALUES ('21', '0', '广西', '0');
INSERT INTO `ls_district` VALUES ('22', '0', '海南省', '0');
INSERT INTO `ls_district` VALUES ('23', '0', '四川省', '0');
INSERT INTO `ls_district` VALUES ('24', '0', '贵州省', '0');
INSERT INTO `ls_district` VALUES ('25', '0', '云南省', '0');
INSERT INTO `ls_district` VALUES ('26', '0', '西藏', '0');
INSERT INTO `ls_district` VALUES ('27', '0', '陕西省', '0');
INSERT INTO `ls_district` VALUES ('28', '0', '甘肃省', '0');
INSERT INTO `ls_district` VALUES ('29', '0', '青海省', '0');
INSERT INTO `ls_district` VALUES ('30', '0', '宁夏', '0');
INSERT INTO `ls_district` VALUES ('31', '0', '新疆', '0');
INSERT INTO `ls_district` VALUES ('32', '0', '台湾省', '0');
INSERT INTO `ls_district` VALUES ('33', '0', '香港', '0');
INSERT INTO `ls_district` VALUES ('34', '0', '澳门', '0');
INSERT INTO `ls_district` VALUES ('35', '1', '东城区', '0');
INSERT INTO `ls_district` VALUES ('36', '1', '西城区', '0');
INSERT INTO `ls_district` VALUES ('37', '1', '崇文区', '0');
INSERT INTO `ls_district` VALUES ('38', '1', '宣武区', '0');
INSERT INTO `ls_district` VALUES ('39', '1', '朝阳区', '0');
INSERT INTO `ls_district` VALUES ('40', '1', '丰台区', '0');
INSERT INTO `ls_district` VALUES ('41', '1', '石景山区', '0');
INSERT INTO `ls_district` VALUES ('42', '1', '海淀区', '0');
INSERT INTO `ls_district` VALUES ('43', '1', '门头沟区', '0');
INSERT INTO `ls_district` VALUES ('44', '1', '房山区', '0');
INSERT INTO `ls_district` VALUES ('45', '1', '通州区', '0');
INSERT INTO `ls_district` VALUES ('46', '1', '顺义区', '0');
INSERT INTO `ls_district` VALUES ('47', '1', '昌平区', '0');
INSERT INTO `ls_district` VALUES ('48', '1', '大兴区', '0');
INSERT INTO `ls_district` VALUES ('49', '1', '怀柔区', '0');
INSERT INTO `ls_district` VALUES ('50', '1', '平谷区', '0');
INSERT INTO `ls_district` VALUES ('51', '1', '密云县', '0');
INSERT INTO `ls_district` VALUES ('52', '1', '延庆县', '0');
INSERT INTO `ls_district` VALUES ('53', '2', '黄浦区', '0');
INSERT INTO `ls_district` VALUES ('54', '2', '卢湾区', '0');
INSERT INTO `ls_district` VALUES ('55', '2', '徐汇区', '0');
INSERT INTO `ls_district` VALUES ('56', '2', '长宁区', '0');
INSERT INTO `ls_district` VALUES ('57', '2', '静安区', '0');
INSERT INTO `ls_district` VALUES ('58', '2', '普陀区', '0');
INSERT INTO `ls_district` VALUES ('59', '2', '闸北区', '0');
INSERT INTO `ls_district` VALUES ('60', '2', '虹口区', '0');
INSERT INTO `ls_district` VALUES ('61', '2', '杨浦区', '0');
INSERT INTO `ls_district` VALUES ('62', '2', '闵行区', '0');
INSERT INTO `ls_district` VALUES ('63', '2', '宝山区', '0');
INSERT INTO `ls_district` VALUES ('64', '2', '嘉定区', '0');
INSERT INTO `ls_district` VALUES ('65', '2', '浦东新区', '0');
INSERT INTO `ls_district` VALUES ('66', '2', '金山区', '0');
INSERT INTO `ls_district` VALUES ('67', '2', '松江区', '0');
INSERT INTO `ls_district` VALUES ('68', '2', '青浦区', '0');
INSERT INTO `ls_district` VALUES ('69', '2', '南汇区', '0');
INSERT INTO `ls_district` VALUES ('70', '2', '奉贤区', '0');
INSERT INTO `ls_district` VALUES ('71', '2', '崇明县', '0');
INSERT INTO `ls_district` VALUES ('72', '3', '和平区', '0');
INSERT INTO `ls_district` VALUES ('73', '3', '河东区', '0');
INSERT INTO `ls_district` VALUES ('74', '3', '河西区', '0');
INSERT INTO `ls_district` VALUES ('75', '3', '南开区', '0');
INSERT INTO `ls_district` VALUES ('76', '3', '河北区', '0');
INSERT INTO `ls_district` VALUES ('77', '3', '红桥区', '0');
INSERT INTO `ls_district` VALUES ('78', '3', '塘沽区', '0');
INSERT INTO `ls_district` VALUES ('79', '3', '汉沽区', '0');
INSERT INTO `ls_district` VALUES ('80', '3', '大港区', '0');
INSERT INTO `ls_district` VALUES ('81', '3', '东丽区', '0');
INSERT INTO `ls_district` VALUES ('82', '3', '西青区', '0');
INSERT INTO `ls_district` VALUES ('83', '3', '津南区', '0');
INSERT INTO `ls_district` VALUES ('84', '3', '北辰区', '0');
INSERT INTO `ls_district` VALUES ('85', '3', '武清区', '0');
INSERT INTO `ls_district` VALUES ('86', '3', '宝坻区', '0');
INSERT INTO `ls_district` VALUES ('87', '3', '宁河县', '0');
INSERT INTO `ls_district` VALUES ('88', '3', '静海县', '0');
INSERT INTO `ls_district` VALUES ('89', '3', '蓟县', '0');
INSERT INTO `ls_district` VALUES ('90', '4', '万州区', '0');
INSERT INTO `ls_district` VALUES ('91', '4', '涪陵区', '0');
INSERT INTO `ls_district` VALUES ('92', '4', '渝中区', '0');
INSERT INTO `ls_district` VALUES ('93', '4', '大渡口区', '0');
INSERT INTO `ls_district` VALUES ('94', '4', '江北区', '0');
INSERT INTO `ls_district` VALUES ('95', '4', '沙坪坝区', '0');
INSERT INTO `ls_district` VALUES ('96', '4', '九龙坡区', '0');
INSERT INTO `ls_district` VALUES ('97', '4', '南岸区', '0');
INSERT INTO `ls_district` VALUES ('98', '4', '北碚区', '0');
INSERT INTO `ls_district` VALUES ('99', '4', '万盛区', '0');
INSERT INTO `ls_district` VALUES ('100', '4', '双桥区', '0');
INSERT INTO `ls_district` VALUES ('101', '4', '渝北区', '0');
INSERT INTO `ls_district` VALUES ('102', '4', '巴南区', '0');
INSERT INTO `ls_district` VALUES ('103', '4', '黔江区', '0');
INSERT INTO `ls_district` VALUES ('104', '4', '长寿区', '0');
INSERT INTO `ls_district` VALUES ('105', '4', '綦江县', '0');
INSERT INTO `ls_district` VALUES ('106', '4', '潼南县', '0');
INSERT INTO `ls_district` VALUES ('107', '4', '铜梁县', '0');
INSERT INTO `ls_district` VALUES ('108', '4', '大足县', '0');
INSERT INTO `ls_district` VALUES ('109', '4', '荣昌县', '0');
INSERT INTO `ls_district` VALUES ('110', '4', '璧山县', '0');
INSERT INTO `ls_district` VALUES ('111', '4', '梁平县', '0');
INSERT INTO `ls_district` VALUES ('112', '4', '城口县', '0');
INSERT INTO `ls_district` VALUES ('113', '4', '丰都县', '0');
INSERT INTO `ls_district` VALUES ('114', '4', '垫江县', '0');
INSERT INTO `ls_district` VALUES ('115', '4', '武隆县', '0');
INSERT INTO `ls_district` VALUES ('116', '4', '忠县', '0');
INSERT INTO `ls_district` VALUES ('117', '4', '开县', '0');
INSERT INTO `ls_district` VALUES ('118', '4', '云阳县', '0');
INSERT INTO `ls_district` VALUES ('119', '4', '奉节县', '0');
INSERT INTO `ls_district` VALUES ('120', '4', '巫山县', '0');
INSERT INTO `ls_district` VALUES ('121', '4', '巫溪县', '0');
INSERT INTO `ls_district` VALUES ('122', '4', '石柱', '0');
INSERT INTO `ls_district` VALUES ('123', '4', '秀山', '0');
INSERT INTO `ls_district` VALUES ('124', '4', '酉阳', '0');
INSERT INTO `ls_district` VALUES ('125', '4', '彭水', '0');
INSERT INTO `ls_district` VALUES ('126', '4', '江津市', '0');
INSERT INTO `ls_district` VALUES ('127', '4', '合川市', '0');
INSERT INTO `ls_district` VALUES ('128', '4', '永川市', '0');
INSERT INTO `ls_district` VALUES ('129', '4', '南川市', '0');
INSERT INTO `ls_district` VALUES ('130', '5', '石家庄市', '0');
INSERT INTO `ls_district` VALUES ('131', '5', '唐山市', '0');
INSERT INTO `ls_district` VALUES ('132', '5', '秦皇岛市', '0');
INSERT INTO `ls_district` VALUES ('133', '5', '邯郸市', '0');
INSERT INTO `ls_district` VALUES ('134', '5', '邢台市', '0');
INSERT INTO `ls_district` VALUES ('135', '5', '保定市', '0');
INSERT INTO `ls_district` VALUES ('136', '5', '张家口市', '0');
INSERT INTO `ls_district` VALUES ('137', '5', '承德市', '0');
INSERT INTO `ls_district` VALUES ('138', '5', '沧州市', '0');
INSERT INTO `ls_district` VALUES ('139', '5', '廊坊市', '0');
INSERT INTO `ls_district` VALUES ('140', '5', '衡水市', '0');
INSERT INTO `ls_district` VALUES ('141', '6', '太原市', '0');
INSERT INTO `ls_district` VALUES ('142', '6', '大同市', '0');
INSERT INTO `ls_district` VALUES ('143', '6', '阳泉市', '0');
INSERT INTO `ls_district` VALUES ('144', '6', '长治市', '0');
INSERT INTO `ls_district` VALUES ('145', '6', '晋城市', '0');
INSERT INTO `ls_district` VALUES ('146', '6', '朔州市', '0');
INSERT INTO `ls_district` VALUES ('147', '6', '晋中市', '0');
INSERT INTO `ls_district` VALUES ('148', '6', '运城市', '0');
INSERT INTO `ls_district` VALUES ('149', '6', '忻州市', '0');
INSERT INTO `ls_district` VALUES ('150', '6', '临汾市', '0');
INSERT INTO `ls_district` VALUES ('151', '6', '吕梁市', '0');
INSERT INTO `ls_district` VALUES ('152', '7', '呼和浩特市', '0');
INSERT INTO `ls_district` VALUES ('153', '7', '包头市', '0');
INSERT INTO `ls_district` VALUES ('154', '7', '乌海市', '0');
INSERT INTO `ls_district` VALUES ('155', '7', '赤峰市', '0');
INSERT INTO `ls_district` VALUES ('156', '7', '通辽市', '0');
INSERT INTO `ls_district` VALUES ('157', '7', '鄂尔多斯市', '0');
INSERT INTO `ls_district` VALUES ('158', '7', '呼伦贝尔市', '0');
INSERT INTO `ls_district` VALUES ('159', '7', '巴彦淖尔市', '0');
INSERT INTO `ls_district` VALUES ('160', '7', '乌兰察布市', '0');
INSERT INTO `ls_district` VALUES ('161', '7', '兴安盟', '0');
INSERT INTO `ls_district` VALUES ('162', '7', '锡林郭勒盟', '0');
INSERT INTO `ls_district` VALUES ('163', '7', '阿拉善盟', '0');
INSERT INTO `ls_district` VALUES ('164', '8', '沈阳市', '0');
INSERT INTO `ls_district` VALUES ('165', '8', '大连市', '0');
INSERT INTO `ls_district` VALUES ('166', '8', '鞍山市', '0');
INSERT INTO `ls_district` VALUES ('167', '8', '抚顺市', '0');
INSERT INTO `ls_district` VALUES ('168', '8', '本溪市', '0');
INSERT INTO `ls_district` VALUES ('169', '8', '丹东市', '0');
INSERT INTO `ls_district` VALUES ('170', '8', '锦州市', '0');
INSERT INTO `ls_district` VALUES ('171', '8', '营口市', '0');
INSERT INTO `ls_district` VALUES ('172', '8', '阜新市', '0');
INSERT INTO `ls_district` VALUES ('173', '8', '辽阳市', '0');
INSERT INTO `ls_district` VALUES ('174', '8', '盘锦市', '0');
INSERT INTO `ls_district` VALUES ('175', '8', '铁岭市', '0');
INSERT INTO `ls_district` VALUES ('176', '8', '朝阳市', '0');
INSERT INTO `ls_district` VALUES ('177', '8', '葫芦岛市', '0');
INSERT INTO `ls_district` VALUES ('178', '9', '长春市', '0');
INSERT INTO `ls_district` VALUES ('179', '9', '吉林市', '0');
INSERT INTO `ls_district` VALUES ('180', '9', '四平市', '0');
INSERT INTO `ls_district` VALUES ('181', '9', '辽源市', '0');
INSERT INTO `ls_district` VALUES ('182', '9', '通化市', '0');
INSERT INTO `ls_district` VALUES ('183', '9', '白山市', '0');
INSERT INTO `ls_district` VALUES ('184', '9', '松原市', '0');
INSERT INTO `ls_district` VALUES ('185', '9', '白城市', '0');
INSERT INTO `ls_district` VALUES ('186', '9', '延边市', '0');
INSERT INTO `ls_district` VALUES ('187', '10', '哈尔滨市', '0');
INSERT INTO `ls_district` VALUES ('188', '10', '齐齐哈尔市', '0');
INSERT INTO `ls_district` VALUES ('189', '10', '鸡西市', '0');
INSERT INTO `ls_district` VALUES ('190', '10', '鹤岗市', '0');
INSERT INTO `ls_district` VALUES ('191', '10', '双鸭山市', '0');
INSERT INTO `ls_district` VALUES ('192', '10', '大庆市', '0');
INSERT INTO `ls_district` VALUES ('193', '10', '伊春市', '0');
INSERT INTO `ls_district` VALUES ('194', '10', '佳木斯市', '0');
INSERT INTO `ls_district` VALUES ('195', '10', '七台河市', '0');
INSERT INTO `ls_district` VALUES ('196', '10', '牡丹江市', '0');
INSERT INTO `ls_district` VALUES ('197', '10', '黑河市', '0');
INSERT INTO `ls_district` VALUES ('198', '10', '绥化市', '0');
INSERT INTO `ls_district` VALUES ('199', '10', '大兴安岭', '0');
INSERT INTO `ls_district` VALUES ('200', '11', '南京市', '0');
INSERT INTO `ls_district` VALUES ('201', '11', '无锡市', '0');
INSERT INTO `ls_district` VALUES ('202', '11', '徐州市', '0');
INSERT INTO `ls_district` VALUES ('203', '11', '常州市', '0');
INSERT INTO `ls_district` VALUES ('204', '11', '苏州市', '0');
INSERT INTO `ls_district` VALUES ('205', '11', '南通市', '0');
INSERT INTO `ls_district` VALUES ('206', '11', '连云港市', '0');
INSERT INTO `ls_district` VALUES ('207', '11', '淮安市', '0');
INSERT INTO `ls_district` VALUES ('208', '11', '盐城市', '0');
INSERT INTO `ls_district` VALUES ('209', '11', '扬州市', '0');
INSERT INTO `ls_district` VALUES ('210', '11', '镇江市', '0');
INSERT INTO `ls_district` VALUES ('211', '11', '泰州市', '0');
INSERT INTO `ls_district` VALUES ('212', '11', '宿迁市', '0');
INSERT INTO `ls_district` VALUES ('213', '12', '杭州市', '0');
INSERT INTO `ls_district` VALUES ('214', '12', '宁波市', '0');
INSERT INTO `ls_district` VALUES ('215', '12', '温州市', '0');
INSERT INTO `ls_district` VALUES ('216', '12', '嘉兴市', '0');
INSERT INTO `ls_district` VALUES ('217', '12', '湖州市', '0');
INSERT INTO `ls_district` VALUES ('218', '12', '绍兴市', '0');
INSERT INTO `ls_district` VALUES ('219', '12', '金华市', '0');
INSERT INTO `ls_district` VALUES ('220', '12', '衢州市', '0');
INSERT INTO `ls_district` VALUES ('221', '12', '舟山市', '0');
INSERT INTO `ls_district` VALUES ('222', '12', '台州市', '0');
INSERT INTO `ls_district` VALUES ('223', '12', '丽水市', '0');
INSERT INTO `ls_district` VALUES ('224', '13', '合肥市', '0');
INSERT INTO `ls_district` VALUES ('225', '13', '芜湖市', '0');
INSERT INTO `ls_district` VALUES ('226', '13', '蚌埠市', '0');
INSERT INTO `ls_district` VALUES ('227', '13', '淮南市', '0');
INSERT INTO `ls_district` VALUES ('228', '13', '马鞍山市', '0');
INSERT INTO `ls_district` VALUES ('229', '13', '淮北市', '0');
INSERT INTO `ls_district` VALUES ('230', '13', '铜陵市', '0');
INSERT INTO `ls_district` VALUES ('231', '13', '安庆市', '0');
INSERT INTO `ls_district` VALUES ('232', '13', '黄山市', '0');
INSERT INTO `ls_district` VALUES ('233', '13', '滁州市', '0');
INSERT INTO `ls_district` VALUES ('234', '13', '阜阳市', '0');
INSERT INTO `ls_district` VALUES ('235', '13', '宿州市', '0');
INSERT INTO `ls_district` VALUES ('236', '13', '巢湖市', '0');
INSERT INTO `ls_district` VALUES ('237', '13', '六安市', '0');
INSERT INTO `ls_district` VALUES ('238', '13', '亳州市', '0');
INSERT INTO `ls_district` VALUES ('239', '13', '池州市', '0');
INSERT INTO `ls_district` VALUES ('240', '13', '宣城市', '0');
INSERT INTO `ls_district` VALUES ('241', '14', '福州市', '0');
INSERT INTO `ls_district` VALUES ('242', '14', '厦门市', '0');
INSERT INTO `ls_district` VALUES ('243', '14', '莆田市', '0');
INSERT INTO `ls_district` VALUES ('244', '14', '三明市', '0');
INSERT INTO `ls_district` VALUES ('245', '14', '泉州市', '0');
INSERT INTO `ls_district` VALUES ('246', '14', '漳州市', '0');
INSERT INTO `ls_district` VALUES ('247', '14', '南平市', '0');
INSERT INTO `ls_district` VALUES ('248', '14', '龙岩市', '0');
INSERT INTO `ls_district` VALUES ('249', '14', '宁德市', '0');
INSERT INTO `ls_district` VALUES ('250', '15', '南昌市', '0');
INSERT INTO `ls_district` VALUES ('251', '15', '景德镇市', '0');
INSERT INTO `ls_district` VALUES ('252', '15', '萍乡市', '0');
INSERT INTO `ls_district` VALUES ('253', '15', '九江市', '0');
INSERT INTO `ls_district` VALUES ('254', '15', '新余市', '0');
INSERT INTO `ls_district` VALUES ('255', '15', '鹰潭市', '0');
INSERT INTO `ls_district` VALUES ('256', '15', '赣州市', '0');
INSERT INTO `ls_district` VALUES ('257', '15', '吉安市', '0');
INSERT INTO `ls_district` VALUES ('258', '15', '宜春市', '0');
INSERT INTO `ls_district` VALUES ('259', '15', '抚州市', '0');
INSERT INTO `ls_district` VALUES ('260', '15', '上饶市', '0');
INSERT INTO `ls_district` VALUES ('261', '16', '济南市', '0');
INSERT INTO `ls_district` VALUES ('262', '16', '青岛市', '0');
INSERT INTO `ls_district` VALUES ('263', '16', '淄博市', '0');
INSERT INTO `ls_district` VALUES ('264', '16', '枣庄市', '0');
INSERT INTO `ls_district` VALUES ('265', '16', '东营市', '0');
INSERT INTO `ls_district` VALUES ('266', '16', '烟台市', '0');
INSERT INTO `ls_district` VALUES ('267', '16', '潍坊市', '0');
INSERT INTO `ls_district` VALUES ('268', '16', '济宁市', '0');
INSERT INTO `ls_district` VALUES ('269', '16', '泰安市', '0');
INSERT INTO `ls_district` VALUES ('270', '16', '威海市', '0');
INSERT INTO `ls_district` VALUES ('271', '16', '日照市', '0');
INSERT INTO `ls_district` VALUES ('272', '16', '莱芜市', '0');
INSERT INTO `ls_district` VALUES ('273', '16', '临沂市', '0');
INSERT INTO `ls_district` VALUES ('274', '16', '德州市', '0');
INSERT INTO `ls_district` VALUES ('275', '16', '聊城市', '0');
INSERT INTO `ls_district` VALUES ('276', '16', '滨州市', '0');
INSERT INTO `ls_district` VALUES ('277', '16', '荷泽市', '0');
INSERT INTO `ls_district` VALUES ('278', '17', '郑州市', '0');
INSERT INTO `ls_district` VALUES ('279', '17', '开封市', '0');
INSERT INTO `ls_district` VALUES ('280', '17', '洛阳市', '0');
INSERT INTO `ls_district` VALUES ('281', '17', '平顶山市', '0');
INSERT INTO `ls_district` VALUES ('282', '17', '安阳市', '0');
INSERT INTO `ls_district` VALUES ('283', '17', '鹤壁市', '0');
INSERT INTO `ls_district` VALUES ('284', '17', '新乡市', '0');
INSERT INTO `ls_district` VALUES ('285', '17', '焦作市', '0');
INSERT INTO `ls_district` VALUES ('286', '17', '濮阳市', '0');
INSERT INTO `ls_district` VALUES ('287', '17', '许昌市', '0');
INSERT INTO `ls_district` VALUES ('288', '17', '漯河市', '0');
INSERT INTO `ls_district` VALUES ('289', '17', '三门峡市', '0');
INSERT INTO `ls_district` VALUES ('290', '17', '南阳市', '0');
INSERT INTO `ls_district` VALUES ('291', '17', '商丘市', '0');
INSERT INTO `ls_district` VALUES ('292', '17', '信阳市', '0');
INSERT INTO `ls_district` VALUES ('293', '17', '周口市', '0');
INSERT INTO `ls_district` VALUES ('294', '17', '驻马店市', '0');
INSERT INTO `ls_district` VALUES ('295', '18', '武汉市', '0');
INSERT INTO `ls_district` VALUES ('296', '18', '黄石市', '0');
INSERT INTO `ls_district` VALUES ('297', '18', '十堰市', '0');
INSERT INTO `ls_district` VALUES ('298', '18', '宜昌市', '0');
INSERT INTO `ls_district` VALUES ('299', '18', '襄樊市', '0');
INSERT INTO `ls_district` VALUES ('300', '18', '鄂州市', '0');
INSERT INTO `ls_district` VALUES ('301', '18', '荆门市', '0');
INSERT INTO `ls_district` VALUES ('302', '18', '孝感市', '0');
INSERT INTO `ls_district` VALUES ('303', '18', '荆州市', '0');
INSERT INTO `ls_district` VALUES ('304', '18', '黄冈市', '0');
INSERT INTO `ls_district` VALUES ('305', '18', '咸宁市', '0');
INSERT INTO `ls_district` VALUES ('306', '18', '随州市', '0');
INSERT INTO `ls_district` VALUES ('307', '18', '恩施市', '0');
INSERT INTO `ls_district` VALUES ('308', '18', '仙桃市', '0');
INSERT INTO `ls_district` VALUES ('309', '18', '潜江市', '0');
INSERT INTO `ls_district` VALUES ('310', '18', '天门市', '0');
INSERT INTO `ls_district` VALUES ('311', '18', '神农架林区', '0');
INSERT INTO `ls_district` VALUES ('312', '19', '长沙市', '0');
INSERT INTO `ls_district` VALUES ('313', '19', '株洲市', '0');
INSERT INTO `ls_district` VALUES ('314', '19', '湘潭市', '0');
INSERT INTO `ls_district` VALUES ('315', '19', '衡阳市', '0');
INSERT INTO `ls_district` VALUES ('316', '19', '邵阳市', '0');
INSERT INTO `ls_district` VALUES ('317', '19', '岳阳市', '0');
INSERT INTO `ls_district` VALUES ('318', '19', '常德市', '0');
INSERT INTO `ls_district` VALUES ('319', '19', '张家界市', '0');
INSERT INTO `ls_district` VALUES ('320', '19', '益阳市', '0');
INSERT INTO `ls_district` VALUES ('321', '19', '郴州市', '0');
INSERT INTO `ls_district` VALUES ('322', '19', '永州市', '0');
INSERT INTO `ls_district` VALUES ('323', '19', '怀化市', '0');
INSERT INTO `ls_district` VALUES ('324', '19', '娄底市', '0');
INSERT INTO `ls_district` VALUES ('325', '19', '湘西', '0');
INSERT INTO `ls_district` VALUES ('326', '20', '广州市', '0');
INSERT INTO `ls_district` VALUES ('327', '20', '韶关市', '0');
INSERT INTO `ls_district` VALUES ('328', '20', '深圳市', '0');
INSERT INTO `ls_district` VALUES ('329', '20', '珠海市', '0');
INSERT INTO `ls_district` VALUES ('330', '20', '汕头市', '0');
INSERT INTO `ls_district` VALUES ('331', '20', '佛山市', '0');
INSERT INTO `ls_district` VALUES ('332', '20', '江门市', '0');
INSERT INTO `ls_district` VALUES ('333', '20', '湛江市', '0');
INSERT INTO `ls_district` VALUES ('334', '20', '茂名市', '0');
INSERT INTO `ls_district` VALUES ('335', '20', '肇庆市', '0');
INSERT INTO `ls_district` VALUES ('336', '20', '惠州市', '0');
INSERT INTO `ls_district` VALUES ('337', '20', '梅州市', '0');
INSERT INTO `ls_district` VALUES ('338', '20', '汕尾市', '0');
INSERT INTO `ls_district` VALUES ('339', '20', '河源市', '0');
INSERT INTO `ls_district` VALUES ('340', '20', '阳江市', '0');
INSERT INTO `ls_district` VALUES ('341', '20', '清远市', '0');
INSERT INTO `ls_district` VALUES ('342', '20', '东莞市', '0');
INSERT INTO `ls_district` VALUES ('343', '20', '中山市', '0');
INSERT INTO `ls_district` VALUES ('344', '20', '潮州市', '0');
INSERT INTO `ls_district` VALUES ('345', '20', '揭阳市', '0');
INSERT INTO `ls_district` VALUES ('346', '20', '云浮市', '0');
INSERT INTO `ls_district` VALUES ('347', '21', '南宁市', '0');
INSERT INTO `ls_district` VALUES ('348', '21', '柳州市', '0');
INSERT INTO `ls_district` VALUES ('349', '21', '桂林市', '0');
INSERT INTO `ls_district` VALUES ('350', '21', '梧州市', '0');
INSERT INTO `ls_district` VALUES ('351', '21', '北海市', '0');
INSERT INTO `ls_district` VALUES ('352', '21', '防城港市', '0');
INSERT INTO `ls_district` VALUES ('353', '21', '钦州市', '0');
INSERT INTO `ls_district` VALUES ('354', '21', '贵港市', '0');
INSERT INTO `ls_district` VALUES ('355', '21', '玉林市', '0');
INSERT INTO `ls_district` VALUES ('356', '21', '百色市', '0');
INSERT INTO `ls_district` VALUES ('357', '21', '贺州市', '0');
INSERT INTO `ls_district` VALUES ('358', '21', '河池市', '0');
INSERT INTO `ls_district` VALUES ('359', '21', '来宾市', '0');
INSERT INTO `ls_district` VALUES ('360', '21', '崇左市', '0');
INSERT INTO `ls_district` VALUES ('361', '22', '海口市', '0');
INSERT INTO `ls_district` VALUES ('362', '22', '三亚市', '0');
INSERT INTO `ls_district` VALUES ('363', '22', '五指山市', '0');
INSERT INTO `ls_district` VALUES ('364', '22', '琼海市', '0');
INSERT INTO `ls_district` VALUES ('365', '22', '儋州市', '0');
INSERT INTO `ls_district` VALUES ('366', '22', '文昌市', '0');
INSERT INTO `ls_district` VALUES ('367', '22', '万宁市', '0');
INSERT INTO `ls_district` VALUES ('368', '22', '东方市', '0');
INSERT INTO `ls_district` VALUES ('369', '22', '定安县', '0');
INSERT INTO `ls_district` VALUES ('370', '22', '屯昌县', '0');
INSERT INTO `ls_district` VALUES ('371', '22', '澄迈县', '0');
INSERT INTO `ls_district` VALUES ('372', '22', '临高县', '0');
INSERT INTO `ls_district` VALUES ('373', '22', '白沙', '0');
INSERT INTO `ls_district` VALUES ('374', '22', '昌江', '0');
INSERT INTO `ls_district` VALUES ('375', '22', '乐东', '0');
INSERT INTO `ls_district` VALUES ('376', '22', '陵水', '0');
INSERT INTO `ls_district` VALUES ('377', '22', '保亭', '0');
INSERT INTO `ls_district` VALUES ('378', '22', '琼中', '0');
INSERT INTO `ls_district` VALUES ('379', '22', '西沙群岛', '0');
INSERT INTO `ls_district` VALUES ('380', '22', '南沙群岛', '0');
INSERT INTO `ls_district` VALUES ('381', '22', '中沙群岛', '0');
INSERT INTO `ls_district` VALUES ('382', '23', '成都市', '0');
INSERT INTO `ls_district` VALUES ('383', '23', '自贡市', '0');
INSERT INTO `ls_district` VALUES ('384', '23', '攀枝花市', '0');
INSERT INTO `ls_district` VALUES ('385', '23', '泸州市', '0');
INSERT INTO `ls_district` VALUES ('386', '23', '德阳市', '0');
INSERT INTO `ls_district` VALUES ('387', '23', '绵阳市', '0');
INSERT INTO `ls_district` VALUES ('388', '23', '广元市', '0');
INSERT INTO `ls_district` VALUES ('389', '23', '遂宁市', '0');
INSERT INTO `ls_district` VALUES ('390', '23', '内江市', '0');
INSERT INTO `ls_district` VALUES ('391', '23', '乐山市', '0');
INSERT INTO `ls_district` VALUES ('392', '23', '南充市', '0');
INSERT INTO `ls_district` VALUES ('393', '23', '眉山市', '0');
INSERT INTO `ls_district` VALUES ('394', '23', '宜宾市', '0');
INSERT INTO `ls_district` VALUES ('395', '23', '广安市', '0');
INSERT INTO `ls_district` VALUES ('396', '23', '达州市', '0');
INSERT INTO `ls_district` VALUES ('397', '23', '雅安市', '0');
INSERT INTO `ls_district` VALUES ('398', '23', '巴中市', '0');
INSERT INTO `ls_district` VALUES ('399', '23', '资阳市', '0');
INSERT INTO `ls_district` VALUES ('400', '23', '阿坝', '0');
INSERT INTO `ls_district` VALUES ('401', '23', '甘孜', '0');
INSERT INTO `ls_district` VALUES ('402', '23', '凉山', '0');
INSERT INTO `ls_district` VALUES ('403', '24', '贵阳市', '0');
INSERT INTO `ls_district` VALUES ('404', '24', '六盘水市', '0');
INSERT INTO `ls_district` VALUES ('405', '24', '遵义市', '0');
INSERT INTO `ls_district` VALUES ('406', '24', '安顺市', '0');
INSERT INTO `ls_district` VALUES ('407', '24', '铜仁地区', '0');
INSERT INTO `ls_district` VALUES ('408', '24', '黔西南州', '0');
INSERT INTO `ls_district` VALUES ('409', '24', '毕节地区', '0');
INSERT INTO `ls_district` VALUES ('410', '24', '黔东南州', '0');
INSERT INTO `ls_district` VALUES ('411', '24', '黔南州', '0');
INSERT INTO `ls_district` VALUES ('412', '25', '昆明市', '0');
INSERT INTO `ls_district` VALUES ('413', '25', '曲靖市', '0');
INSERT INTO `ls_district` VALUES ('414', '25', '玉溪市', '0');
INSERT INTO `ls_district` VALUES ('415', '25', '保山市', '0');
INSERT INTO `ls_district` VALUES ('416', '25', '昭通市', '0');
INSERT INTO `ls_district` VALUES ('417', '25', '丽江市', '0');
INSERT INTO `ls_district` VALUES ('418', '25', '思茅市', '0');
INSERT INTO `ls_district` VALUES ('419', '25', '临沧市', '0');
INSERT INTO `ls_district` VALUES ('420', '25', '楚雄', '0');
INSERT INTO `ls_district` VALUES ('421', '25', '红河州', '0');
INSERT INTO `ls_district` VALUES ('422', '25', '文山州', '0');
INSERT INTO `ls_district` VALUES ('423', '25', '西双版纳州', '0');
INSERT INTO `ls_district` VALUES ('424', '25', '大理州', '0');
INSERT INTO `ls_district` VALUES ('425', '25', '德宏州', '0');
INSERT INTO `ls_district` VALUES ('426', '25', '怒江州', '0');
INSERT INTO `ls_district` VALUES ('427', '25', '迪庆州', '0');
INSERT INTO `ls_district` VALUES ('428', '26', '拉萨市', '0');
INSERT INTO `ls_district` VALUES ('429', '26', '昌都地区', '0');
INSERT INTO `ls_district` VALUES ('430', '26', '山南地区', '0');
INSERT INTO `ls_district` VALUES ('431', '26', '日喀则地区', '0');
INSERT INTO `ls_district` VALUES ('432', '26', '那曲地区', '0');
INSERT INTO `ls_district` VALUES ('433', '26', '阿里地区', '0');
INSERT INTO `ls_district` VALUES ('434', '26', '林芝地区', '0');
INSERT INTO `ls_district` VALUES ('435', '27', '西安市', '0');
INSERT INTO `ls_district` VALUES ('436', '27', '铜川市', '0');
INSERT INTO `ls_district` VALUES ('437', '27', '宝鸡市', '0');
INSERT INTO `ls_district` VALUES ('438', '27', '咸阳市', '0');
INSERT INTO `ls_district` VALUES ('439', '27', '渭南市', '0');
INSERT INTO `ls_district` VALUES ('440', '27', '延安市', '0');
INSERT INTO `ls_district` VALUES ('441', '27', '汉中市', '0');
INSERT INTO `ls_district` VALUES ('442', '27', '榆林市', '0');
INSERT INTO `ls_district` VALUES ('443', '27', '安康市', '0');
INSERT INTO `ls_district` VALUES ('444', '27', '商洛市', '0');
INSERT INTO `ls_district` VALUES ('445', '28', '兰州市', '0');
INSERT INTO `ls_district` VALUES ('446', '28', '嘉峪关市', '0');
INSERT INTO `ls_district` VALUES ('447', '28', '金昌市', '0');
INSERT INTO `ls_district` VALUES ('448', '28', '白银市', '0');
INSERT INTO `ls_district` VALUES ('449', '28', '天水市', '0');
INSERT INTO `ls_district` VALUES ('450', '28', '武威市', '0');
INSERT INTO `ls_district` VALUES ('451', '28', '张掖市', '0');
INSERT INTO `ls_district` VALUES ('452', '28', '平凉市', '0');
INSERT INTO `ls_district` VALUES ('453', '28', '酒泉市', '0');
INSERT INTO `ls_district` VALUES ('454', '28', '庆阳市', '0');
INSERT INTO `ls_district` VALUES ('455', '28', '定西市', '0');
INSERT INTO `ls_district` VALUES ('456', '28', '陇南市', '0');
INSERT INTO `ls_district` VALUES ('457', '28', '临夏', '0');
INSERT INTO `ls_district` VALUES ('458', '28', '甘南', '0');
INSERT INTO `ls_district` VALUES ('459', '29', '西宁市', '0');
INSERT INTO `ls_district` VALUES ('460', '29', '海东地区', '0');
INSERT INTO `ls_district` VALUES ('461', '29', '海北州', '0');
INSERT INTO `ls_district` VALUES ('462', '29', '黄南州', '0');
INSERT INTO `ls_district` VALUES ('463', '29', '海南州', '0');
INSERT INTO `ls_district` VALUES ('464', '29', '果洛州', '0');
INSERT INTO `ls_district` VALUES ('465', '29', '玉树州', '0');
INSERT INTO `ls_district` VALUES ('466', '29', '海西州', '0');
INSERT INTO `ls_district` VALUES ('467', '30', '银川市', '0');
INSERT INTO `ls_district` VALUES ('468', '30', '石嘴山市', '0');
INSERT INTO `ls_district` VALUES ('469', '30', '吴忠市', '0');
INSERT INTO `ls_district` VALUES ('470', '30', '固原市', '0');
INSERT INTO `ls_district` VALUES ('471', '30', '中卫市', '0');
INSERT INTO `ls_district` VALUES ('472', '31', '乌鲁木齐市', '0');
INSERT INTO `ls_district` VALUES ('473', '31', '克拉玛依市', '0');
INSERT INTO `ls_district` VALUES ('474', '31', '吐鲁番地区', '0');
INSERT INTO `ls_district` VALUES ('475', '31', '哈密地区', '0');
INSERT INTO `ls_district` VALUES ('476', '31', '昌吉州', '0');
INSERT INTO `ls_district` VALUES ('477', '31', '博州', '0');
INSERT INTO `ls_district` VALUES ('478', '31', '巴州', '0');
INSERT INTO `ls_district` VALUES ('479', '31', '阿克苏地区', '0');
INSERT INTO `ls_district` VALUES ('480', '31', '克州', '0');
INSERT INTO `ls_district` VALUES ('481', '31', '喀什地区', '0');
INSERT INTO `ls_district` VALUES ('482', '31', '和田地区', '0');
INSERT INTO `ls_district` VALUES ('483', '31', '伊犁州', '0');
INSERT INTO `ls_district` VALUES ('484', '31', '塔城地区', '0');
INSERT INTO `ls_district` VALUES ('485', '31', '阿勒泰地区', '0');
INSERT INTO `ls_district` VALUES ('486', '31', '石河子市', '0');
INSERT INTO `ls_district` VALUES ('487', '31', '阿拉尔市', '0');
INSERT INTO `ls_district` VALUES ('488', '31', '图木舒克市', '0');
INSERT INTO `ls_district` VALUES ('489', '31', '五家渠市', '0');
INSERT INTO `ls_district` VALUES ('490', '32', '台北市', '0');
INSERT INTO `ls_district` VALUES ('491', '32', '高雄市', '0');
INSERT INTO `ls_district` VALUES ('492', '32', '基隆市', '0');
INSERT INTO `ls_district` VALUES ('493', '32', '新竹市', '0');
INSERT INTO `ls_district` VALUES ('494', '32', '台中市', '0');
INSERT INTO `ls_district` VALUES ('495', '32', '嘉义市', '0');
INSERT INTO `ls_district` VALUES ('496', '32', '台南市', '0');
INSERT INTO `ls_district` VALUES ('497', '32', '台北县', '0');
INSERT INTO `ls_district` VALUES ('498', '32', '桃园县', '0');
INSERT INTO `ls_district` VALUES ('499', '32', '新竹县', '0');
INSERT INTO `ls_district` VALUES ('500', '32', '苗栗县', '0');
INSERT INTO `ls_district` VALUES ('501', '32', '台中县', '0');
INSERT INTO `ls_district` VALUES ('502', '32', '彰化县', '0');
INSERT INTO `ls_district` VALUES ('503', '32', '南投县', '0');
INSERT INTO `ls_district` VALUES ('504', '32', '云林县', '0');
INSERT INTO `ls_district` VALUES ('505', '32', '嘉义县', '0');
INSERT INTO `ls_district` VALUES ('506', '32', '台南县', '0');
INSERT INTO `ls_district` VALUES ('507', '32', '高雄县', '0');
INSERT INTO `ls_district` VALUES ('508', '32', '屏东县', '0');
INSERT INTO `ls_district` VALUES ('509', '32', '宜兰县', '0');
INSERT INTO `ls_district` VALUES ('510', '32', '花莲县', '0');
INSERT INTO `ls_district` VALUES ('511', '32', '台东县', '0');
INSERT INTO `ls_district` VALUES ('512', '32', '澎湖县', '0');
INSERT INTO `ls_district` VALUES ('513', '32', '金门县', '0');
INSERT INTO `ls_district` VALUES ('514', '32', '连江县', '0');
INSERT INTO `ls_district` VALUES ('515', '33', '中西区', '0');
INSERT INTO `ls_district` VALUES ('516', '33', '东区', '0');
INSERT INTO `ls_district` VALUES ('517', '33', '南区', '0');
INSERT INTO `ls_district` VALUES ('518', '33', '湾仔区', '0');
INSERT INTO `ls_district` VALUES ('519', '33', '九龙城区', '0');
INSERT INTO `ls_district` VALUES ('520', '33', '观塘区', '0');
INSERT INTO `ls_district` VALUES ('521', '33', '深水埗区', '0');
INSERT INTO `ls_district` VALUES ('522', '33', '黄大仙区', '0');
INSERT INTO `ls_district` VALUES ('523', '33', '油尖旺区', '0');
INSERT INTO `ls_district` VALUES ('524', '33', '离岛区', '0');

-- ----------------------------
-- Table structure for ls_express
-- ----------------------------
DROP TABLE IF EXISTS `ls_express`;
CREATE TABLE `ls_express` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sort` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_express
-- ----------------------------
INSERT INTO `ls_express` VALUES ('1', '顺风快递', '1');
INSERT INTO `ls_express` VALUES ('2', '申通快递', '2');
INSERT INTO `ls_express` VALUES ('3', '圆通快递', '3');
INSERT INTO `ls_express` VALUES ('4', '韵达快递', '4');

-- ----------------------------
-- Table structure for ls_fav
-- ----------------------------
DROP TABLE IF EXISTS `ls_fav`;
CREATE TABLE `ls_fav` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_fav
-- ----------------------------

-- ----------------------------
-- Table structure for ls_friend
-- ----------------------------
DROP TABLE IF EXISTS `ls_friend`;
CREATE TABLE `ls_friend` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `friend_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `verify` tinyint(1) NOT NULL,
  `message` varchar(254) COLLATE utf8_unicode_ci NOT NULL,
  `addtime` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_friend
-- ----------------------------

-- ----------------------------
-- Table structure for ls_group
-- ----------------------------
DROP TABLE IF EXISTS `ls_group`;
CREATE TABLE `ls_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `score` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_group
-- ----------------------------
INSERT INTO `ls_group` VALUES ('1', '普通会员', '0', '0', '1', '0');
INSERT INTO `ls_group` VALUES ('2', '白银会员', '1000', '1', '1', '0');
INSERT INTO `ls_group` VALUES ('3', '白金会员', '3000', '1', '2', '0');
INSERT INTO `ls_group` VALUES ('4', '钻石会员', '7000', '1', '3', '1');
INSERT INTO `ls_group` VALUES ('8', '中级会员', '10000', '5', '1', '0');
INSERT INTO `ls_group` VALUES ('9', '高级会员', '15000', '5', '2', '0');
INSERT INTO `ls_group` VALUES ('10', '特级会员', '25000', '5', '3', '0');

-- ----------------------------
-- Table structure for ls_hotword
-- ----------------------------
DROP TABLE IF EXISTS `ls_hotword`;
CREATE TABLE `ls_hotword` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `times` int(10) NOT NULL,
  `type` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_hotword
-- ----------------------------

-- ----------------------------
-- Table structure for ls_letter
-- ----------------------------
DROP TABLE IF EXISTS `ls_letter`;
CREATE TABLE `ls_letter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `from_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_new` tinyint(1) NOT NULL,
  `create_time` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_letter
-- ----------------------------

-- ----------------------------
-- Table structure for ls_link
-- ----------------------------
DROP TABLE IF EXISTS `ls_link`;
CREATE TABLE `ls_link` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `url` varchar(100) NOT NULL,
  `img` varchar(200) DEFAULT NULL,
  `sort` int(10) NOT NULL,
  `click` int(10) NOT NULL,
  `is_qiniu` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_link
-- ----------------------------

-- ----------------------------
-- Table structure for ls_lottery
-- ----------------------------
DROP TABLE IF EXISTS `ls_lottery`;
CREATE TABLE `ls_lottery` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `category` tinyint(1) NOT NULL,
  `total` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ls_lottery
-- ----------------------------
INSERT INTO `ls_lottery` VALUES ('1', '幸运大转盘', '1', '1', '3');

-- ----------------------------
-- Table structure for ls_lotteryitem
-- ----------------------------
DROP TABLE IF EXISTS `ls_lotteryitem`;
CREATE TABLE `ls_lotteryitem` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) NOT NULL,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `percent` tinyint(2) NOT NULL,
  `sort` tinyint(1) NOT NULL,
  `win` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_lotteryitem
-- ----------------------------
INSERT INTO `ls_lotteryitem` VALUES ('28', '1', '七等奖谢谢参与', '98', '7', '0');
INSERT INTO `ls_lotteryitem` VALUES ('27', '1', '六等奖谢谢参与', '98', '6', '0');
INSERT INTO `ls_lotteryitem` VALUES ('26', '1', '五等奖谢谢参与', '98', '5', '0');
INSERT INTO `ls_lotteryitem` VALUES ('25', '1', '四等奖谢谢参与', '98', '4', '0');
INSERT INTO `ls_lotteryitem` VALUES ('24', '1', '三等奖谢谢参与', '0', '3', '1');
INSERT INTO `ls_lotteryitem` VALUES ('23', '1', '二等奖三星手机', '0', '2', '1');
INSERT INTO `ls_lotteryitem` VALUES ('22', '1', '一等奖电热水器', '0', '1', '1');

-- ----------------------------
-- Table structure for ls_lotteryrules
-- ----------------------------
DROP TABLE IF EXISTS `ls_lotteryrules`;
CREATE TABLE `ls_lotteryrules` (
  `id` int(255) NOT NULL AUTO_INCREMENT COMMENT 'è‡ªå¢žId',
  `commodityId` int(255) DEFAULT NULL COMMENT 'å•†å“Id',
  `currenttimes` int(255) DEFAULT NULL,
  `max` int(255) DEFAULT NULL COMMENT 'æ»¡è¶³å¼€å¥–æ¬¡æ•°',
  `lotterytime` int(255) DEFAULT NULL COMMENT 'å¼€å¥–æ—¶é—´',
  `lotterytnum` int(255) DEFAULT '0' COMMENT 'ä¸­å¥–å·ç ',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ls_lotteryrules
-- ----------------------------
INSERT INTO `ls_lotteryrules` VALUES ('1', '213', '2', '100', '12312', '0');

-- ----------------------------
-- Table structure for ls_lotteryuser
-- ----------------------------
DROP TABLE IF EXISTS `ls_lotteryuser`;
CREATE TABLE `ls_lotteryuser` (
  `id` int(255) NOT NULL AUTO_INCREMENT COMMENT 'ä¸»Id',
  `userId` int(255) DEFAULT NULL COMMENT 'ç”¨æˆ·Id',
  `lotteryId` int(255) DEFAULT NULL COMMENT 'å¼€å¥–æœŸæ•°',
  `addtime` int(255) DEFAULT NULL COMMENT 'ä¸­å¥–æ—¶é—´',
  `lotterynum` int(255) DEFAULT NULL COMMENT 'å¼€å¥–å·ç ',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ls_lotteryuser
-- ----------------------------
INSERT INTO `ls_lotteryuser` VALUES ('1', '61', '1', '432531515', '1000000024');

-- ----------------------------
-- Table structure for ls_lotterywin
-- ----------------------------
DROP TABLE IF EXISTS `ls_lotterywin`;
CREATE TABLE `ls_lotterywin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) NOT NULL,
  `uid` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `create_time` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_lotterywin
-- ----------------------------
INSERT INTO `ls_lotterywin` VALUES ('53', '1', '65', '24', '18812341234', '12143t', '1542860738');
INSERT INTO `ls_lotterywin` VALUES ('54', '1', '65', '23', '18812341234', '12143t', '1542860753');

-- ----------------------------
-- Table structure for ls_mailrules
-- ----------------------------
DROP TABLE IF EXISTS `ls_mailrules`;
CREATE TABLE `ls_mailrules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `value` tinyint(1) NOT NULL,
  `template` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_mailrules
-- ----------------------------
INSERT INTO `ls_mailrules` VALUES ('1', '注册会员', 'set_reg', '注册会员成功后发送邮件通知', '1', '恭喜你成为{sitename}的会员\n你的用户名是：{username}\n你的密码是：{password}\n此邮件由系统自动发出，请勿回复！');
INSERT INTO `ls_mailrules` VALUES ('3', '确认收货', 'set_receive', '管理员确认付款后发通知邮件', '1', '亲爱的{sitename}会员{username}：\n您已收到货物!。\n');
INSERT INTO `ls_mailrules` VALUES ('4', '修改订单', 'mod_pay', '管理员改价格或支付方式后', '1', '亲爱的{username}会员：\n管理员已修改了价格。\n请登录会员中心查看。\n此信息由系统自动发送，请勿回复！');
INSERT INTO `ls_mailrules` VALUES ('5', '改收货信息', 'mod_receiving', '管理员修改收货信息后', '1', '您好，{username}，管理员已给您修改了收货地址，请到会员中心查看!');
INSERT INTO `ls_mailrules` VALUES ('7', '关闭交易', 'close_order', '管理员关闭交易后', '1', '不好意思，{username}会员，管理员已关闭了您的订单！');
INSERT INTO `ls_mailrules` VALUES ('8', '评价回复', 'appraise_reply', '管理员回复用户评价后', '1', '您好{username}，管理员已回复您的评价，请到{domain}网站登录后查询！');
INSERT INTO `ls_mailrules` VALUES ('9', '咨询回复', 'consult_reply', '管理员回复咨询后', '1', '您好{username}，管理员已回复您的商品咨询，请到{domain}网站登录后查询！');
INSERT INTO `ls_mailrules` VALUES ('12', '发布商品', 'publish_product', '用户发布商品管理员通过审核后', '1', '您好{username}，您发布的商品已审核通过，请登陆{domain}网站查看！');
INSERT INTO `ls_mailrules` VALUES ('13', '发布新闻', 'publish_news', '用户发布新闻管理员通过审核后', '1', '您好{username}，您发布的新闻已审核通过，请登陆{domain}网站查看！');
INSERT INTO `ls_mailrules` VALUES ('2', '已支付', 'set_paid', '管理员确认支付', '1', '亲爱的{username},管理员已确认支付!');
INSERT INTO `ls_mailrules` VALUES ('6', '发货', 'deliver', '管理员发货后邮件通知', '0', '亲爱的{username}，您的货物已发出，请等待收货!您的地址是{address}');

-- ----------------------------
-- Table structure for ls_mails
-- ----------------------------
DROP TABLE IF EXISTS `ls_mails`;
CREATE TABLE `ls_mails` (
  `id` int(11) NOT NULL,
  `mail_host` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `port` smallint(5) NOT NULL,
  `SMTPAuth` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_mails
-- ----------------------------
INSERT INTO `ls_mails` VALUES ('1', 'smtp.exmail.qq.com', '1977486322', '1419841262ab', '465', '1');

-- ----------------------------
-- Table structure for ls_message
-- ----------------------------
DROP TABLE IF EXISTS `ls_message`;
CREATE TABLE `ls_message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_message
-- ----------------------------

-- ----------------------------
-- Table structure for ls_mobile
-- ----------------------------
DROP TABLE IF EXISTS `ls_mobile`;
CREATE TABLE `ls_mobile` (
  `id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `title_theme` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `transitions` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `nav_theme` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `search_theme` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `index_pronav_theme` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `index_rec_theme` varchar(2) NOT NULL,
  `footer_theme` varchar(2) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_mobile
-- ----------------------------
INSERT INTO `ls_mobile` VALUES ('1', 'd', 'slidefade', 'e', 'd', 'd', 'f', 'd');

-- ----------------------------
-- Table structure for ls_module
-- ----------------------------
DROP TABLE IF EXISTS `ls_module`;
CREATE TABLE `ls_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `classname` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `is_user_pub` tinyint(1) NOT NULL,
  `sort` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT '类型：1为产品，2为新闻',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_module
-- ----------------------------
INSERT INTO `ls_module` VALUES ('31', '产品展示模块', 'product', '0', '1', '1');
INSERT INTO `ls_module` VALUES ('32', '新闻展示模块', 'news', '0', '2', '2');
INSERT INTO `ls_module` VALUES ('40', '积分商品', 'score', '0', '5', '4');

-- ----------------------------
-- Table structure for ls_nav
-- ----------------------------
DROP TABLE IF EXISTS `ls_nav`;
CREATE TABLE `ls_nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sort` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `display` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_nav
-- ----------------------------
INSERT INTO `ls_nav` VALUES ('70', '积分购', '1', '0', '40', '4', '1');
INSERT INTO `ls_nav` VALUES ('71', '最新消息', '2', '71', '32', '2', '1');
INSERT INTO `ls_nav` VALUES ('72', '首页文字轮播', '3', '0', '32', '2', '1');
INSERT INTO `ls_nav` VALUES ('73', '每日推送', '4', '0', '32', '2', '1');

-- ----------------------------
-- Table structure for ls_ncate
-- ----------------------------
DROP TABLE IF EXISTS `ls_ncate`;
CREATE TABLE `ls_ncate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_ncate
-- ----------------------------

-- ----------------------------
-- Table structure for ls_news
-- ----------------------------
DROP TABLE IF EXISTS `ls_news`;
CREATE TABLE `ls_news` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `cate` int(11) NOT NULL,
  `description` text NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `thumb` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT '',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  `verify` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_recommend` int(11) NOT NULL,
  `click` int(10) NOT NULL,
  `recommand` int(11) NOT NULL,
  `is_qiniu` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_news
-- ----------------------------
INSERT INTO `ls_news` VALUES ('64', '好劵上线欢迎使用', '72', '2', '<p>惠涛<p>1</p>', '', '1545454613', '0', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `ls_news` VALUES ('68', '我们又见面了', '73', '', '<p>123</p>', '', '1551081703', '0', '5', '0', '0', '0', '0', '0', '0');
INSERT INTO `ls_news` VALUES ('65', '发布测试', '72', '2', '<p>1</p>', '', '1547778379', '0', '2', '0', '0', '0', '0', '0', '0');
INSERT INTO `ls_news` VALUES ('66', '如果有什么意见可以提交给我', '72', '2', '<p>1</p>', '', '1547778399', '0', '3', '0', '0', '0', '0', '0', '0');
INSERT INTO `ls_news` VALUES ('67', '谢谢大家', '72', '2', '<p>1</p>', '', '1547778411', '0', '4', '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for ls_orders
-- ----------------------------
DROP TABLE IF EXISTS `ls_orders`;
CREATE TABLE `ls_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sn` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '订单号',
  `create_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '下单时间',
  `pay_status` tinyint(1) NOT NULL COMMENT '支付状态:0，未支付,1，支付成功,2,支付失败',
  `delivery_status` tinyint(1) NOT NULL COMMENT '送货状态：0,未发货,1,已发货,2,已收货',
  `order_status` tinyint(1) NOT NULL COMMENT '订单状态：0,交易失败,1,交易成功,2,已退款,3,已退货,4,已退款，已退货,5,未结单',
  `name` varchar(20) NOT NULL COMMENT '收货姓名',
  `tel` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '电话',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '地址',
  `message` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '买家留言',
  `district` smallint(5) NOT NULL COMMENT '地区主类',
  `sdistrict` smallint(5) NOT NULL COMMENT '地区子类',
  `total_price` decimal(10,2) NOT NULL COMMENT '总价',
  `delivery_fee` decimal(10,2) NOT NULL COMMENT '运费',
  `payment_id` int(10) NOT NULL COMMENT '支付ID',
  `score` int(10) NOT NULL,
  `uid` int(10) NOT NULL COMMENT '用户ID',
  `pay_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '支付时间',
  `delivery_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '发货时间',
  `order_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '订单结束时间',
  `express_id` int(10) NOT NULL DEFAULT '0',
  `express_sn` varchar(100) NOT NULL DEFAULT '0',
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_orders
-- ----------------------------

-- ----------------------------
-- Table structure for ls_ordersitem
-- ----------------------------
DROP TABLE IF EXISTS `ls_ordersitem`;
CREATE TABLE `ls_ordersitem` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) NOT NULL COMMENT '商品ID',
  `oid` int(10) NOT NULL COMMENT '订单ID',
  `amount` int(5) NOT NULL,
  `specs` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `uid` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=125 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_ordersitem
-- ----------------------------

-- ----------------------------
-- Table structure for ls_payment
-- ----------------------------
DROP TABLE IF EXISTS `ls_payment`;
CREATE TABLE `ls_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sort` int(10) unsigned NOT NULL DEFAULT '50',
  `typename` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `byname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `introduction` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `notes` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `partner_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `authkey` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `fee` varchar(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `parameter1` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `parameter2` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `parameter3` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `parameter4` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_payment
-- ----------------------------
INSERT INTO `ls_payment` VALUES ('1', '1', 'alipay', '支付宝', '全球领先的独立第三方支付平台', '支付宝，全球领先的独立第三方支付平台，致力于为广大用户提供安全快速的电子支付/网上支付/安全支付/手机支付体验，及转账收款/水电煤缴费/信用卡还款/AA收款等生活服务应用', '2016082100302320', 'MIIEpAIBAAKCAQEAsIM1QBR8NPCLPzEDu+qS5pwGjM6SD55G31pn9F3IUBxNb6mshAz7RmiDxArD53zTKIOzPk/YIb7q3G4eaheNG3+rLW/g29am7ec+/2wk5fVuxbTZe2F1LEoYKbjBo8WyEgvpJDKRx/RZ5TN3tU3m6zYelVdkWUzCPHMMGFRiZaEPApliXHsz3wR4RGrvwDEoq8rPtA0xAnR4+rSTEGjjLP5EIVKnpu0fUUXKyCxKCEZGzIfUDsaE1iNprZeIDnPg2G66iSMTHPl3liM0l7492dM44dXtA9hpPi7LPfNHVGSOZBt9QrOwtrreb32IqSWCM0kiLo7Q3+i9XJCZku/bqQIDAQABAoIBADusX/hF9KfBGpJGc8i3yOoFnYFE5MQ68iLYYYSPoATVTKiPaC9MZDatZr6EFS7RWGG+BH7wZ1UhQi07XTTouV+ujaRSymYH729GWlnnqaHEk6prNYssq3xJoFmaiHxhfY30UOFX50j+JtYBzFqS95pVNYmvfdFizde53UDsZkeM15hu8zhv4dsTpze64td5F7gv+MArZF1T0XOKHDmh0L7Uea/kOKVlLvrVR0v59w/qazLHMoeJDJWGUW2GsJDVnRcSnnLIBYY5SLvn4G+HdgfaMXuzAUNMlaYmOn6Uft9nKJ57AvAyb7PpALfzw2uEWgI2nRQQNOQcV+JV6lr+d/ECgYEA4Vu1vUzxS2FQNUAyXeFlm4R1zQ1S3Dep0Dtea0G+gTNlYirv00Ca6L42xO+ETNQh40Ug7npu3cvvNeiDj1Oz2D8uvnAUmVTL1jgdpTLU3eUfdTyL2AnllXaVbhyXZ7CZ/laozzPXZ1eHUJQclabnz5guK668gTf2SrvduraM+28CgYEAyINFrTO80EjzyN7Co3+KiEk2lpe0mBOsxTmWZp7Cqm/asNQpssfdmf0URF1JWKWW7TKcZt12tZ1riXWVCJZxrBvpK5fxH7lPVcmcCoZrsNhGlSD2XtoVS3O3Ht2diD5GDmSSmZe91I11CZIeN9XUEpIKGgKCqr9dfPMViZQjbmcCgYArOGSFlrEcTOCOJe7C9IyBJAlXtztyArbtucUk+unna40BI8z1Dgnnoztrz6fm+DQ7mzFyq0aCAS+yfhJlNZ9jVNLJMUOyGIIzZnXBDhunJt8+o8sKNvOyE5kbEh6zgzo1fjdH7eBc8HuCJ7XHucfxl3UbaZq7iZkRwjAHNCWbvwKBgQCCBvaxKeLgYt6MPUCVDAlG9ctLftdi4ydfwkdxBrUQF3cGwp7Dy+49hKuW5bPBo6gq624XGrh3b70jp7dcmUrfpD3hwidgPihfZl0lSiQdyzKCVJzPx7aVdlWi023rww5lGP0kUw2L/6uM6E9mP+jFniSk10nq9ivm8i/eRs1vMwKBgQDI9p1myricSLCUxOBi5RojHDayzY20cJuB43O+0sO8VoytAYYxdm26pAkH+NjWkXQ3viQkgh2m0qNqsrhvrvbvwbQ8YuVZlyFf2uArH2RyuPcz6SFq4NvDYdfvLEDWkDrifAOE8Kkz5YEZsJZ/mMgv5tz5qpR/zkmVz4NnzEP4GQ==', '1.5', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2Y9+RZwt4TXHu9g7CtuWl+0EG+2TltuxDto702eUnpY8zlTvHmu/wm46IIHBC0tP+CRqiAbyLrIBH8LUvJlZ018ggfXlsZhlAMYbOA5Y3DLUqfOP+p4Px1shOjiOJg2zWzw9uqJyIjKMX9EWAXH04YMcuP9X/y2p6hQQHm0PARMHYEC183RA8h+Q4kjCH0YFWGi0ylXAdAYmMg/9RATbvIs15MtgdZHe37PWYrlEwM+7cCXD8apKDDFq2QojnVVKneDO9k0w1SCkNbbdoDDK+YuhjBinL/Yku4S648LRttJnkzbrz5UNhudhgiZh8KY8PlTUw7xmxF2JkLCTNiSEaQIDAQAB', '3', 'pem/300981504533959.pem', '');
INSERT INTO `ls_payment` VALUES ('3', '3', 'cash', '货到付款', '送货上门后再收款', '送货上门后再收款，支持现金、POS机刷卡、支票支付', '', '', '0', '', '', '', '');
INSERT INTO `ls_payment` VALUES ('2', '2', 'weixinpay', '微信支付', '微信支付是集成在微信客户端的支付功能，用户可以通过手机完成快速的支', '微信支付是集成在微信客户端的支付功能，用户可以通过手机完成快速的支付流程。微信支付以绑定银行卡的快捷支付为基础，向用户提供安全、快捷、高效的支付服务。', '123123', '6666666666666', '0', '456', 'd423', '20160502192121_337.pem', 'pem/158391504535736.pem');

-- ----------------------------
-- Table structure for ls_pcate
-- ----------------------------
DROP TABLE IF EXISTS `ls_pcate`;
CREATE TABLE `ls_pcate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_pcate
-- ----------------------------
INSERT INTO `ls_pcate` VALUES ('23', '关于我们', '<p><span style=\"color: rgb(88, 86, 86); font-family: Simsun; font-size: 14px; line-height: 25px; text-indent: 28px; white-space: normal;\">乐尚商城系统，是一项基于PHP+MYSQL为核心开发的一套免费 + 开源专业商城系统。软件具执行效率高、模板自由切换、后台管理功能方便等诸多优秀特点。<br/></span><span style=\"color: rgb(88, 86, 86); font-family: Simsun; font-size: 14px; line-height: 25px; text-indent: 28px; white-space: normal;\"></span></p><p style=\"color: rgb(88, 86, 86); font-family: Simsun; font-size: 14px; line-height: 25px; text-indent: 28px; white-space: normal;\">&nbsp; &nbsp; 本软件是基于Web应用的B/S架构的商城网站建设解决方案的建站系统。它可以让用户高效、快速、低成本的构建个性化、专业化、强大功能的团购网站。从技术层面来看，本程序采用目前软件开发IT业界较为流行的PHP和MYSQL数据库开发技术，基于面向对象的编程，模版与代码分离MVC架构。从功能层面来看，分为模块管理，可以将您发布的新闻或商品增加权限，通过积分等级形式访问，具有评论，私信、好友，评价等功能。本软件管理员后台具有人性化的参数配置、支付管理、邮件服务器配置、各模式权限管理，迅速的帮助有热情、有志向投入运营商城网站的客户建立属于自己的商城网站。从而在你当地抢得先机。再则你也有多余的时间和精力放在网站的宣传和业务运营上。 乐尚商城软件不只是帮你建立商城网站，作为我们的用户，我们还将提供网站安装、使用指导、网站故障排除、BUG提交及时解决；当然在功能、模版升级以及定制方面用户都可以得到很好的技术保障。另外在以后功能以及风格样式的升级方面，我们都将虚心听从用户的建议和指导。希望我们能与运营团购网站的您携手共同提高，共同进步。</p><p style=\"color: rgb(88, 86, 86); font-family: Simsun; font-size: 14px; line-height: 25px; text-indent: 28px; white-space: normal;\">&nbsp; &nbsp; &nbsp;我们一直坚持“以人才为根本，以市场为导向，以质量为保证，以服务为宗旨”的理念。致力为用户提供最优秀的网站和商城系统平台建设以及相关咨询、培训和实时服务提供整体解决方案。<br/>&nbsp; &nbsp; &nbsp;QQ群:307867520<br/><br/>版本:1.0.5--------------------------------------//版本:1.0.5--------------------------------------//<br/>1.后台增加会员搜索功能（用户名、邮箱、电话）;<br/>2.后台增加会员修改功能（密码、邮箱、积分等);<br/>3.加入会员注册时间以及登陆时间<br/>4.修复安装程序新建数据库错误<br/>5.修复商品评价管理员回复后不更新回复时间问题<br/>6.修复购物车提交订单后依然存在的错误<br/>7.后台文章管理增加推荐次数显示<br/>8.修复后台管理员分组新增分组的样式排列以及增加全选按钮问题<br/>9.修复新会员发布商品不为空的错误<br/>10.增加新注册会员直接登陆进入会员中心功能<br/>11.修复新闻一级分类不显示的错误以及网站位置链接的错误<br/>12.增加导航显示与隐藏设置<br/>13.修复了部分后台空白的错误<br/>14.修改了后台登陆提示时间过长<br/>15.修复前台原价与现价错误<br/>16.后台增加在线升级模块（一键升级）<br/>17.修复后台数据还原错误<br/><br/><br/>版本:1.1.0-------------------------------------//<br/>1.添加后台还原数据进行版本比较<br/>2.修复缓存开启后后台广告列表不能翻页的错误<br/>3.增加友情链接功能<br/>4.修复后台模块管理修改时不能修改类型的问题<br/>5.后台模块管理增加普通商品与品牌商品模块<br/>6.增加后台结束订单删除功能<br/>7.修复后台导航隐藏后前台依然显示的问题<br/>8.后台增加搜索关键字管理<br/>9.后台网站设置增加收藏夹图标上传<br/>10.修复后台无效图片管理ICO图标显示为无效错误<br/>11.后台模块增加品牌商品类型<br/>12.后台增加清除即时运行缓存功能<br/>13.后台增加发送测试邮件功能<br/>14.优化前台会员查找密码发邮件功能<br/>15.后台邮件服务器增加发送测试邮件功能<br/>16.后台增加发送邮件规则<br/>17.前台增加按邮件规则发送邮件<br/>18.前台修复顶部LOGO后台不能更改的问题<br/><br/><br/>版本:1.1.3-------------------------------------//<br/>1.修复提交订单时不填用户留言时的错误<br/>2.修复返回购物车时收货地区不显示的错误<br/>3.增加未安装系统时直接进入安装界面<br/>4.后台增加会员统计功能<br/>5.后台增加在线模板编辑功能<br/>6.后台增加用户统计功能<br/>7.增加前台品牌栏目<br/><br/><br/><br/><br/>版本:1.1.4-------------------------------------//<br/>1.紧急修复支付宝不能支付的错误<br/>2.修复还原数据错误<br/>3.后台网站设置增加网站关闭与设置关闭内容功能<br/>4.增加安装时如果有备份直接恢复备份数据功能<br/>18.前台修复顶部LOGO后台不能更改的问题<br/><br/>版本:1.1.4.1-------------------------------------//<br/>1.紧急修复前台会员注册不成功的错误<br/>2.紧急修复安装时选择备份文件后安装不成功的错误</p><p style=\"color: rgb(88, 86, 86); font-family: Simsun; font-size: 14px; line-height: 25px; text-indent: 28px; white-space: normal;\"><br/></p><p style=\"color: rgb(88, 86, 86); font-family: Simsun; font-size: 14px; line-height: 25px; text-indent: 28px; white-space: normal;\">乐尚商城 v1.1.7 更新日志：</p><p style=\"color: rgb(88, 86, 86); font-family: Simsun; font-size: 14px; line-height: 25px; text-indent: 28px; white-space: normal;\">1.修改首页与商品索引页显示推荐商品<br/><span style=\"line-height: 1.5;\">2.修复后台管理员会话到期直接退出框架到登陆窗口<br/></span><span style=\"line-height: 1.5;\">3.增加管理员可以对用户是否禁用登陆<br/></span><span style=\"line-height: 1.5;\">4.后台无效图片管理更名为无效文件管理并优化<br/></span><span style=\"line-height: 1.5;\">5.增加咨询电话、QQ、ICP备案内容设置及前端显示<br/></span><span style=\"line-height: 1.5;\">6.修复安装默认超级管理员权限不足的错误<br/></span><span style=\"line-height: 1.5;\">7.增加商品自动生成图片缩略图功能，提升页面访问速度<br/></span><span style=\"line-height: 1.5;\">8.后台设置增加缩略图尺寸设置<br/></span><span style=\"line-height: 1.5;\">9.后台设置可否增加水印以及水印位置<br/></span><span style=\"line-height: 1.5;\">10.增加转盘积分抽奖功能</span></p><p><br/></p>', '1');
INSERT INTO `ls_pcate` VALUES ('24', '帮助中心', '<p>帮助中心</p>', '2');
INSERT INTO `ls_pcate` VALUES ('25', '诚聘英才', '&lt;p&gt;&lt;span style=&quot;font-family: &amp;#39;microsoft yahei&amp;#39;; font-size: 12px; text-align: -webkit-center; white-space: normal;&quot;&gt;诚聘英才&lt;/span&gt;&lt;/p&gt;', '3');
INSERT INTO `ls_pcate` VALUES ('26', '联系我们', '&lt;p&gt;&lt;span style=&quot;font-family: &amp;#39;microsoft yahei&amp;#39;; font-size: 12px; text-align: -webkit-center; white-space: normal;&quot;&gt;联系我们&lt;/span&gt;&lt;/p&gt;', '4');
INSERT INTO `ls_pcate` VALUES ('27', '网站合作', '&lt;p&gt;&lt;span style=&quot;font-family: &amp;#39;microsoft yahei&amp;#39;; font-size: 12px; text-align: -webkit-center; white-space: normal;&quot;&gt;网站合作&lt;/span&gt;&lt;/p&gt;', '5');
INSERT INTO `ls_pcate` VALUES ('28', '版权说明', '<p><span style=\"font-family: &#39;microsoft yahei&#39;; font-size: 12px; text-align: -webkit-center; white-space: normal;\"><img src=\"http://localhost/lsnew/public/ueditor/php/upload/20170805/15019442121169.jpg\" _src=\"http://localhost/lsnew/public/ueditor/php/upload/20170805/15019442121169.jpg\"/>版权说明1</span></p>', '6');

-- ----------------------------
-- Table structure for ls_product
-- ----------------------------
DROP TABLE IF EXISTS `ls_product`;
CREATE TABLE `ls_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '商品名称',
  `img` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品主图',
  `thumb` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `serial_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '商品编码',
  `brand_id` int(10) NOT NULL COMMENT '品牌ID',
  `cate_id` int(10) NOT NULL COMMENT '分类ID',
  `origin_price` decimal(10,2) NOT NULL COMMENT '原价',
  `current_price` decimal(10,2) NOT NULL COMMENT '现价',
  `brief` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '介绍',
  `specifications` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '规格参数介绍',
  `inventory` int(10) NOT NULL COMMENT '库存',
  `delivery_fee` decimal(10,2) NOT NULL COMMENT '运费',
  `spec_main` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `click` int(10) NOT NULL COMMENT '浏览量',
  `is_recommend` tinyint(1) NOT NULL,
  `add_time` varchar(50) NOT NULL,
  `update_time` varchar(50) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL,
  `sort` int(10) NOT NULL,
  `verify` tinyint(1) unsigned NOT NULL,
  `user_id` tinyint(1) unsigned NOT NULL,
  `is_qiniu` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_product
-- ----------------------------
INSERT INTO `ls_product` VALUES ('61', '积分购测试商品', '20171001/35671506871629.png', '20181129/thumb_49651543463057.png', '20181129114417640', '0', '70', '998.00', '0.00', '<p>123</p>', '<p>213</p>', '5000', '0.00', '', '0', '2', '1543463057', '1543543376', '1', '1', '0', '0', '0');
INSERT INTO `ls_product` VALUES ('62', '积分购测试商品1', '20181130/101931543543355.png', null, '20181129023032172', '0', '70', '998.00', '9.00', '<p>99</p>', '<p>999</p>', '999', '99.00', '', '0', '2', '1543473032', '1543543355', '1', '2', '0', '0', '0');

-- ----------------------------
-- Table structure for ls_productspec
-- ----------------------------
DROP TABLE IF EXISTS `ls_productspec`;
CREATE TABLE `ls_productspec` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `specs` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `origin_price` decimal(10,2) NOT NULL,
  `current_price` decimal(10,2) NOT NULL,
  `inventory` int(10) NOT NULL,
  `pid` int(10) NOT NULL,
  `img` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `is_qiniu` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=189 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_productspec
-- ----------------------------

-- ----------------------------
-- Table structure for ls_profav
-- ----------------------------
DROP TABLE IF EXISTS `ls_profav`;
CREATE TABLE `ls_profav` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_profav
-- ----------------------------

-- ----------------------------
-- Table structure for ls_purchase
-- ----------------------------
DROP TABLE IF EXISTS `ls_purchase`;
CREATE TABLE `ls_purchase` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `commodityId` int(255) DEFAULT NULL COMMENT 'å•†å“Id',
  `number` int(255) DEFAULT NULL COMMENT 'å¹¸è¿Id',
  `userId` int(255) DEFAULT NULL,
  `qishu` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4121 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of ls_purchase
-- ----------------------------
INSERT INTO `ls_purchase` VALUES ('4111', '213', '100000001', '99', '215');
INSERT INTO `ls_purchase` VALUES ('4112', '213', '100000002', '99', '215');
INSERT INTO `ls_purchase` VALUES ('4113', '213', '100000003', '99', '215');
INSERT INTO `ls_purchase` VALUES ('4114', '213', '100000004', '99', '215');
INSERT INTO `ls_purchase` VALUES ('4115', '213', '100000005', '99', '215');
INSERT INTO `ls_purchase` VALUES ('4116', '213', '100000006', '99', '215');
INSERT INTO `ls_purchase` VALUES ('4117', '213', '100000007', '99', '215');
INSERT INTO `ls_purchase` VALUES ('4118', '213', '100000008', '99', '215');
INSERT INTO `ls_purchase` VALUES ('4119', '213', '100000009', '99', '215');
INSERT INTO `ls_purchase` VALUES ('4120', '213', '100000010', '99', '215');

-- ----------------------------
-- Table structure for ls_qiniu
-- ----------------------------
DROP TABLE IF EXISTS `ls_qiniu`;
CREATE TABLE `ls_qiniu` (
  `ACCESSKEY` varchar(50) NOT NULL,
  `SECRETKEY` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `BUCKET` varchar(50) NOT NULL,
  `DOMAIN` varchar(50) NOT NULL,
  `id` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_qiniu
-- ----------------------------
INSERT INTO `ls_qiniu` VALUES ('test', 'test', 'test', 'test', '1');

-- ----------------------------
-- Table structure for ls_scorecart
-- ----------------------------
DROP TABLE IF EXISTS `ls_scorecart`;
CREATE TABLE `ls_scorecart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) NOT NULL,
  `uid` int(10) NOT NULL,
  `amount` int(10) NOT NULL,
  `score` int(10) NOT NULL,
  `add_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_scorecart
-- ----------------------------

-- ----------------------------
-- Table structure for ls_sms
-- ----------------------------
DROP TABLE IF EXISTS `ls_sms`;
CREATE TABLE `ls_sms` (
  `id` int(11) NOT NULL,
  `appkey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `secretKey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `signature` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_sms
-- ----------------------------
INSERT INTO `ls_sms` VALUES ('1', 'dd', 'bb', 'ccc');

-- ----------------------------
-- Table structure for ls_smsrules
-- ----------------------------
DROP TABLE IF EXISTS `ls_smsrules`;
CREATE TABLE `ls_smsrules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `value` tinyint(1) NOT NULL,
  `template` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_smsrules
-- ----------------------------
INSERT INTO `ls_smsrules` VALUES ('1', '注册会员', 'set_reg', '注册会员成功后发送短信通知', '1', '恭喜你成为{sitename}的会员\n你的用户名是：{username}\n你的密码是：{password}\n此邮件由系统自动发出，请勿回复！');
INSERT INTO `ls_smsrules` VALUES ('3', '确认收货', 'set_receive', '管理员确认付款后发短信邮件', '1', '亲爱的{sitename}会员{username}：\n您已收到货物!。\n');
INSERT INTO `ls_smsrules` VALUES ('4', '修改订单', 'mod_pay', '管理员改价格或支付方式后', '1', '亲爱的{username}会员：\n管理员已修改了价格。\n请登录会员中心查看。\n此信息由系统自动发送，请勿回复！');
INSERT INTO `ls_smsrules` VALUES ('5', '改收货信息', 'mod_receiving', '管理员修改收货信息后', '1', '您好，{username}，管理员已给您修改了收货地址，请到会员中心查看!');
INSERT INTO `ls_smsrules` VALUES ('7', '关闭交易', 'close_order', '管理员关闭交易后', '1', '不好意思，{username}会员，管理员已关闭了您的订单！');
INSERT INTO `ls_smsrules` VALUES ('8', '评价回复', 'appraise_reply', '管理员回复用户评价后', '1', '您好{username}，管理员已回复您的评价，请到{domain}网站登录后查询！');
INSERT INTO `ls_smsrules` VALUES ('9', '咨询回复', 'consult_reply', '管理员回复咨询后', '1', '您好{username}，管理员已回复您的商品咨询，请到{domain}网站登录后查询！');
INSERT INTO `ls_smsrules` VALUES ('12', '发布商品', 'publish_product', '用户发布商品管理员通过审核后', '1', '您好{username}，您发布的商品已审核通过，请登陆{domain}网站查看！');
INSERT INTO `ls_smsrules` VALUES ('13', '发布新闻', 'publish_news', '用户发布新闻管理员通过审核后', '1', '您好{username}，您发布的新闻已审核通过，请登陆{domain}网站查看！');
INSERT INTO `ls_smsrules` VALUES ('2', '已支付', 'set_paid', '管理员确认支付', '1', '亲爱的{username},管理员已确认支付!');
INSERT INTO `ls_smsrules` VALUES ('6', '发货', 'deliver', '管理员发货后短信通知', '0', '亲爱的{username}，您的货物已发出，请等待收货!您的地址是{address}');

-- ----------------------------
-- Table structure for ls_spec
-- ----------------------------
DROP TABLE IF EXISTS `ls_spec`;
CREATE TABLE `ls_spec` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sort` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `cate_id` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ls_spec
-- ----------------------------

-- ----------------------------
-- Table structure for ls_survey
-- ----------------------------
DROP TABLE IF EXISTS `ls_survey`;
CREATE TABLE `ls_survey` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `item1` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `item2` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `item3` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `item4` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `item5` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `result` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_survey
-- ----------------------------

-- ----------------------------
-- Table structure for ls_user
-- ----------------------------
DROP TABLE IF EXISTS `ls_user`;
CREATE TABLE `ls_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `signature` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ran_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `score` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `reg_time` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `log_time` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `account` int(11) NOT NULL,
  `audit` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=141 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_user
-- ----------------------------

-- ----------------------------
-- Table structure for ls_userlog
-- ----------------------------
DROP TABLE IF EXISTS `ls_userlog`;
CREATE TABLE `ls_userlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL,
  `log_time` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `log_ip` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=92 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ls_userlog
-- ----------------------------
INSERT INTO `ls_userlog` VALUES ('86', '65', '1542860703', '127.0.0.1');
INSERT INTO `ls_userlog` VALUES ('87', '65', '1542860925', '127.0.0.1');
INSERT INTO `ls_userlog` VALUES ('88', '65', '1542860931', '127.0.0.1');
INSERT INTO `ls_userlog` VALUES ('89', '65', '1543296074', '127.0.0.1');
INSERT INTO `ls_userlog` VALUES ('90', '136', '1550551674', '127.0.0.1');
INSERT INTO `ls_userlog` VALUES ('91', '136', '1550551767', '127.0.0.1');
