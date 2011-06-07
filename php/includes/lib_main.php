<?php

/**
 * DIANDIANTAO 前台公用函数库
 * ============================================================================
 * 网站地址: http://www.DIANDIANTAO.com；
 * ----------------------------------------------------------------------------
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 * ============================================================================
*/

if (!defined('IN_ECS'))
{
    die('Hacking attempt');
}

/**
 * mt更新用户SESSION,COOKIE及登录时间、登录次数。
 *
 * @access  public
 * @return  void
 */
function update_user_info()
{
    if (!$_SESSION['user_id'])
    {
        return false;
    }

    /* 查询会员信息 */
    $time = date('Y-m-d');
    $sql = 'SELECT u.user_money, u.pay_points, u.user_rank, u.rank_points, '.
            ' IFNULL(b.type_money, 0) AS user_bonus, u.last_login, u.last_ip'.
            ' FROM ' .$GLOBALS['ecs']->table('users'). ' AS u ' .
            ' LEFT JOIN ' .$GLOBALS['ecs']->table('user_bonus'). ' AS ub'.
            ' ON ub.user_id = u.user_id AND ub.used_time = 0 ' .
            ' LEFT JOIN ' .$GLOBALS['ecs']->table('bonus_type'). ' AS b'.
            " ON b.type_id = ub.bonus_type_id AND b.use_start_date <= '$time' AND b.use_end_date >= '$time' ".
            " WHERE u.user_id = '$_SESSION[user_id]'";
    if ($row = $GLOBALS['db']->getRow($sql))
    {
        /* 更新SESSION */
        $_SESSION['last_time']   = $row['last_login'];
        $_SESSION['last_ip']     = $row['last_ip'];
        $_SESSION['login_fail']  = 0;

        /* 取得用户等级和折扣 */
        if ($row['user_rank'] == 0)
        {
            // 非特殊等级，根据等级积分计算用户等级（注意：不包括特殊等级）
            $sql = 'SELECT rank_id, discount FROM ' . $GLOBALS['ecs']->table('user_rank') . " WHERE special_rank = '0' AND min_points <= " . intval($row['rank_points']) . ' AND max_points > ' . intval($row['rank_points']);
            if ($row = $GLOBALS['db']->getRow($sql))
            {
                $_SESSION['user_rank'] = $row['rank_id'];
                $_SESSION['discount']  = $row['discount'] / 100.00;
            }
            else
            {
                $_SESSION['user_rank'] = 0;
                $_SESSION['discount']  = 1;
            }
        }
        else
        {
            // 特殊等级
            $sql = 'SELECT rank_id, discount FROM ' . $GLOBALS['ecs']->table('user_rank') . " WHERE rank_id = '$row[user_rank]'";
            if ($row = $GLOBALS['db']->getRow($sql))
            {
                $_SESSION['user_rank'] = $row['rank_id'];
                $_SESSION['discount']  = $row['discount'] / 100.00;
            }
            else
            {
                $_SESSION['user_rank'] = 0;
                $_SESSION['discount']  = 1;
            }
        }
    }

    /* 更新登录时间，登录次数及登录ip */
    $sql = "UPDATE " .$GLOBALS['ecs']->table('users'). " SET".
           " visit_count = visit_count + 1, ".
           " last_ip = '" .real_ip(). "',".
           " last_login = '" .gmtime(). "'".
           " WHERE user_id = '" . $_SESSION['user_id'] . "'";
    $GLOBALS['db']->query($sql);
	
}

/**
 *  获取用户信息数组
 *
 * @access  public
 * @param
 *
 * @return array        $user       用户信息数组
 */
function get_user_info($id=0)
{
	
		die('get_user_info');	
    
}
/**
 * 取得当前位置和页面标题
 *
 * @access  public
 * @param   integer     $cat    分类编号（只有商品及分类、文章及分类用到）
 * @param   string      $str    商品名、文章标题或其他附加的内容（无链接）
 * @return  array
 */
function assign_ur_here($cat = 0, $str = '')
{
   die('assign_ur_here');	
}

/**
 * 获得指定分类的所有上级分类
 *
 * @access  public
 * @param   integer $cat    分类编号
 * @return  array
 */
function get_parent_cats($cat)
{}

/**
 * 根据提供的数组编译成页面标题
 *
 * @access  public
 * @param   string  $type   类型
 * @param   array   $arr    分类数组
 * @return  string
 */
function build_pagetitle($arr, $type = 'category')
{
    $str = '';

    foreach ($arr AS $val)
    {
        $str .= htmlspecialchars($val['cat_name']) . '_';
    }

    return $str;
}

/**
 * 根据提供的数组编译成当前位置
 *
 * @access  public
 * @param   string  $type   类型
 * @param   array   $arr    分类数组
 * @return  void
 */
function build_urhere($arr, $type = 'category')
{
}

/**
 * 获得指定页面的动态内容
 *
 * @access  public
 * @param   string  $tmp    模板名称
 * @return  void
 */
function assign_dynamic($tmp)
{
    $sql = 'SELECT id, number, type FROM ' . $GLOBALS['ecs']->table('template') .
        " WHERE filename = '$tmp' AND type > 0 AND remarks ='' AND theme='" . $GLOBALS['_CFG']['template'] . "'";
    $res = $GLOBALS['db']->getAll($sql);

   foreach ($res AS $row)
    {
    	
        switch ($row['type'])
        {
            case 1:
                /* 分类下的商品 */
                $GLOBALS['smarty']->assign('goods_cat_' . $row['id'], assign_cat_goods($row['id'], $row['number']));
            break;
            case 2:
                /* 品牌的商品 */
                $brand_goods = assign_brand_goods($row['id'], $row['number']);

                $GLOBALS['smarty']->assign('brand_goods_' . $row['id'], $brand_goods['goods']);
                $GLOBALS['smarty']->assign('goods_brand_' . $row['id'], $brand_goods['brand']);
            break;
            case 3:
                /* 文章列表 */
                $cat_articles = assign_articles($row['id'], $row['number']);

                $GLOBALS['smarty']->assign('articles_cat_' . $row['id'], $cat_articles['cat']);
                $GLOBALS['smarty']->assign('articles_' . $row['id'], $cat_articles['arr']);
            break;
        }
    }
}

/**
 * 分配文章列表给smarty
 *
 * @access  public
 * @param   integer     $id     文章分类的编号
 * @param   integer     $num    文章数量
 * @return  array
 */
function assign_articles($id, $num)
{
    $sql = 'SELECT cat_name FROM ' . $GLOBALS['ecs']->table('article_cat') . " WHERE cat_id = '" . $id ."'";

    $cat['id']       = $id;
    $cat['name']     = $GLOBALS['db']->getOne($sql);
    $cat['url']      = build_uri('article_cat', array('acid' => $id), $cat['name']);

    $articles['cat'] = $cat;
    $articles['arr'] = get_cat_articles($id, 1, $num);

    return $articles;
}

/**
 * 分配帮助信息
 *
 * @access  public
 * @return  array
 */
function get_shop_help()
{}

/**
 * 创建分页信息
 *
 * @access  public
 * @param   string  $app            程序名称，如category
 * @param   string  $cat            分类ID
 * @param   string  $record_count   记录总数
 * @param   string  $size           每页记录数
 * @param   string  $sort           排序类型
 * @param   string  $order          排序顺序
 * @param   string  $page           当前页
 * @param   string  $keywords       查询关键字
 * @param   string  $brand          品牌
 * @param   string  $price_min      最小价格
 * @param   string  $price_max      最高价格
 * @return  void
 */
function assign_pager($app, $cat, $record_count, $size, $sort, $order, $page = 1,
                        $keywords = '', $brand = 0, $price_min = 0, $price_max = 0, $display_type = 'list', $filter_attr='', $url_format='', $sch_array='')
{}

/**
 *  生成给pager.lbi赋值的数组
 *
 * @access  public
 * @param   string      $url        分页的链接地址(必须是带有参数的地址，若不是可以伪造一个无用参数)
 * @param   array       $param      链接参数 key为参数名，value为参数值
 * @param   int         $record     记录总数量
 * @param   int         $page       当前页数
 * @param   int         $size       每页大小
 *
 * @return  array       $pager
 */
function get_pager($url, $param, $record_count, $page = 1, $size = 10)
{}

/**
 * 调用调查内容
 *
 * @access  public
 * @param   integer $id   调查的编号
 * @return  array
 */
function get_vote($id = '')
{}

/**
 * 获得浏览器名称和版本
 *
 * @access  public
 * @return  string
 */
function get_user_browser()
{
    if (empty($_SERVER['HTTP_USER_AGENT']))
    {
        return '';
    }

    $agent       = $_SERVER['HTTP_USER_AGENT'];
    $browser     = '';
    $browser_ver = '';

    if (preg_match('/MSIE\s([^\s|;]+)/i', $agent, $regs))
    {
        $browser     = 'Internet Explorer';
        $browser_ver = $regs[1];
    }
    elseif (preg_match('/FireFox\/([^\s]+)/i', $agent, $regs))
    {
        $browser     = 'FireFox';
        $browser_ver = $regs[1];
    }
    elseif (preg_match('/Maxthon/i', $agent, $regs))
    {
        $browser     = '(Internet Explorer ' .$browser_ver. ') Maxthon';
        $browser_ver = '';
    }
    elseif (preg_match('/Opera[\s|\/]([^\s]+)/i', $agent, $regs))
    {
        $browser     = 'Opera';
        $browser_ver = $regs[1];
    }
    elseif (preg_match('/OmniWeb\/(v*)([^\s|;]+)/i', $agent, $regs))
    {
        $browser     = 'OmniWeb';
        $browser_ver = $regs[2];
    }
    elseif (preg_match('/Netscape([\d]*)\/([^\s]+)/i', $agent, $regs))
    {
        $browser     = 'Netscape';
        $browser_ver = $regs[2];
    }
    elseif (preg_match('/safari\/([^\s]+)/i', $agent, $regs))
    {
        $browser     = 'Safari';
        $browser_ver = $regs[1];
    }
    elseif (preg_match('/NetCaptor\s([^\s|;]+)/i', $agent, $regs))
    {
        $browser     = '(Internet Explorer ' .$browser_ver. ') NetCaptor';
        $browser_ver = $regs[1];
    }
    elseif (preg_match('/Lynx\/([^\s]+)/i', $agent, $regs))
    {
        $browser     = 'Lynx';
        $browser_ver = $regs[1];
    }

    if (!empty($browser))
    {
       return addslashes($browser . ' ' . $browser_ver);
    }
    else
    {
        return 'Unknow browser';
    }
}

/**
 * 判断是否为搜索引擎蜘蛛
 *
 * @access  public
 * @return  string
 */
function is_spider($record = true)
{
    static $spider = NULL;

    if ($spider !== NULL)
    {
        return $spider;
    }

    if (empty($_SERVER['HTTP_USER_AGENT']))
    {
        $spider = '';

        return '';
    }

    $searchengine_bot = array(
        'googlebot',
        'mediapartners-google',
        'baiduspider+',
        'msnbot',
        'yodaobot',
        'yahoo! slurp;',
        'yahoo! slurp china;',
        'iaskspider',
        'sogou web spider',
        'sogou push spider'
    );

    $searchengine_name = array(
        'GOOGLE',
        'GOOGLE ADSENSE',
        'BAIDU',
        'MSN',
        'YODAO',
        'YAHOO',
        'Yahoo China',
        'IASK',
        'SOGOU',
        'SOGOU'
    );

    $spider = strtolower($_SERVER['HTTP_USER_AGENT']);

    foreach ($searchengine_bot AS $key => $value)
    {
        if (strpos($spider, $value) !== false)
        {
            $spider = $searchengine_name[$key];

            if ($record === true)
            {
                $GLOBALS['db']->autoReplace($GLOBALS['ecs']->table('searchengine'), array('date' => local_date('Y-m-d'), 'searchengine' => $spider, 'count' => 1), array('count' => 1));
            }

            return $spider;
        }
    }

    $spider = '';

    return '';
}

/**
 * 获得客户端的操作系统
 *
 * @access  private
 * @return  void
 */
function get_os()
{
    if (empty($_SERVER['HTTP_USER_AGENT']))
    {
        return 'Unknown';
    }

    $agent = strtolower($_SERVER['HTTP_USER_AGENT']);
    $os    = '';

    if (strpos($agent, 'win') !== false)
    {
        if (strpos($agent, 'nt 5.1') !== false)
        {
            $os = 'Windows XP';
        }
        elseif (strpos($agent, 'nt 5.2') !== false)
        {
            $os = 'Windows 2003';
        }
        elseif (strpos($agent, 'nt 5.0') !== false)
        {
            $os = 'Windows 2000';
        }
        elseif (strpos($agent, 'nt 6.0') !== false)
        {
            $os = 'Windows Vista';
        }
        elseif (strpos($agent, 'nt') !== false)
        {
            $os = 'Windows NT';
        }
        elseif (strpos($agent, 'win 9x') !== false && strpos($agent, '4.90') !== false)
        {
            $os = 'Windows ME';
        }
        elseif (strpos($agent, '98') !== false)
        {
            $os = 'Windows 98';
        }
        elseif (strpos($agent, '95') !== false)
        {
            $os = 'Windows 95';
        }
        elseif (strpos($agent, '32') !== false)
        {
            $os = 'Windows 32';
        }
        elseif (strpos($agent, 'ce') !== false)
        {
            $os = 'Windows CE';
        }
    }
    elseif (strpos($agent, 'linux') !== false)
    {
        $os = 'Linux';
    }
    elseif (strpos($agent, 'unix') !== false)
    {
        $os = 'Unix';
    }
    elseif (strpos($agent, 'sun') !== false && strpos($agent, 'os') !== false)
    {
        $os = 'SunOS';
    }
    elseif (strpos($agent, 'ibm') !== false && strpos($agent, 'os') !== false)
    {
        $os = 'IBM OS/2';
    }
    elseif (strpos($agent, 'mac') !== false && strpos($agent, 'pc') !== false)
    {
        $os = 'Macintosh';
    }
    elseif (strpos($agent, 'powerpc') !== false)
    {
        $os = 'PowerPC';
    }
    elseif (strpos($agent, 'aix') !== false)
    {
        $os = 'AIX';
    }
    elseif (strpos($agent, 'hpux') !== false)
    {
        $os = 'HPUX';
    }
    elseif (strpos($agent, 'netbsd') !== false)
    {
        $os = 'NetBSD';
    }
    elseif (strpos($agent, 'bsd') !== false)
    {
        $os = 'BSD';
    }
    elseif (strpos($agent, 'osf1') !== false)
    {
        $os = 'OSF1';
    }
    elseif (strpos($agent, 'irix') !== false)
    {
        $os = 'IRIX';
    }
    elseif (strpos($agent, 'freebsd') !== false)
    {
        $os = 'FreeBSD';
    }
    elseif (strpos($agent, 'teleport') !== false)
    {
        $os = 'teleport';
    }
    elseif (strpos($agent, 'flashget') !== false)
    {
        $os = 'flashget';
    }
    elseif (strpos($agent, 'webzip') !== false)
    {
        $os = 'webzip';
    }
    elseif (strpos($agent, 'offline') !== false)
    {
        $os = 'offline';
    }
    else
    {
        $os = 'Unknown';
    }

    return $os;
}

/**
 * 统计访问信息
 *
 * @access  public
 * @return  void
 */
function visit_stats()
{
    if (isset($GLOBALS['_CFG']['visit_stats']) && $GLOBALS['_CFG']['visit_stats'] == 'off')
    {
        return;
    }
    $time = gmtime();
    /* 检查客户端是否存在访问统计的cookie */
    $visit_times = (!empty($_COOKIE['ECS']['visit_times'])) ? intval($_COOKIE['ECS']['visit_times']) + 1 : 1;
    setcookie('ECS[visit_times]', $visit_times, $time + 86400 * 365, '/');

    $browser  = get_user_browser();
    $os       = get_os();
    $ip       = real_ip();
    $area     = ecs_geoip($ip);

    /* 语言 */
    if (!empty($_SERVER['HTTP_ACCEPT_LANGUAGE']))
    {
        $pos  = strpos($_SERVER['HTTP_ACCEPT_LANGUAGE'], ';');
        $lang = addslashes(($pos !== false) ? substr($_SERVER['HTTP_ACCEPT_LANGUAGE'], 0, $pos) : $_SERVER['HTTP_ACCEPT_LANGUAGE']);
    }
    else
    {
        $lang = '';
    }

    /* 来源 */
    if (!empty($_SERVER['HTTP_REFERER']) && strlen($_SERVER['HTTP_REFERER']) > 9)
    {
        $pos = strpos($_SERVER['HTTP_REFERER'], '/', 9);
        if ($pos !== false)
        {
            $domain = substr($_SERVER['HTTP_REFERER'], 0, $pos);
            $path   = substr($_SERVER['HTTP_REFERER'], $pos);

            /* 来源关键字 */
            if (!empty($domain) && !empty($path))
            {
                save_searchengine_keyword($domain, $path);
            }
        }
        else
        {
            $domain = $path = '';
        }
    }
    else
    {
        $domain = $path = '';
    }

    $sql = 'INSERT INTO ' . $GLOBALS['ecs']->table('stats') . ' ( ' .
                'ip_address, visit_times, browser, system, language, area, ' .
                'referer_domain, referer_path, access_url, access_time' .
            ') VALUES (' .
                "'$ip', '$visit_times', '$browser', '$os', '$lang', '$area', ".
                "'" . addslashes($domain) ."', '" . addslashes($path) ."', '" . addslashes(PHP_SELF) ."', '" . $time . "')";
    $GLOBALS['db']->query($sql);
}

/**
 * 保存搜索引擎关键字
 *
 * @access  public
 * @return  void
 */
function save_searchengine_keyword($domain, $path)
{
    if (strpos($domain, 'google.com.tw') !== false && preg_match('/q=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'GOOGLE TAIWAN';
        $keywords = urldecode($regs[1]); // google taiwan
    }
    if (strpos($domain, 'google.cn') !== false && preg_match('/q=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'GOOGLE CHINA';
        $keywords = urldecode($regs[1]); // google china
    }
    if (strpos($domain, 'google.com') !== false && preg_match('/q=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'GOOGLE';
        $keywords = urldecode($regs[1]); // google
    }
    elseif (strpos($domain, 'baidu.') !== false && preg_match('/wd=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'BAIDU';
        $keywords = urldecode($regs[1]); // baidu
    }
    elseif (strpos($domain, 'baidu.') !== false && preg_match('/word=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'BAIDU';
        $keywords = urldecode($regs[1]); // baidu
    }
    elseif (strpos($domain, '114.vnet.cn') !== false && preg_match('/kw=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'CT114';
        $keywords = urldecode($regs[1]); // ct114
    }
    elseif (strpos($domain, 'iask.com') !== false && preg_match('/k=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'IASK';
        $keywords = urldecode($regs[1]); // iask
    }
    elseif (strpos($domain, 'soso.com') !== false && preg_match('/w=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'SOSO';
        $keywords = urldecode($regs[1]); // soso
    }
    elseif (strpos($domain, 'sogou.com') !== false && preg_match('/query=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'SOGOU';
        $keywords = urldecode($regs[1]); // sogou
    }
    elseif (strpos($domain, 'so.163.com') !== false && preg_match('/q=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'NETEASE';
        $keywords = urldecode($regs[1]); // netease
    }
    elseif (strpos($domain, 'yodao.com') !== false && preg_match('/q=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'YODAO';
        $keywords = urldecode($regs[1]); // yodao
    }
    elseif (strpos($domain, 'zhongsou.com') !== false && preg_match('/word=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'ZHONGSOU';
        $keywords = urldecode($regs[1]); // zhongsou
    }
    elseif (strpos($domain, 'search.tom.com') !== false && preg_match('/w=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'TOM';
        $keywords = urldecode($regs[1]); // tom
    }
    elseif (strpos($domain, 'live.com') !== false && preg_match('/q=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'MSLIVE';
        $keywords = urldecode($regs[1]); // MSLIVE
    }
    elseif (strpos($domain, 'tw.search.yahoo.com') !== false && preg_match('/p=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'YAHOO TAIWAN';
        $keywords = urldecode($regs[1]); // yahoo taiwan
    }
    elseif (strpos($domain, 'cn.yahoo.') !== false && preg_match('/p=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'YAHOO CHINA';
        $keywords = urldecode($regs[1]); // yahoo china
    }
    elseif (strpos($domain, 'yahoo.') !== false && preg_match('/p=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'YAHOO';
        $keywords = urldecode($regs[1]); // yahoo
    }
    elseif (strpos($domain, 'msn.com.tw') !== false && preg_match('/q=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'MSN TAIWAN';
        $keywords = urldecode($regs[1]); // msn taiwan
    }
    elseif (strpos($domain, 'msn.com.cn') !== false && preg_match('/q=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'MSN CHINA';
        $keywords = urldecode($regs[1]); // msn china
    }
    elseif (strpos($domain, 'msn.com') !== false && preg_match('/q=([^&]*)/i', $path, $regs))
    {
        $searchengine = 'MSN';
        $keywords = urldecode($regs[1]); // msn
    }

    if (!empty($keywords))
    {
        $gb_search = array('YAHOO CHINA', 'TOM', 'ZHONGSOU', 'NETEASE', 'SOGOU', 'SOSO', 'IASK', 'CT114', 'BAIDU');
        if (EC_CHARSET == 'utf-8' && in_array($searchengine, $gb_search))
        {
            $keywords = ecs_iconv('GBK', 'UTF8', $keywords);
        }
        if (EC_CHARSET == 'gbk' && !in_array($searchengine, $gb_search))
        {
            $keywords = ecs_iconv('UTF8', 'GBK', $keywords);
        }

        $GLOBALS['db']->autoReplace($GLOBALS['ecs']->table('keywords'), array('date' => local_date('Y-m-d'), 'searchengine' => $searchengine, 'keyword' => addslashes($keywords), 'count' => 1), array('count' => 1));
    }
}

/**
 * 获得指定用户、商品的所有标记
 *
 * @access  public
 * @param   integer $goods_id
 * @param   integer $user_id
 * @return  array
 */
function get_tags($goods_id = 0, $user_id = 0)
{}

/**
 * 获取指定主题某个模板的主题的动态模块
 *
 * @access  public
 * @param   string       $theme    模板主题
 * @param   string       $tmp      模板名称
 *
 * @return array()
 */
function get_dyna_libs($theme, $tmp)
{}

/**
 * 替换动态模块
 *
 * @access  public
 * @param   string       $matches    匹配内容
 *
 * @return string        结果
 */
function dyna_libs_replace($matches)
{}

/**
 * 处理上传文件，并返回上传图片名(上传失败时返回图片名为空）
 *
 * @access  public
 * @param array     $upload     $_FILES 数组
 * @param array     $type       图片所属类别，即data目录下的文件夹名
 *
 * @return string               上传图片名
 */
function upload_file($upload, $type)
{
    if (!empty($upload['tmp_name']))
    {
        $ftype = check_file_type($upload['tmp_name'], $upload['name'], '|png|jpg|jpeg|gif|doc|xls|txt|zip|ppt|pdf|rar|');
        if (!empty($ftype))
        {
            $name = date('Ymd');
            for ($i = 0; $i < 6; $i++)
            {
                $name .= chr(mt_rand(97, 122));
            }

            $name = $_SESSION['user_id'] . '_' . $name . '.' . $ftype;

            $target = ROOT_PATH . DATA_DIR . '/' . $type . '/' . $name;
            if (!move_upload_file($upload['tmp_name'], $target))
            {
                $GLOBALS['err']->add($GLOBALS['_LANG']['upload_file_error'], 1);

                return false;
            }
            else
            {
                return $name;
            }
        }
        else
        {
            $GLOBALS['err']->add($GLOBALS['_LANG']['upload_file_type'], 1);

            return false;
        }
    }
    else
    {
        $GLOBALS['err']->add($GLOBALS['_LANG']['upload_file_error']);
        return false;
    }
}

/**
 * 显示一个提示信息
 *
 * @access  public
 * @param   string  $content
 * @param   string  $link
 * @param   string  $href
 * @param   string  $type               信息类型：warning, error, info
 * @param   string  $auto_redirect      是否自动跳转
 * @return  void
 */
function show_message($content, $links = '', $hrefs = '', $type = 'info', $auto_redirect = true)
{
    assign_template();

    $msg['content'] = $content;
    if (is_array($links) && is_array($hrefs))
    {
        if (!empty($links) && count($links) == count($hrefs))
        {
            foreach($links as $key =>$val)
            {
                $msg['url_info'][$val] = $hrefs[$key];
            }
            $msg['back_url'] = $hrefs['0'];
        }
    }
    else
    {
        $link   = empty($links) ? $GLOBALS['_LANG']['back_up_page'] : $links;
        $href    = empty($hrefs) ? 'javascript:history.back()'       : $hrefs;
        $msg['url_info'][$link] = $href;
        $msg['back_url'] = $href;
    }

    $msg['type']    = $type;
    $position = assign_ur_here(0, $GLOBALS['_LANG']['sys_msg']);
    $GLOBALS['smarty']->assign('page_title', $position['title']);   // 页面标题
    $GLOBALS['smarty']->assign('ur_here',    $position['ur_here']); // 当前位置

    if (is_null($GLOBALS['smarty']->get_template_vars('helps')))
    {
        $GLOBALS['smarty']->assign('helps', get_shop_help()); // 网店帮助
    }

    $GLOBALS['smarty']->assign('auto_redirect', $auto_redirect);
    $GLOBALS['smarty']->assign('message', $msg);
    $GLOBALS['smarty']->display('message.dwt');

    exit;
}

/**
 * 将一个形如+10, 10, -10, 10%的字串转换为相应数字，并返回操作符号
 *
 * @access  public
 * @param   string      str     要格式化的数据
 * @param   char        operate 操作符号，只能返回‘+’或‘*’;
 * @return  float       value   浮点数
 */
function parse_rate_value($str, &$operate)
{
    $operate = '+';
    $is_rate = false;

    $str = trim($str);
    if (empty($str))
    {
        return 0;
    }
    if ($str[strlen($str) - 1] == '%')
    {
        $value = floatval($str);
        if ($value > 0)
        {
            $operate = '*';

            return $value / 100;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return floatval($str);
    }
}

/**
 * 重新计算购物车中的商品价格：目的是当用户登录时享受会员价格，当用户退出登录时不享受会员价格
 * 如果商品有促销，价格不变
 *
 * @access  public
 * @return  void
 */
function recalculate_price()
{}

/**
 * 查询评论内容
 *
 * @access  public
 * @params  integer     $id
 * @params  integer     $type
 * @params  integer     $page
 * @return  array
 */
function assign_comment($id, $type, $page = 1)
{
    /* 取得评论列表 */
    $count = $GLOBALS['db']->getOne('SELECT COUNT(*) FROM ' .$GLOBALS['ecs']->table('comment').
           " WHERE id_value = '$id' AND comment_type = '$type' AND status = 1 AND parent_id = 0");
    $size  = !empty($GLOBALS['_CFG']['comments_number']) ? $GLOBALS['_CFG']['comments_number'] : 5;

    $page_count = ($count > 0) ? intval(ceil($count / $size)) : 1;

    $sql = 'SELECT * FROM ' . $GLOBALS['ecs']->table('comment') .
            " WHERE id_value = '$id' AND comment_type = '$type' AND status = 1 AND parent_id = 0".
            ' ORDER BY comment_id DESC';
    $res = $GLOBALS['db']->selectLimit($sql, $size, ($page-1) * $size);

    $arr = array();
    $ids = '';
    while ($row = $GLOBALS['db']->fetchRow($res))
    {
        $ids .= $ids ? ",$row[comment_id]" : $row['comment_id'];
        $arr[$row['comment_id']]['id']       = $row['comment_id'];
        $arr[$row['comment_id']]['email']    = $row['email'];
        $arr[$row['comment_id']]['username'] = $row['user_name'];
        $arr[$row['comment_id']]['content']  = str_replace('\r\n', '<br />', htmlspecialchars($row['content']));
        $arr[$row['comment_id']]['content']  = nl2br(str_replace('\n', '<br />', $arr[$row['comment_id']]['content']));
        $arr[$row['comment_id']]['rank']     = $row['comment_rank'];
        $arr[$row['comment_id']]['add_time'] = local_date($GLOBALS['_CFG']['time_format'], $row['add_time']);
    }
    /* 取得已有回复的评论 */
    if ($ids)
    {
        $sql = 'SELECT * FROM ' . $GLOBALS['ecs']->table('comment') .
                " WHERE parent_id IN( $ids )";
        $res = $GLOBALS['db']->query($sql);
        while ($row = $GLOBALS['db']->fetch_array($res))
        {
            $arr[$row['parent_id']]['re_content']  = nl2br(str_replace('\n', '<br />', htmlspecialchars($row['content'])));
            $arr[$row['parent_id']]['re_add_time'] = local_date($GLOBALS['_CFG']['time_format'], $row['add_time']);
            $arr[$row['parent_id']]['re_email']    = $row['email'];
            $arr[$row['parent_id']]['re_username'] = $row['user_name'];
        }
    }
    /* 分页样式 */
    //$pager['styleid'] = isset($GLOBALS['_CFG']['page_style'])? intval($GLOBALS['_CFG']['page_style']) : 0;
    $pager['page']         = $page;
    $pager['size']         = $size;
    $pager['record_count'] = $count;
    $pager['page_count']   = $page_count;
    $pager['page_first']   = "javascript:gotoPage(1,$id,$type)";
    $pager['page_prev']    = $page > 1 ? "javascript:gotoPage(" .($page-1). ",$id,$type)" : 'javascript:;';
    $pager['page_next']    = $page < $page_count ? 'javascript:gotoPage(' .($page + 1) . ",$id,$type)" : 'javascript:;';
    $pager['page_last']    = $page < $page_count ? 'javascript:gotoPage(' .$page_count. ",$id,$type)"  : 'javascript:;';

    $cmt = array('comments' => $arr, 'pager' => $pager);

    return $cmt;
}


function assign_template($ctype = '', $catlist = array())
{
    global $smarty;

    $smarty->assign('image_width',   $GLOBALS['_CFG']['image_width']);
    $smarty->assign('image_height',  $GLOBALS['_CFG']['image_height']);
    $smarty->assign('points_name',   $GLOBALS['_CFG']['integral_name']);
    $smarty->assign('qq',            explode(',', $GLOBALS['_CFG']['qq']));
    $smarty->assign('ww',            explode(',', $GLOBALS['_CFG']['ww']));
    $smarty->assign('ym',            explode(',', $GLOBALS['_CFG']['ym']));
    $smarty->assign('msn',           explode(',', $GLOBALS['_CFG']['msn']));
    $smarty->assign('skype',         explode(',', $GLOBALS['_CFG']['skype']));
    $smarty->assign('stats_code',    $GLOBALS['_CFG']['stats_code']);
    $smarty->assign('copyright',     sprintf($GLOBALS['_LANG']['copyright'], date('Y'), $GLOBALS['_CFG']['shop_name']));
    $smarty->assign('shop_name',     $GLOBALS['_CFG']['shop_name']);
    $smarty->assign('service_email', $GLOBALS['_CFG']['service_email']);
    $smarty->assign('service_phone', $GLOBALS['_CFG']['service_phone']);
    $smarty->assign('shop_address',  $GLOBALS['_CFG']['shop_address']);
    $smarty->assign('licensed',      license_info());
    $smarty->assign('ecs_version',   VERSION);
    $smarty->assign('icp_number',    $GLOBALS['_CFG']['icp_number']);
    $smarty->assign('username',      !empty($_SESSION['user_name']) ? $_SESSION['user_name'] : '');
    $smarty->assign('category_list', cat_list(0, 0, true,  2, false));
    $smarty->assign('catalog_list',  cat_list(0, 0, false, 1, false));
    $smarty->assign('navigator_list',        get_navigator($ctype, $catlist));  //自定义导航栏

    if (!empty($GLOBALS['_CFG']['search_keywords']))
    {
        $searchkeywords = explode(',', trim($GLOBALS['_CFG']['search_keywords']));
    }
    else
    {
        $searchkeywords = array();
    }
    $smarty->assign('searchkeywords', $searchkeywords);
}

/**
 * 将一个本地时间戳转成GMT时间戳
 *
 * @access  public
 * @param   int     $time
 *
 * @return int      $gmt_time;
 */
function time2gmt($time)
{
    return strtotime(gmdate('Y-m-d H:i:s', $time));
}

/**
 * 查询会员的红包金额
 *
 * @access  public
 * @param   integer     $user_id
 * @return  void
 */
function get_user_bonus($user_id = 0)
{}

/**
 * 保存推荐uid
 *
 * @access  public
 * @param   void
 *
 * @return void
 * @author xuanyan
 **/
function set_affiliate()
{}

/**
 * 获取推荐uid
 *
 * @access  public
 * @param   void
 *
 * @return int
 * @author xuanyan
 **/
function get_affiliate()
{}

/**
 * 获得指定分类同级的所有分类以及该分类下的子分类
 *
 * @access  public
 * @param   integer     $cat_id     分类编号
 * @return  array
 */
function article_categories_tree($cat_id = 0)
{}

/**
 * 获得指定文章分类的所有上级分类
 *
 * @access  public
 * @param   integer $cat    分类编号
 * @return  array
 */
function get_article_parent_cats($cat)
{
    if ($cat == 0)
    {
        return array();
    }

    $arr = $GLOBALS['db']->GetAll('SELECT cat_id, cat_name, parent_id FROM ' . $GLOBALS['ecs']->table('article_cat'));

    if (empty($arr))
    {
        return array();
    }

    $index = 0;
    $cats  = array();

    while (1)
    {
        foreach ($arr AS $row)
        {
            if ($cat == $row['cat_id'])
            {
                $cat = $row['parent_id'];

                $cats[$index]['cat_id']   = $row['cat_id'];
                $cats[$index]['cat_name'] = $row['cat_name'];

                $index++;
                break;
            }
        }

        if ($index == 0 || $cat == 0)
        {
            break;
        }
    }

    return $cats;
}

/**
 * 取得某模板某库设置的数量
 * @param   string      $template   模板名，如index
 * @param   string      $library    库名，如recommend_best
 * @param   int         $def_num    默认数量：如果没有设置模板，显示的数量
 * @return  int         数量
 */
function get_library_number($library, $template = null)
{}

/**
 * 取得自定义导航栏列表
 * @param   string      $type    位置，如top、bottom、middle
 * @return  array         列表
 */
function get_navigator($ctype = '', $catlist = array())
{
    $sql = 'SELECT * FROM '. $GLOBALS['ecs']->table('nav') . '
            WHERE ifshow = \'1\' ORDER BY type, vieworder';
    $res = $GLOBALS['db']->query($sql);
    $cur_url = substr(strrchr($_SERVER['REQUEST_URI'],'/'),1);

    if (intval($GLOBALS['_CFG']['rewrite']))
    {
        if(strpos($cur_url, '-'))
        {
            preg_match('/([a-z]*)-([0-9]*)/',$cur_url,$matches);
            $cur_url = $matches[1].'.php?id='.$matches[2];
        }
    }
    else
    {
        $cur_url = substr(strrchr($_SERVER['REQUEST_URI'],'/'),1);
    }

    $noindex = false;
    $active = 0;
    $navlist = array(
        'top' => array(),
        'middle' => array(),
        'bottom' => array()
    );
    while ($row = $GLOBALS['db']->fetchRow($res))
    {
        $navlist[$row['type']][] = array(
            'name'      =>  $row['name'],
            'opennew'   =>  $row['opennew'],
            'url'       =>  $row['url'],
            'ctype'     =>  $row['ctype'],
            'cid'       =>  $row['cid'],
            );
    }

    /*遍历自定义是否存在currentPage*/
    foreach($navlist['middle'] as $k=>$v)
    {
        $condition = empty($ctype) ? (strpos($cur_url, $v['url']) === 0) : (strpos($cur_url, $v['url']) === 0 && strlen($cur_url) == strlen($v['url']));
        if ($condition)
        {
            $navlist['middle'][$k]['active'] = 1;
            $noindex = true;
            $active += 1;
        }
    }

    if(!empty($ctype) && $active < 1)
    {
        foreach($catlist as $key => $val)
        {
            foreach($navlist['middle'] as $k=>$v)
            {
                if(!empty($v['ctype']) && $v['ctype'] == $ctype && $v['cid'] == $val && $active < 1)
                {
                    $navlist['middle'][$k]['active'] = 1;
                    $noindex = true;
                    $active += 1;
                }
            }
        }
    }

    if ($noindex == false) {
        $navlist['config']['index'] = 1;
    }

    return $navlist;
}

/**
 * 授权信息内容
 *
 * @return  str
 */
function license_info()
{
    if($GLOBALS['_CFG']['licensed'] > 0)
    {
        /* 获取HOST */
        if (isset($_SERVER['HTTP_X_FORWARDED_HOST']))
        {
            $host = $_SERVER['HTTP_X_FORWARDED_HOST'];
        }
        elseif (isset($_SERVER['HTTP_HOST']))
        {
            $host = $_SERVER['HTTP_HOST'];
        }
        //$license = '<a href="http://license.comsenz.com/?pid=4&host='. $host .'">Licensed</a>';
        $host = 'http://' . $host . '/';
        $license = '<a href="http://service.shopex.cn/auth.php?product=DIANDIANTAO&url=' . urlencode($host) . '">Licensed</a>';
        return $license;
    }
    else
    {
        return '';
    }
}

?>