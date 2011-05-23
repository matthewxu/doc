<?php

	/**
	 * test smarty index.php
	*/
	//mt定义入口常量
	define('IN_ECS', true);
	/* 取得当前ecshop所在的根目录 */
	//str_replace(find,replace,string,count)
	define('ROOT_PATH', str_replace('testproductsmarty.php', '', str_replace('\\', '/', __FILE__)));
	/* 创建 Smarty 对象。*/
	//cls_template.php 模版类 
    require(ROOT_PATH . 'includes/cls_template.php');
    $_CFG = array();
    $_CFG['template']='default';
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
     $smarty->assign('searchbox', '搜索商品');     
     $smarty->assign('searchtitle', '点点淘搜索');
     $smarty->assign('sekw', '望远镜');
     $smarty->assign('fromprice', '元到');
     $smarty->assign('toprice', '元');
     $smarty->assign('searchbutton','搜');
    #####recent view object
	$ocat = array();
	while($i++<3){
		$ocat[$i]['catname']='光学产品/光学仪器';
		$ocat[$i]['catlink']='a.html';
		$ocat[$i]['subcatname']='望远镜';
		$ocat[$i]['subcatlink']='a.html';
	}

	$oprice=array();
	$i=0;
	while($i++<5){
		$oprice[$i][price]='低于 70';
		$oprice[$i][pricelink]='a.htm';
	}
	$obrand=array();
	$i=0;
	while($i++<5){
		$obrand[$i][brand]='品牌'.$i;
		$obrand[$i][brandlink]='a.htm';
	}
	
	
	$smarty->assign('oprice', $oprice);
	$smarty->assign('ocat', $ocat);
	$smarty->assign('obrand', $obrand);
	$smarty->assign('allcat','所有类别');
	$smarty->assign('allprice', '所有价格');
	$smarty->assign('allbrand','所有品牌');
	#####foot object
	
		$ofoot = array();
        $ofoot[0]['model']      = '首页';
        $ofoot[0]['modellink']       = 'a.html';
        
        $ofoot[1]['model']      = '隐私权';
        $ofoot[1]['modellink']       = 'a.html';
        
        $ofoot[2]['model']      = '帮助';
        $ofoot[2]['modellink']       = 'a.html';
        
	$smarty->assign('ofoot', $ofoot);
	#####SEO object
	$smarty->assign('page_title', '望远镜 - 点点淘 购物搜索');
	$smarty->assign('keywords', '望远镜 价格|望远镜 评价|望远镜');
	$smarty->assign('description', '提供 望远镜 价格比较，评价测试，在线商店商家地址信息');
	    
    $smarty->display('product.dwt', '');


?>