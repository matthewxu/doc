<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
<meta name="Generator" content="APPNAME VERSION" />
        <noscript>
            <meta http-equiv=refresh content="0; URL=/prdhp?hl=zh-cn&tab=wf&output=nojs">
        </noscript>
        <meta http-equiv="Content-Type" content="text/html; charset=EC_CHARSET" />
        <meta name="Keywords" content="<?php echo $this->_var['keywords']; ?>" />
        <meta name="Description" content="<?php echo $this->_var['description']; ?>" />
        <title>
            <?php echo $this->_var['page_title']; ?>
        </title>
        <link type="text/css" rel="stylesheet" href="<?php echo $this->_var['themes']; ?>/style/ps-style.css">
        <link type="text/css" rel="stylesheet" href="<?php echo $this->_var['themes']; ?>/style/ps-newstyle.css">
        <link type="text/css" rel="stylesheet" href="<?php echo $this->_var['themes']; ?>/style/ps-center.css">
        <link type="text/css" rel="stylesheet" href="<?php echo $this->_var['themes']; ?>/style/ps-product.css">
        <link type="text/css" rel="stylesheet" href="<?php echo $this->_var['themes']; ?>/style/ps-pp-style.css">
    </head>
    
    <body>
 		<?php echo $this->fetch('library/page_header.lbi'); ?>
 		<div id="pp-cont">
 		<?php echo $this->fetch('library/page_product_sumarize.lbi'); ?>
 		<?php echo $this->fetch('library/page_product_seller.lbi'); ?>
 		<?php echo $this->fetch('library/page_product_review.lbi'); ?>
 		<?php echo $this->fetch('library/page_product_info.lbi'); ?>
 		</div>           
		<?php echo $this->fetch('library/page_footer.lbi'); ?>
		 </div>
    </body>
	
    <script language="JavaScript">
        document.f.q.focus();
    </script>
</html>