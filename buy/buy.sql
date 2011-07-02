/*
SQLyog Enterprise - MySQL GUI v6.56
MySQL - 5.0.51b-community-nt : Database - buy
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`buy` /*!40100 DEFAULT CHARACTER SET utf8 */;

/*Table structure for table `brand` */

DROP TABLE IF EXISTS `brand`;

CREATE TABLE `brand` (
  `ID` int(11) unsigned NOT NULL auto_increment COMMENT '自增',
  `Name` varchar(255) NOT NULL default '' COMMENT '品牌中文名',
  `EngName` varchar(255) NOT NULL default '' COMMENT 'English Name',
  `SiteURL` varchar(255) NOT NULL default '' COMMENT '品牌官方网址',
  `DefaultVisuality` enum('LOGO','NORMAL TEXT','BOLD TEXT') NOT NULL default 'NORMAL TEXT',
  `DefaultTextUnderLogo` varchar(255) NOT NULL default '' COMMENT '品牌logo下的说明文字',
  `DefaultSalesMessage` text COMMENT '品牌销售说明',
  `LogoFile` varchar(255) NOT NULL default '' COMMENT 'logo的路径',
  `LogoWidth` smallint(5) unsigned NOT NULL default '0' COMMENT 'logo宽度',
  `LogoHeight` smallint(5) unsigned NOT NULL default '0' COMMENT 'logo高度',
  `Type` enum('Brand','Manufacturer') NOT NULL default 'Manufacturer' COMMENT '品牌类型（商店，品牌）',
  `Description` varchar(255) NOT NULL default '' COMMENT '描述',
  `r_OnlineProductCount` int(11) unsigned NOT NULL default '0' COMMENT '线上产品数',
  `r_TotalProductCount` int(11) unsigned NOT NULL default '0' COMMENT '总共产品数',
  `r_Popularity` int(11) unsigned NOT NULL default '0' COMMENT '受欢迎度',
  `AddDate` timestamp NOT NULL default '2000-01-01 08:00:00' COMMENT '增加时间',
  `Status` enum('DELETE','ACTIVE') NOT NULL default 'ACTIVE',
  `BrandSEOName` varchar(255) NOT NULL default '',
  `URLName` varchar(255) NOT NULL default '',
  `LastChangeDate` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `brand` */

/*Table structure for table `c3article` */

DROP TABLE IF EXISTS `c3article`;

CREATE TABLE `c3article` (
  `ID` int(11) NOT NULL auto_increment,
  `catid` smallint(5) NOT NULL default '0',
  `title` varchar(150) NOT NULL default '',
  `content` longtext NOT NULL,
  `author` varchar(30) NOT NULL default '',
  `author_email` varchar(60) NOT NULL default '',
  `keywords` varchar(255) NOT NULL default '',
  `article_type` tinyint(1) unsigned NOT NULL default '2',
  `is_open` tinyint(1) unsigned NOT NULL default '1',
  `add_time` int(10) unsigned NOT NULL default '0',
  `file_url` varchar(255) NOT NULL default '',
  `open_type` tinyint(1) unsigned NOT NULL default '0',
  `link` varchar(255) NOT NULL default '',
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`ID`),
  KEY `cat_id` (`catid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `c3article` */

/*Table structure for table `c3articlecat` */

DROP TABLE IF EXISTS `c3articlecat`;

CREATE TABLE `c3articlecat` (
  `ID` smallint(5) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `type` tinyint(1) unsigned NOT NULL default '1',
  `keywords` varchar(255) NOT NULL default '',
  `desc` varchar(255) NOT NULL default '',
  `parent_id` smallint(5) unsigned NOT NULL default '0',
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `c3articlecat` */

/*Table structure for table `c3category` */

DROP TABLE IF EXISTS `c3category`;

CREATE TABLE `c3category` (
  `id` int(11) NOT NULL auto_increment COMMENT '★',
  `CategoryID` int(11) unsigned NOT NULL COMMENT '★CategoryID',
  `Name` varchar(128) NOT NULL default '' COMMENT '★Category Name',
  `EngName` varchar(128) default '' COMMENT '★Category English Name',
  `SEAlias` text COMMENT 'Search alias?',
  `Type` enum('Normal','BMV','FreeText','Structured','Special') NOT NULL default 'Normal' COMMENT '★',
  `Description` text COMMENT '★Category description',
  `IsActive` enum('YES','NO') NOT NULL default 'YES' COMMENT '★If the category is avtive',
  `IsValid` enum('YES','NO') NOT NULL default 'YES' COMMENT '★If the category is valid',
  `externalURL` varchar(512) NOT NULL default '',
  `r_OnlineProductCount` int(11) unsigned NOT NULL default '0' COMMENT '★',
  `r_CPCOnlineProductCount` int(11) unsigned NOT NULL default '0',
  `r_TotalProductCount` int(11) unsigned NOT NULL default '0' COMMENT '★',
  `r_CPCTotalProductCount` int(11) unsigned NOT NULL default '0',
  `r_Popularity` int(11) unsigned NOT NULL default '0' COMMENT '★',
  `AddDate` timestamp NULL default NULL COMMENT '★',
  `LastChangeDate` timestamp NOT NULL default CURRENT_TIMESTAMP COMMENT '★',
  `URLName` varchar(255) NOT NULL default '' COMMENT '★',
  `SearchName` varchar(255) NOT NULL default '' COMMENT '★',
  `SingularName` varchar(128) NOT NULL default '' COMMENT '★单数的',
  `PluralName` varchar(255) NOT NULL default '',
  `CategorySEOtext` varchar(255) NOT NULL default '',
  `IsSEOModify` enum('YES','NO') NOT NULL default 'NO',
  `r_KeywordRevenue` decimal(10,4) NOT NULL default '0.0000',
  PRIMARY KEY  (`id`,`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `c3category` */

/*Table structure for table `c3merchantbidproduct` */

DROP TABLE IF EXISTS `c3merchantbidproduct`;

CREATE TABLE `c3merchantbidproduct` (
  `ID` int(11) unsigned NOT NULL auto_increment,
  `OfferID` int(11) unsigned NOT NULL default '0',
  `MerchantID` int(11) unsigned NOT NULL default '0',
  `ProductID` int(11) unsigned NOT NULL default '0',
  `UniquePID` int(11) unsigned NOT NULL default '0',
  `ProductName` varchar(255) NOT NULL default '',
  `ProductSKU` varchar(255) NOT NULL default '',
  `BrandName` varchar(255) NOT NULL default '',
  `ProductDescription` text,
  `CategoryName` text,
  `ShippingCostFix` decimal(11,2) NOT NULL default '0.00',
  `Price` decimal(11,2) NOT NULL default '0.00',
  `ListPrice` decimal(11,2) NOT NULL default '0.00',
  `CurrencySymbol` char(3) NOT NULL default '' COMMENT 'Abbr of currency.',
  `URL` text,
  `ImageURL` text,
  `DisplayLogo` enum('YES','NO','FREE') NOT NULL default 'NO' COMMENT 'corresponding to r_LogoCPC',
  `StockStatus` enum('In Stock','Out Of Stock','Special Order','Pre Order','Unknown') NOT NULL default 'Unknown',
  `PriceStatus` enum('WLINK','WOLINK') NOT NULL default 'WLINK',
  `SpecialOffer` varchar(1000) NOT NULL default '',
  `ProductCondition` varchar(255) NOT NULL default '',
  `MerRank` char(33) NOT NULL default '000000000000000000000000000000000',
  `r_Coupon` smallint(5) NOT NULL default '0',
  `r_CPC` decimal(5,2) NOT NULL default '0.00',
  `r_CPCCurrency` char(3) NOT NULL default '' COMMENT 'Abbr of currency.',
  `r_ExtraCPC` decimal(5,2) NOT NULL default '0.00',
  `r_LogoCPC` decimal(5,2) NOT NULL default '0.00',
  `r_BusinessType` enum('CPC','CPA','CPC-H','FREE') NOT NULL default 'CPC',
  `AddDate` timestamp NULL default NULL,
  `MerchantSKU` varchar(255) NOT NULL default '',
  `LastChangeDate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Position` int(11) NOT NULL default '0',
  `r_CategoryID` int(11) NOT NULL default '0',
  PRIMARY KEY  (`ID`,`OfferID`),
  UNIQUE KEY `MerchantProduct` (`MerchantID`,`ProductID`),
  KEY `ProductID` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `c3merchantbidproduct` */

/*Table structure for table `c3product` */

DROP TABLE IF EXISTS `c3product`;

CREATE TABLE `c3product` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `ProductID` int(11) unsigned NOT NULL default '0' COMMENT 'ProductID',
  `UniquePID` int(11) unsigned NOT NULL default '0' COMMENT 'Global Product ID',
  `Name` varchar(500) NOT NULL default '' COMMENT 'Product Name',
  `EngName` varchar(400) default '' COMMENT 'Product English Name',
  `BrandID` int(11) NOT NULL default '0',
  `BrandName` varchar(255) NOT NULL default '',
  `HasImage` enum('YES','NO') NOT NULL default 'NO' COMMENT 'If it has image',
  `Brief` varchar(500) default '' COMMENT 'Brief',
  `Description` text COMMENT 'description',
  `AddDate` timestamp NULL default NULL COMMENT 'Add date',
  `r_Popularity` int(11) unsigned NOT NULL default '0' COMMENT 'Product popularity',
  `r_Spec` enum('YES','NO') NOT NULL default 'NO' COMMENT 'If the product has spec',
  `r_AvgRating` decimal(5,2) NOT NULL default '0.00',
  `r_ImageCount` smallint(5) NOT NULL default '0',
  `LastChangeDate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`,`ProductID`),
  UNIQUE KEY `UniquePID` (`UniquePID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `c3product` */

/*Table structure for table `c3productcategory` */

DROP TABLE IF EXISTS `c3productcategory`;

CREATE TABLE `c3productcategory` (
  `ID` int(11) unsigned NOT NULL auto_increment,
  `ProductID` int(11) unsigned NOT NULL default '0',
  `CategoryID` int(11) unsigned NOT NULL default '0',
  `AddDate` timestamp NULL default NULL,
  `LastChangeDate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`,`ProductID`),
  KEY `CategoryID` (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `c3productcategory` */

/*Table structure for table `c3productextendinfo` */

DROP TABLE IF EXISTS `c3productextendinfo`;

CREATE TABLE `c3productextendinfo` (
  `ID` int(11) unsigned NOT NULL auto_increment,
  `ProductID` int(11) unsigned NOT NULL default '0',
  `Info` text,
  `InfoType` varchar(50) default NULL,
  `AddDate` timestamp NULL default NULL,
  `LastChangeDate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`),
  KEY `ProductID` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `c3productextendinfo` */

/*Table structure for table `c3productimage` */

DROP TABLE IF EXISTS `c3productimage`;

CREATE TABLE `c3productimage` (
  `ID` int(11) unsigned NOT NULL auto_increment,
  `ImageID` int(11) unsigned NOT NULL default '0' COMMENT 'Product ImageID',
  `ProductID` int(11) unsigned NOT NULL default '0' COMMENT 'ProductID',
  `ImageWidth` smallint(5) unsigned NOT NULL default '0',
  `ImageHeight` smallint(5) unsigned NOT NULL default '0',
  `Sequence` smallint(5) unsigned NOT NULL default '0' COMMENT 'Product Image Sequence',
  `ImageFileSize` int(11) unsigned NOT NULL default '0' COMMENT 'Product Image File size',
  `ImageFileMD5` char(32) NOT NULL default '' COMMENT 'MD5 value for this images',
  `IsMain` enum('YES','NO') NOT NULL default 'NO' COMMENT 'If the picture is treated as the main it',
  `AddDate` timestamp NULL default NULL,
  `LastChangeDate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `UK_ProdID_ImgID` (`ProductID`,`ImageID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `c3productimage` */

/*Table structure for table `c3productreview` */

DROP TABLE IF EXISTS `c3productreview`;

CREATE TABLE `c3productreview` (
  `ID` int(11) NOT NULL default '0',
  `ChannelID` int(11) NOT NULL default '0',
  `ProductID` int(11) NOT NULL default '0',
  `ReviewTime` datetime NOT NULL default '0000-00-00 00:00:00',
  `IsReview` enum('NO','YES') NOT NULL default 'NO',
  `ReviewTitle` varchar(255) NOT NULL default '',
  `ReviewText` text NOT NULL,
  `DisplayName` varchar(100) default 'N/A',
  `ScoreOverall` float(11,2) NOT NULL default '0.00',
  `ScoreQuality` float(11,2) NOT NULL default '0.00',
  `ScoreFeatures` float(11,2) NOT NULL default '0.00',
  `ScoreSupport` float(11,2) NOT NULL default '0.00',
  `ScoreValue` float(11,2) NOT NULL default '0.00',
  `HelpfulYesCount` int(11) NOT NULL default '0',
  `HelpfulNoCount` int(11) NOT NULL default '0',
  `IsApproved` enum('NO','YES') NOT NULL default 'NO',
  `ReportedAbuseCount` int(11) NOT NULL default '0',
  `ExpertID` int(11) NOT NULL default '0',
  `URL` text NOT NULL,
  `SiteID` int(11) default NULL,
  `r_ProductName` varchar(255) default NULL,
  `Location` varchar(200) default '',
  `ThirdPartReviewID` varchar(200) default '',
  `OwnedTime` varchar(30) default '',
  `LastChangeDate` timestamp NULL default NULL on update CURRENT_TIMESTAMP COMMENT 'log the last update datetime',
  PRIMARY KEY  (`ID`),
  KEY `ProductID` (`ProductID`),
  KEY `ExpertID` (`ExpertID`),
  KEY `idx_ch_prod_PR` (`ChannelID`,`ProductID`),
  KEY `idx_ch` (`ChannelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 MAX_ROWS=4000000000;

/*Data for the table `c3productreview` */

/*Table structure for table `c3productskus` */

DROP TABLE IF EXISTS `c3productskus`;

CREATE TABLE `c3productskus` (
  `ID` int(11) unsigned NOT NULL auto_increment,
  `ProductID` int(11) unsigned NOT NULL default '0',
  `ProductNO` varchar(255) NOT NULL default '',
  `Type` enum('EAN','ISBN','UPC','SKU','MfPN','CatalogNo','MerchantUniqueCode','ASIN','SDCN','Unknown') NOT NULL default 'Unknown',
  `IsMain` enum('YES','NO') NOT NULL default 'NO',
  `Comments` varchar(255) NOT NULL default '',
  `AddDate` timestamp NULL default NULL,
  `LastChangeDate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`),
  KEY `ProductID` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `c3productskus` */

/*Table structure for table `channel` */

DROP TABLE IF EXISTS `channel`;

CREATE TABLE `channel` (
  `ID` int(11) unsigned NOT NULL auto_increment,
  `Name` varchar(100) NOT NULL default '',
  `EngName` varchar(100) NOT NULL default '',
  `Host` varchar(100) NOT NULL default '',
  `DB` varchar(100) NOT NULL default '',
  `ProductTable` varchar(64) NOT NULL default '',
  `ProductSKUTable` varchar(64) NOT NULL default '',
  `ProductSkipTable` varchar(64) NOT NULL,
  `ProductImageTable` varchar(64) NOT NULL default '',
  `ProductExtendInfoTable` varchar(64) NOT NULL default '',
  `CategoryTable` varchar(64) NOT NULL default '',
  `CatProdTable` varchar(64) NOT NULL default '',
  `MerBidProdTable` varchar(64) NOT NULL default '',
  `Type` varchar(10) NOT NULL default '',
  `IsValid` enum('YES','TEST','NO') NOT NULL default 'NO',
  `ChannelGroup` enum('BMV','CE','SG') NOT NULL default 'SG',
  `SEODisplayName` varchar(32) default NULL,
  `URLName` varchar(32) default NULL,
  `LastChangeDate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `channel` */

/*Table structure for table `comment` */

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `comment` text,
  `createtime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `comment` */

/*Table structure for table `config` */

DROP TABLE IF EXISTS `config`;

CREATE TABLE `config` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `code` varchar(30) NOT NULL default '',
  `type` varchar(10) NOT NULL default '',
  `store_range` varchar(255) NOT NULL default '',
  `store_dir` varchar(255) NOT NULL default '',
  `value` text NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL default '1',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=922 DEFAULT CHARSET=utf8;

/*Data for the table `config` */

insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (904,'shop_closed','','','','0',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (905,'template','','','','default',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (906,'cache_time','','','','360000',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (907,'integrate_config','','','','',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (908,'captcha','','','','0',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (909,'captcha_width','','','','80',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (910,'captcha_height','','','','20',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (911,'reg_closed','','','','0',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (912,'mail_charset','','','','utf8',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (913,'shop_name','','','','diandiantao',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (914,'mail_service','','','','0',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (916,'smtp_host','','','','localhost',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (917,'smtp_port','','','','25',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (918,'smtp_user','','','','',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (919,'smtp_pass','','','','',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (920,'smtp_mail','','','','',1);
insert  into `config`(`id`,`code`,`type`,`store_range`,`store_dir`,`value`,`sort_order`) values (921,'smtp_ssl','','','','0',1);

/*Table structure for table `mail_templates` */

DROP TABLE IF EXISTS `mail_templates`;

CREATE TABLE `mail_templates` (
  `template_id` tinyint(1) unsigned NOT NULL auto_increment,
  `template_code` varchar(30) NOT NULL default '',
  `is_html` tinyint(1) unsigned NOT NULL default '0',
  `template_subject` varchar(200) NOT NULL default '',
  `template_content` text NOT NULL,
  `last_modify` int(10) unsigned NOT NULL default '0',
  `last_send` int(10) unsigned NOT NULL default '0',
  `type` varchar(10) NOT NULL,
  PRIMARY KEY  (`template_id`),
  UNIQUE KEY `template_code` (`template_code`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `mail_templates` */

insert  into `mail_templates`(`template_id`,`template_code`,`is_html`,`template_subject`,`template_content`,`last_modify`,`last_send`,`type`) values (1,'send_password',1,'密码找回','{$user_name}您好！<br>\n<br>\n您已经进行了密码重置的操作，请点击以下链接(或者复制到您的浏览器):<br>\n<br>\n<a href=\"{$reset_email}\" target=\"_blank\">{$reset_email}</a><br>\n<br>\n以确认您的新密码重置操作！<br>\n<br>\n{$shop_name}<br>\n{$send_date}',1194824789,0,'template');
insert  into `mail_templates`(`template_id`,`template_code`,`is_html`,`template_subject`,`template_content`,`last_modify`,`last_send`,`type`) values (2,'order_confirm',0,'订单确认通知','亲爱的{$order.consignee}，你好！ \n\n我们已经收到您于 {$order.formated_add_time} 提交的订单，该订单编号为：{$order.order_sn} 请记住这个编号以便日后的查询。\n\n{$shop_name}\n{$sent_date}\n\n\n',1158226370,0,'template');
insert  into `mail_templates`(`template_id`,`template_code`,`is_html`,`template_subject`,`template_content`,`last_modify`,`last_send`,`type`) values (3,'deliver_notice',1,'发货通知','亲爱的{$order.consignee}。你好！</br></br>\n\n您的订单{$order.order_sn}已于{$send_time}按照您预定的配送方式给您发货了。</br>\n</br>\n{if $order.invoice_no}发货单号是{$order.invoice_no}。</br>{/if}\n</br>\n在您收到货物之后请点击下面的链接确认您已经收到货物：</br>\n<a href=\"{$confirm_url}\" target=\"_blank\">{$confirm_url}</a></br></br>\n如果您还没有收到货物可以点击以下链接给我们留言：</br></br>\n<a href=\"{$send_msg_url}\" target=\"_blank\">{$send_msg_url}</a></br>\n<br>\n再次感谢您对我们的支持。欢迎您的再次光临。 <br>\n<br>\n{$shop_name} </br>\n{$send_date}',1194823291,0,'template');
insert  into `mail_templates`(`template_id`,`template_code`,`is_html`,`template_subject`,`template_content`,`last_modify`,`last_send`,`type`) values (4,'order_cancel',0,'订单取消','亲爱的{$order.consignee}，你好！ \n\n您的编号为：{$order.order_sn}的订单已取消。\n\n{$shop_name}\n{$send_date}',1156491130,0,'template');
insert  into `mail_templates`(`template_id`,`template_code`,`is_html`,`template_subject`,`template_content`,`last_modify`,`last_send`,`type`) values (5,'order_invalid',0,'订单无效','亲爱的{$order.consignee}，你好！\n\n您的编号为：{$order.order_sn}的订单无效。\n\n{$shop_name}\n{$send_date}',1156491164,0,'template');
insert  into `mail_templates`(`template_id`,`template_code`,`is_html`,`template_subject`,`template_content`,`last_modify`,`last_send`,`type`) values (6,'send_bonus',0,'发红包','亲爱的{$user_name}您好！\n\n恭喜您获得了{$count}个红包，金额{if $count > 1}分别{/if}为{$money}\n\n{$shop_name}\n{$send_date}\n',1156491184,0,'template');
insert  into `mail_templates`(`template_id`,`template_code`,`is_html`,`template_subject`,`template_content`,`last_modify`,`last_send`,`type`) values (7,'group_buy',1,'团购商品','亲爱的{$consignee}，您好！<br>\n<br>\n您于{$order_time}在本店参加团购商品活动，所购买的商品名称为：{$goods_name}，数量：{$goods_number}，订单号为：{$order_sn}，订单金额为：{$order_amount}<br>\n<br>\n此团购商品现在已到结束日期，并达到最低价格，您现在可以对该订单付款。<br>\n<br>\n请点击下面的链接：<br>\n<a href=\"{$shop_url}\" target=\"_blank\">{$shop_url}</a><br>\n<br>\n请尽快登录到用户中心，查看您的订单详情信息。 <br>\n<br>\n{$shop_name} <br>\n<br>\n{$send_date}',1194824668,0,'template');
insert  into `mail_templates`(`template_id`,`template_code`,`is_html`,`template_subject`,`template_content`,`last_modify`,`last_send`,`type`) values (8,'register_validate',1,'邮件验证','{$user_name}您好！<br><br>\r\n\r\n这封邮件是 {$shop_name} 发送的。你收到这封邮件是为了验证你注册邮件地址是否有效。如果您已经通过验证了，请忽略这封邮件。<br>\r\n请点击以下链接(或者复制到您的浏览器)来验证你的邮件地址:<br>\r\n<a href=\"{$validate_email}\" target=\"_blank\">{$validate_email}</a><br><br>\r\n\r\n{$shop_name}<br>\r\n{$send_date}',1162201031,0,'template');
insert  into `mail_templates`(`template_id`,`template_code`,`is_html`,`template_subject`,`template_content`,`last_modify`,`last_send`,`type`) values (9,'virtual_card',0,'虚拟卡片','亲爱的{$order.consignee}\r\n你好！您的订单{$order.order_sn}中{$goods.goods_name} 商品的详细信息如下:\r\n{foreach from=$virtual_card item=card}\r\n{if $card.card_sn}卡号：{$card.card_sn}{/if}{if $card.card_password}卡片密码：{$card.card_password}{/if}{if $card.end_date}截至日期：{$card.end_date}{/if}\r\n{/foreach}\r\n再次感谢您对我们的支持。欢迎您的再次光临。\r\n\r\n{$shop_name} \r\n{$send_date}',1162201031,0,'template');
insert  into `mail_templates`(`template_id`,`template_code`,`is_html`,`template_subject`,`template_content`,`last_modify`,`last_send`,`type`) values (10,'attention_list',0,'关注商品','亲爱的{$user_name}您好~\n\n您关注的商品 : {$goods_name} 最近已经更新,请您查看最新的商品信息\n\n{$goods_url}\r\n\r\n{$shop_name} \r\n{$send_date}',1183851073,0,'template');
insert  into `mail_templates`(`template_id`,`template_code`,`is_html`,`template_subject`,`template_content`,`last_modify`,`last_send`,`type`) values (11,'remind_of_new_order',0,'新订单通知','亲爱的店长，您好：\n   快来看看吧，又有新订单了。\n    订单号:{$order.order_sn} \n 订单金额:{$order.order_amount}，\n 用户购买商品:{foreach from=$goods_list item=goods_data}{$goods_data.goods_name}(货号:{$goods_data.goods_sn})    {/foreach} \n\n 收货人:{$order.consignee}， \n 收货人地址:{$order.address}，\n 收货人电话:{$order.tel} {$order.mobile}, \n 配送方式:{$order.shipping_name}(费用:{$order.shipping_fee}), \n 付款方式:{$order.pay_name}(费用:{$order.pay_fee})。\n\n               系统提醒\n               {$send_date}',1196239170,0,'template');
insert  into `mail_templates`(`template_id`,`template_code`,`is_html`,`template_subject`,`template_content`,`last_modify`,`last_send`,`type`) values (12,'goods_booking',1,'缺货回复','亲爱的{$user_name}。你好！</br></br>{$dispose_note}</br></br>您提交的缺货商品链接为</br></br><a href=\"{$goods_link}\" target=\"_blank\">{$goods_name}</a></br><br>{$shop_name} </br>{$send_date}',0,0,'template');
insert  into `mail_templates`(`template_id`,`template_code`,`is_html`,`template_subject`,`template_content`,`last_modify`,`last_send`,`type`) values (13,'user_message',1,'留言回复','亲爱的{$user_name}。你好！</br></br>对您的留言：</br>{$message_content}</br></br>店主作了如下回复：</br>{$message_note}</br></br>您可以随时回到店中和店主继续沟通。</br>{$shop_name}</br>{$send_date}',0,0,'template');
insert  into `mail_templates`(`template_id`,`template_code`,`is_html`,`template_subject`,`template_content`,`last_modify`,`last_send`,`type`) values (14,'recomment',1,'用户评论回复','亲爱的{$user_name}。你好！</br></br>对您的评论：</br>“{$comment}”</br></br>店主作了如下回复：</br>“{$recomment}”</br></br>您可以随时回到店中和店主继续沟通。</br>{$shop_name}</br>{$send_date}',0,0,'template');

/*Table structure for table `merchant` */

DROP TABLE IF EXISTS `merchant`;

CREATE TABLE `merchant` (
  `id` int(11) NOT NULL auto_increment,
  `MerchantID` int(11) unsigned NOT NULL default '0',
  `MerchantName` varchar(100) NOT NULL default '',
  `NameAlias` varchar(500) NOT NULL default '' COMMENT 'Separated by ||',
  `Country` char(3) NOT NULL default '',
  `SiteURL` varchar(255) NOT NULL default '',
  `SiteLink` enum('YES','NO','PARTIAL') NOT NULL default 'NO',
  `RegisterDate` datetime NOT NULL default '2000-01-01 00:00:00',
  `SalesMessage` varchar(2000) NOT NULL default '',
  `Authorized` enum('YES','NO') NOT NULL default 'NO',
  `MerSource` enum('OWN','PARNTER','BOTH') NOT NULL default 'OWN',
  `IsTrusted` enum('YES','NO') NOT NULL default 'NO',
  `PriceStatus` enum('WLINK','WOLINK','OFFLINE') NOT NULL default 'WOLINK' COMMENT 'W-with, WO-without',
  `PriceShare` enum('LOCAL','INTERNATIONALWLINK','INTERNATIONALWOLINK') NOT NULL default 'LOCAL' COMMENT 'LOCAL means only local country can display offer, International means accross country can display offers, WLink means with Link, WOLink means without Link',
  `BusinessType` enum('CPC','CPA','FREE','CPC-H') NOT NULL default 'CPC' COMMENT 'check MerDeal table',
  `MerLogoDisplay` enum('YES','NO') NOT NULL default 'NO',
  `LastChangeDate` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `r_ReviewCount` int(11) NOT NULL default '0',
  `r_AvgRating` decimal(5,2) NOT NULL default '0.00',
  `r_OwnTotalOfferCount` int(11) unsigned NOT NULL default '0',
  `r_OwnOnlineOfferCount` int(11) unsigned NOT NULL default '0',
  `r_Popularity` int(11) unsigned NOT NULL default '0',
  `r_ProductCount` int(11) unsigned NOT NULL default '0',
  `r_ImpressionCount` int(11) unsigned NOT NULL default '0',
  `r_ClickCount` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`,`MerchantID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `merchant` */

/*Table structure for table `nav` */

DROP TABLE IF EXISTS `nav`;

CREATE TABLE `nav` (
  `id` mediumint(8) NOT NULL auto_increment,
  `ctype` varchar(10) default NULL,
  `cid` smallint(5) unsigned default NULL,
  `name` varchar(255) NOT NULL,
  `ifshow` tinyint(1) NOT NULL,
  `vieworder` tinyint(1) NOT NULL,
  `opennew` tinyint(1) NOT NULL,
  `url` varchar(255) NOT NULL,
  `type` varchar(10) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `type` (`type`),
  KEY `ifshow` (`ifshow`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

/*Data for the table `nav` */

/*Table structure for table `searchkeyword` */

DROP TABLE IF EXISTS `searchkeyword`;

CREATE TABLE `searchkeyword` (
  `ID` int(11) NOT NULL auto_increment,
  `UserID` int(11) default NULL,
  `Keyword` varchar(30) default '',
  `AddDate` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `searchkeyword` */

/*Table structure for table `sessions` */

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `sesskey` char(32) character set utf8 collate utf8_bin NOT NULL default '',
  `expiry` int(10) unsigned NOT NULL default '0',
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `adminid` mediumint(8) unsigned NOT NULL default '0',
  `ip` char(15) NOT NULL default '',
  `user_name` varchar(60) NOT NULL,
  `user_rank` tinyint(3) NOT NULL,
  `discount` decimal(3,2) NOT NULL,
  `email` varchar(60) NOT NULL,
  `data` char(255) NOT NULL default '',
  PRIMARY KEY  (`sesskey`),
  KEY `expiry` (`expiry`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

/*Data for the table `sessions` */

insert  into `sessions`(`sesskey`,`expiry`,`userid`,`adminid`,`ip`,`user_name`,`user_rank`,`discount`,`email`,`data`) values ('1133df6ad9d3789bc475fc77a2eb300d',1309627932,0,0,'127.0.0.1','0',0,'1.00','0','a:3:{s:7:\"from_ad\";i:0;s:7:\"referer\";s:6:\"本站\";s:10:\"login_fail\";i:0;}');

/*Table structure for table `sessions_log` */

DROP TABLE IF EXISTS `sessions_log`;

CREATE TABLE `sessions_log` (
  `sesskey` char(32) character set utf8 collate utf8_bin NOT NULL default '',
  `expiry` int(10) unsigned NOT NULL default '0',
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `adminid` mediumint(8) unsigned NOT NULL default '0',
  `ip` char(15) NOT NULL default '',
  `user_name` varchar(60) NOT NULL,
  `user_rank` tinyint(3) NOT NULL,
  `discount` decimal(3,2) NOT NULL,
  `email` varchar(60) NOT NULL,
  `data` char(255) NOT NULL default '',
  PRIMARY KEY  (`sesskey`),
  KEY `expiry` (`expiry`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

/*Data for the table `sessions_log` */

/*Table structure for table `site` */

DROP TABLE IF EXISTS `site`;

CREATE TABLE `site` (
  `id` int(11) NOT NULL auto_increment,
  `site` varchar(500) default NULL,
  `sitename` varchar(500) default NULL,
  `adddate` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `site` */

/*Table structure for table `stats` */

DROP TABLE IF EXISTS `stats`;

CREATE TABLE `stats` (
  `id` mediumint(8) NOT NULL auto_increment,
  `access_time` int(10) unsigned NOT NULL default '0',
  `ip_address` varchar(15) NOT NULL default '',
  `visit_times` smallint(5) unsigned NOT NULL default '1',
  `browser` varchar(60) NOT NULL default '',
  `system` varchar(20) NOT NULL default '',
  `language` varchar(20) NOT NULL default '',
  `area` varchar(30) NOT NULL default '',
  `referer_domain` varchar(100) NOT NULL default '',
  `referer_path` varchar(200) NOT NULL default '',
  `access_url` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `access_time` (`access_time`)
) ENGINE=MyISAM AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;

/*Data for the table `stats` */

insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (1,1307866222,'127.0.0.1',1,'Internet Explorer 7.0','Windows NT','en-US','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (2,1307917576,'127.0.0.1',2,'FireFox 3.6.17','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (3,1307931076,'127.0.0.1',3,'FireFox 3.6.17','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (4,1308030275,'127.0.0.1',4,'FireFox 3.6.17','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (5,1308117242,'127.0.0.1',5,'FireFox 3.6.17','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (6,1308159302,'127.0.0.1',6,'FireFox 3.6.17','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (7,1308205498,'127.0.0.1',7,'FireFox 3.6.17','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (8,1308504431,'127.0.0.1',8,'FireFox 3.6.17','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (9,1308624844,'127.0.0.1',9,'FireFox 3.6.17','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (10,1308677061,'127.0.0.1',10,'FireFox 3.6.17','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (11,1308764980,'127.0.0.1',11,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (12,1309069721,'127.0.0.1',12,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (13,1309110470,'127.0.0.1',13,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (14,1309116293,'0.0.0.0',1,'','Unknown','','IANA','','','captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (15,1309116376,'127.0.0.1',14,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (16,1309116495,'0.0.0.0',1,'','Unknown','','IANA','','','captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (17,1309116723,'0.0.0.0',1,'','Unknown','','IANA','','','captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (18,1309116742,'0.0.0.0',1,'','Unknown','','IANA','','','captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (19,1309116786,'0.0.0.0',1,'','Unknown','','IANA','','','captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (20,1309116997,'0.0.0.0',1,'','Unknown','','IANA','','','testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (21,1309117035,'0.0.0.0',1,'','Unknown','','IANA','','','testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (22,1309117534,'0.0.0.0',1,'','Unknown','','IANA','','','testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (23,1309117558,'0.0.0.0',1,'','Unknown','','IANA','','','captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (24,1309117590,'0.0.0.0',1,'','Unknown','','IANA','','','captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (25,1309117644,'0.0.0.0',1,'','Unknown','','IANA','','','captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (26,1309117935,'0.0.0.0',1,'','Unknown','','IANA','','','captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (27,1309117979,'0.0.0.0',1,'','Unknown','','IANA','','','captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (28,1309118138,'0.0.0.0',1,'','Unknown','','IANA','','','captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (29,1309118789,'0.0.0.0',1,'','Unknown','','IANA','','','captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (30,1309118880,'0.0.0.0',1,'','Unknown','','IANA','','','captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (31,1309124359,'127.0.0.1',15,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (32,1309124396,'0.0.0.0',1,'','Unknown','','IANA','','','testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (33,1309125959,'0.0.0.0',1,'','Unknown','','IANA','','','captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (34,1309126476,'0.0.0.0',1,'','Unknown','','IANA','','','testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (35,1309136134,'127.0.0.1',16,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (36,1309142482,'127.0.0.1',17,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (37,1309145219,'127.0.0.1',18,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (38,1309195761,'127.0.0.1',19,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','http://localhost:8880','/buy/php/testusersigin.php','/buy/php/captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (39,1309225719,'127.0.0.1',20,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (40,1309242042,'127.0.0.1',21,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','http://localhost:8880','/buy/php/testusersigin.php','/buy/php/user.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (41,1309282344,'127.0.0.1',22,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','http://localhost:8880','/buy/php/testusersigin.php','/buy/php/user.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (42,1309287808,'127.0.0.1',23,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','http://localhost:8880','/buy/php/testusersigin.php','/buy/php/user.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (43,1309287901,'0.0.0.0',1,'','Unknown','','IANA','','','testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (44,1309287991,'0.0.0.0',1,'','Unknown','','IANA','','','testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (45,1309288166,'0.0.0.0',1,'','Unknown','','IANA','','','testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (46,1309288199,'0.0.0.0',1,'','Unknown','','IANA','','','testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (47,1309288279,'0.0.0.0',1,'','Unknown','','IANA','','','testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (48,1309288504,'0.0.0.0',1,'','Unknown','','IANA','','','testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (49,1309289062,'0.0.0.0',1,'','Unknown','','IANA','','','testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (50,1309295486,'127.0.0.1',24,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','http://localhost:8880','/buy/php/testusersigin.php','/buy/php/captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (51,1309297710,'127.0.0.1',1,'Internet Explorer 8.0','Windows NT','en-US','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (52,1309309531,'127.0.0.1',25,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','http://localhost:8880','/buy/php/testusersigin.php','/buy/php/captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (53,1309312786,'127.0.0.1',26,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (54,1309312786,'127.0.0.1',26,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (55,1309325413,'127.0.0.1',27,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testusersigin.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (56,1309328562,'127.0.0.1',1,'Internet Explorer 8.0','Windows NT','en-US','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (57,1309332596,'127.0.0.1',28,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (58,1309368647,'127.0.0.1',29,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','http://localhost:8880','/buy/php/testuserreg.php','/buy/php/captcha.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (59,1309372243,'127.0.0.1',30,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (60,1309376345,'127.0.0.1',31,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','http://localhost:8880','/buy/php/testuserreg.php','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (61,1309381613,'127.0.0.1',32,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (62,1309412639,'127.0.0.1',33,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (63,1309414354,'127.0.0.1',1,'Safari 534.30','Windows NT','zh-CN,zh','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (64,1309472355,'127.0.0.1',34,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (65,1309479262,'127.0.0.1',35,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (66,1309482046,'127.0.0.1',36,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','http://localhost:8880','/buy/php/testuserreg.php','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (67,1309487786,'127.0.0.1',37,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','http://localhost:8880','/buy/php/testuserreg.php?act=logout','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (68,1309488034,'127.0.0.1',38,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/index.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (69,1309498903,'127.0.0.1',39,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','http://localhost:8880','/buy/php/testuserreg.php?act=login','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (70,1309499918,'127.0.0.1',40,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/index.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (71,1309501255,'127.0.0.1',41,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/index.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (72,1309502213,'127.0.0.1',42,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (73,1309502626,'127.0.0.1',43,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (74,1309504231,'127.0.0.1',44,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (75,1309504884,'127.0.0.1',45,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (76,1309504959,'127.0.0.1',46,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (77,1309545354,'127.0.0.1',47,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (78,1309581741,'127.0.0.1',48,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','http://localhost:8880','/buy/php/testuserreg.php?act=qpsw','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (79,1309591661,'127.0.0.1',49,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (80,1309597243,'127.0.0.1',50,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','http://localhost:8880','/buy/php/testuserreg.php?act=qpsw','/buy/php/testuserreg.php');
insert  into `stats`(`id`,`access_time`,`ip_address`,`visit_times`,`browser`,`system`,`language`,`area`,`referer_domain`,`referer_path`,`access_url`) values (81,1309597867,'127.0.0.1',51,'FireFox 3.6.18','Windows NT','zh-cn,zh','LAN','','','/buy/php/user.php');

/*Table structure for table `tag` */

DROP TABLE IF EXISTS `tag`;

CREATE TABLE `tag` (
  `ID` mediumint(8) NOT NULL auto_increment,
  `tag_words` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `tag` */

/*Table structure for table `url` */

DROP TABLE IF EXISTS `url`;

CREATE TABLE `url` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `url` varchar(1024) NOT NULL,
  `content` text,
  `catid` int(11) default '0',
  `md5` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `url` */

/*Table structure for table `url2user2comment` */

DROP TABLE IF EXISTS `url2user2comment`;

CREATE TABLE `url2user2comment` (
  `ID` int(11) unsigned NOT NULL auto_increment,
  `URLID` int(11) NOT NULL,
  `USERID` int(11) NOT NULL,
  `COMMENTID` int(11) NOT NULL,
  `CREATETIME` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `url2user2comment` */

/*Table structure for table `url2user2tag` */

DROP TABLE IF EXISTS `url2user2tag`;

CREATE TABLE `url2user2tag` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `urlid` int(11) default NULL,
  `userid` int(11) default NULL,
  `tagid` int(11) default NULL,
  `createtime` timestamp NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `url2user2tag` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `ID` int(11) NOT NULL auto_increment,
  `UserName` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL default '',
  `Email` varchar(64) NOT NULL,
  `sex` varchar(2) default NULL,
  `Birthday` date NOT NULL default '0000-00-00',
  `Question` text,
  `Answer` text,
  `Validate` enum('YES','NO') default 'NO',
  `reg_time` timestamp NULL default CURRENT_TIMESTAMP,
  `last_login` datetime default '0000-00-00 00:00:00',
  `Country` varchar(20) NOT NULL default '',
  `PostalCode` varchar(8) NOT NULL default '',
  `UserPaidAccount` varchar(64) NOT NULL default '',
  `AccountType` smallint(4) NOT NULL default '0',
  `qq` varchar(20) default NULL,
  `msn` varchar(60) default NULL,
  `office_phone` varchar(20) default NULL,
  `home_phone` varchar(20) default NULL,
  `mobile_phone` varchar(20) default NULL,
  `visit_count` int(10) default '0',
  `last_ip` varchar(20) default NULL,
  `salt` varchar(10) default '',
  PRIMARY KEY  (`ID`,`UserName`,`Birthday`),
  UNIQUE KEY `Email` (`Email`),
  KEY `login` (`UserName`,`password`)
) ENGINE=MyISAM AUTO_INCREMENT=32887 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`ID`,`UserName`,`password`,`Email`,`sex`,`Birthday`,`Question`,`Answer`,`Validate`,`reg_time`,`last_login`,`Country`,`PostalCode`,`UserPaidAccount`,`AccountType`,`qq`,`msn`,`office_phone`,`home_phone`,`mobile_phone`,`visit_count`,`last_ip`,`salt`) values (32871,'1@1.com','111111','1@1.com',NULL,'0000-00-00',NULL,NULL,'NO',NULL,'0000-00-00 00:00:00','','','',0,NULL,NULL,NULL,NULL,NULL,0,NULL,'');
insert  into `user`(`ID`,`UserName`,`password`,`Email`,`sex`,`Birthday`,`Question`,`Answer`,`Validate`,`reg_time`,`last_login`,`Country`,`PostalCode`,`UserPaidAccount`,`AccountType`,`qq`,`msn`,`office_phone`,`home_phone`,`mobile_phone`,`visit_count`,`last_ip`,`salt`) values (32881,'2@1.com','96e79218965eb72c92a549dd5a330112','2@1.com',NULL,'0000-00-00',NULL,NULL,'NO','0000-00-00 00:00:00','0000-00-00 00:00:00','','','',0,'','','','','',0,NULL,'');
insert  into `user`(`ID`,`UserName`,`password`,`Email`,`sex`,`Birthday`,`Question`,`Answer`,`Validate`,`reg_time`,`last_login`,`Country`,`PostalCode`,`UserPaidAccount`,`AccountType`,`qq`,`msn`,`office_phone`,`home_phone`,`mobile_phone`,`visit_count`,`last_ip`,`salt`) values (32882,'a@a.com','96e79218965eb72c92a549dd5a330112','a@a.com',NULL,'0000-00-00',NULL,NULL,'NO','0000-00-00 00:00:00','0000-00-00 00:00:00','','','',0,'','','','','',0,NULL,'');
insert  into `user`(`ID`,`UserName`,`password`,`Email`,`sex`,`Birthday`,`Question`,`Answer`,`Validate`,`reg_time`,`last_login`,`Country`,`PostalCode`,`UserPaidAccount`,`AccountType`,`qq`,`msn`,`office_phone`,`home_phone`,`mobile_phone`,`visit_count`,`last_ip`,`salt`) values (32883,'dfd@hot.com','96e79218965eb72c92a549dd5a330112','dfd@hot.com',NULL,'0000-00-00',NULL,NULL,'NO','0000-00-00 00:00:00','0000-00-00 00:00:00','','','',0,'','','','','',0,NULL,'');
insert  into `user`(`ID`,`UserName`,`password`,`Email`,`sex`,`Birthday`,`Question`,`Answer`,`Validate`,`reg_time`,`last_login`,`Country`,`PostalCode`,`UserPaidAccount`,`AccountType`,`qq`,`msn`,`office_phone`,`home_phone`,`mobile_phone`,`visit_count`,`last_ip`,`salt`) values (32884,'matthew0816@gmail.com','96e79218965eb72c92a549dd5a330112','matthew0816@gmail.com',NULL,'0000-00-00',NULL,NULL,'NO','0000-00-00 00:00:00','0000-00-00 00:00:00','','','',0,'','','','','',0,NULL,'');
insert  into `user`(`ID`,`UserName`,`password`,`Email`,`sex`,`Birthday`,`Question`,`Answer`,`Validate`,`reg_time`,`last_login`,`Country`,`PostalCode`,`UserPaidAccount`,`AccountType`,`qq`,`msn`,`office_phone`,`home_phone`,`mobile_phone`,`visit_count`,`last_ip`,`salt`) values (32885,'a@a11.com','96e79218965eb72c92a549dd5a330112','a@a11.com',NULL,'0000-00-00',NULL,NULL,'NO','0000-00-00 00:00:00','0000-00-00 00:00:00','','','',0,'','','','','',0,NULL,'');
insert  into `user`(`ID`,`UserName`,`password`,`Email`,`sex`,`Birthday`,`Question`,`Answer`,`Validate`,`reg_time`,`last_login`,`Country`,`PostalCode`,`UserPaidAccount`,`AccountType`,`qq`,`msn`,`office_phone`,`home_phone`,`mobile_phone`,`visit_count`,`last_ip`,`salt`) values (32886,'2@2.com','e3ceb5881a0a1fdaad01296d7554868d','2@2.com',NULL,'0000-00-00',NULL,NULL,'NO','0000-00-00 00:00:00','0000-00-00 00:00:00','','','',0,'','','','','',0,NULL,'');

/*Table structure for table `userhistory` */

DROP TABLE IF EXISTS `userhistory`;

CREATE TABLE `userhistory` (
  `ID` mediumint(8) NOT NULL auto_increment,
  `user_id` mediumint(8) unsigned NOT NULL default '0',
  `url` varchar(2048) NOT NULL default '',
  `metacontent` varchar(2048) NOT NULL default '',
  `viewdate` timestamp NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `userhistory` */

insert  into `userhistory`(`ID`,`user_id`,`url`,`metacontent`,`viewdate`) values (8,1,'2','','2011-06-30 13:33:05');

/*Table structure for table `userhistorytag` */

DROP TABLE IF EXISTS `userhistorytag`;

CREATE TABLE `userhistorytag` (
  `ID` int(11) NOT NULL auto_increment,
  `tagID` int(11) NOT NULL,
  `historyid` int(11) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `userhistorytag` */

/*Table structure for table `userpageview` */

DROP TABLE IF EXISTS `userpageview`;

CREATE TABLE `userpageview` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `log_time` int(10) unsigned NOT NULL default '0',
  `logtYPE` int(10) unsigned NOT NULL default '0',
  `user_id` tinyint(3) unsigned NOT NULL default '0',
  `log_info` varchar(255) NOT NULL default '',
  `ip_address` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `log_time` (`log_time`),
  KEY `user_id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=464 DEFAULT CHARSET=utf8;

/*Data for the table `userpageview` */

/*Table structure for table `userpageview_log` */

DROP TABLE IF EXISTS `userpageview_log`;

CREATE TABLE `userpageview_log` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `log_time` int(10) unsigned NOT NULL default '0',
  `logtYPE` int(10) unsigned NOT NULL default '0',
  `user_id` tinyint(3) unsigned NOT NULL default '0',
  `log_info` varchar(255) NOT NULL default '',
  `ip_address` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `log_time` (`log_time`),
  KEY `user_id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=464 DEFAULT CHARSET=utf8;

/*Data for the table `userpageview_log` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;