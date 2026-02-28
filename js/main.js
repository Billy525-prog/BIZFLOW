// Main JavaScript File for BIZFLOW System

// Live Date and Time Function
function updateDateTime() {
    const now = new Date();
    
    // Format date
    const options = { 
        weekday: 'long', 
        year: 'numeric', 
        month: 'long', 
        day: 'numeric' 
    };
    const dateStr = now.toLocaleDateString('en-US', options);
    
    // Format time
    const timeStr = now.toLocaleTimeString('en-US', { 
        hour: '2-digit', 
        minute: '2-digit', 
        second: '2-digit' 
    });
    
    // Update DOM
    const dateElement = document.getElementById('currentDate');
    const timeElement = document.getElementById('currentTime');
    
    if (dateElement) dateElement.textContent = dateStr;
    if (timeElement) timeElement.textContent = timeStr;
}

// Update every second
setInterval(updateDateTime, 1000);

// Page Navigation Functions
function showLogin() {
    document.getElementById('loginForm').style.display = 'block';
    document.getElementById('registerForm').style.display = 'none';
}

function showRegister() {
    document.getElementById('loginForm').style.display = 'none';
    document.getElementById('registerForm').style.display = 'block';
}

// Login Function
document.addEventListener('DOMContentLoaded', function() {
    // Check if user is logged in
    const isLoggedIn = localStorage.getItem('bizflow_logged_in');
    
    if (isLoggedIn === 'true') {
        showDashboard();
    } else {
        showLoginPage();
    }
    
    // Login Form Submit
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Simulate login
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            
            if (email && password) {
                localStorage.setItem('bizflow_logged_in', 'true');
                localStorage.setItem('bizflow_user', JSON.stringify({
                    name: 'Alex John',
                    email: email,
                    role: 'Administrator',
                    shop: 'TechZone Computers'
                }));
                
                showDashboard();
                loadDashboardContent();
            } else {
                alert('Please enter email and password');
            }
        });
    }
    
    // Register Form Submit
    const registerForm = document.getElementById('registerForm');
    if (registerForm) {
        registerForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Simulate registration
            const fullname = document.getElementById('fullname').value;
            const email = document.getElementById('reg-email').value;
            const password = document.getElementById('reg-password').value;
            const confirmPass = document.getElementById('confirm-password').value;
            
            if (password !== confirmPass) {
                alert('Passwords do not match!');
                return;
            }
            
            if (fullname && email && password) {
                localStorage.setItem('bizflow_logged_in', 'true');
                localStorage.setItem('bizflow_user', JSON.stringify({
                    name: fullname,
                    email: email,
                    role: 'Administrator',
                    shop: document.getElementById('shop-name').value || 'My Computer Shop'
                }));
                
                showDashboard();
                loadDashboardContent();
            } else {
                alert('Please fill all fields');
            }
        });
    }
    
    // Load initial content
    loadDashboardContent();
});

// Show/Hide Functions
function showLoginPage() {
    document.getElementById('loginPage').style.display = 'flex';
    document.getElementById('dashboardPage').classList.remove('active');
}

function showDashboard() {
    document.getElementById('loginPage').style.display = 'none';
    document.getElementById('dashboardPage').classList.add('active');
    
    // Update user info in sidebar
    const user = JSON.parse(localStorage.getItem('bizflow_user') || '{}');
    const userNameElements = document.querySelectorAll('.user-name');
    const userRoleElements = document.querySelectorAll('.user-role');
    
    userNameElements.forEach(el => {
        el.textContent = user.name || 'Alex John';
    });
    
    userRoleElements.forEach(el => {
        el.textContent = user.role || 'Administrator';
    });
}

// Logout Function
function logout() {
    localStorage.removeItem('bizflow_logged_in');
    localStorage.removeItem('bizflow_user');
    showLoginPage();
}

// Page Loading Function
function loadPage(page) {
    // Update active nav link
    document.querySelectorAll('.nav-link').forEach(link => {
        link.classList.remove('active');
    });
    event.currentTarget.classList.add('active');
    
    // Update page title
    const titles = {
        'dashboard': { title: 'Dashboard', desc: 'Welcome back! Here\'s your overview' },
        'crm': { title: 'Customer Relationship Management', desc: 'Manage your customers and interactions' },
        'inventory': { title: 'Inventory Management', desc: 'Track your computer accessories stock' },
        'sales': { title: 'Sales & Invoicing', desc: 'Create and manage sales invoices' },
        'tasks': { title: 'Tasks & Employees', desc: 'Manage team tasks and assignments' },
        'reports': { title: 'Reports & Analytics', desc: 'View business insights and reports' },
        'settings': { title: 'System Settings', desc: 'Configure your BIZFLOW system' },
        'shop': { title: 'Computer Accessories Shop', desc: 'Browse and sell products' }
    };
    
    document.getElementById('pageTitle').textContent = titles[page].title;
    document.getElementById('pageDescription').textContent = titles[page].desc;
    
    // Load page content
    switch(page) {
        case 'dashboard':
            loadDashboardContent();
            break;
        case 'crm':
            loadCRMContent();
            break;
        case 'inventory':
            loadInventoryContent();
            break;
        case 'sales':
            loadSalesContent();
            break;
        case 'tasks':
            loadTasksContent();
            break;
        case 'reports':
            loadReportsContent();
            break;
        case 'settings':
            loadSettingsContent();
            break;
        case 'shop':
            loadShopContent();
            break;
    }
}

// Load Dashboard Content
function loadDashboardContent() {
    const contentArea = document.getElementById('contentArea');
    
    contentArea.innerHTML = `
        <div class="dashboard-cards">
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Today's Sales</h3>
                    <div class="stat-number">TSh 1,240,000</div>
                    <div class="stat-change">+12% from yesterday</div>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Total Customers</h3>
                    <div class="stat-number">156</div>
                    <div class="stat-change">+8 new this week</div>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Low Stock Items</h3>
                    <div class="stat-number">3</div>
                    <div class="stat-change" style="color: #ef4444;">Need reorder</div>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Pending Tasks</h3>
                    <div class="stat-number">5</div>
                    <div class="stat-change">2 due today</div>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-tasks"></i>
                </div>
            </div>
        </div>
        
        <div class="charts-row">
            <div class="chart-card">
                <div class="chart-header">
                    <h3>Sales Overview</h3>
                    <select class="chart-period">
                        <option>Weekly</option>
                        <option>Monthly</option>
                        <option>Yearly</option>
                    </select>
                </div>
                <div style="height: 300px; display: flex; align-items: flex-end; gap: 10px; padding: 20px 0;">
                    <div style="flex: 1; text-align: center;">
                        <div style="height: 150px; background: linear-gradient(to top, #2563eb, #60a5fa); width: 100%; border-radius: 5px;"></div>
                        <span style="font-size: 12px;">Mon</span>
                    </div>
                    <div style="flex: 1; text-align: center;">
                        <div style="height: 180px; background: linear-gradient(to top, #2563eb, #60a5fa); width: 100%; border-radius: 5px;"></div>
                        <span style="font-size: 12px;">Tue</span>
                    </div>
                    <div style="flex: 1; text-align: center;">
                        <div style="height: 120px; background: linear-gradient(to top, #2563eb, #60a5fa); width: 100%; border-radius: 5px;"></div>
                        <span style="font-size: 12px;">Wed</span>
                    </div>
                    <div style="flex: 1; text-align: center;">
                        <div style="height: 210px; background: linear-gradient(to top, #2563eb, #60a5fa); width: 100%; border-radius: 5px;"></div>
                        <span style="font-size: 12px;">Thu</span>
                    </div>
                    <div style="flex: 1; text-align: center;">
                        <div style="height: 190px; background: linear-gradient(to top, #2563eb, #60a5fa); width: 100%; border-radius: 5px;"></div>
                        <span style="font-size: 12px;">Fri</span>
                    </div>
                    <div style="flex: 1; text-align: center;">
                        <div style="height: 250px; background: linear-gradient(to top, #2563eb, #60a5fa); width: 100%; border-radius: 5px;"></div>
                        <span style="font-size: 12px;">Sat</span>
                    </div>
                    <div style="flex: 1; text-align: center;">
                        <div style="height: 200px; background: linear-gradient(to top, #2563eb, #60a5fa); width: 100%; border-radius: 5px;"></div>
                        <span style="font-size: 12px;">Sun</span>
                    </div>
                </div>
            </div>
            
            <div class="chart-card">
                <div class="chart-header">
                    <h3>Top Products</h3>
                </div>
                <div style="margin-top: 20px;">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                        <span>Gaming Mouse</span>
                        <span style="font-weight: 600;">45 sold</span>
                    </div>
                    <div style="height: 8px; background: #f3f4f6; border-radius: 4px; margin-bottom: 15px;">
                        <div style="width: 85%; height: 100%; background: #2563eb; border-radius: 4px;"></div>
                    </div>
                    
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                        <span>Mechanical Keyboard</span>
                        <span style="font-weight: 600;">32 sold</span>
                    </div>
                    <div style="height: 8px; background: #f3f4f6; border-radius: 4px; margin-bottom: 15px;">
                        <div style="width: 70%; height: 100%; background: #2563eb; border-radius: 4px;"></div>
                    </div>
                    
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                        <span>USB-C Hub</span>
                        <span style="font-weight: 600;">28 sold</span>
                    </div>
                    <div style="height: 8px; background: #f3f4f6; border-radius: 4px; margin-bottom: 15px;">
                        <div style="width: 60%; height: 100%; background: #2563eb; border-radius: 4px;"></div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="chart-card" style="margin-top: 20px;">
            <div class="chart-header">
                <h3>Recent Sales</h3>
                <button class="btn-sm btn-edit" onclick="loadPage('sales')">View All</button>
            </div>
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Customer</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Premium Gaming Mouse</td>
                            <td>John Doe</td>
                            <td>TSh 89,000</td>
                            <td><span class="status-badge status-paid">Paid</span></td>
                            <td>2 mins ago</td>
                        </tr>
                        <tr>
                            <td>Mechanical Keyboard</td>
                            <td>Jane Smith</td>
                            <td>TSh 120,000</td>
                            <td><span class="status-badge status-paid">Paid</span></td>
                            <td>45 mins ago</td>
                        </tr>
                        <tr>
                            <td>USB-C Hub</td>
                            <td>Mike Johnson</td>
                            <td>TSh 45,000</td>
                            <td><span class="status-badge status-pending">Pending</span></td>
                            <td>1 hour ago</td>
                        </tr>
                        <tr>
                            <td>Laptop Stand</td>
                            <td>Sarah Wilson</td>
                            <td>TSh 35,000</td>
                            <td><span class="status-badge status-paid">Paid</span></td>
                            <td>3 hours ago</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    `;
}

// Load CRM Content
function loadCRMContent() {
    const contentArea = document.getElementById('contentArea');
    
    contentArea.innerHTML = `
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h3 style="color: #1f2937;">Customer List</h3>
            <button class="btn btn-primary" style="width: auto;" onclick="showAddCustomerModal()">
                <i class="fas fa-plus"></i> Add New Customer
            </button>
        </div>
        
        <div style="display: flex; gap: 15px; margin-bottom: 20px;">
            <div class="search-box" style="flex: 1;">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search customers..." style="width: 100%;">
            </div>
            <select style="padding: 10px; border: 2px solid #e5e7eb; border-radius: 8px;">
                <option>All Customers</option>
                <option>Active</option>
                <option>Inactive</option>
                <option>VIP</option>
            </select>
        </div>
        
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Customer</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Total Purchases</th>
                        <th>Last Interaction</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div style="display: flex; align-items: center; gap: 10px;">
                                <img src="https://ui-avatars.com/api/?name=John+Doe&background=2563eb&color=fff" style="width: 35px; height: 35px; border-radius: 8px;">
                                John Doe
                            </div>
                        </td>
                        <td>john@email.com</td>
                        <td>+255 712 345 678</td>
                        <td>TSh 450,000</td>
                        <td>2024-02-28</td>
                        <td><span class="status-badge status-paid">Active</span></td>
                        <td>
                            <button class="btn-sm btn-edit"><i class="fas fa-edit"></i></button>
                            <button class="btn-sm btn-edit"><i class="fas fa-eye"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div style="display: flex; align-items: center; gap: 10px;">
                                <img src="https://ui-avatars.com/api/?name=Jane+Smith&background=2563eb&color=fff" style="width: 35px; height: 35px; border-radius: 8px;">
                                Jane Smith
                            </div>
                        </td>
                        <td>jane@email.com</td>
                        <td>+255 723 456 789</td>
                        <td>TSh 890,000</td>
                        <td>2024-02-27</td>
                        <td><span class="status-badge status-paid">Active</span></td>
                        <td>
                            <button class="btn-sm btn-edit"><i class="fas fa-edit"></i></button>
                            <button class="btn-sm btn-edit"><i class="fas fa-eye"></i></button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    `;
}

// Load Inventory Content
function loadInventoryContent() {
    const contentArea = document.getElementById('contentArea');
    
    contentArea.innerHTML = `
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h3 style="color: #1f2937;">Computer Accessories Inventory</h3>
            <button class="btn btn-primary" style="width: auto;" onclick="showAddProductModal()">
                <i class="fas fa-plus"></i> Add New Product
            </button>
        </div>
        
        <div style="display: flex; gap: 20px; margin-bottom: 20px;">
            <div class="search-box" style="flex: 1;">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search products..." style="width: 100%;">
            </div>
            <select style="padding: 10px; border: 2px solid #e5e7eb; border-radius: 8px;">
                <option>All Categories</option>
                <option>Mice</option>
                <option>Keyboards</option>
                <option>Headphones</option>
                <option>Cables</option>
                <option>Adapters</option>
            </select>
            <select style="padding: 10px; border: 2px solid #e5e7eb; border-radius: 8px;">
                <option>All Stock</option>
                <option>In Stock</option>
                <option>Low Stock</option>
                <option>Out of Stock</option>
            </select>
        </div>
        
        <div class="inventory-grid">
            <div class="product-card">
                <div class="product-image">
                    <i class="fas fa-mouse"></i>
                </div>
                <div class="product-info">
                    <div class="product-name">Logitech G502 Hero</div>
                    <div class="product-sku">SKU: MOU-001</div>
                    <div class="product-price">TSh 85,000</div>
                    <div class="product-stock">
                        <i class="fas fa-box"></i>
                        <span>Stock: <span style="color: #10b981; font-weight: 600;">45 units</span></span>
                    </div>
                </div>
            </div>
            
            <div class="product-card">
                <div class="product-image">
                    <i class="fas fa-keyboard"></i>
                </div>
                <div class="product-info">
                    <div class="product-name">Mechanical Keyboard K70</div>
                    <div class="product-sku">SKU: KEY-002</div>
                    <div class="product-price">TSh 120,000</div>
                    <div class="product-stock">
                        <i class="fas fa-box"></i>
                        <span>Stock: <span style="color: #ef4444; font-weight: 600;">3 units</span></span>
                    </div>
                    <div style="margin-top: 5px; font-size: 12px; color: #ef4444;">
                        <i class="fas fa-exclamation-triangle"></i> Low Stock Alert!
                    </div>
                </div>
            </div>
            
            <div class="product-card">
                <div class="product-image">
                    <i class="fas fa-headphones"></i>
                </div>
                <div class="product-info">
                    <div class="product-name">Wireless Headphones</div>
                    <div class="product-sku">SKU: AUD-003</div>
                    <div class="product-price">TSh 150,000</div>
                    <div class="product-stock">
                        <i class="fas fa-box"></i>
                        <span>Stock: <span style="color: #10b981; font-weight: 600;">12 units</span></span>
                    </div>
                </div>
            </div>
            
            <div class="product-card">
                <div class="product-image">
                    <i class="fas fa-hdd"></i>
                </div>
                <div class="product-info">
                    <div class="product-name">1TB External SSD</div>
                    <div class="product-sku">SKU: STO-004</div>
                    <div class="product-price">TSh 180,000</div>
                    <div class="product-stock">
                        <i class="fas fa-box"></i>
                        <span>Stock: <span style="color: #10b981; font-weight: 600;">8 units</span></span>
                    </div>
                </div>
            </div>
            
            <div class="product-card">
                <div class="product-image">
                    <i class="fas fa-plug"></i>
                </div>
                <div class="product-info">
                    <div class="product-name">USB-C Hub 7-in-1</div>
                    <div class="product-sku">SKU: USB-005</div>
                    <div class="product-price">TSh 45,000</div>
                    <div class="product-stock">
                        <i class="fas fa-box"></i>
                        <span>Stock: <span style="color: #ef4444; font-weight: 600;">2 units</span></span>
                    </div>
                    <div style="margin-top: 5px; font-size: 12px; color: #ef4444;">
                        <i class="fas fa-exclamation-triangle"></i> Low Stock Alert!
                    </div>
                </div>
            </div>
            
            <div class="product-card">
                <div class="product-image">
                    <i class="fas fa-video"></i>
                </div>
                <div class="product-info">
                    <div class="product-name">Webcam HD Pro</div>
                    <div class="product-sku">SKU: CAM-006</div>
                    <div class="product-price">TSh 65,000</div>
                    <div class="product-stock">
                        <i class="fas fa-box"></i>
                        <span>Stock: <span style="color: #10b981; font-weight: 600;">15 units</span></span>
                    </div>
                </div>
            </div>
        </div>
    `;
}

// Load Sales Content
function loadSalesContent() {
    const contentArea = document.getElementById('contentArea');
    
    contentArea.innerHTML = `
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h3 style="color: #1f2937;">Sales & Invoicing</h3>
            <button class="btn btn-primary" style="width: auto;" onclick="showCreateInvoiceModal()">
                <i class="fas fa-plus"></i> Create New Invoice
            </button>
        </div>
        
        <div class="dashboard-cards" style="grid-template-columns: repeat(4, 1fr);">
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Today's Sales</h3>
                    <div class="stat-number">TSh 1,240,000</div>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-calendar-day"></i>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-info">
                    <h3>This Week</h3>
                    <div class="stat-number">TSh 5,890,000</div>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-calendar-week"></i>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-info">
                    <h3>This Month</h3>
                    <div class="stat-number">TSh 24,500,000</div>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-calendar-alt"></i>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Pending Invoices</h3>
                    <div class="stat-number">8</div>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
            </div>
        </div>
        
        <div style="margin-top: 20px;">
            <div style="display: flex; gap: 10px; margin-bottom: 20px; border-bottom: 2px solid #f3f4f6; padding-bottom: 10px;">
                <button style="padding: 10px 20px; background: #2563eb; color: white; border: none; border-radius: 8px;">All Invoices</button>
                <button style="padding: 10px 20px; background: none; color: #6b7280; border: none;">Paid</button>
                <button style="padding: 10px 20px; background: none; color: #6b7280; border: none;">Pending</button>
                <button style="padding: 10px 20px; background: none; color: #6b7280; border: none;">Overdue</button>
            </div>
            
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Invoice #</th>
                            <th>Customer</th>
                            <th>Date</th>
                            <th>Items</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Payment</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><span style="font-weight: 600;">INV-001</span></td>
                            <td>John Doe</td>
                            <td>2024-02-28</td>
                            <td>Gaming Mouse x2</td>
                            <td>TSh 178,000</td>
                            <td><span class="status-badge status-paid">Paid</span></td>
                            <td>Cash</td>
                            <td>
                                <button class="btn-sm btn-edit"><i class="fas fa-print"></i></button>
                                <button class="btn-sm btn-edit"><i class="fas fa-envelope"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td><span style="font-weight: 600;">INV-002</span></td>
                            <td>Jane Smith</td>
                            <td>2024-02-28</td>
                            <td>Keyboard + Mouse</td>
                            <td>TSh 205,000</td>
                            <td><span class="status-badge status-pending">Pending</span></td>
                            <td>Card</td>
                            <td>
                                <button class="btn-sm btn-edit"><i class="fas fa-print"></i></button>
                                <button class="btn-sm btn-edit"><i class="fas fa-envelope"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td><span style="font-weight: 600;">INV-003</span></td>
                            <td>Mike Johnson</td>
                            <td>2024-02-27</td>
                            <td>USB-C Hub</td>
                            <td>TSh 45,000</td>
                            <td><span class="status-badge status-paid">Paid</span></td>
                            <td>M-Pesa</td>
                            <td>
                                <button class="btn-sm btn-edit"><i class="fas fa-print"></i></button>
                                <button class="btn-sm btn-edit"><i class="fas fa-envelope"></i></button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    `;
}

// Load Shop Content
function loadShopContent() {
    const contentArea = document.getElementById('contentArea');
    
    contentArea.innerHTML = `
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h3 style="color: #1f2937;">Computer Accessories Shop</h3>
            <button class="btn btn-primary" style="width: auto;" onclick="showAddToCartModal()">
                <i class="fas fa-shopping-cart"></i> View Cart (0)
            </button>
        </div>
        
        <div class="shop-grid">
            <div class="shop-categories">
                <h4 style="margin-bottom: 15px; color: #1f2937;">Categories</h4>
                <ul class="category-list">
                    <li class="category-item active">All Products</li>
                    <li class="category-item">Gaming Mice</li>
                    <li class="category-item">Keyboards</li>
                    <li class="category-item">Headphones</li>
                    <li class="category-item">Cables & Adapters</li>
                    <li class="category-item">Storage Devices</li>
                    <li class="category-item">Webcams</li>
                    <li class="category-item">Laptop Accessories</li>
                </ul>
            </div>
            
            <div class="products-grid">
                <div class="shop-product-card">
                    <div class="shop-product-image">
                        <i class="fas fa-mouse"></i>
                    </div>
                    <h4>Gaming Mouse</h4>
                    <p style="color: #6b7280; font-size: 12px;">Logitech G502</p>
                    <div class="shop-product-price">TSh 85,000</div>
                    <button class="btn-add-to-cart" onclick="addToCart('Gaming Mouse')">
                        <i class="fas fa-cart-plus"></i> Add to Cart
                    </button>
                </div>
                
                <div class="shop-product-card">
                    <div class="shop-product-image">
                        <i class="fas fa-keyboard"></i>
                    </div>
                    <h4>Mechanical Keyboard</h4>
                    <p style="color: #6b7280; font-size: 12px;">Corsair K70</p>
                    <div class="shop-product-price">TSh 120,000</div>
                    <button class="btn-add-to-cart" onclick="addToCart('Mechanical Keyboard')">
                        <i class="fas fa-cart-plus"></i> Add to Cart
                    </button>
                </div>
                
                <div class="shop-product-card">
                    <div class="shop-product-image">
                        <i class="fas fa-headphones"></i>
                    </div>
                    <h4>Wireless Headphones</h4>
                    <p style="color: #6b7280; font-size: 12px;">Sony WH-1000XM4</p>
                    <div class="shop-product-price">TSh 350,000</div>
                    <button class="btn-add-to-cart" onclick="addToCart('Wireless Headphones')">
                        <i class="fas fa-cart-plus"></i> Add to Cart
                    </button>
                </div>
                
                <div class="shop-product-card">
                    <div class="shop-product-image">
                        <i class="fas fa-hdd"></i>
                    </div>
                    <h4>External SSD</h4>
                    <p style="color: #6b7280; font-size: 12px;">Samsung T7 1TB</p>
                    <div class="shop-product-price">TSh 180,000</div>
                    <button class="btn-add-to-cart" onclick="addToCart('External SSD')">
                        <i class="fas fa-cart-plus"></i> Add to Cart
                    </button>
                </div>
                
                <div class="shop-product-card">
                    <div class="shop-product-image">
                        <i class="fas fa-plug"></i>
                    </div>
                    <h4>USB-C Hub</h4>
                    <p style="color: #6b7280; font-size: 12px;">7-in-1 Adapter</p>
                    <div class="shop-product-price">TSh 45,000</div>
                    <button class="btn-add-to-cart" onclick="addToCart('USB-C Hub')">
                        <i class="fas fa-cart-plus"></i> Add to Cart
                    </button>
                </div>
                
                <div class="shop-product-card">
                    <div class="shop-product-image">
                        <i class="fas fa-video"></i>
                    </div>
                    <h4>HD Webcam</h4>
                    <p style="color: #6b7280; font-size: 12px;">1080p Pro</p>
                    <div class="shop-product-price">TSh 65,000</div>
                    <button class="btn-add-to-cart" onclick="addToCart('HD Webcam')">
                        <i class="fas fa-cart-plus"></i> Add to Cart
                    </button>
                </div>
            </div>
        </div>
    `;
}

// Modal Functions
function showAddProductModal() {
    alert('Add Product Modal - In production, this would open a form for adding new products with image upload');
}

function showAddCustomerModal() {
    alert('Add Customer Modal - Form for adding new customers');
}

function showCreateInvoiceModal() {
    alert('Create Invoice Modal - Form for creating new sales invoice');
}

function showAddToCartModal() {
    alert('Shopping Cart - View and manage your cart');
}

function addToCart(product) {
    alert(`${product} added to cart!`);
}

// Initialize date/time on load
updateDateTime();

// Load tasks, reports, settings functions (similar structure)
function loadTasksContent() {
    const contentArea = document.getElementById('contentArea');
    contentArea.innerHTML = '<div class="loading"><i class="fas fa-tasks"></i><h3>Tasks & Employee Management</h3><p>Loading tasks...</p></div>';
}

function loadReportsContent() {
    const contentArea = document.getElementById('contentArea');
    contentArea.innerHTML = '<div class="loading"><i class="fas fa-chart-bar"></i><h3>Reports & Analytics</h3><p>Loading reports...</p></div>';
}

function loadSettingsContent() {
    const contentArea = document.getElementById('contentArea');
    contentArea.innerHTML = '<div class="loading"><i class="fas fa-cog"></i><h3>System Settings</h3><p>Loading settings...</p></div>';
}