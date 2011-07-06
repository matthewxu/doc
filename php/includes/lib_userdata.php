<?php

/**
 * DIANDIANTAO 用户帐号相关函数库
 * ============================================================================
 * 网站地址: http://www.DIANDIANTAO.com；
 * ----------------------------------------------------------------------------
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 * ============================================================================
*/

if (!defined('IN_DDT'))
{
    die('Hacking attempt');
}

/**
 * 用户分享数据读取
 *
 * @access  public
 * @param   int       $uid          注册用户id
 * @param   int       $email             注册email
 * @param   array        $other             注册的其他信息
 *
 * @return  bool         $bool
 */
function register($username, $password, $email, $other = array())
{
	
		
    /* 检查注册是否关闭 */
    if (!empty($GLOBALS['_CFG']['reg_closed']))
    {
        $GLOBALS['err']->add($GLOBALS['_LANG']['register_closed']);
    }
	 /* 检查email */
    if (empty($email))
    {
        $GLOBALS['err']->add($GLOBALS['_LANG']['email_empty']);
    }
    else
    {
        if (!is_email($email))
        {
            $GLOBALS['err']->add(sprintf($GLOBALS['_LANG']['email_invalid'], htmlspecialchars($email)));
        }
    }
    /* 检查username */
    if (empty($username))
    {
        $GLOBALS['err']->add($GLOBALS['_LANG']['username_empty']);
    }
    else
    {
        if (preg_match('/\'\/^\\s*$|^c:\\\\con\\\\con$|[%,\\*\\"\\s\\t\\<\\>\\&\'\\\\]/', $username))
        {
            $GLOBALS['err']->add(sprintf($GLOBALS['_LANG']['username_invalid'], htmlspecialchars($username)));
        }
    }

   

    if ($GLOBALS['err']->error_no > 0)
    {
        return false;
    }

    /* 检查是否和管理员重名
    if (admin_registered($username))
    {
        $GLOBALS['err']->add(sprintf($GLOBALS['_LANG']['username_exist'], $username));
        return false;
    }
 */
    if (!$GLOBALS['user']->add_user($username, $password, $email))
    {
    	
        if ($GLOBALS['user']->error == ERR_INVALID_USERNAME)
        {
            $GLOBALS['err']->add(sprintf($GLOBALS['_LANG']['username_invalid'], $username));
        }
        elseif ($GLOBALS['user']->error == ERR_USERNAME_NOT_ALLOW)
        {
            $GLOBALS['err']->add(sprintf($GLOBALS['_LANG']['username_not_allow'], $username));
        }
        elseif ($GLOBALS['user']->error == ERR_USERNAME_EXISTS)
        {
            $GLOBALS['err']->add(sprintf($GLOBALS['_LANG']['username_exist'], $username));
        }
        elseif ($GLOBALS['user']->error == ERR_INVALID_EMAIL)
        {
            $GLOBALS['err']->add(sprintf($GLOBALS['_LANG']['email_invalid'], $email));
        }
        elseif ($GLOBALS['user']->error == ERR_EMAIL_NOT_ALLOW)
        {
            $GLOBALS['err']->add(sprintf($GLOBALS['_LANG']['email_not_allow'], $email));
        }
        elseif ($GLOBALS['user']->error == ERR_EMAIL_EXISTS)
        {
            $GLOBALS['err']->add(sprintf($GLOBALS['_LANG']['email_exist'], $email));
        }
        else
        {
            $GLOBALS['err']->add('UNKNOWN ERROR!');
        }

        //注册失败
        return false;
    }
    else
    {
        //注册成功
        /* 设置成登录状态 */
        $GLOBALS['user']->set_session($username);
        $GLOBALS['user']->set_cookie($username);

        //定义other合法的变量数组
        $other_key_array = array('msn', 'qq', 'office_phone', 'home_phone', 'mobile_phone');
        $update_data['reg_time'] = local_strtotime(local_date('Y-m-d H:i:s'));
        if ($other)
        {
            foreach ($other as $key=>$val)
            {
                //删除非法key值
                if (!in_array($key, $other_key_array))
                {
                    unset($other[$key]);
                }
                else
                {
                    $other[$key] =  htmlspecialchars(trim($val)); //防止用户输入javascript代码
                }
            }
            $update_data = array_merge($update_data, $other);
        }
        
        $GLOBALS['db']->autoExecute($GLOBALS['ddt']->table('user'), $update_data, 'UPDATE', 'id = ' . $_SESSION['user_id']);
        update_user_info();      // 更新用户信息
        return true;
    }
}

?>