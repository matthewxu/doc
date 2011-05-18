<?php

/**
 *  首页文件
 */

//mt定义入口常量
define('IN_ECS', true);
define('ROOT_PATH_1', str_replace('test/testinit.php', '', str_replace('\\', '/', __FILE__)));
//mt init.php前台公用文件
echo ROOT_PATH_1. '/includes/init.php'."\n";
require(ROOT_PATH_1. '/includes/init.php');

?>