<?php
// includes/functions.php - Helper functions
require_once 'db_connect.php';

// Get user by ID
function getUserById($user_id) {
    $pdo = getDB();
    $stmt = $pdo->prepare("SELECT * FROM users WHERE id = ?");
    $stmt->execute([$user_id]);
    return $stmt->fetch();
}

// Get dashboard statistics
function getDashboardStats() {
    $pdo = getDB();
    $stats = [];
    
    // Today's sales
    $stmt = $pdo->query("SELECT COALESCE(SUM(total_amount), 0) as total FROM sales WHERE DATE(sale_date) = CURDATE()");
    $stats['today_sales'] = $stmt->fetch()['total'];
    
    // Total customers
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM customers");
    $stats['total_customers'] = $stmt->fetch()['count'];
    
    // Low stock items
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM products WHERE quantity <= low_stock_threshold");
    $stats['low_stock'] = $stmt->fetch()['count'];
    
    // Pending tasks
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM tasks WHERE status = 'pending'");
    $stats['pending_tasks'] = $stmt->fetch()['count'];
    
    return $stats;
}

// Get all products
function getAllProducts() {
    $pdo = getDB();
    $stmt = $pdo->query("SELECT p.*, c.category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id ORDER BY p.id DESC");
    return $stmt->fetchAll();
}

// Get all categories
function getAllCategories() {
    $pdo = getDB();
    $stmt = $pdo->query("SELECT * FROM categories WHERE status = 'active' ORDER BY category_name");
    return $stmt->fetchAll();
}

// Get all suppliers
function getAllSuppliers() {
    $pdo = getDB();
    $stmt = $pdo->query("SELECT * FROM suppliers WHERE status = 'active' ORDER BY company_name");
    return $stmt->fetchAll();
}

// Get all customers
function getAllCustomers() {
    $pdo = getDB();
    $stmt = $pdo->query("SELECT * FROM customers WHERE status = 'active' ORDER BY name");
    return $stmt->fetchAll();
}

// Get all sales
function getAllSales() {
    $pdo = getDB();
    $stmt = $pdo->query("SELECT s.*, c.name as customer_name FROM sales s LEFT JOIN customers c ON s.customer_id = c.id ORDER BY s.id DESC LIMIT 50");
    return $stmt->fetchAll();
}

// Get sales statistics
function getSalesStats() {
    $pdo = getDB();
    $stats = [];
    
    // Today's sales
    $stmt = $pdo->query("SELECT COALESCE(SUM(total_amount), 0) as total FROM sales WHERE DATE(sale_date) = CURDATE()");
    $stats['today'] = $stmt->fetch()['total'];
    
    // This week
    $stmt = $pdo->query("SELECT COALESCE(SUM(total_amount), 0) as total FROM sales WHERE YEARWEEK(sale_date) = YEARWEEK(CURDATE())");
    $stats['week'] = $stmt->fetch()['total'];
    
    // This month
    $stmt = $pdo->query("SELECT COALESCE(SUM(total_amount), 0) as total FROM sales WHERE MONTH(sale_date) = MONTH(CURDATE()) AND YEAR(sale_date) = YEAR(CURDATE())");
    $stats['month'] = $stmt->fetch()['total'];
    
    // Pending invoices
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM sales WHERE payment_status = 'pending'");
    $stats['pending'] = $stmt->fetch()['count'];
    
    return $stats;
}

// Get recent sales HTML
function getRecentSalesHTML() {
    $pdo = getDB();
    $stmt = $pdo->query("SELECT s.*, c.name as customer_name FROM sales s LEFT JOIN customers c ON s.customer_id = c.id ORDER BY s.id DESC LIMIT 5");
    $sales = $stmt->fetchAll();
    
    $html = '';
    foreach($sales as $sale) {
        $status_class = $sale['payment_status'] == 'paid' ? 'status-paid' : 'status-pending';
        $html .= '<tr>';
        $html .= '<td>Invoice #' . $sale['invoice_no'] . '</td>';
        $html .= '<td>' . ($sale['customer_name'] ?? 'Walk-in') . '</td>';
        $html .= '<td>TSh ' . number_format($sale['total_amount']) . '</td>';
        $html .= '<td><span class="status-badge ' . $status_class . '">' . ucfirst($sale['payment_status']) . '</span></td>';
        $html .= '<td>' . date('H:i', strtotime($sale['sale_date'])) . '</td>';
        $html .= '</tr>';
    }
    return $html;
}

// Get product icon based on category
function getProductIcon($category_id) {
    $icons = [
        1 => 'mouse',
        2 => 'keyboard',
        3 => 'headphones',
        4 => 'plug',
        5 => 'hdd',
        6 => 'video',
        7 => 'laptop',
        8 => 'wifi',
        9 => 'code',
        10 => 'print'
    ];
    return $icons[$category_id] ?? 'box';
}

// Add product function
function addProduct($data, $files) {
    $pdo = getDB();
    
    try {
        // Handle image upload
        $image_path = '';
        if(isset($files['product_image']) && $files['product_image']['error'] == 0) {
            $allowed = ['jpg', 'jpeg', 'png', 'gif'];
            $filename = $files['product_image']['name'];
            $ext = strtolower(pathinfo($filename, PATHINFO_EXTENSION));
            
            if(in_array($ext, $allowed)) {
                $new_filename = uniqid() . '.' . $ext;
                $upload_path = '../uploads/products/' . $new_filename;
                
                if(move_uploaded_file($files['product_image']['tmp_name'], $upload_path)) {
                    $image_path = 'products/' . $new_filename;
                }
            }
        }
        
        // Insert product
        $stmt = $pdo->prepare("INSERT INTO products (product_code, product_name, category_id, supplier_id, buying_price, selling_price, quantity, low_stock_threshold, brand, model, description, image_path, warranty_period) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        
        $stmt->execute([
            $data['product_code'],
            $data['product_name'],
            $data['category_id'],
            $data['supplier_id'] ?: null,
            $data['buying_price'],
            $data['selling_price'],
            $data['quantity'],
            $data['low_stock_threshold'] ?? 5,
            $data['brand'] ?? null,
            $data['model'] ?? null,
            $data['description'] ?? null,
            $image_path,
            $data['warranty_period'] ?? 0
        ]);
        
        return ['success' => true, 'message' => 'Product added successfully'];
    } catch(Exception $e) {
        return ['success' => false, 'message' => $e->getMessage()];
    }
}

// Process sale
function processSale($data) {
    $pdo = getDB();
    
    try {
        $pdo->beginTransaction();
        
        // Generate invoice number
        $stmt = $pdo->query("SELECT COUNT(*) as count FROM sales WHERE DATE(created_at) = CURDATE()");
        $count = $stmt->fetch()['count'] + 1;
        $invoice_no = 'INV-' . date('Ymd') . '-' . str_pad($count, 3, '0', STR_PAD_LEFT);
        
        // Calculate totals
        $subtotal = 0;
        foreach($data['items'] as $item) {
            $subtotal += $item['price'] * $item['quantity'];
        }
        $tax = $subtotal * 0.18;
        $total = $subtotal + $tax;
        
        // Insert sale
        $stmt = $pdo->prepare("INSERT INTO sales (invoice_no, customer_id, user_id, subtotal, tax_amount, total_amount, payment_method, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->execute([
            $invoice_no,
            $data['customer_id'] ?: null,
            $_SESSION['user_id'],
            $subtotal,
            $tax,
            $total,
            $data['payment_method'],
            'paid'
        ]);
        
        $sale_id = $pdo->lastInsertId();
        
        // Insert sale items and update stock
        foreach($data['items'] as $item) {
            // Insert sale item
            $stmt = $pdo->prepare("INSERT INTO sale_items (sale_id, product_id, quantity, unit_price, total_price) VALUES (?, ?, ?, ?, ?)");
            $stmt->execute([
                $sale_id,
                $item['id'],
                $item['quantity'],
                $item['price'],
                $item['price'] * $item['quantity']
            ]);
            
            // Update product stock
            $stmt = $pdo->prepare("UPDATE products SET quantity = quantity - ? WHERE id = ?");
            $stmt->execute([$item['quantity'], $item['id']]);
            
            // Record stock movement
            $stmt = $pdo->prepare("INSERT INTO stock_movements (product_id, movement_type, quantity, reference_type, reference_id) VALUES (?, 'sale', ?, 'sale', ?)");
            $stmt->execute([$item['id'], -$item['quantity'], $sale_id]);
        }
        
        $pdo->commit();
        return ['success' => true, 'sale_id' => $sale_id, 'invoice_no' => $invoice_no];
    } catch(Exception $e) {
        $pdo->rollBack();
        return ['success' => false, 'message' => $e->getMessage()];
    }
}
?>