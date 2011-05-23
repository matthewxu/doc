<div id="lhs-ref">
                <div class="lhs-group">
                </div>
                <div class="lhs-group" id="ref-category">
                    <p class="ref_active">
                        <span class="rsaquo">›</span>
                        <?php echo $this->_var['allcat']; ?>
                    </p>
                    <?php $_from = $this->_var['ocat']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'icat');if (count($_from)):
    foreach ($_from AS $this->_var['icat']):
?>
                    <ul>
                        <li><a href="<?php echo $this->_var['icat']['catlink']; ?>"><?php echo $this->_var['icat']['catname']; ?></a></li>
                        <li class="ref-cat-indent"><a href="<?php echo $this->_var['icat']['subcatlink']; ?>"><?php echo $this->_var['icat']['subcatname']; ?></a> </li>
                    </ul>
                    <?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
                    
                </div>
                <div class="lhs-group" id="ref-price">
                    <p class="ref_active">
                        <span class="rsaquo">›</span>
                        <?php echo $this->_var['allprice']; ?>
                    </p>
                    <ul>
                    	<?php $_from = $this->_var['oprice']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'iprice');if (count($_from)):
    foreach ($_from AS $this->_var['iprice']):
?>
                    	
                        <li>
                            <a href="<?php echo $this->_var['iprice']['pricelink']; ?>" id="price_sugg3"><?php echo $this->_var['iprice']['price']; ?> </a>
                        </li>
                        <?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>    
                        <li>
                            <form method="get" name="pf" action="/products">
                                <input name="q" value="<?php echo $this->_var['sekw']; ?>" type="hidden"><input name="output" value="nojs" type="hidden">
                                <input name="hl" value="zh-cn" type="hidden"><input name="lnk" value="pruser" type="hidden">
                                <input gtbfieldid="21" size="5" name="price1" class="price-range-input" type="text"><?php echo $this->_var['fromprice']; ?>
                                <br>
                                <input gtbfieldid="22" size="5" name="price2" class="price-range-input" type="text"><?php echo $this->_var['toprice']; ?>
                                <input value="<?php echo $this->_var['searchbutton']; ?>" type="submit">
                            </form>
                        </li>
                    </ul>
                </div>
                <div class="lhs-group" id="ref-brand">
                    <p class="ref_active">
                        <span class="rsaquo">›</span>
                        <?php echo $this->_var['allbrand']; ?>
                    </p>
                    <ul>
                    	<?php $_from = $this->_var['obrand']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'ibrand');if (count($_from)):
    foreach ($_from AS $this->_var['ibrand']):
?>
                        <li>
                            <a href="<?php echo $this->_var['ibrand']['brandlink']; ?>" id="brand_sugg0" title="nikon"><?php echo $this->_var['ibrand']['brand']; ?></a>
                        </li>
                        <?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
                    </ul>
                </div>
            </div>