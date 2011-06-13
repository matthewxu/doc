<?php

/**
 * DIANDIANTAO 会员中心
 * ============================================================================
 * 网站地址: http://www.DIANDIANTAO.com；
 * ----------------------------------------------------------------------------
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 * ============================================================================
*/

define('IN_DDT', true);
//调用初始化
require(dirname(__FILE__) . '/includes/init.php');
/* 载入语言文件 */
require_once(ROOT_PATH . 'languages/' .$_CFG['lang']. '/user.php');
$user_id = $_SESSION['user_id'];

$action  = isset($_REQUEST['act']) ? trim($_REQUEST['act']) : 'signin';


/* 显示会员注册界面 */
if ($action == 'signin')
{
    if (!isset($back_act) && isset($GLOBALS['_SERVER']['HTTP_REFERER']))
    {
        $back_act = strpos($GLOBALS['_SERVER']['HTTP_REFERER'], 'user.php') ? './index.php' : $GLOBALS['_SERVER']['HTTP_REFERER'];
    }


    /* 验证码相关设置 */
    if ((intval($_CFG['captcha']) & CAPTCHA_REGISTER) && gd_version() > 0)
    {
        $smarty->assign('enabled_captcha', 1);
        $smarty->assign('rand',            mt_rand());
    }

    /* 密码提示问题 */
    $smarty->assign('passwd_questions', $_LANG['passwd_questions']);

    /* 增加是否关闭注册 */
    $smarty->assign('shop_reg_closed', $_CFG['shop_reg_closed']);
    $smarty->assign('back_act', $back_act);
    $smarty->assign('action', $action);
    
    $smarty->display('user.dwt');
}

/* 注册会员的处理 */
/*
 * mt processing
 */
elseif ($action == 'act_signin')
{
}

/* 验证用户注册邮件 */
elseif ($action == '')
{
}

/* 验证用户注册用户名是否可以注册 */
elseif ($action == 'is_registered')
{
}

/* 验证用户邮箱地址是否被注册 */
elseif($action == 'check_email')
{
}

?>