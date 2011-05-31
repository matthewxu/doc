<?php

	/**
	 * test smarty index.php
	*/
	//mt定义入口常量
	define('IN_ECS', true);
	/* 取得当前ecshop所在的根目录 */
	//str_replace(find,replace,string,count)
	define('ROOT_PATH', str_replace('testinfosmarty.php', '', str_replace('\\', '/', __FILE__)));
	$_CFG = array();
    $_CFG['template']='default';
    $_CFG['language']='zh_cn';
	
	
	/* 创建 Smarty 对象。*/
	//cls_template.php 模版类 
    require(ROOT_PATH . 'includes/cls_template.php');
    require(ROOT_PATH . 'languages/'.$_CFG['language'].'/common.php');

    $smarty = new cls_template;
    
	$smarty->direct_output = false;
	$smarty->force_compile = true;
    $smarty->template_dir   = ROOT_PATH . 'themes/'.$_CFG['template'];
    $smarty->cache_dir      = ROOT_PATH . 'temp/caches';
    $smarty->compile_dir    = ROOT_PATH . 'temp/compiled';
    ####config####
    
  	$smarty->assign('themes', 'themes/'.$_CFG['template']);
	#####head object
		$ohead = array();
        $ohead[0]['model']      = '购物';
        $ohead[0]['modellink']       = 'a.html';
        
        $ohead[1]['model']      = '工作';
        $ohead[1]['modellink']       = 'a.html';
        
        $ohead[2]['model']      = '点评';
        $ohead[2]['modellink']       = 'a.html';
        
        $ohead[3]['model']      = '房产';
        $ohead[3]['modellink']       = 'a.html';
        
     $smarty->assign('ohead', $ohead);
     $smarty->assign('home', 'index.php');   
     $smarty->assign('searchlink', 'index.php');   
     $smarty->assign('sekw', '望远镜');
    #####recent view object
	$ocat = array();
	$i=0;
	while($i++<3){
		$ocat[$i]['catname']='光学产品/光学仪器';
		$ocat[$i]['catlink']='a.html';
		$ocat[$i]['subcatname']='望远镜';
		$ocat[$i]['subcatlink']='a.html';
	}

	$oprice=array();
	$i=0;
	while($i++<5){
		$oprice[$i]['price']='70';
		$oprice[$i]['pricelink']='a.htm';
	}
	$obrand=array();
	$i=0;
	while($i++<8){
		$obrand[$i]['brand']='品牌'.$i;
		$obrand[$i]['brandlink']='a.htm';
		$obrand[$i]['brandimglink']='a.jpg';
	}
	##### search result product list
	$oproduct = array();
	$i=0;
	while($i++<8){
		$oproduct[$i]['sellercount']='8';
		$oproduct[$i]['pricerange']='￥150到 ￥280';
		$oproduct[$i]['imglink']='images/rhbWInmpZi00Q1jF8Ucty-vlX1qHLdDZzQGlDvJWDGx-gUOuZkem_wYDZYOm.jpg';
		$oproduct[$i]['link']='images/rhbWInmpZi00Q1jF8Ucty-vlX1qHLdDZzQGlDvJWDGx-gUOuZkem_wYDZYOm.jpg';
		$oproduct[$i]['imgalt']='博冠 1050ZCY 保罗';
		$oproduct[$i]['imgtitle']='博冠 1050ZCY 保罗';
		$oproduct[$i]['title']='博冠 1050ZCY 保罗';
		$oproduct[$i]['desc']='工作原理:折射式 放大倍率:10 变焦类型:定焦 调焦方式:中央调焦 物镜口径:50mm';
		$oproduct[$i]['reviewsum']='98';
		
	}
	
	$orelatekw = array();
	$i=0;
	while($i++<18){
		$orelatekw[$i]['keyword']='天文望远镜';
		$orelatekw[$i]['link']='a.html';
	}	
	$onew = array();
	$i=0;
	while($i++<5){
		$onew[$i]['title']='望远镜选购指南（如何辨别劣质望远镜） 行色天下KDS宽带山宽带山社区 ...';
		$onew[$i]['link']='a.html';
		$onew[$i]['desc']='驴行天下，没有一个好的的望远镜怎么行呢，以下是一些望远镜知识，希望能对大家选购';
	}
	##########
	$osumarize=array();
	
	$osumarize['imglink']='images/0qgqyhj0fLRqPRw7e_GVQCtrsXUuMYRHYhapfwLst4rX7WPb6yH-x9pljeEk.jpg';
	$osumarize['imgalt']='戴尔 Latitude E6400';
	$osumarize['pricerange']='￥7,500到 ￥12,077';
	$osumarize['name']='戴尔 Latitude E6400';
	$osumarize['link']='a.html';
	$osumarize['desc']='工作原理:折射式 放大倍率:10 变焦类型:定焦 调焦方式:中央调焦 物镜口径:50mm';
	$osumarize['cmppricelink']='a.html';
	$osumarize['techlink']='a.html';
	$osumarize['reviewlink']='a.html';
	$osumarize['reviewcount']='88';
	$osumarize['sellercount']='10';
	##########
	$oreview=array();
	$i=0;
	while($i++<5){
		$oreview[$i]['title']='性价比非常高，非常喜欢。 ';
		$oreview[$i]['site']='www.buy360.com';
		$oreview[$i]['sitename']='京东商城 ';
		$oreview[$i]['author']='adidasboy520@tom.com';
		$oreview[$i]['date']='2011-5-1';
		$oreview[$i]['star']='5';
		$oreview[$i]['link']='http://www.google.com.hk';
		$oreview[$i]['content']='优点： 性价比非常高，非常喜欢。...不足： 暂时还没发现缺点哦！ 性价比非常高，非常喜欢。';
	}
	
	$oattribute=array();
	$i=0;
	while($i++<5){
		$oattribute[$i]['name']='品牌 ';
		$oattribute[$i]['value']='dell(戴尔)';
	}
	
	
	$smarty->assign('oattribute',$oattribute);
	$smarty->assign('oreview',$oreview);
	$smarty->assign('osumarize',$osumarize);
	$smarty->assign('orelatekw',$orelatekw);
	$smarty->assign('oprice', $oprice);
	$smarty->assign('ocat', $ocat);
	$smarty->assign('obrand', $obrand);
	$smarty->assign('oproduct', $oproduct);
	$smarty->assign('onew', $onew);
	$smarty->assign('lang',$_LANG);
	#####foot object
	
		$ofoot = array();
        $ofoot[0]['model']      = '首页';
        $ofoot[0]['link']       = 'a.html';
        
        $ofoot[1]['model']      = '隐私权';
        $ofoot[1]['link']       = 'a.html';
        
        $ofoot[2]['model']      = '帮助';
        $ofoot[2]['link']       = 'a.html';
        
	$smarty->assign('ofoot', $ofoot);
	#####SEO object
	$smarty->assign('page_title', '望远镜 - 点点淘 购物搜索');
	$smarty->assign('keywords', '望远镜 价格|望远镜 评价|望远镜');
	$smarty->assign('description', '提供 望远镜 价格比较，评价测试，在线商店商家地址信息');
	    
    $smarty->display('review.dwt', '');


?>