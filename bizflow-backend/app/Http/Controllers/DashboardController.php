<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index()
    {
        return view('dashboard',[
            'products'=>Product::count(),
            'sales'=>Sale::count(),
            "users" => User::count()
        ]);
    }
}

