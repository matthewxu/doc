<div id="lhs-ref">
                <div id="ms">
                    <ul>
                        <li>
                            <div>
                                <span class="mode-icon"></span>
                                <span class="mode-desc"><a href="">{allresult}所有结果</a></span>
                            </div>
                        </li>
                        <li class="current-mode">
                            <div>
                                <span class="mode-icon"></span>
                                <span class="mode-desc"><b>{model}购物</b></span>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="lhs-group">
                </div>
                <div class="lhs-group" id="ref-category">
                    <p class="ref_active">
                        <span class="rsaquo">›</span>
                        {allcatigory}所有类别
                    </p>
                    <ul>
                        <li>
                            <a href="">{catigory}光学产品/光学仪器</a>
                        </li>
                        <li class="ref-cat-indent">
                            <a href="">{subcatigory}望远镜</a>
                        </li>
                    </ul>
                </div>
                <div class="lhs-group" id="ref-price">
                    <p class="ref_active">
                        <span class="rsaquo">›</span>
                        {allprice}所有价格
                    </p>
                    <ul>
                        <li>
                            <a href="" id="price_sugg0">{price} 低于 ￥70</a>
                        </li>
                        <li>
                            <a href="" id="price_sugg1">{price}￥70 - ￥300</a>
                        </li>
                        <li>
                            <a href="" id="price_sugg4">{price}高于 ￥5,000</a>
                        </li>
                        <li>
                            <form method="get" name="pf" action="/products">
                                <input name="q" value="望远镜" type="hidden"><input name="output" value="nojs" type="hidden"><input name="hl" value="zh-cn" type="hidden"><input name="lnk" value="pruser" type="hidden"><input gtbfieldid="21" size="5" name="price1" class="price-range-input" type="text">{fromprice}元到
                                <br>
                                <input gtbfieldid="22" size="5" name="price2" class="price-range-input" type="text">{toprice}元<input value="搜" type="submit">
                            </form>
                        </li>
                    </ul>
                </div>
                <div class="lhs-group" id="ref-brand">
                    <p class="ref_active">
                        <span class="rsaquo">›</span>
                        {allbrand}所有品牌
                    </p>
                    <ul>
                        <li>
                            <a href="" id="brand_sugg0" title="nikon">{brand}Nikon</a>
                        </li>
                        <li>
                            <a href="" id="brand_sugg1">{brand}利康</a>
                        </li>
                        <li>
                            <a href="" id="brand_sugg2" title="{brand}博 冠">{brand}博冠</a>
                        </li>
                        <li>
                            <a href="" id="brand_sugg3" title="{brand}博士 能">{brand}博士能</a>
                        </li>
                    </ul>
                </div>
            </div>