<?php

/**
 * test mysql 
*/
//mt定义入口常量
define('IN_ECS', true);
/* 取得当前ecshop所在的根目录 */
//str_replace(find,replace,string,count)
	define('ROOT_PATH', str_replace('test/testmysql.php', '', str_replace('\\', '/', __FILE__)));
	echo ROOT_PATH."\n";
	require(ROOT_PATH . 'data/config.php');
	require(ROOT_PATH . 'includes/cls_mysql.php');
	echo $db_host."\t".$db_user."\t".$db_pass."\t".$db_name."\n";
	$db = new cls_mysql($db_host, $db_user, $db_pass, $db_name);
	$db_host = $db_user = $db_pass = $db_name = NULL;
	$sql = "select *from documents";
    $res = $GLOBALS['db']->query($sql);

    while ($row = $GLOBALS['db']->fetchRow($res))
    {
    	echo $row['title']."\t".$row['content']."\n";
    	/**
    	************
        $ext_info = unserialize($row['title']);
        $arr = array_merge($row, $ext_info);
        $arr['formated_start_price'] = price_format($arr['start_price']);
        $arr['formated_end_price'] = price_format($arr['end_price']);
        $arr['thumb'] = get_image_path($row['goods_id'], $row['goods_thumb'], true);
        $arr['url'] = build_uri('auction', array('auid' => $arr['act_id']));
        $arr['short_name']   = $GLOBALS['_CFG']['goods_name_length'] > 0 ?
                                           sub_str($arr['goods_name'], $GLOBALS['_CFG']['goods_name_length']) : $arr['goods_name'];
        $arr['short_style_name']   = add_style($arr['short_name'],'');
        $list[] = $arr;
        ***************/
    }



?>