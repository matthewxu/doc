         <table id="sample_q" width="1000">
                <tbody>
               
                    <tr class="samp_q_line">
                        <td colspan="5">
                            {recentsearch}用户最近查询的商品：
                        </td>
                    </tr>
                    <tr>
               
               <?php $_from = $this->_var['okw']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }; $this->push_vars('', 'ikw');if (count($_from)):
    foreach ($_from AS $this->_var['ikw']):
?>
               		<?php  $this->_var['count'] = $this->_var['count'] + 1;?>
               		
               <?php if ($this->_var['count'] > 10): ?>
               		<?php  $this->_var['count'] = 0;?>
        			</tr><tr class="samp_q_line">
        		<?php endif; ?>
                        <td width="10%">
                            <a href="<?php echo $this->_var['ikw']['link']; ?>">
                                <?php echo $this->_var['ikw']['keyword']; ?>
                            </a>
                        </td>
               <?php endforeach; endif; unset($_from); ?><?php $this->pop_vars();; ?>
                    </tr>
                </tbody>
            </table>