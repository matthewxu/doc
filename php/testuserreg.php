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


// 不需要登录的操作或自己验证是否登录（如ajax处理）的act
$not_login_arr =
array('1','login','act_login','reg','act_reg','signin', 'add_tag', 'collect',  'logout', 'email_list', 
'checkemail','checkname', 'checkcaptcha', 'is_registered',
'get_passwd_question','qpsw', 'act_qpsw','reset_qpsw', 'check_answer');

/* 显示页面的action列表 */
$ui_arr = array('reg', 'login', 'profile', 'order_list', 'order_detail', 'address_list', 'collection_list',
'message_list', 'tag_list', 'reset_password', 'booking_list', 'add_booking', 'account_raply',
'account_deposit', 'account_log', 'account_detail', 'act_account', 'pay', 'default', 'bonus', 'group_buy', 
'group_buy_detail', 'affiliate', 'comment_list','validate_email','track_packages', 'transform_points','favour_list',
'group_list', 'get_passwd_question', 'check_answer');

$action  = isset($_REQUEST['act']) ? trim($_REQUEST['act']) : 'profile';
if(!in_array($action,$not_login_arr) && !in_array($action,$ui_arr)){
	$action='profile';
}
/**/
$login_reg=array('reg','act_reg','login','act_login');

/* 未登录处理 */
if (empty($_SESSION['user_id']))
{
	if (!in_array($action, $not_login_arr))
	{
		if (in_array($action, $ui_arr))
		{
			/* 如果需要登录,并是显示页面的操作，记录当前操作，用于登录后跳转到相应操作*/
			 if ($action == 'login')
			 {
				 if (isset($_REQUEST['back_act']))
				 {
				 	$back_act = trim($_REQUEST['back_act']);
				 }
			 }
			 else
			 {
			 	
			 }
			if (!empty($_SERVER['QUERY_STRING']))
			{
				$back_act = $thisfile."?" . $_SERVER['QUERY_STRING'];
			}
			$action = 'login';
		}
		else
		{
			//未登录提交数据。非正常途径提交数据！
			die($_LANG['require_login']);
		}
	}
}elseif (in_array($action,$login_reg)){
	$action='profile';
}

$thisfile=basename(PHP_SELF);
$smarty->assign('thisfile', $thisfile);
$smarty->assign('action',   $action);	

if (!isset($_SESSION['back_act']) && isset($GLOBALS['_SERVER']['HTTP_REFERER']))
{
	$back_act =  $GLOBALS['_SERVER']['HTTP_REFERER'];
	$_SESSION['back_act']=$back_act;
}
$back_act=$back_act?$back_act:$_SESSION['back_act'];


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
        	$userinfo['username']= $_SESSION['username'];
			$smarty->assign('user_info',$userinfo );
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
elseif ($action =='checkname'){

    include_once(ROOT_PATH . 'includes/lib_passport.php');

    $username = trim($_GET['username']);
    
    $username = json_str_iconv($username);
	if (preg_match('/\'\/^\\s*$|^c:\\\\con\\\\con$|[%,\\*\\"\\s\\t\\<\\>\\&\'\\\\]/', $username))
    {
            echo sprintf($_LANG['username_invalid'],$username);
    }elseif ($user->check_user($username) )
    {
        echo sprintf($GLOBALS['_LANG']['username_exist'],$username);
    }
    else
    {
        
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

elseif ($action == 'profile')
{
		$smarty->assign('action', 'profile');
		if($user_id){
			$userinfo['username']= $_SESSION['username'];
			$smarty->assign('user_info',$userinfo );
		}
        $smarty->display('user.dwt');
}

/*取回密码*/
elseif($action == 'qpsw')
{
	        $smarty->display('user.dwt');
}
/*send psw to user email*/
elseif ($action=='act_qpsw'){
	include_once(ROOT_PATH . 'includes/lib_passport.php');
	if (isset($_GET['code']) && isset($_GET['uid'])) //从邮件处获得的act
    {
        $code = trim($_GET['code']);
        $uid  = intval($_GET['uid']);

        /* 判断链接的合法性 */
        $user_info = $user->get_profile_by_id($uid);
        if (empty($user_info) || ($user_info && md5($user_info['user_id'] . $_CFG['hash_code'] . $user_info['reg_time']) != $code))
        {
            show_message($_LANG['parm_error'], $_LANG['back_home_lnk'], './', 'info');
        }

        $smarty->assign('uid',    $uid);
        $smarty->assign('code',   $code);
        $smarty->assign('action', 'reset_qpsw');
        $smarty->display('user.dwt');
        exit;
    }
	
    /* 初始化会员用户名和邮件地址 */
    $email     = !empty($_POST['email'])     ? trim($_POST['email'])     : '';

    //用户名和邮件地址是否匹配
    $user_info = $user->get_user_info($email);
    
    if ($user_info && $user_info['email'] == $email)
    {
    	$user_name=$user_info['user_name'];
        //生成code
         //$code = md5($user_info[0] . $user_info[1]);

        $code = md5($user_info['user_id'] . $_CFG['hash_code'] . $user_info['reg_time']);
        //发送邮件的函数
        if (send_pwd_email($user_info['user_id'], $user_name, $email, $code))
        {
        	show_message($_LANG['send_success'] . $email, $_LANG['back_home_lnk'], './', 'info');

        }
        else
        {
        	//发送邮件出错
            show_message($_LANG['fail_send_password'], $_LANG['back_page_up'], $back_act, 'info');
        }
    }
    else
    {
        //用户名与邮件地址不匹配
        show_message($_LANG['username_no_email'], $_LANG['back_page_up'], '', 'info');
    }
	
}
elseif($action == 'reset_qpsw')
{			
    include_once(ROOT_PATH . 'includes/lib_passport.php');

    $old_password = isset($_POST['old_password']) ? trim($_POST['old_password']) : null;
    $new_2_password = isset($_POST['PasswdAgain']) ? trim($_POST['PasswdAgain']) : null;
    $new_password = isset($_POST['Passwd']) ? trim($_POST['Passwd']) : '';
    $user_id      = isset($_POST['uid'])  ? intval($_POST['uid']) : $user_id;
    $code         = isset($_POST['code']) ? trim($_POST['code'])  : '';

    if($new_password !==$new_2_password){
    	   show_message($_LANG['passport_js']['confirm_password_invalid']);
    }
    if (strlen($new_password) < 6)
    {
        show_message($_LANG['passport_js']['password_shorter']);
    }

    $user_info = $user->get_profile_by_id($user_id); //论坛记录

    if (($user_info && (!empty($code) && md5($user_info['user_id'] . $_CFG['hash_code'] . $user_info['reg_time']) == $code))
    	 || ($_SESSION['user_id']>0 && $_SESSION['user_id'] == $user_id && $user->check_user($_SESSION['user_name'], $old_password)))
    {
        if ($user->edit_user(array('username'=> (empty($code) ? $_SESSION['user_name'] : $user_info['user_name']), 'old_password'=>$old_password, 'password'=>$new_password), empty($code) ? 0 : 1))
        {
            $user->logout();
            show_message($_LANG['edit_password_success'], $_LANG['relogin_lnk'], 'user.php?act=login', 'info');
        }
        else
        {
            show_message($_LANG['edit_password_failure'], $_LANG['back_page_up'], '', 'info');
        }
    }
    else
    {
        show_message($_LANG['edit_password_failure'], $_LANG['back_page_up'], '', 'info');
    }
    
}
/* 修改会员密码 */
elseif ($action == 'act_edit_password')
{
    
}

elseif($action == 'logout')
{    
	if (!isset($back_act) && isset($GLOBALS['_SERVER']['HTTP_REFERER']))
    {
        $back_act = strpos($GLOBALS['_SERVER']['HTTP_REFERER'], $thisfile) ? './index.php' : $GLOBALS['_SERVER']['HTTP_REFERER'];
    }

    $user->logout();
    $ucdata = empty($user->ucdata)? "" : $user->ucdata;
    show_message($_LANG['logout'] . $ucdata, array($_LANG['back_up_page'], $_LANG['back_home_lnk']), array($back_act, 'index.php'), 'info');
}elseif($action=='login'){
	if (empty($back_act))
    {
        if (empty($back_act) && isset($GLOBALS['_SERVER']['HTTP_REFERER']))
        {
            $back_act = strpos($GLOBALS['_SERVER']['HTTP_REFERER'], $thisfile) ? './index.php' : $GLOBALS['_SERVER']['HTTP_REFERER'];
        }
        else
        {
            $back_act = $thisfile;
        }

    }


    $captcha = intval($_CFG['captcha']);
    if (($captcha & CAPTCHA_LOGIN) && (!($captcha & CAPTCHA_LOGIN_FAIL) || (($captcha & CAPTCHA_LOGIN_FAIL) && $_SESSION['login_fail'] > 2)) && gd_version() > 0)
    {
        $GLOBALS['smarty']->assign('enabled_captcha', 1);
        $GLOBALS['smarty']->assign('rand', mt_rand());
    }

    $smarty->assign('back_act', $back_act);
    $smarty->display('user.dwt');
}
elseif($action=='act_login'){
	
    $username = isset($_POST['Email']) ? trim($_POST['Email']) : '';
    $password = isset($_POST['Passwd']) ? trim($_POST['Passwd']) : '';
    //$back_act = isset($_POST['back_act']) ? trim($_POST['back_act']) : '';


    $captcha = intval($_CFG['captcha']);
    if (($captcha & CAPTCHA_LOGIN) && (!($captcha & CAPTCHA_LOGIN_FAIL) || (($captcha & CAPTCHA_LOGIN_FAIL) && $_SESSION['login_fail'] > 2)) && gd_version() > 0)
    {
        if (empty($_POST['captcha']))
        {
            show_message($_LANG['invalid_captcha'], $_LANG['relogin_lnk'], 'user.php', 'error');
        }

        /* 检查验证码 */
        include_once('includes/cls_captcha.php');

        $validator = new captcha();
        $validator->session_word = 'captcha_login';
        if (!$validator->check_word($_POST['captcha']))
        {
            show_message($_LANG['invalid_captcha'], $_LANG['relogin_lnk'], 'user.php', 'error');
        }
    }

    if ($user->login($username, $password,isset($_POST['remember'])))
    {
    	
        update_user_info();
        $userinfo['username']= $_SESSION['username'];
		$smarty->assign('user_info',$userinfo );
        $ucdata = isset($user->ucdata)? $user->ucdata : '';
        show_message($_LANG['login_success'] . $ucdata , array($_LANG['back_up_page'], $_LANG['profile_lnk']), array($back_act,'user.php'), 'info');
    }
    else
    {
        $_SESSION['login_fail'] ++ ;
        show_message($_LANG['login_failure'], $_LANG['relogin_lnk'], $thisfile, 'error');
    }
}//
elseif ($action=='collection'){
	
	$smarty->display('user.dwt');
}

?>