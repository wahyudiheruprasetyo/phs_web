<?php

namespace App\Http\Controllers\Frontend;

use App\Http\Controllers\Controller;
use App\Models\Blog;
use App\Models\About;
use App\Models\Buyer;
use App\Models\Certificate;
use App\Models\Gallery;
use App\Models\Service;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    public function index()
    {
        try {
            $data = [
                'about' => About::first(),
                'blogs' => Blog::with('category')
                    ->whereNull('deleted_at')
                    ->orderBy('created_at', 'desc')
                    ->limit(3)
                    ->get(),
                'buyers' => Buyer::whereNull('deleted_at')->get(),
                'certificates' => Certificate::whereNull('deleted_at')
                    ->orderBy('created_at', 'desc')
                    ->limit(6)
                    ->get(),
                'galleries' => Gallery::whereNull('deleted_at')
                    ->orderBy('created_at', 'desc')
                    ->limit(6)
                    ->get(),
                'services' => Service::whereNull('deleted_at')
                    ->orderBy('created_at', 'desc')
                    ->limit(6)
                    ->get(),
            ];

            return view('frontend.home.index', $data);
        } catch (\Exception $e) {
            // Jika ada error, tampilkan view tanpa data
            return view('frontend.home.index', [
                'about' => null,
                'blogs' => collect(),
                'buyers' => collect(),
                'certificates' => collect(),
                'galleries' => collect(),
                'services' => collect(),
            ]);
        }
    }
    public function about()
    {
        $about = About::first();
        return view('frontend.about', compact('about'));
    }
}