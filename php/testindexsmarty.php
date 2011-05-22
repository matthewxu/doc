<?php

	/**
	 * test smarty index.php
	*/
	//mt定义入口常量
	define('IN_ECS', true);
	/* 取得当前ecshop所在的根目录 */
	//str_replace(find,replace,string,count)
	define('ROOT_PATH', str_replace('testindexsmarty.php', '', str_replace('\\', '/', __FILE__)));
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
    #####recent view object
	$oview = array();
	while($i++<10){
		$oview[$i]['img']='images/_uu-1DaNOyy8wgsaXarxI5NJTWV0XOR1axo-TxkQ0FEyFXZ1ir3bnAbddY6U.jpg';
		$oview[$i]['price']='340$';
		$oview[$i]['star1']='1';
		$oview[$i]['star2']='1';
		$oview[$i]['star3']='1';
		$oview[$i]['star4']='1';
		$oview[$i]['star5']='0';
		$oview[$i]['name']='Samsung2 i9000 ';
		$oview[$i]['description']='8GB...';
		$oview[$i]['num']=$i-1;
	}
	/***
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
	
	$oview[3]['img']='images/_uu-1DaNOyy8wgsaXarxI5NJTWV0XOR1axo-TxkQ0FEyFXZ1ir3bnAbddY6U.jpg';
	$oview[3]['price']='340$';
	$oview[3]['star1']='1';
	$oview[3]['star2']='1';
	$oview[3]['star3']='1';
	$oview[3]['star4']='1';
	$oview[3]['star5']='0';
	$oview[3]['name']='Samsung2 i9000 ';
	$oview[3]['description']='8GB...';
	$oview[3]['num']='3';

	$oview[4]['img']='images/_uu-1DaNOyy8wgsaXarxI5NJTWV0XOR1axo-TxkQ0FEyFXZ1ir3bnAbddY6U.jpg';
	$oview[4]['price']='340$';
	$oview[4]['star1']='1';
	$oview[4]['star2']='1';
	$oview[4]['star3']='1';
	$oview[4]['star4']='1';
	$oview[4]['star5']='0';
	$oview[4]['name']='Samsung2 i9000 ';
	$oview[4]['description']='8GB...';
	$oview[4]['num']='4';
	


	$oview[5]['img']='images/_uu-1DaNOyy8wgsaXarxI5NJTWV0XOR1axo-TxkQ0FEyFXZ1ir3bnAbddY6U.jpg';
	$oview[5]['price']='340$';
	$oview[5]['star1']='1';
	$oview[5]['star2']='1';
	$oview[5]['star3']='1';
	$oview[5]['star4']='1';
	$oview[5]['star5']='0';
	$oview[5]['name']='Samsung2 i9000 ';
	$oview[5]['description']='8GB...';
	$oview[5]['num']='4';
	**/
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

	$okw=array();
	$i=0;
	while($i++<10){
		$okw[$i][keyword]='手机';
		$okw[$i][link]='a.htm';
	}
	
	$smarty->assign('ohot', $ohot);
	$smarty->assign('oview', $oview);
	$smarty->assign('okw', $okw);
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