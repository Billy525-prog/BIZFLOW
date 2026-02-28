<?php
// includes/process-sale.php
session_start();
if(!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
    exit();
}

require_once 'db_connect.php';
require_once 'functions.php';

// Get JSON input
$input = json_decode(file_get_contents('php://input'), true);

if(!$input) {
    echo json_encode(['success' => false, 'message' => 'Invalid input']);
    exit();
}

$result = processSale($input);
echo json_encode($result);
?>