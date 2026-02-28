<?php
// pages/dashboard.php
session_start();
if(!isset($_SESSION['user_id'])) {
    header("Location: ../index.php");
    exit();
}
require_once '../includes/db_connect.php';
require_once '../includes/functions.php';

$user = getUserById($_SESSION['user_id']);
$stats = getDashboardStats();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - BIZFLOW</title>
    <link rel="icon" type="image/png" href="../favicon.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="dashboard-container active">
        <?php include '../includes/sidebar.php'; ?>

        <div class="main-content">
            <div class="top-bar">
                <div class="page-title">
                    <h2>Dashboard</h2>
                    <p>Welcome back, <?php echo htmlspecialchars($user['fullname']); ?>! Here's what's happening today.</p>
                </div>
                <div class="top-bar-right">
                    <div class="live-datetime" id="liveDateTime">
                        <div class="date" id="currentDate"></div>
                        <div class="time" id="currentTime"></div>
                    </div>
                    <div class="notifications">
                        <i class="fas fa-bell"></i>
                        <span class="notification-badge">3</span>
                    </div>
                </div>
            </div>

            <div class="content-area">
                <!-- Stats Cards -->
                <div class="dashboard-cards">
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>Today's Sales</h3>
                            <div class="stat-number">TSh <?php echo number_format($stats['today_sales']); ?></div>
                            <div class="stat-change">+12% from yesterday</div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>Total Customers</h3>
                            <div class="stat-number"><?php echo $stats['total_customers']; ?></div>
                            <div class="stat-change">+8 new this week</div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>Low Stock Items</h3>
                            <div class="stat-number"><?php echo $stats['low_stock']; ?></div>
                            <div class="stat-change" style="color: #ef4444;">Need reorder</div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>Pending Tasks</h3>
                            <div class="stat-number"><?php echo $stats['pending_tasks']; ?></div>
                            <div class="stat-change">2 due today</div>
                        </div>
                        <div class="stat-icon">
                            <i class="fas fa-tasks"></i>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions -->
                <div style="display: flex; gap: 15px; margin-bottom: 20px;">
                    <a href="pos.php" class="btn btn-primary" style="width: auto; padding: 12px 25px;">
                        <i class="fas fa-cash-register"></i> New Sale
                    </a>
                    <a href="inventory-add.php" class="btn btn-secondary" style="width: auto; padding: 12px 25px;">
                        <i class="fas fa-plus"></i> Add Product
                    </a>
                    <a href="customers-add.php" class="btn btn-secondary" style="width: auto; padding: 12px 25px;">
                        <i class="fas fa-user-plus"></i> Add Customer
                    </a>
                </div>
                
                <!-- Recent Sales -->
                <div class="chart-card">
                    <div class="chart-header">
                        <h3>Recent Sales</h3>
                        <a href="sales.php" class="btn-sm btn-edit">View All</a>
                    </div>
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Invoice</th>
                                    <th>Customer</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                    <th>Time</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php echo getRecentSalesHTML(); ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="../js/main.js"></script>
</body>
</html>