        <div id="gbar">
            <nobr>
                <?php $_from = $this->_var['ohead']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'ihead');if (count($_from)):
    foreach ($_from AS $this->_var['ihead']):
?>
                <a id="gb_1" href="<?php echo $this->_var['ihead']['modellink']; ?>"  class="gb1">
                    <?php echo $this->_var['ihead']['model']; ?>
                </a>
				<?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>

            </nobr>
        </div>
        <div id="body-center">
            <div id="srch-block">
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <a href="<?php echo $this->_var['home']; ?>">
                                    <img id="srch-logo" src="<?php echo $this->_var['themes']; ?>/images/product_search_logo.gif" alt="Google Product Search">
                                </a>
                            </td>
                            <td>
                                <form name="f" action="/products">
                                    <table id="search-input" cellspacing="0">
                                        <tbody>
                                            <tr>
                                                <td class="srchBoxCont" nowrap="nowrap">
                                                    <input class="srch_box" maxlength="2048" name="q" size="41" title="{searchbox}">
                                                </td>
                                                <td nowrap="nowrap">
                                                    <div class="srchButtonRightShadow">
                                                        <div class="srchButtonBorder">
                                                            <input class="srch_button" value="{searchtitle}" id="srchButton"
                                                            type="submit">
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <input name="hl" value="zh-cn" type="hidden">
                                        </tbody>
                                    </table>
                                    <input disabled="disabled" value="" name="oq" type="hidden">
                                </form>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            
            