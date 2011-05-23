<div>
    <div class="list lhs">
        <div class="content-cont">
            
            <div id="view-sort">
                <div class="fr view-sort-cont">
                    <form action="/products?q=%E6%9C%9B%E8%BF%9C%E9%95%9C&amp;output=nojs&amp;hl=zh-cn" name="scr">
                        <input name="q" value="<?php echo $this->_var['sekw']; ?>" type="hidden"><input name="output" value="nojs" type="hidden"><input name="hl" value="zh-cn" type="hidden">
                        <nobr>
                            <?php echo $this->_var['osort']['t_sortstyle']; ?>：
                        </nobr>
                        <select gtbfieldid="23" name="scoring" onchange="window.location='\x2Fproducts?q=%E6%9C%9B%E8%BF%9C%E9%95%9C\x26output=nojs\x26hl=zh-cn&amp;scoring='+this.options[this.selectedIndex].value;">
                            <option value="r" selected="selected"><?php echo $this->_var['osort']['t_sortr']; ?></option>
                            <option value="p"><?php echo $this->_var['osort']['t_sortp']; ?></option>
                            <option value="pd"><?php echo $this->_var['osort']['t_sortpd']; ?></option>
                        </select>
                        <input value="<?php echo $this->_var['t_searchbutton']; ?>" type="submit">
                    </form>
                    <span class="display_options_icons"><span class="ps-sprite ps-sprite-list-view" title="<?php echo $this->_var['osort']['t_sorts']; ?>"></span>&nbsp;<a href="" title="{showlist}显示图库视图" id="toggletogrid"><span class="ps-sprite ps-sprite-show-grid-view" title="{showpic}显示图库视图"></span></a></span>
                </div>
                <p class="clear_right">
                </p>
            </div>
            
            <ol id="results">
            <?php $_from = $this->_var['oproduct']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'iproduct');if (count($_from)):
    foreach ($_from AS $this->_var['iproduct']):
?>
                <li class="result" id="res0">
                    <div class="result-cont">
                        <p class="result-image">
                            <a href=""><img src="<?php echo $this->_var['themes']; ?>/<?php echo $this->_var['iproduct']['imglink']; ?>" alt="<?php echo $this->_var['iproduct']['imgalt']; ?>" title="<?php echo $this->_var['iproduct']['imgtitle']; ?>"></a>
                        </p>
                        <div class="result-price-seller">
                            <div class="result-price">
                                <span id="price0"><span class="result-price-range"><?php echo $this->_var['iproduct']['pricerange']; ?></span></span>
                            </div>
                            <div class="result-seller">
                                <?php echo $this->_var['iproduct']['sellercount']; ?>
                            </div>
                            <div class="result-button">
                                <form method="get" action="">
                                    <input value="<?php echo $this->_var['t_cmpprice']; ?>" id="price-but0" type="submit"><input name="q" value="<?php echo $this->_var['sekw']; ?>" type="hidden"><input name="output" value="nojs" type="hidden"><input name="hl" value="zh-cn" type="hidden"><input name="cid" value="7241257218809552867" type="hidden">
                                </form>
                            </div>
                        </div>
                        <div class="result-title-description">
                            <h3 class="result-title"><a href=""><?php echo $this->_var['iproduct']['title']; ?></a></h3>
                            <p class="result-attributes">
                            </p>
                            <p class="result-pop">
                            </p>
                            <p class="result-desc">
                                <?php echo $this->_var['iproduct']['desc']; ?>
                            </p>
                            <div class="result-rating">
                                <a href="" class="nb"><span class="ps-sprite ps-sprite-son" title="4.5 星{ps-sprite-son}"></span><span class="ps-sprite ps-sprite-son" title="4.5 星{ps-sprite-son}"></span><span class="ps-sprite ps-sprite-son" title="4.5 星{ps-sprite-son}"></span><span class="ps-sprite ps-sprite-son" title="4.5 星{ps-sprite-son}"></span><span class="ps-sprite ps-sprite-shalf" title="4.5 星{ps-sprite-son}"></span></a>
                                &nbsp;<a href="" class="fl" id="res0rev"><?php echo $this->_var['iproduct']['reviewsum']; ?><?php echo $this->_var['t_review']; ?></a>
                            </div>
                        </div>
                    </div>
                </li>
            <?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>    
            </ol>
            <p class="clear">
            </p>
            <div id="query_suggestions">
                <p>
                    "<b><?php echo $this->_var['sekw']; ?></b>
                    "<?php echo $this->_var['t_relate']; ?>
                </p>
                <table>
                    <tbody>
                        <tr>
                        	<?php $_from = $this->_var['orelatekw']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'irelatekw');if (count($_from)):
    foreach ($_from AS $this->_var['irelatekw']):
?>
               				
               		
               					<?php if ($this->_var['count'] > 6): ?>
               				    <?php  $this->_var['count'] = 0;?>
        						</td> </tr><tr>
        						<?php endif; ?>
                            <td>
                                <nobr>
                                    <a href="<?php echo $this->_var['irelatekw']['link']; ?>"><?php echo $this->_var['irelatekw']['keyword']; ?></a>
                                </nobr>
                            </td>
                            <?php  $this->_var['count'] = $this->_var['count'] + 1;?>
                            <?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
                        </tr>
                        <tr>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div id="buying_guides">
                <h2 class="tool-header"><?php echo $this->_var['sekw']; ?><?php echo $this->_var['t_guide']; ?></h2>

                <ul class="popular-ref">
                <?php $_from = $this->_var['onew']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'inew');if (count($_from)):
    foreach ($_from AS $this->_var['inew']):
?>
                    <li>
                        <div class="ps-guide">
                            <a href="<?php echo $this->_var['inew']['desc']; ?>"><?php echo $this->_var['inew']['title']; ?></a>
                            <p>
                                <?php echo $this->_var['inew']['desc']; ?>
                            </p>
                            <p class="clear">
                            </p>
                        </div>
                    </li>
                <?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>    
                    <li>
                        <p class="more-guides-link">
                            <a href="" class="fl"><?php echo $this->_var['t_moreinfo']; ?></a>
                        </p>
                    </li>
                </ul>

            </div>
            <div id="visual_tools">
                <div class="v-ref-sixpack">
                    <div class="v-ref-hdr">
                        {listbybrand}按品牌选购
                    </div>
                    <div class="v-ref">
                        <div class="v-ref-img">
                            <a href=""><img src="<?php echo $this->_var['themes']; ?>/images/X8w8iiflB5F6tuipVsG4H6YJP0UMIilnQP236Ssic3AF8B_U2ps4tgyUXocT.jpg" alt="{brandname}施华洛世奇" title="{brandname}施华洛世奇"></a>
                        </div><a href="">{brandname}施华洛世奇</a>
                    </div>
                    <p class="clear">
                    </p>
                </div>
            </div>
        </div>
    </div>
    <div class="below-content">
        <div id="ps-navbar" class="n">
            <table width="1%">
                <tbody>
                    <tr>
                        <td nowrap="nowrap" align="right">
                            <div id="nf">
                            </div>
                        </td>
                        <td nowrap="nowrap">
                            <div id="nc">
                            </div>
                            <span class="i">1</span>
                        </td>
                        <td nowrap="nowrap">
                            <a href="" data-num="2">
                                <div class="nr">
                                </div>
                                <span>2</span></a>
                        </td>
                        <td nowrap="nowrap" valign="bottom">
                            <a href="" data-num="2">
                                <div id="nn">
                                </div>
                                <span class="b">{nextpage}下一页</span></a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
