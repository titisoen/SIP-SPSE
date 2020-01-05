<!-- Header -->
<header class="app-layout-header">

    <nav class="navbar navbar-default">

        <div class="container-fluid">
            
            <div class="navbar-header">
                <button class="pull-left hidden-lg hidden-md navbar-toggle" type="button" data-toggle="layout" data-action="sidebar_toggle">
                    <span class="sr-only">Toggle drawer</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <span class="navbar-page-title"></span>
            </div>
            <div class="collapse navbar-collapse" id="header-navbar-collapse">
						
                            <?php
                                if ($this->session->userdata('auth_id') == ''){
                            ?>
                <ul class="nav navbar-nav navbar-right navbar-toolbar hidden-sm hidden-xs">
                    <li class="">
                        <a href="javascript:void(0)">
                            <span class="m-r-sm app-open-login-page">Login User&nbsp;</span>
                            <img class="img-avatar img-avatar-48" src="<?=base_url('assets/uploads/avatars/finger.png')?>" alt="Authentication" />
                        </a>
                    </li>
                </ul>
                            <?php
                                }
                                else{
                            ?>
								
                <ul class="nav navbar-nav navbar-right navbar-toolbar hidden-sm hidden-xs">
                    <li class="dropdown dropdown-profile">
                        <a href="javascript:void(0)" data-toggle="dropdown">
                            <span class="m-r-sm">Administrator&nbsp;<span class="caret"></span></span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-right">
													<li><a href="#"  class="app-auth-logout-btn">Keluar</a></li>
                        </ul>
                    </li>
                </ul>
								
                            <?php
                                }
                            ?>
            </div>
        
        </div>
        <!-- .container-fluid -->

    </nav>
    <!-- .navbar-default -->

</header>
<!-- End header -->