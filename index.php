<?php
// index.php - Main landing page with login/register
session_start();
if(isset($_SESSION['user_id'])) {
    header("Location: pages/dashboard.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BIZFLOW - Computer Accessories Management System</title>
    <link rel="icon" type="image/png" href="favicon.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- Login/Register Page -->
    <div class="login-container">
        <div class="login-card">
            <!-- Left Side - Preview -->
            <div class="login-preview">
                <div class="preview-logo">
                    <i class="fas fa-bolt"></i>
                    <span>BIZFLOW</span>
                </div>
                <h2>Streamline Your Success</h2>
                <p>Complete management system for your computer accessories shop</p>
                
                <div class="preview-features">
                    <div class="preview-feature">
                        <i class="fas fa-boxes"></i>
                        <div>
                            <h4>Inventory Management</h4>
                            <p>Track stock levels in real-time</p>
                        </div>
                    </div>
                    <div class="preview-feature">
                        <i class="fas fa-users"></i>
                        <div>
                            <h4>Customer Management</h4>
                            <p>Manage customer relationships</p>
                        </div>
                    </div>
                    <div class="preview-feature">
                        <i class="fas fa-file-invoice"></i>
                        <div>
                            <h4>Sales & Invoicing</h4>
                            <p>Create and manage invoices</p>
                        </div>
                    </div>
                    <div class="preview-feature">
                        <i class="fas fa-chart-line"></i>
                        <div>
                            <h4>Real-time Reports</h4>
                            <p>Make data-driven decisions</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Side - Login/Register Tabs -->
            <div class="login-form-section">
                <div class="form-logo">
                    <i class="fas fa-bolt"></i>
                    <h1>BIZFLOW</h1>
                    <p>Computer Accessories Shop Management</p>
                </div>

                <!-- Tab Buttons -->
                <div style="display: flex; gap: 10px; margin-bottom: 20px;">
                    <button class="tab-btn active" onclick="showLogin()" id="loginTab">Login</button>
                    <button class="tab-btn" onclick="showRegister()" id="registerTab">Register</button>
                </div>

                <!-- Login Form -->
                <form id="loginForm" action="includes/login-process.php" method="POST">
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <div class="input-group">
                            <i class="fas fa-envelope"></i>
                            <input type="email" id="email" name="email" placeholder="name@company.com" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="input-group">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="password" name="password" placeholder="••••••••" required>
                        </div>
                    </div>

                    <button type="submit" name="login" class="btn btn-primary">
                        <i class="fas fa-sign-in-alt"></i> Sign In
                    </button>
                </form>

                <!-- Register Form -->
                <form id="registerForm" action="includes/register-process.php" method="POST" style="display: none;">
                    <div class="form-group">
                        <label for="fullname">Full Name</label>
                        <div class="input-group">
                            <i class="fas fa-user"></i>
                            <input type="text" id="fullname" name="fullname" placeholder="John Doe" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="reg-email">Email Address</label>
                        <div class="input-group">
                            <i class="fas fa-envelope"></i>
                            <input type="email" id="reg-email" name="email" placeholder="name@company.com" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="reg-password">Password</label>
                        <div class="input-group">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="reg-password" name="password" placeholder="••••••••" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirm-password">Confirm Password</label>
                        <div class="input-group">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="confirm-password" name="confirm_password" placeholder="••••••••" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="shop-name">Shop Name</label>
                        <div class="input-group">
                            <i class="fas fa-store"></i>
                            <input type="text" id="shop-name" name="shop_name" placeholder="Your Computer Accessories Shop" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <div class="input-group">
                            <i class="fas fa-phone"></i>
                            <input type="text" id="phone" name="phone" placeholder="0712 345 678">
                        </div>
                    </div>

                    <button type="submit" name="register" class="btn btn-primary">
                        <i a href="forgot-password.php"class="fas fa-user-plus"></i> Register
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function showLogin() {
            document.getElementById('loginForm').style.display = 'block';
            document.getElementById('registerForm').style.display = 'none';
            document.getElementById('loginTab').classList.add('active');
            document.getElementById('registerTab').classList.remove('active');
        }

        function showRegister() {
            document.getElementById('loginForm').style.display = 'none';
            document.getElementById('registerForm').style.display = 'block';
            document.getElementById('registerTab').classList.add('active');
            document.getElementById('loginTab').classList.remove('active');
        }
    </script>
    <script src="js/main.js"></script>
</body>
</html>