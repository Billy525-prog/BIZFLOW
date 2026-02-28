<?php
// includes/register-process.php
session_start();
require_once 'db_connect.php';

if(isset($_POST['register'])) {
    $fullname = $_POST['fullname'];
    $email = $_POST['email'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
    $shop_name = $_POST['shop_name'];
    $phone = $_POST['phone'] ?? '';
    
    // Check if email exists
    $stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
    $stmt->execute([$email]);
    if($stmt->fetch()) {
        header("Location: ../index.php?error=Email already exists");
        exit();
    }
    
    // Insert user
    $stmt = $pdo->prepare("INSERT INTO users (fullname, email, password, shop_name, phone, role) VALUES (?, ?, ?, ?, ?, 'admin')");
    
    if($stmt->execute([$fullname, $email, $password, $shop_name, $phone])) {
        $_SESSION['user_id'] = $pdo->lastInsertId();
        $_SESSION['user_name'] = $fullname;
        $_SESSION['user_role'] = 'admin';
        
        header("Location: ../pages/dashboard.php");
        exit();
    } else {
        header("Location: ../index.php?error=Registration failed");
        exit();
    }
}
?>