<?php
	/**
	 * test mysql 
	*/
	//mt定义入口常量
	define('IN_ECS', true);
	/* 取得当前ecshop所在的根目录 */
	//str_replace(find,replace,string,count)
	define('ROOT_PATH', str_replace('test/testsmarty.php', '', str_replace('\\', '/', __FILE__)));
	echo ROOT_PATH."\n";

    /* 创建 Smarty 对象。*/
	//cls_template.php 模版类 
    require(ROOT_PATH . 'includes/cls_template.php');
    $smarty = new cls_template;
	$smarty->direct_output = true;
	$smarty->force_compile = true;
    $smarty->template_dir   = ROOT_PATH . 'themes/test';
    $smarty->cache_dir      = ROOT_PATH . 'temp/caches';
    $smarty->compile_dir    = ROOT_PATH . 'temp/compiled';

	$_LANG['sys_msg'] = '系统提示';
	$_LANG['catalog'] = '目录';
	$_LANG['please_view_order_detail'] = '商品已发货，详情请到用户中心订单详情查看';
	$_LANG['user_center'] = '用户中心';
	$_LANG['shop_closed'] = '本店盘点中，请您稍后再来...';
	    
    $smarty->assign('lang', $_LANG);
    $smarty->display('test.dwt', '');
    
?>