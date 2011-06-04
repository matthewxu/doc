<?php

	/**
	 * test smarty index.php
	*/
	//mt定义入口常量
	define('IN_ECS', true);
	/* 取得当前ecshop所在的根目录 */
	//str_replace(find,replace,string,count)
	define('ROOT_PATH', str_replace('test/testindexsmarty.php', '', str_replace('\\', '/', __FILE__)));
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
//     $smarty->assign('searchbox', '搜索商品');     
//     $smarty->assign('searchtitle', '点点淘搜索');   
    $smarty->assign('lang',$_LANG);
     #####recent view object
	$oview = array();
	$oview[0]['img']='images/_uu-1DaNOyy8wgsaXarxI5NJTWV0XOR1axo-TxkQ0FEyFXZ1ir3bnAbddY6U.jpg';
	$oview[0]['price']='340$';
	$oview[0]['star1']='1';
	$oview[0]['star2']='1';
	$oview[0]['star3']='1';
	$oview[0]['star4']='1';
	$oview[0]['star5']='0';
	$oview[0]['name']='Samsung2 i9000 ';
	$oview[0]['description']='8GB...';
	$oview[0]['num']='1';
	
	$oview[1]['img']='images/_uu-1DaNOyy8wgsaXarxI5NJTWV0XOR1axo-TxkQ0FEyFXZ1ir3bnAbddY6U.jpg';
	$oview[1]['price']='340$';
	$oview[1]['star1']='1';
	$oview[1]['star2']='1';
	$oview[1]['star3']='1';
	$oview[1]['star4']='1';
	$oview[1]['star5']='0';
	$oview[1]['name']='Samsung2 i9000 ';
	$oview[1]['description']='8GB...';
	$oview[1]['num']='1';
	
	$oview[2]['img']='images/_uu-1DaNOyy8wgsaXarxI5NJTWV0XOR1axo-TxkQ0FEyFXZ1ir3bnAbddY6U.jpg';
	$oview[2]['price']='340$';
	$oview[2]['star1']='1';
	$oview[2]['star2']='1';
	$oview[2]['star3']='1';
	$oview[2]['star4']='1';
	$oview[2]['star5']='0';
	$oview[2]['name']='Samsung2 i9000 ';
	$oview[2]['description']='8GB...';
	$oview[2]['num']='2';
	####hot
	$ohot = array();
	$ohot[0]['img']='images/_uu-1DaNOyy8wgsaXarxI5NJTWV0XOR1axo-TxkQ0FEyFXZ1ir3bnAbddY6U.jpg';
	$ohot[0]['price']='340$';
	$ohot[0]['star1']='1';
	$ohot[0]['star2']='1';
	$ohot[0]['star3']='1';
	$ohot[0]['star4']='1';
	$ohot[0]['star5']='0';
	$ohot[0]['name']='Samsung2 i9000 ';
	$ohot[0]['description']='8GB...';
	
	$ohot[1]['img']='images/_uu-1DaNOyy8wgsaXarxI5NJTWV0XOR1axo-TxkQ0FEyFXZ1ir3bnAbddY6U.jpg';
	$ohot[1]['price']='340$';
	$ohot[1]['star1']='1';
	$ohot[1]['star2']='1';
	$ohot[1]['star3']='1';
	$ohot[1]['star4']='1';
	$ohot[1]['star5']='0';
	$ohot[1]['name']='Samsung2 i9000 ';
	$ohot[1]['description']='8GB...';
	
	$smarty->assign('ohot', $ohot);
	$smarty->assign('oview', $oview);
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
	    
    $smarty->display('index.dwt', '');
?>