<style>
    #searchSuggestionContainer {
        position: absolute;
        top: 73%;
        left: 15px;
        right: 75px;
        background: #fff;
        z-index: 9999;
        max-height: 300px;
        overflow-y: auto;
        border: 1px solid #ccc;
        border-top: none;
        border-radius: 0px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }
    #searchSuggestionContainer .list-group-item {
        cursor: pointer;
        border-radius: 0px !important;
    }
    #searchSuggestionContainer .list-group-item:hover {
        background-color: #f1f1f1;
    }

</style>

<!--header start-->
<header id="masthead" class="header ttm-header-style-01">
    
    
    <!-- header_main -->
    <div class="header_main">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-sm-3 col-3 order-1">
                    <!-- site-branding -->
                    <div class="site-branding">
                        <a class="home-link" href="{{ url('/') }}" title="Fixfellow" rel="home">
                            <img id="logo-img" class="img-center" src="{{ asset('assets/buyer-assets/images/logo-img.png') }}" alt="logo-img">
                        </a>
                    </div><!-- site-branding end -->
                </div>
                <div class="col-lg-6 col-12 order-lg-2 order-3 text-lg-left text-right">
                    <div class="header_search"><!-- header_search -->
                        <div class="header_search_content">
                            <div id="search_block_top" class="search_block_top">
                                <form id="searchbox" method="get" action="#">
                                    <input class="search_query form-control" type="text" id="search_query_top" name="s" placeholder="Search For Product...." value="">

                                    <button type="submit" name="submit_search" class="btn btn-default button-search"><i class="fa fa-search"></i></button>
                                </form>
                                <div id="searchSuggestionContainer"></div>
                            </div>
                        </div>
                    </div>    
                    <!-- header_search end -->
                </div>
                <div class="col-lg-3 col-9 order-lg-3 order-2 text-lg-left text-right">
                    <!-- header_extra -->
                    <div class="header_extra d-flex flex-row align-items-center justify-content-end">
                     <div class="account dropdown">
                      <div class="d-flex align-items-center gap-2">
                        <div class="account_icon text-white fs-3">
                          <i class="bi bi-person-circle"></i>
                        </div>

                        @auth
                          <a class="account_text dropdown-toggle text-white fw-semibold" href="#" id="accountDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 16px;">
                            {{ \Illuminate\Support\Str::limit(Auth::user()->name, 7, '...') }}
                        </a>


                          <ul class="dropdown-menu dropdown-menu-end shadow border-0 rounded-3" aria-labelledby="accountDropdown" style="min-width: 200px;position: absolute;margin-top: 10px;transform: translate3d(0px, 28px, 0px);border-radius: 5px !important;">
                            <li>
                              <a class="dropdown-item d-flex align-items-center gap-2" href="#">
                                <i class="bi bi-person-circle"></i> My Account
                              </a>
                            </li>
                            <li>
                              <a class="dropdown-item d-flex align-items-center gap-2" href="#">
                                <i class="bi bi-receipt"></i> My RFQ
                              </a>
                            </li>
                            <li>
                              <a class="dropdown-item d-flex align-items-center gap-2" href="#">
                                <i class="bi bi-bag-plus-fill"></i> My Orders
                              </a>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                              <a class="dropdown-item text-danger d-flex align-items-center gap-2" href="{{ route('logout') }}"
                                 onclick="event.preventDefault(); document.getElementById('logout-form').submit();">
                                <i class="bi bi-box-arrow-right"></i> Logout
                              </a>
                              <form id="logout-form" action="{{ route('logout') }}" method="POST" class="d-none">
                                  @csrf
                              </form>
                            </li>
                          </ul>

                        @else
                          <div class="account_text">
                            <a href="{{ route('login') }}" class="btn btn-outline-light btn-sm">Sign In</a>
                          </div>
                        @endauth
                      </div>
                    </div>


                        <div class="cart dropdown">
                            <div class="dropdown_link d-flex flex-row align-items-center justify-content-end" data-toggle="dropdown">
                                <div class="cart_icon" style="font-size: 24px;">
                                    <i class="bi bi-bag-plus-fill"></i>
                                    <div class="cart_count">02</div>
                                </div>
                                <div class="cart_content">
                                    <div class="cart_text"><a href="#" style="color: white;font-size: 15px;font-weight: 600;">My RFQ</a></div>
                                </div>
                            </div>
                            <aside class="widget_shopping_cart dropdown_content">
                                <ul class="cart-list">
                                    <li>
                                        <a href="#" class="photo"><img src="{{ asset('assets/buyer-assets/images/product/pro-front-02.png') }}" class="cart-thumb" alt="" /></a>
                                        <h6><a href="#">Impact Wrench</a></h6>
                                        <p>2x - <span class="price">$220.00</span></p>
                                    </li>
                                    <li>
                                        <a href="#" class="photo"><img src="{{ asset('assets/buyer-assets/images/product/pro-front-03.png') }}" class="cart-thumb" alt="" /></a>
                                        <h6><a href="#">Demolition Breaker</a></h6>
                                        <p>1x - <span class="price">$38.00</span></p>
                                    </li>
                                    <li class="total">
                                        <span class="pull-right"><strong>Total</strong>: $257.00</span>
                                        <a href="#" class="btn btn-default btn-cart">Cart</a>
                                    </li>
                                </ul>
                            </aside>
                        </div>
                    </div><!-- header_extra end -->
                </div>
            </div>
        </div>
    </div><!-- haeder-main end -->
    
    <!-- site-header-menu -->
    <div id="site-header-menu" class="site-header-menu ttm-bgcolor-white clearfix">
        <div class="site-header-menu-inner stickable-header">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="main_nav_content d-flex flex-row">
                            <div class="cat_menu_container">
                                <a href="#" class="cat_menu d-flex flex-row align-items-center">
                                    <div class="cat_icon"><i class="fa fa-bars"></i></div>
                                    <div class="cat_text"><span>Shop by</span><h4>Categories</h4></div>
                                </a>
                                <ul class="cat_menu_list menu-vertical" id="headerCategoryList">
                                    <li><a href="#" class="close-side"><i class="fa fa-times"></i></a></li>
                                </ul>
                            </div>
                            <!--site-navigation -->
                            <div id="site-navigation" class="site-navigation">
                                <div class="btn-show-menu-mobile menubar menubar--squeeze">
                                    <span class="menubar-box">
                                        <span class="menubar-inner"></span>
                                    </span>
                                </div>
                                <!-- menu -->
                                <nav class="menu menu-mobile" id="menu">
                                    <ul class="nav">
                                        <li><a href="{{ route('buyer.index') }}">Home</a></li>
                                        <li><a href="{{ route('buyer.products.list-page') }}">Product List</a></li>
                                        <li><a href="{{ route('buyer.get-best-deal.create') }}">Get Best Deal</a></li>
                                        <li><a href="#">Contact Us</a></li>
                                    </ul>
                                </nav>
                            </div><!-- site-navigation end-->
                            <div class="user_zone_block d-flex flex-row align-items-center justify-content-end ml-auto">
                                <div class="icon"><i class="bi bi-graph-up-arrow"></i></div>
                                <h6 class="text"><a href="javascript:void(0)">Free Listing</a></h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div><!-- site-header-menu end -->
</header><!--header end-->
<style>
    /* Basic dropdown styles for categories */
    #headerCategoryList li { position: relative; }
    #headerCategoryList .submenu {
        list-style: none;
        margin: 0;
        padding-left: 0;
        position: absolute;
        top: 0;
        left: 100%;
        min-width: 180px;
        display: none;
        background: #fff;
        z-index: 1000;
    }
    #headerCategoryList li:hover > .submenu { display: block; }
</style>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        axios.get('{{ route('buyer.categories') }}').then(function (response) {
            var list = document.getElementById('headerCategoryList');
            if (list) {
                list.querySelectorAll('li:not(:first-child)').forEach(function (el) { el.remove(); });
                var data = response.data;
                if (data.length) {
                    data.forEach(function (cat) {
                        var li = document.createElement('li');
                        li.className = 'position-relative';
                        var anchor = document.createElement('a');
                        anchor.href = '#';
                        anchor.textContent = cat.name;
                        anchor.className = 'd-block px-3 py-2';
                        li.appendChild(anchor);
                        if (cat.children && cat.children.length) {
                            var subUl = document.createElement('ul');
                            subUl.className = 'submenu shadow-sm';
                            cat.children.forEach(function (sub) {
                                var subLi = document.createElement('li');
                                subLi.innerHTML = '<a href="#" class="d-block px-3 py-2">' + sub.name + '</a>';
                                subUl.appendChild(subLi);
                            });
                            li.appendChild(subUl);
                        }
                        list.appendChild(li);
                    });
                } else {
                    var li = document.createElement('li');
                    li.className = 'px-3 py-2 text-muted';
                    li.textContent = 'No categories found';
                    list.appendChild(li);
                }
            }
        });

        var searchInput = document.getElementById('search_query_top');
        var suggestionContainer = document.getElementById('searchSuggestionContainer');

        function renderSuggestions(data) {
            let html = '';
            if ((data.products && data.products.length) || (data.categories && data.categories.length)) {
                html += '<div class="list-group">';

                // ✅ Products (Click to fill input)
                if (data.products && data.products.length) {
                    data.products.forEach(function (p) {
                        let date = p.date ? ' <span class="text-muted small">(' + p.date + ')</span>' : '';
                        html += `<div class="list-group-item list-group-item-action d-flex justify-content-between align-items-center product-suggestion" data-name="${p.name}">
                                    ${p.name}${date}
                                 </div>`;
                    });
                }

                // 🚫 Categories (Not clickable)
                if (data.categories && data.categories.length) {
                    html += '<div class="border-top my-1"></div>';
                    data.categories.forEach(function (c) {
                        html += `<div class="list-group-item text-muted">
                                    ${c.name}
                                 </div>`;
                    });
                }

                html += '</div>';
            } else {
                html = '<div class="p-2 text-muted">No results found.</div>';
            }

            suggestionContainer.innerHTML = html;

            // ✅ Add click event to product suggestions
            document.querySelectorAll('.product-suggestion').forEach(function (el) {
                el.addEventListener('click', function () {
                    const name = this.getAttribute('data-name');
                    document.getElementById('search_query_top').value = name;
                    suggestionContainer.innerHTML = ''; // hide suggestions
                });
            });
        }




        if (searchInput) {
            searchInput.addEventListener('keyup', function () {
                var q = this.value.trim();
                if (!/^[a-zA-Z0-9\s]*$/.test(q)) {
                    suggestionContainer.innerHTML = '<div class="text-danger p-2">Invalid characters.</div>';
                    return;
                }
                if (q.length < 2) {
                    suggestionContainer.innerHTML = '';
                    return;
                }
                axios.get('{{ route('buyer.search-suggestions') }}', { params: { q: q } })
                    .then(function (res) {
                        renderSuggestions(res.data);
                    })
                    .catch(function () {
                        suggestionContainer.innerHTML = '';
                    });
            });
        }
    });
</script>