<?php
// includes/login-process.php
session_start();
require_once 'db_connect.php';

if(isset($_POST['login'])) {
    $email = $_POST['email'];
    $password = $_POST['password'];
    
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch();
    
    if($user && password_verify($password, $user['password'])) {
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['user_name'] = $user['fullname'];
        $_SESSION['user_role'] = $user['role'];
        
        if(isset($_POST['remember'])) {
            setcookie('user_email', $email, time() + (86400 * 30), "/");
        }
        
        header("Location: ../pages/dashboard.php");
        exit();
    } else {
        header("Location: ../index.php?error=Invalid email or password");
        exit();
    }
}
?>