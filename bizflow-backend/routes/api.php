<?php
Route::get('/products',[ProductController::class,'index']);
Route::post('/products',[ProductController::class,'store']);
?>