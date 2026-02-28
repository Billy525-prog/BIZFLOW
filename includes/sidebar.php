<?php
// includes/sidebar.php
$current_page = basename($_SERVER['PHP_SELF']);
?>
<div class="sidebar">
    <div class="sidebar-logo">
        <i class="fas fa-bolt"></i>
        <div>
            <span>BIZFLOW</span>
            <small>Computer Accessories</small>
        </div>
    </div>

    <ul class="nav-menu">
        <li class="nav-item">
            <a href="dashboard.php" class="nav-link <?php echo $current_page == 'dashboard.php' ? 'active' : ''; ?>">
                <i class="fas fa-home"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="pos.php" class="nav-link <?php echo $current_page == 'pos.php' ? 'active' : ''; ?>">
                <i class="fas fa-cash-register"></i>
                <span>Point of Sale</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="inventory.php" class="nav-link <?php echo strpos($current_page, 'inventory') !== false ? 'active' : ''; ?>">
                <i class="fas fa-boxes"></i>
                <span>Inventory</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="sales.php" class="nav-link <?php echo $current_page == 'sales.php' ? 'active' : ''; ?>">
                <i class="fas fa-shopping-cart"></i>
                <span>Sales</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="customers.php" class="nav-link <?php echo $current_page == 'customers.php' ? 'active' : ''; ?>">
                <i class="fas fa-users"></i>
                <span>Customers</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="suppliers.php" class="nav-link <?php echo $current_page == 'suppliers.php' ? 'active' : ''; ?>">
                <i class="fas fa-truck"></i>
                <span>Suppliers</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="purchase-orders.php" class="nav-link <?php echo $current_page == 'purchase-orders.php' ? 'active' : ''; ?>">
                <i class="fas fa-file-invoice"></i>
                <span>Purchase Orders</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="reports.php" class="nav-link <?php echo $current_page == 'reports.php' ? 'active' : ''; ?>">
                <i class="fas fa-chart-bar"></i>
                <span>Reports</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="tasks.php" class="nav-link <?php echo $current_page == 'tasks.php' ? 'active' : ''; ?>">
                <i class="fas fa-tasks"></i>
                <span>Tasks</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="settings.php" class="nav-link <?php echo $current_page == 'settings.php' ? 'active' : ''; ?>">
                <i class="fas fa-cog"></i>
                <span>Settings</span>
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <div class="user-info">
            <img src="https://ui-avatars.com/api/?name=<?php echo urlencode($_SESSION['user_name'] ?? 'User'); ?>&background=2563eb&color=fff" alt="User">
            <div>
                <p class="user-name"><?php echo $_SESSION['user_name'] ?? 'User'; ?></p>
                <p class="user-role"><?php echo $_SESSION['user_role'] ?? 'Staff'; ?></p>
            </div>
        </div>
        <a href="../includes/logout.php" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
        </a>
    </div>
</div>