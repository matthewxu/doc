<?php

	/**
	 * test smarty index.php
	*/
	//mt定义入口常量
	define('IN_ECS', true);
	/* 取得当前ecshop所在的根目录 */
	//str_replace(find,replace,string,count)
	define('ROOT_PATH', str_replace('testinfosmarty.php', '', str_replace('\\', '/', __FILE__)));
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
     $smarty->assign('t_searchbutton','搜');
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
	while($i++<8){
		$obrand[$i][brand]='品牌'.$i;
		$obrand[$i][brandlink]='a.htm';
		$obrand[$i][brandimglink]='a.jpg';
	}
	$opage=array();
	$i=0;
	while($i++<8){
		$opage[$i][num]=$i;
		$opage[$i][link]=$i.'a.htm';
	}
	$i++;
	$onpage[num]='2';
	$onpage[next]='下一页';
	$onpage[link]='2'.'a.htm';
	
	$osort=array();
	$osort['t_sortstyle']='排序方式';
	$osort['t_sortr']='相关性';
	$osort['t_sortp']='价格：从低到高';
	$osort['t_sortpd']='价格：从高到低';
	$osort['t_sorts']='显示列表视图';
	
	
	##### search result product list
	$oproduct = array();
	$i=0;
	while($i++<8){
		$oproduct[$i]['sellercount']='共 8 个卖家有售';
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
	$smarty->assign('opage',$opage);
	$smarty->assign('onpage',$onpage);
	$smarty->assign('osort',$osort);
	$smarty->assign('orelatekw',$orelatekw);
	$smarty->assign('oprice', $oprice);
	$smarty->assign('ocat', $ocat);
	$smarty->assign('obrand', $obrand);
	$smarty->assign('oproduct', $oproduct);
	$smarty->assign('onew', $onew);
	$smarty->assign('allcat','所有类别');
	$smarty->assign('allprice', '所有价格');
	$smarty->assign('allbrand','所有品牌');
	$smarty->assign('t_moreinfo','	查看更多导购信息 »');
	$smarty->assign('t_relate','的相关搜索');
	$smarty->assign('t_cmpprice','比较价格');
	$smarty->assign('t_review','条评论');
	$smarty->assign('t_brandbuy','按品牌选购');
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