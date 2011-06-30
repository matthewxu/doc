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

$action  = isset($_REQUEST['act']) ? trim($_REQUEST['act']) : 'reg';

$thisfile=basename(PHP_SELF);
$smarty->assign('thisfile', $thisfile);
	
/* 显示会员注册界面 */
if ($action == 'reg')
{
	
    /* 增加是否关闭注册 */
    if ($_CFG['reg_closed'])
    {
        $smarty->assign('action',     'register');
        $smarty->assign('reg_closed', $_CFG['reg_closed']);
        $smarty->assign('back_act', $back_act);
        $smarty->display('user.dwt');
    }else{
	    if (!isset($back_act) && isset($GLOBALS['_SERVER']['HTTP_REFERER']))
	    {
	        $back_act = strpos($GLOBALS['_SERVER']['HTTP_REFERER'], 'user.php') ? './index.php' : $GLOBALS['_SERVER']['HTTP_REFERER'];
	        $_SESSION['back_act']=$back_act;
	    }
	    
	    /* 验证码相关设置 */
	    if ((intval($_CFG['captcha']) & CAPTCHA_REGISTER) && gd_version() > 0)
	    {
	        $smarty->assign('enabled_captcha', 1);
	        $smarty->assign('rand',            mt_rand());
	    }
	    /* 密码提示问题 */
	    $smarty->assign('passwd_questions', $_LANG['passwd_questions']);
	    $smarty->assign('action', $action);
	    $smarty->display('user.dwt');
	}
}
/* 处理注册 */
/*
 *todo mt processing
 */
elseif ($action == 'act_reg')
{
    /* 增加是否关闭注册 */
    if ($_CFG['reg_closed'])
    {
        $smarty->assign('action',     'register');
        $smarty->assign('reg_closed', $_CFG['reg_closed']);
        $smarty->display('user.dwt');
    }
    else
    {
        include_once(ROOT_PATH . 'includes/lib_passport.php');
        $username = isset($_POST['username']) ? trim($_POST['username']) : '';
        $password = isset($_POST['Passwd']) ? trim($_POST['Passwd']) : '';
        $email    = isset($_POST['Email']) ? trim($_POST['Email']) : '';
        $other['msn'] = isset($_POST['extend_field1']) ? $_POST['extend_field1'] : '';
        $other['qq'] = isset($_POST['extend_field2']) ? $_POST['extend_field2'] : '';
        $other['office_phone'] = isset($_POST['extend_field3']) ? $_POST['extend_field3'] : '';
        $other['home_phone'] = isset($_POST['extend_field4']) ? $_POST['extend_field4'] : '';
        $other['mobile_phone'] = isset($_POST['extend_field5']) ? $_POST['extend_field5'] : '';
        $sel_question = empty($_POST['sel_question']) ? '' : $_POST['sel_question'];
        $passwd_answer = isset($_POST['passwd_answer']) ? trim($_POST['passwd_answer']) : '';

    	if (!isset($_SESSION['back_act']) && isset($GLOBALS['_SERVER']['HTTP_REFERER']))
	    {
	        $back_act =  $GLOBALS['_SERVER']['HTTP_REFERER'];
	        $_SESSION['back_act']=$back_act;
	    }
	    $back_act=$_SESSION['back_act'];
        if (strlen($password) < 6)
        {
            show_message($_LANG['passport_js']['password_shorter'],$_LANG['sign_up'],$thisfile, 'error');
        }
        			
        
        if (strpos($password, ' ') > 0)
        {
            show_message($_LANG['passwd_blank'],$_LANG['sign_up'],$thisfile, 'error');
        }
        
        /* 验证码检查 */
        if ((intval($_CFG['captcha']) & CAPTCHA_REGISTER) && gd_version() > 0)
        {
            if (empty($_POST['captcha']))
            {
                show_message($_LANG['invalid_captcha'], $_LANG['sign_up'], $thisfile, 'error');
            }

            /* 检查验证码 */
            include_once('includes/cls_captcha.php');

            $validator = new captcha();
            if (!$validator->check_word($_POST['captcha']))
            {
                show_message($_LANG['invalid_captcha'], $_LANG['sign_up'], $thisfile, 'error');
            }
        }
        if (register($username, $password, $email, $other) !== false)
        {
        	

            /* 写入密码提示问题和答案 */
            if (!empty($passwd_answer) && !empty($sel_question))
            {
                $sql = 'UPDATE ' . $ddt->table('user') . " SET `question`='$sel_question', `answer`='$passwd_answer'  WHERE ` id`='" . $_SESSION['user_id'] . "'";
                $db->query($sql);
            }

            $ucdata = empty($user->ucdata)? "" : $user->ucdata;
            show_message(sprintf($_LANG['register_success'], $username . $ucdata), array($_LANG['back_up_page'], $_LANG['profile_lnk']), array($back_act, 'user.php'), 'info');
        }
        else
        {
            $err->show($_LANG['sign_up'], $thisfile);
        }
    }
}

/* 验证用户注册邮件 */
elseif ($action == 'checkemail')
{
	
	$email = trim($_GET['email']);
    $email = htmlspecialchars($email);
   
	if (!is_email($email))
    {
        $info = sprintf($_LANG['email_invalid'], $email);
        die($info);
    }
    $ck = $db->getRow("SELECT * FROM " . $ddt->table('user') . " WHERE email = '$email' limit 1");
    if (empty($ck)){
    	die (0);
    }else{
    	$info = sprintf($_LANG['msg_email_registered'], $email);
    	die($info);
    }
}/*ajax验证码*/
elseif ($action=='checkcaptcha')
{
    	/* 验证码检查 */
	if ((intval($_CFG['captcha']) & CAPTCHA_REGISTER) && gd_version() > 0)
        {

        	if (empty($_GET['captcha']))
            {
                die($_LANG['invalid_captcha']);
            }
            /* 检查验证码 */
            include_once('includes/cls_captcha.php');

            $validator = new captcha();
            if (!$validator->check_word($_GET['captcha']))
            {
                die($_LANG['invalid_captcha']);
            }
        }
        die(0);
}

/* 验证用户注册用户名是否可以注册 */
elseif ($action == 'is_registered')
{
}


elseif($action == 'check_email')
{
}

?>