<?php
// pages/pos.php
session_start();
if(!isset($_SESSION['user_id'])) {
    header("Location: ../index.php");
    exit();
}
require_once '../includes/db_connect.php';
require_once '../includes/functions.php';

$products = getAllProducts();
$customers = getAllCustomers();
$categories = getAllCategories();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Point of Sale - BIZFLOW</title>
    <link rel="icon" type="image/png" href="../favicon.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .pos-container { display: flex; height: calc(100vh - 140px); gap: 20px; }
        .pos-products { flex: 2; background: white; border-radius: 12px; padding: 20px; overflow-y: auto; }
        .pos-cart { flex: 1; background: white; border-radius: 12px; padding: 20px; display: flex; flex-direction: column; }
        .pos-products-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 15px; margin-top: 20px; }
        .pos-product-card { border: 1px solid #e5e7eb; border-radius: 8px; padding: 15px; text-align: center; cursor: pointer; transition: all 0.3s; }
        .pos-product-card:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); border-color: #2563eb; }
        .pos-product-image { height: 80px; display: flex; align-items: center; justify-content: center; font-size: 40px; color: #2563eb; }
        .cart-items { flex: 1; overflow-y: auto; margin: 20px 0; }
        .cart-item { display: flex; justify-content: space-between; align-items: center; padding: 10px; border-bottom: 1px solid #e5e7eb; }
        .cart-summary { border-top: 2px solid #e5e7eb; padding-top: 15px; }
        .summary-row { display: flex; justify-content: space-between; margin-bottom: 10px; }
        .summary-row.total { font-size: 20px; font-weight: bold; color: #2563eb; }
        .payment-methods { display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px; margin: 20px 0; }
        .payment-method { padding: 10px; border: 1px solid #e5e7eb; border-radius: 8px; background: white; cursor: pointer; }
        .payment-method.active { background: #2563eb; color: white; border-color: #2563eb; }
        .category-tabs { display: flex; gap: 10px; overflow-x: auto; padding: 10px 0; }
        .category-tab { padding: 8px 16px; background: #f3f4f6; border: none; border-radius: 20px; cursor: pointer; white-space: nowrap; }
        .category-tab.active { background: #2563eb; color: white; }
    </style>
</head>
<body>
    <div class="dashboard-container active">
        <?php include '../includes/sidebar.php'; ?>

        <div class="main-content">
            <div class="top-bar">
                <div class="page-title">
                    <h2><i class="fas fa-cash-register"></i> Point of Sale</h2>
                    <p>Quick and easy sales processing</p>
                </div>
                <div class="live-datetime" id="liveDateTime"></div>
            </div>

            <div class="pos-container">
                <!-- Left Side - Products -->
                <div class="pos-products">
                    <div class="pos-search" style="margin-bottom: 15px;">
                        <i class="fas fa-search" style="position: absolute; margin: 12px 0 0 12px; color: #9ca3af;"></i>
                        <input type="text" id="posSearch" placeholder="Search product by name or scan barcode..." 
                               style="width: 100%; padding: 12px 12px 12px 40px; border: 2px solid #e5e7eb; border-radius: 8px;">
                    </div>
                    
                    <div class="category-tabs" id="categoryTabs">
                        <button class="category-tab active" onclick="filterByCategory('all')">All Products</button>
                        <?php foreach($categories as $cat): ?>
                        <button class="category-tab" onclick="filterByCategory(<?php echo $cat['id']; ?>)">
                            <?php echo htmlspecialchars($cat['category_name']); ?>
                        </button>
                        <?php endforeach; ?>
                    </div>

                    <div class="pos-products-grid" id="posProducts">
                        <?php foreach($products as $product): ?>
                        <div class="pos-product-card" data-category="<?php echo $product['category_id']; ?>" 
                             data-name="<?php echo strtolower($product['product_name']); ?>"
                             onclick='addToCart(<?php echo json_encode($product); ?>)'>
                            <div class="pos-product-image">
                                <i class="fas fa-<?php echo getProductIcon($product['category_id']); ?>"></i>
                            </div>
                            <h4 style="font-size: 14px; margin: 10px 0;"><?php echo htmlspecialchars($product['product_name']); ?></h4>
                            <p style="font-weight: bold; color: #2563eb;">TSh <?php echo number_format($product['selling_price']); ?></p>
                            <p style="font-size: 12px; color: <?php echo $product['quantity'] <= $product['low_stock_threshold'] ? '#ef4444' : '#10b981'; ?>">
                                Stock: <?php echo $product['quantity']; ?>
                            </p>
                        </div>
                        <?php endforeach; ?>
                    </div>
                </div>

                <!-- Right Side - Cart -->
                <div class="pos-cart">
                    <h3>Current Sale</h3>
                    
                    <select id="customerSelect" style="width: 100%; padding: 10px; border: 2px solid #e5e7eb; border-radius: 8px; margin: 15px 0;">
                        <option value="">Walk-in Customer</option>
                        <?php foreach($customers as $cust): ?>
                        <option value="<?php echo $cust['id']; ?>"><?php echo htmlspecialchars($cust['name']); ?></option>
                        <?php endforeach; ?>
                    </select>

                    <div class="cart-items" id="cartItems">
                        <!-- Cart items will appear here -->
                    </div>

                    <div class="cart-summary">
                        <div class="summary-row">
                            <span>Subtotal:</span>
                            <span id="subtotal">TSh 0</span>
                        </div>
                        <div class="summary-row">
                            <span>Tax (18%):</span>
                            <span id="tax">TSh 0</span>
                        </div>
                        <div class="summary-row total">
                            <span>Total:</span>
                            <span id="total">TSh 0</span>
                        </div>
                    </div>

                    <div class="payment-methods">
                        <button class="payment-method active" onclick="setPaymentMethod('cash')">
                            <i class="fas fa-money-bill"></i> Cash
                        </button>
                        <button class="payment-method" onclick="setPaymentMethod('card')">
                            <i class="fas fa-credit-card"></i> Card
                        </button>
                        <button class="payment-method" onclick="setPaymentMethod('mpesa')">
                            <i class="fas fa-mobile-alt"></i> M-Pesa
                        </button>
                        <button class="payment-method" onclick="setPaymentMethod('bank')">
                            <i class="fas fa-university"></i> Bank
                        </button>
                    </div>

                    <button class="btn btn-primary" onclick="completeSale()" style="width: 100%; margin-bottom: 10px;">
                        <i class="fas fa-check-circle"></i> Complete Sale
                    </button>
                    <button class="btn btn-secondary" onclick="holdSale()" style="width: 100%;">
                        <i class="fas fa-clock"></i> Hold for Later
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="../js/main.js"></script>
    <script>
        let cart = [];
        let paymentMethod = 'cash';

        function addToCart(product) {
            if(product.quantity <= 0) {
                alert('Product out of stock!');
                return;
            }
            
            let existing = cart.find(item => item.id === product.id);
            if(existing) {
                if(existing.quantity >= product.quantity) {
                    alert('Not enough stock available!');
                    return;
                }
                existing.quantity++;
                existing.total = existing.quantity * existing.price;
            } else {
                cart.push({
                    id: product.id,
                    name: product.product_name,
                    price: parseFloat(product.selling_price),
                    quantity: 1,
                    total: parseFloat(product.selling_price)
                });
            }
            updateCart();
        }

        function updateCart() {
            let cartHtml = '';
            let subtotal = 0;
            
            cart.forEach((item, index) => {
                subtotal += item.total;
                cartHtml += `
                    <div class="cart-item">
                        <div>
                            <strong>${item.name}</strong><br>
                            <small>TSh ${item.price.toLocaleString()} x ${item.quantity}</small>
                        </div>
                        <div>
                            <strong>TSh ${item.total.toLocaleString()}</strong>
                            <button onclick="removeFromCart(${index})" style="margin-left: 10px; color: #ef4444; border: none; background: none; cursor: pointer;">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                    </div>
                `;
            });
            
            document.getElementById('cartItems').innerHTML = cartHtml || '<p style="text-align: center; color: #9ca3af; padding: 20px;">Cart is empty</p>';
            
            let tax = subtotal * 0.18;
            let total = subtotal + tax;
            
            document.getElementById('subtotal').innerHTML = 'TSh ' + subtotal.toLocaleString();
            document.getElementById('tax').innerHTML = 'TSh ' + tax.toLocaleString();
            document.getElementById('total').innerHTML = 'TSh ' + total.toLocaleString();
        }

        function removeFromCart(index) {
            cart.splice(index, 1);
            updateCart();
        }

        function setPaymentMethod(method) {
            paymentMethod = method;
            document.querySelectorAll('.payment-method').forEach(btn => {
                btn.classList.remove('active');
            });
            event.currentTarget.classList.add('active');
        }

        function completeSale() {
            if(cart.length === 0) {
                alert('Cart is empty!');
                return;
            }
            
            let customerId = document.getElementById('customerSelect').value;
            let saleData = {
                customer_id: customerId,
                payment_method: paymentMethod,
                items: cart
            };
            
            fetch('../includes/process-sale.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(saleData)
            })
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    alert('Sale completed successfully!\nInvoice #: ' + data.invoice_no);
                    cart = [];
                    updateCart();
                    window.open('print-receipt.php?id=' + data.sale_id, '_blank');
                } else {
                    alert('Error: ' + data.message);
                }
            });
        }

        function filterByCategory(categoryId) {
            let products = document.querySelectorAll('.pos-product-card');
            products.forEach(product => {
                if(categoryId === 'all' || product.dataset.category == categoryId) {
                    product.style.display = 'block';
                } else {
                    product.style.display = 'none';
                }
            });
            
            document.querySelectorAll('.category-tab').forEach(btn => {
                btn.classList.remove('active');
            });
            event.currentTarget.classList.add('active');
        }

        document.getElementById('posSearch').addEventListener('keyup', function() {
            let search = this.value.toLowerCase();
            let products = document.querySelectorAll('.pos-product-card');
            
            products.forEach(product => {
                let name = product.dataset.name;
                if(name.includes(search)) {
                    product.style.display = 'block';
                } else {
                    product.style.display = 'none';
                }
            });
        });

        function holdSale() {
            if(cart.length === 0) {
                alert('Cart is empty!');
                return;
            }
            // Save to localStorage
            localStorage.setItem('heldSale', JSON.stringify({
                cart: cart,
                customer: document.getElementById('customerSelect').value,
                time: new Date().toLocaleString()
            }));
            alert('Sale saved. You can recall it from the held sales list.');
            cart = [];
            updateCart();
        }
    </script>
</body>
</html>