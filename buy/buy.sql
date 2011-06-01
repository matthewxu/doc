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

/*Table structure for table `productreview` */

DROP TABLE IF EXISTS `productreview`;

CREATE TABLE `productreview` (
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

/*Table structure for table `searchkeyword` */

DROP TABLE IF EXISTS `searchkeyword`;

CREATE TABLE `searchkeyword` (
  `ID` int(11) NOT NULL auto_increment,
  `UserID` int(11) default NULL,
  `Keyword` varchar(30) default '',
  `AddDate` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `UserID` int(11) NOT NULL auto_increment,
  `UserName` varchar(32) character set latin1 collate latin1_bin default NULL,
  `password` varchar(32) character set latin1 collate latin1_bin NOT NULL default '',
  `Email` varchar(64) NOT NULL,
  `Birthday` date NOT NULL default '0000-00-00',
  `Question` text,
  `Answer` text,
  `Validate` enum('YES','NO') default 'NO',
  `VisitTime` datetime default '0000-00-00 00:00:00',
  `Country` char(2) NOT NULL,
  `PostalCode` varchar(8) NOT NULL,
  `UserPaidAccount` varchar(64) NOT NULL,
  `AccountType` smallint(4) NOT NULL default '0',
  PRIMARY KEY  (`UserID`),
  UNIQUE KEY `Email` (`Email`),
  KEY `login` (`UserName`,`password`)
) ENGINE=MyISAM AUTO_INCREMENT=32871 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;