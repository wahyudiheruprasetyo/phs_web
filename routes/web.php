<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Frontend\HomeController;
use Illuminate\Http\Request;

Route::get('/', [HomeController::class, 'index'])->name('home');
Route::get('/about', [HomeController::class, 'about'])->name('about');
Route::get('/contact', function () {
    return view('frontend.contact');
})->name('contact');

// Contact form submission
Route::post('/contact', function (Request $request) {
    $request->validate([
        'name' => 'required|string|max:255',
        'email' => 'required|email|max:255',
        'subject' => 'required|string|max:255',
        'message' => 'required|string|min:10',
    ]);

    // Simpan ke database (nanti bisa dibuat model ContactMessage)
    // Untuk sementara, hanya redirect dengan success message
    return redirect()->route('contact')
        ->with('success', 'Thank you for contacting us! We will get back to you soon.');
})->name('contact.submit');

// Admin routes
Route::middleware(['auth'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/dashboard', function () {
        return view('admin.dashboard');
    })->name('dashboard');
});