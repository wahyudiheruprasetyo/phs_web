#!/bin/bash

echo "=========================================="
echo "   PHS WEB PROJECT GENERATOR"
echo "   PT Dwi Prima Sentosa"
echo "=========================================="
echo

# Warna untuk output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fungsi untuk print status
print_status() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}! $1${NC}"
}

# ==================== KONFIGURASI ====================
PROJECT_DIR="phs_web_complete"
BACKEND_DIR="$PROJECT_DIR/backend"
PUBLIC_DIR="$BACKEND_DIR/public"
RESOURCES_DIR="$BACKEND_DIR/resources"
APP_DIR="$BACKEND_DIR/app"
DATABASE_DIR="$BACKEND_DIR/database"

print_status "Membuat struktur proyek di: $PROJECT_DIR"

# ==================== BUAT STRUKTUR FOLDER ====================
create_structure() {
    print_status "Membuat struktur folder..."
    
    # Hapus folder lama jika ada
    if [ -d "$PROJECT_DIR" ]; then
        rm -rf "$PROJECT_DIR"
    fi
    
    # Struktur utama
    mkdir -p "$PROJECT_DIR"
    mkdir -p "$BACKEND_DIR"
    
    # App structure
    mkdir -p "$APP_DIR/Http/Controllers/{Admin,Frontend,Auth,Api}"
    mkdir -p "$APP_DIR/Http/Middleware"
    mkdir -p "$APP_DIR/Models"
    mkdir -p "$APP_DIR/Services"
    mkdir -p "$APP_DIR/Helpers"
    
    # Database
    mkdir -p "$DATABASE_DIR/migrations"
    mkdir -p "$DATABASE_DIR/seeders"
    mkdir -p "$DATABASE_DIR/factories"
    
    # Resources
    mkdir -p "$RESOURCES_DIR/views/{layouts,frontend,admin,auth,components,emails}"
    mkdir -p "$RESOURCES_DIR/js"
    mkdir -p "$RESOURCES_DIR/sass"
    mkdir -p "$RESOURCES_DIR/lang/{en,id}"
    
    # Public assets
    mkdir -p "$PUBLIC_DIR/assets/{css,js,images,fonts,metronic}"
    mkdir -p "$PUBLIC_DIR/storage"
    mkdir -p "$PUBLIC_DIR/uploads"
    
    # Routes & config
    mkdir -p "$BACKEND_DIR/routes"
    mkdir -p "$BACKEND_DIR/config"
    mkdir -p "$BACKEND_DIR/bootstrap/cache"
    mkdir -p "$BACKEND_DIR/storage/{app,framework,logs}"
    mkdir -p "$BACKEND_DIR/tests"
    
    print_success "Struktur folder dibuat"
}

# ==================== BUAT FILE COMPOSER.JSON ====================
create_composer_json() {
    print_status "Membuat composer.json..."
    
    cat > "$BACKEND_DIR/composer.json" << 'EOF'
{
    "name": "phs/pt-dwi-prima-sentosa",
    "type": "project",
    "description": "Company profile website for PT Dwi Prima Sentosa - Footwear manufacturer",
    "keywords": ["footwear", "manufacturing", "company-profile", "laravel"],
    "license": "MIT",
    "require": {
        "php": "^8.2",
        "guzzlehttp/guzzle": "^7.2",
        "intervention/image": "^2.7",
        "laravel/framework": "^12.0",
        "laravel/sanctum": "^4.0",
        "laravel/tinker": "^2.8",
        "maatwebsite/excel": "^3.1",
        "spatie/laravel-backup": "^8.0",
        "yajra/laravel-datatables-oracle": "^10.0"
    },
    "require-dev": {
        "barryvdh/laravel-debugbar": "^3.9",
        "fakerphp/faker": "^1.23",
        "laravel/pint": "^1.0",
        "laravel/sail": "^1.18",
        "mockery/mockery": "^1.4.4",
        "nunomaduro/collision": "^8.0",
        "phpunit/phpunit": "^11.0"
    },
    "autoload": {
        "psr-4": {
            "App\\": "app/",
            "Database\\Factories\\": "database/factories/",
            "Database\\Seeders\\": "database/seeders/"
        },
        "files": [
            "app/Helpers/GlobalHelpers.php",
            "app/Helpers/AdminHelpers.php"
        ]
    },
    "scripts": {
        "post-autoload-dump": [
            "Illuminate\\Foundation\\ComposerScripts::postAutoloadDump",
            "@php artisan package:discover --ansi"
        ],
        "post-root-package-install": [
            "@php -r \"file_exists('.env') || copy('.env.example', '.env');\""
        ],
        "post-create-project-cmd": [
            "@php artisan key:generate --ansi"
        ]
    },
    "minimum-stability": "stable",
    "prefer-stable": true,
    "config": {
        "optimize-autoloader": true,
        "preferred-install": "dist",
        "sort-packages": true,
        "allow-plugins": {
            "php-http/discovery": true
        }
    }
}
EOF
    
    print_success "composer.json dibuat"
}

# ==================== BUAT PACKAGE.JSON (TANPA VITE) ====================
create_package_json() {
    print_status "Membuat package.json (tanpa Vite)..."
    
    cat > "$BACKEND_DIR/package.json" << 'EOF'
{
    "private": true,
    "scripts": {
        "dev": "npm run development",
        "development": "mix",
        "watch": "mix watch",
        "watch-poll": "mix watch -- --watch-options-poll=1000",
        "hot": "mix watch --hot",
        "prod": "npm run production",
        "production": "mix --production"
    },
    "devDependencies": {
        "axios": "^1.6.0",
        "bootstrap": "^5.3.0",
        "jquery": "^3.7.0",
        "laravel-mix": "^6.0.0",
        "lodash": "^4.17.21",
        "postcss": "^8.4.0",
        "postcss-import": "^15.0.0",
        "sass": "^1.62.0",
        "sass-loader": "^13.0.0"
    }
}
EOF
    
    print_success "package.json dibuat"
}

# ==================== BUAT WEBPACK.MIX.JS ====================
create_webpack_mix() {
    print_status "Membuat webpack.mix.js..."
    
    cat > "$BACKEND_DIR/webpack.mix.js" << 'EOF'
const mix = require('laravel-mix');

// Frontend Assets
mix.js('resources/js/app.js', 'public/js')
   .sass('resources/sass/app.scss', 'public/css')
   .copy('node_modules/bootstrap/dist/js/bootstrap.bundle.min.js', 'public/js/bootstrap.js')
   .copy('node_modules/jquery/dist/jquery.min.js', 'public/js/jquery.js')
   .copy('resources/images', 'public/images')
   .version();

// Admin Assets (jika terpisah)
mix.js('resources/js/admin.js', 'public/js')
   .sass('resources/sass/admin.scss', 'public/css/admin.css');
EOF
    
    print_success "webpack.mix.js dibuat"
}

# ==================== BUAT .ENV.EXAMPLE ====================
create_env_example() {
    print_status "Membuat .env.example..."
    
    cat > "$BACKEND_DIR/.env.example" << 'EOF'
APP_NAME="PHS - PT Dwi Prima Sentosa"
APP_ENV=production
APP_KEY=
APP_DEBUG=false
APP_URL=http://localhost:8000
APP_TIMEZONE=Asia/Jakarta

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=phs_db
DB_USERNAME=root
DB_PASSWORD=

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=public
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120
SESSION_ENCRYPT=false

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=
MAIL_PASSWORD=
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS="noreply@dwiprimasentosa.com"
MAIL_FROM_NAME="${APP_NAME}"

BACKUP_DISK=public
BACKUP_PATH=backups

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

MIX_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
MIX_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"
EOF
    
    print_success ".env.example dibuat"
}

# ==================== BUAT ROUTES/WEB.PHP ====================
create_routes() {
    print_status "Membuat routes..."
    
    cat > "$BACKEND_DIR/routes/web.php" << 'EOF'
<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Frontend\{
    HomeController,
    AboutController,
    BlogController,
    GalleryController,
    ContactController
};
use App\Http\Controllers\Auth\{
    LoginController,
    RegisterController
};

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

// ==================== PUBLIC ROUTES ====================
Route::get('/', [HomeController::class, 'index'])->name('home');
Route::get('/about', [AboutController::class, 'index'])->name('about');
Route::get('/blog', [BlogController::class, 'index'])->name('blog.index');
Route::get('/blog/{slug}', [BlogController::class, 'show'])->name('blog.show');
Route::get('/gallery', [GalleryController::class, 'index'])->name('gallery');
Route::get('/contact', [ContactController::class, 'index'])->name('contact');
Route::post('/contact', [ContactController::class, 'store'])->name('contact.store');

// ==================== AUTH ROUTES ====================
Route::get('/login', [LoginController::class, 'showLoginForm'])->name('login');
Route::post('/login', [LoginController::class, 'login']);
Route::post('/logout', [LoginController::class, 'logout'])->name('logout');

Route::get('/register', [RegisterController::class, 'showRegistrationForm'])->name('register');
Route::post('/register', [RegisterController::class, 'register']);

// ==================== ADMIN ROUTES ====================
Route::middleware(['auth', 'admin'])->prefix('admin')->name('admin.')->group(function () {
    // Dashboard
    Route::get('/dashboard', [\App\Http\Controllers\Admin\DashboardController::class, 'index'])->name('dashboard');
    
    // Blog Management
    Route::resource('blogs', \App\Http\Controllers\Admin\BlogController::class);
    Route::post('blogs/{id}/restore', [\App\Http\Controllers\Admin\BlogController::class, 'restore'])->name('blogs.restore');
    
    // Gallery Management
    Route::resource('gallery', \App\Http\Controllers\Admin\GalleryController::class);
    
    // Buyers Management
    Route::resource('buyers', \App\Http\Controllers\Admin\BuyerController::class);
    
    // Certificates Management
    Route::resource('certificates', \App\Http\Controllers\Admin\CertificateController::class);
    
    // Services Management
    Route::resource('services', \App\Http\Controllers\Admin\ServiceController::class);
    
    // About Page Editor
    Route::get('/about', [\App\Http\Controllers\Admin\AboutController::class, 'edit'])->name('about.edit');
    Route::put('/about', [\App\Http\Controllers\Admin\AboutController::class, 'update'])->name('about.update');
    
    // Contact Settings
    Route::get('/contact-settings', [\App\Http\Controllers\Admin\ContactController::class, 'edit'])->name('contact.edit');
    Route::put('/contact-settings', [\App\Http\Controllers\Admin\ContactController::class, 'update'])->name('contact.update');
    
    // User Management
    Route::resource('users', \App\Http\Controllers\Admin\UserController::class);
    
    // Settings
    Route::get('/settings', [\App\Http\Controllers\Admin\SettingController::class, 'index'])->name('settings');
    Route::put('/settings', [\App\Http\Controllers\Admin\SettingController::class, 'update'])->name('settings.update');
    
    // Backup
    Route::get('/backup', [\App\Http\Controllers\Admin\BackupController::class, 'index'])->name('backup.index');
    Route::post('/backup/create', [\App\Http\Controllers\Admin\BackupController::class, 'create'])->name('backup.create');
    Route::delete('/backup/{filename}', [\App\Http\Controllers\Admin\BackupController::class, 'destroy'])->name('backup.destroy');
});

// ==================== API ROUTES ====================
Route::prefix('api')->group(function () {
    Route::get('/blogs', [\App\Http\Controllers\Api\BlogController::class, 'index']);
    Route::get('/blogs/{id}', [\App\Http\Controllers\Api\BlogController::class, 'show']);
    Route::get('/gallery', [\App\Http\Controllers\Api\GalleryController::class, 'index']);
});
EOF
    
    print_success "routes/web.php dibuat"
}

# ==================== BUAT MODELS ====================
create_models() {
    print_status "Membuat models..."
    
    # Model: Blog
    cat > "$APP_DIR/Models/Blog.php" << 'EOF'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class Blog extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'blog';
    protected $primaryKey = 'id';

    protected $fillable = [
        'title',
        'id_blogcategory',
        'description',
        'note',
        'path_img',
        'pic',
        'created_at',
        'updated_at',
        'deleted_at'
    ];

    protected $dates = ['created_at', 'updated_at', 'deleted_at'];

    protected $appends = ['excerpt', 'image_url', 'published_date', 'slug'];

    /**
     * Relationship with BlogCategory
     */
    public function category()
    {
        return $this->belongsTo(BlogCategory::class, 'id_blogcategory');
    }

    /**
     * Relationship with BlogComments
     */
    public function comments()
    {
        return $this->hasMany(BlogComment::class, 'id_blog_FK');
    }

    /**
     * Get excerpt from description
     */
    public function getExcerptAttribute()
    {
        return Str::limit(strip_tags($this->description), 150);
    }

    /**
     * Get full image URL
     */
    public function getImageUrlAttribute()
    {
        if ($this->path_img) {
            return asset('storage/' . $this->path_img);
        }
        return asset('assets/images/default-blog.jpg');
    }

    /**
     * Get formatted published date
     */
    public function getPublishedDateAttribute()
    {
        return $this->created_at->format('F d, Y');
    }

    /**
     * Get slug for URL
     */
    public function getSlugAttribute()
    {
        return Str::slug($this->title) . '-' . $this->id;
    }

    /**
     * Scope for active blogs
     */
    public function scopeActive($query)
    {
        return $query->whereNull('deleted_at');
    }

    /**
     * Scope for featured blogs
     */
    public function scopeFeatured($query)
    {
        return $query->where('note', 'like', '%featured%');
    }

    /**
     * Get related blogs
     */
    public function relatedBlogs($limit = 3)
    {
        return self::where('id_blogcategory', $this->id_blogcategory)
                  ->where('id', '!=', $this->id)
                  ->active()
                  ->latest()
                  ->limit($limit)
                  ->get();
    }
}
EOF

    # Model: About
    cat > "$APP_DIR/Models/About.php" << 'EOF'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class About extends Model
{
    use HasFactory;

    protected $table = 'about';
    protected $primaryKey = 'id';

    protected $fillable = [
        'title',
        'header',
        'breadcomb1',
        'breadcomb2',
        'note',
        'description1',
        'description2',
        'visi',
        'misi',
        'filosofi',
        'value',
        'path_image',
        'created_at',
        'updated_at'
    ];

    protected $casts = [
        'created_at' => 'datetime',
        'updated_at' => 'datetime'
    ];

    public function getImageUrlAttribute()
    {
        if ($this->path_image) {
            return asset('storage/' . $this->path_image);
        }
        return asset('assets/images/default-about.jpg');
    }
}
EOF

    # Model: Gallery
    cat > "$APP_DIR/Models/Gallery.php" << 'EOF'
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Gallery extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'galery';
    protected $primaryKey = 'id';

    protected $fillable = [
        'judul',
        'path',
        'created_at',
        'updated_at',
        'deleted_at'
    ];

    protected $dates = ['created_at', 'updated_at', 'deleted_at'];

    protected $appends = ['image_url', 'thumbnail_url'];

    public function getImageUrlAttribute()
    {
        if ($this->path) {
            return asset('storage/' . $this->path);
        }
        return asset('assets/images/default-gallery.jpg');
    }

    public function getThumbnailUrlAttribute()
    {
        if ($this->path) {
            $path = str_replace('.', '-thumb.', $this->path);
            if (file_exists(storage_path('app/public/' . $path))) {
                return asset('storage/' . $path);
            }
        }
        return $this->image_url;
    }

    public function scopeActive($query)
    {
        return $query->whereNull('deleted_at');
    }
}
EOF

    print_success "Models dibuat (Blog, About, Gallery)"
}

# ==================== BUAT CONTROLLERS ====================
create_controllers() {
    print_status "Membuat controllers..."
    
    # HomeController
    cat > "$APP_DIR/Http/Controllers/Frontend/HomeController.php" << 'EOF'
<?php

namespace App\Http\Controllers\Frontend;

use App\Http\Controllers\Controller;
use App\Models\About;
use App\Models\Blog;
use App\Models\Service;
use App\Models\Buyer;
use App\Models\Certificate;
use App\Models\Gallery;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    public function index()
    {
        $data = [
            'about' => About::first(),
            'services' => Service::whereNull('deleted_at')
                ->orderBy('created_at', 'desc')
                ->limit(6)
                ->get(),
            'featured_blogs' => Blog::with('category')
                ->whereNull('deleted_at')
                ->where('note', 'like', '%featured%')
                ->orderBy('created_at', 'desc')
                ->limit(3)
                ->get(),
            'buyers' => Buyer::whereNull('deleted_at')->get(),
            'certificates' => Certificate::whereNull('deleted_at')
                ->orderBy('created_at', 'desc')
                ->limit(8)
                ->get(),
            'galleries' => Gallery::whereNull('deleted_at')
                ->orderBy('created_at', 'desc')
                ->limit(6)
                ->get(),
            'total_blogs' => Blog::whereNull('deleted_at')->count(),
            'total_gallery' => Gallery::whereNull('deleted_at')->count(),
            'total_certificates' => Certificate::whereNull('deleted_at')->count(),
        ];

        return view('frontend.home.index', $data);
    }

    public function about()
    {
        $about = About::first();
        if (!$about) {
            abort(404, 'About page not found');
        }

        return view('frontend.about.index', compact('about'));
    }

    public function contact()
    {
        return view('frontend.contact.index');
    }

    public function submitContact(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'phone' => 'nullable|string|max:20',
            'subject' => 'required|string|max:255',
            'message' => 'required|string|min:10',
            'g-recaptcha-response' => 'required|captcha'
        ]);

        // Save to database
        $contact = \App\Models\ContactMessage::create([
            'name' => $validated['name'],
            'email' => $validated['email'],
            'phone' => $validated['phone'],
            'subject' => $validated['subject'],
            'message' => $validated['message'],
            'ip_address' => $request->ip(),
            'user_agent' => $request->userAgent()
        ]);

        // Send email notification
        \Mail::to(config('mail.from.address'))->send(
            new \App\Mail\ContactFormSubmitted($contact)
        );

        return redirect()->route('contact')
            ->with('success', 'Thank you for contacting us! We will get back to you soon.');
    }
}
EOF

    # Admin DashboardController
    cat > "$APP_DIR/Http/Controllers/Admin/DashboardController.php" << 'EOF'
<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Blog;
use App\Models\Gallery;
use App\Models\User;
use App\Models\ContactMessage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function index()
    {
        $stats = [
            'total_blogs' => Blog::whereNull('deleted_at')->count(),
            'total_gallery' => Gallery::whereNull('deleted_at')->count(),
            'total_users' => User::count(),
            'unread_messages' => ContactMessage::where('read', false)->count(),
            'recent_blogs' => Blog::with('category')
                ->whereNull('deleted_at')
                ->orderBy('created_at', 'desc')
                ->limit(5)
                ->get(),
            'recent_messages' => ContactMessage::orderBy('created_at', 'desc')
                ->limit(5)
                ->get(),
        ];

        // Monthly blog statistics
        $blogStats = Blog::select(
            DB::raw('MONTH(created_at) as month'),
            DB::raw('COUNT(*) as count')
        )
        ->whereYear('created_at', date('Y'))
        ->whereNull('deleted_at')
        ->groupBy('month')
        ->orderBy('month')
        ->get()
        ->pluck('count', 'month')
        ->toArray();

        // Prepare chart data
        $months = [];
        $counts = [];
        for ($i = 1; $i <= 12; $i++) {
            $months[] = date('F', mktime(0, 0, 0, $i, 1));
            $counts[] = $blogStats[$i] ?? 0;
        }

        return view('admin.dashboard.index', compact('stats', 'months', 'counts'));
    }

    public function analytics()
    {
        // Page view statistics (you can integrate with Google Analytics or custom tracking)
        $pageViews = [
            'home' => 1250,
            'about' => 890,
            'blog' => 1560,
            'gallery' => 750,
            'contact' => 420,
        ];

        $visitorData = [
            'labels' => ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            'data' => [65, 59, 80, 81, 56, 55],
        ];

        return view('admin.dashboard.analytics', compact('pageViews', 'visitorData'));
    }

    public function settings()
    {
        return view('admin.dashboard.settings');
    }

    public function updateSettings(Request $request)
    {
        $validated = $request->validate([
            'site_name' => 'required|string|max:255',
            'site_email' => 'required|email',
            'site_phone' => 'nullable|string',
            'site_address' => 'nullable|string',
            'site_description' => 'nullable|string',
            'maintenance_mode' => 'boolean',
        ]);

        foreach ($validated as $key => $value) {
            \App\Models\Setting::updateOrCreate(
                ['key' => $key],
                ['value' => $value]
            );
        }

        return redirect()->route('admin.dashboard.settings')
            ->with('success', 'Settings updated successfully.');
    }
}
EOF

    print_success "Controllers dibuat (Home, Dashboard)"
}

# ==================== BUAT VIEWS ====================
create_views() {
    print_status "Membuat views..."
    
    # Layout: Frontend
    cat > "$RESOURCES_DIR/views/layouts/frontend.blade.php" << 'EOF'
<!DOCTYPE html>
<html lang="id" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="@yield('meta_description', 'PT Dwi Prima Sentosa - Footwear manufacturer with 23+ years experience. High quality shoe production.')">
    <meta name="keywords" content="@yield('meta_keywords', 'footwear, shoe factory, manufacturing, Indonesia, quality shoes')">
    <meta name="author" content="PT Dwi Prima Sentosa">
    
    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">
    
    <title>@yield('title', 'PT Dwi Prima Sentosa - Quality Footwear Manufacturer')</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="{{ asset('assets/images/favicon.ico') }}">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link href="{{ asset('assets/css/app.css') }}" rel="stylesheet">
    <link href="{{ asset('assets/css/custom.css') }}" rel="stylesheet">
    
    <!-- Page Specific CSS -->
    @stack('styles')
    
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        gtag('config', 'G-XXXXXXXXXX');
    </script>
</head>
<body>
    <!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-XXXXXX" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    
    <!-- Header Start -->
    <header class="header sticky-top">
        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
            <div class="container">
                <a class="navbar-brand" href="{{ route('home') }}">
                    <img src="{{ asset('assets/images/logo.png') }}" alt="PT Dwi Prima Sentosa" height="50">
                </a>
                
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link {{ request()->routeIs('home') ? 'active' : '' }}" href="{{ route('home') }}">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link {{ request()->routeIs('about') ? 'active' : '' }}" href="{{ route('about') }}">About Us</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link {{ request()->routeIs('blog.*') ? 'active' : '' }}" href="{{ route('blog.index') }}">News & Events</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link {{ request()->routeIs('gallery') ? 'active' : '' }}" href="{{ route('gallery') }}">Gallery</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link {{ request()->routeIs('contact') ? 'active' : '' }}" href="{{ route('contact') }}">Contact</a>
                        </li>
                        
                        @auth
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user-circle me-1"></i> {{ Auth::user()->name }}
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="{{ route('admin.dashboard') }}"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <form method="POST" action="{{ route('logout') }}">
                                        @csrf
                                        <button type="submit" class="dropdown-item"><i class="fas fa-sign-out-alt me-2"></i> Logout</button>
                                    </form>
                                </li>
                            </ul>
                        </li>
                        @else
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-primary ms-2" href="{{ route('login') }}">Login</a>
                        </li>
                        @endauth
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    <!-- Header End -->
    
    <!-- Main Content -->
    <main class="main-content">
        @yield('content')
    </main>
    
    <!-- Footer Start -->
    <footer class="footer bg-dark text-white py-5 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4">
                    <h5 class="mb-4">PT Dwi Prima Sentosa</h5>
                    <p>Footwear factory with more than 23 years experience in producing high quality shoes for international markets.</p>
                    <div class="social-links mt-3">
                        <a href="https://www.instagram.com/ptdwiprimasentosa/" class="text-white me-3"><i class="fab fa-instagram fa-lg"></i></a>
                        <a href="https://www.linkedin.com/company/pt-dwi-prima-sentosa/" class="text-white me-3"><i class="fab fa-linkedin fa-lg"></i></a>
                        <a href="https://www.youtube.com/@dpsngawi" class="text-white me-3"><i class="fab fa-youtube fa-lg"></i></a>
                        <a href="mailto:info@dwiprimasentosa.com" class="text-white"><i class="fas fa-envelope fa-lg"></i></a>
                    </div>
                </div>
                
                <div class="col-lg-2 col-md-6 mb-4">
                    <h5 class="mb-4">Quick Links</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="{{ route('home') }}" class="text-white-50 text-decoration-none">Home</a></li>
                        <li class="mb-2"><a href="{{ route('about') }}" class="text-white-50 text-decoration-none">About Us</a></li>
                        <li class="mb-2"><a href="{{ route('blog.index') }}" class="text-white-50 text-decoration-none">News</a></li>
                        <li class="mb-2"><a href="{{ route('gallery') }}" class="text-white-50 text-decoration-none">Gallery</a></li>
                        <li class="mb-2"><a href="{{ route('contact') }}" class="text-white-50 text-decoration-none">Contact</a></li>
                    </ul>
                </div>
                
                <div class="col-lg-3 col-md-6 mb-4">
                    <h5 class="mb-4">Our Services</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><i class="fas fa-check-circle text-primary me-2"></i> In-house Manufacturing</li>
                        <li class="mb-2"><i class="fas fa-check-circle text-primary me-2"></i> Quality Assurance</li>
                        <li class="mb-2"><i class="fas fa-check-circle text-primary me-2"></i> Custom Design</li>
                        <li class="mb-2"><i class="fas fa-check-circle text-primary me-2"></i> Bulk Production</li>
                        <li class="mb-2"><i class="fas fa-check-circle text-primary me-2"></i> Export Ready</li>
                    </ul>
                </div>
                
                <div class="col-lg-3 mb-4">
                    <h5 class="mb-4">Contact Info</h5>
                    <ul class="list-unstyled">
                        <li class="mb-3">
                            <i class="fas fa-map-marker-alt text-primary me-3"></i>
                            Cabean, Karang Tengah Prandon, Ngawi, East Java 63218
                        </li>
                        <li class="mb-3">
                            <i class="fas fa-phone text-primary me-3"></i>
                            +62 351 4477985
                        </li>
                        <li class="mb-3">
                            <i class="fas fa-envelope text-primary me-3"></i>
                            info@dwiprimasentosa.com
                        </li>
                        <li>
                            <i class="fas fa-clock text-primary me-3"></i>
                            Mon - Fri: 8:00 AM - 5:00 PM
                        </li>
                    </ul>
                </div>
            </div>
            
            <hr class="bg-white my-4">
            
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0">&copy; {{ date('Y') }} PT Dwi Prima Sentosa. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <a href="#" class="text-white-50 text-decoration-none me-3">Privacy Policy</a>
                    <a href="#" class="text-white-50 text-decoration-none">Terms of Service</a>
                </div>
            </div>
        </div>
    </footer>
    <!-- Footer End -->
    
    <!-- Back to Top Button -->
    <button onclick="topFunction()" id="backToTop" class="btn btn-primary rounded-circle" title="Go to top">
        <i class="fas fa-arrow-up"></i>
    </button>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    
    <!-- Custom JS -->
    <script src="{{ asset('assets/js/app.js') }}"></script>
    
    <!-- Back to Top Script -->
    <script>
        // Get the button
        let backToTopButton = document.getElementById("backToTop");
        
        // When the user scrolls down 20px from the top, show the button
        window.onscroll = function() {scrollFunction()};
        
        function scrollFunction() {
            if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                backToTopButton.style.display = "block";
            } else {
                backToTopButton.style.display = "none";
            }
        }
        
        // When the user clicks on the button, scroll to the top
        function topFunction() {
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
        }
    </script>
    
    <!-- Page Specific Scripts -->
    @stack('scripts')
    
    <!-- Success/Error Messages -->
    @if(session('success'))
    <script>
        $(document).ready(function() {
            showToast('Success', '{{ session('success') }}', 'success');
        });
    </script>
    @endif
    
    @if(session('error'))
    <script>
        $(document).ready(function() {
            showToast('Error', '{{ session('error') }}', 'error');
        });
    </script>
    @endif
</body>
</html>
EOF

    # Homepage View
    cat > "$RESOURCES_DIR/views/frontend/home/index.blade.php" << 'EOF'
@extends('layouts.frontend')

@section('title', 'Home - PT Dwi Prima Sentosa')

@section('meta_description', 'PT Dwi Prima Sentosa - Footwear manufacturer with 23+ years experience. High quality shoe production in Indonesia.')
@section('meta_keywords', 'footwear factory, shoe manufacturer, Indonesia, quality shoes, export')

@section('styles')
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.4/css/lightbox.min.css">
<style>
    .hero-section {
        background: linear-gradient(rgba(30, 64, 175, 0.9), rgba(30, 64, 175, 0.7)), url('{{ asset("assets/images/hero-bg.jpg") }}');
        background-size: cover;
        background-position: center;
        color: white;
        padding: 100px 0;
    }
    .stat-number {
        font-size: 2.5rem;
        font-weight: bold;
        color: #1E40AF;
    }
    .service-card {
        transition: transform 0.3s ease;
        border: none;
        box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    }
    .service-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 15px 30px rgba(0,0,0,0.15);
    }
    .partner-logo img {
        transition: all 0.3s ease;
    }
    .partner-logo:hover img {
        filter: grayscale(0);
        opacity: 1;
        transform: scale(1.05);
    }
    .certificate-item {
        padding: 15px;
        background: white;
        border-radius: 10px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
    }
    .certificate-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.15);
    }
    .back-to-top {
        position: fixed;
        bottom: 30px;
        right: 30px;
        z-index: 1000;
        display: none;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background: #1E40AF;
        color: white;
        border: none;
        font-size: 20px;
    }
</style>
@endsection

@section('content')
<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <h1 class="display-4 fw-bold mb-4">Footwear Factory With More Than 23 Years Experience</h1>
                <p class="lead mb-4">PT Dwi Prima Sentosa is a leading footwear manufacturer in Indonesia, producing high-quality shoes for international brands with precision and excellence.</p>
                <div class="d-flex flex-wrap gap-3">
                    <a href="{{ route('about') }}" class="btn btn-light btn-lg px-4">Learn More</a>
                    <a href="{{ route('contact') }}" class="btn btn-outline-light btn-lg px-4">Contact Us</a>
                    <a href="#certificates" class="btn btn-outline-light btn-lg px-4">Our Certificates</a>
                </div>
            </div>
            <div class="col-lg-6 text-center">
                <img src="{{ asset('assets/images/factory-illustration.png') }}" alt="Factory Illustration" class="img-fluid" style="max-height: 400px;">
            </div>
        </div>
    </div>
</section>

<!-- Statistics Section -->
<section class="py-5">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-3 col-6 text-center">
                <div class="stat-number">{{ $total_blogs ?? 0 }}+</div>
                <p class="text-muted">News & Events</p>
            </div>
            <div class="col-md-3 col-6 text-center">
                <div class="stat-number">{{ $total_gallery ?? 0 }}+</div>
                <p class="text-muted">Gallery Photos</p>
            </div>
            <div class="col-md-3 col-6 text-center">
                <div class="stat-number">{{ $total_certificates ?? 0 }}+</div>
                <p class="text-muted">Certificates</p>
            </div>
            <div class="col-md-3 col-6 text-center">
                <div class="stat-number">23+</div>
                <p class="text-muted">Years Experience</p>
            </div>
        </div>
    </div>
</section>

<!-- About Preview -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <h2 class="mb-4">About Our Company</h2>
                <p class="lead">{{ $about->note ?? 'Leading footwear manufacturer in East Java with international standards' }}</p>
                <p>{{ Str::limit($about->description1 ?? 'Located in East Java, we are the only footwear manufacturing industry in Ngawi and Madiun with advantage in transportation logistics and highway integration.', 200) }}</p>
                <a href="{{ route('about') }}" class="btn btn-primary mt-3">Read Full Story <i class="fas fa-arrow-right ms-2"></i></a>
            </div>
            <div class="col-lg-6">
                <img src="{{ $about->image_url ?? asset('assets/images/about-preview.jpg') }}" alt="About PT Dwi Prima Sentosa" class="img-fluid rounded shadow">
            </div>
        </div>
    </div>
</section>

<!-- Services -->
<section class="py-5">
    <div class="container">
        <div class="text-center mb-5">
            <h2>Why Choose Us</h2>
            <p class="text-muted">We provide comprehensive footwear manufacturing solutions</p>
        </div>
        
        <div class="row">
            @forelse($services as $service)
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="service-card card h-100">
                    <div class="card-body p-4 text-center">
                        <div class="mb-4">
                            <img src="{{ asset('storage/' . $service->path_image) }}" alt="{{ $service->title }}" class="img-fluid rounded" style="height: 150px; object-fit: cover;">
                        </div>
                        <h5 class="card-title">{{ $service->title }}</h5>
                        <p class="card-text text-muted">{{ Str::limit($service->description, 100) }}</p>
                        @if($service->video_link)
                        <button class="btn btn-sm btn-outline-primary mt-2" data-bs-toggle="modal" data-bs-target="#videoModal{{ $service->id }}">
                            <i class="fas fa-play me-1"></i> Watch Video
                        </button>
                        @endif
                    </div>
                </div>
            </div>
            @empty
            <div class="col-12 text-center">
                <p class="text-muted">No services available at the moment.</p>
            </div>
            @endforelse
        </div>
    </div>
</section>

<!-- Featured News -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-5">
            <div>
                <h2>Latest News & Events</h2>
                <p class="text-muted">Stay updated with our company activities</p>
            </div>
            <a href="{{ route('blog.index') }}" class="btn btn-outline-primary">View All News</a>
        </div>
        
        <div class="row">
            @forelse($featured_blogs as $blog)
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card h-100 border-0 shadow-sm">
                    <div class="position-relative">
                        <img src="{{ $blog->image_url }}" class="card-img-top" alt="{{ $blog->title }}" style="height: 200px; object-fit: cover;">
                        <span class="position-absolute top-0 start-0 bg-primary text-white px-3 py-1 m-3 rounded">
                            {{ $blog->category->nama ?? 'News' }}
                        </span>
                    </div>
                    <div class="card-body">
                        <small class="text-muted"><i class="far fa-calendar me-1"></i> {{ $blog->published_date }}</small>
                        <h5 class="card-title mt-2">{{ Str::limit($blog->title, 60) }}</h5>
                        <p class="card-text">{{ $blog->excerpt }}</p>
                    </div>
                    <div class="card-footer bg-transparent border-top-0">
                        <a href="{{ route('blog.show', $blog->slug) }}" class="btn btn-sm btn-primary">Read More</a>
                        <small class="text-muted float-end"><i class="far fa-eye me-1"></i> 0</small>
                    </div>
                </div>
            </div>
            @empty
            <div class="col-12 text-center py-5">
                <i class="fas fa-newspaper fa-3x text-muted mb-3"></i>
                <h4 class="text-muted">No news available</h4>
                <p>Check back later for updates</p>
            </div>
            @endforelse
        </div>
    </div>
</section>

<!-- Partners -->
<section class="py-5">
    <div class="container">
        <div class="text-center mb-5">
            <h2>Our Trusted Partners</h2>
            <p class="text-muted">We work with reputable international brands</p>
        </div>
        
        <div class="row">
            @forelse($buyers as $buyer)
            <div class="col-6 col-md-3 col-lg-2 text-center mb-4">
                <div class="partner-logo p-3">
                    <img src="{{ asset('storage/' . $buyer->logo) }}" alt="{{ $buyer->name }}" class="img-fluid" style="height: 60px; object-fit: contain;">
                </div>
            </div>
            @empty
            <div class="col-12 text-center">
                <p class="text-muted">Partners information coming soon.</p>
            </div>
            @endforelse
        </div>
    </div>
</section>

<!-- Certificates -->
<section id="certificates" class="py-5 bg-light">
    <div class="container">
        <div class="text-center mb-5">
            <h2>Our Certifications</h2>
            <p class="text-muted">Quality assurance and international standards compliance</p>
        </div>
        
        <div class="row">
            @forelse($certificates as $certificate)
            <div class="col-md-3 col-6 mb-4">
                <div class="certificate-item text-center">
                    <a href="{{ asset('storage/' . $certificate->path) }}" data-lightbox="certificates" data-title="{{ $certificate->judul }}">
                        <img src="{{ asset('storage/' . $certificate->path) }}" alt="{{ $certificate->judul }}" class="img-fluid" style="height: 120px; object-fit: contain;">
                    </a>
                    <p class="mt-3 mb-0 small fw-bold">{{ $certificate->judul }}</p>
                </div>
            </div>
            @empty
            <div class="col-12 text-center">
                <p class="text-muted">Certificates information coming soon.</p>
            </div>
            @endforelse
        </div>
    </div>
</section>

<!-- Gallery Preview -->
<section class="py-5">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-5">
            <div>
                <h2>Our Gallery</h2>
                <p class="text-muted">Behind the scenes at our factory</p>
            </div>
            <a href="{{ route('gallery') }}" class="btn btn-outline-primary">View All Photos</a>
        </div>
        
        <div class="row">
            @forelse($galleries as $gallery)
            <div class="col-6 col-md-4 col-lg-2 mb-3">
                <a href="{{ $gallery->image_url }}" data-lightbox="gallery" data-title="{{ $gallery->judul }}">
                    <img src="{{ $gallery->thumbnail_url }}" alt="{{ $gallery->judul }}" class="img-fluid rounded" style="height: 100px; width: 100%; object-fit: cover;">
                </a>
            </div>
            @empty
            <div class="col-12 text-center">
                <p class="text-muted">Gallery photos coming soon.</p>
            </div>
            @endforelse
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="py-5 bg-primary text-white">
    <div class="container text-center">
        <h2 class="mb-4">Ready to Work With Us?</h2>
        <p class="lead mb-4">Contact us for inquiries, partnerships, or career opportunities. Our team is ready to assist you.</p>
        <div class="d-flex flex-wrap justify-content-center gap-3">
            <a href="{{ route('contact') }}" class="btn btn-light btn-lg px-5">
                <i class="fas fa-envelope me-2"></i> Send Message
            </a>
            <a href="tel:+623514477985" class="btn btn-outline-light btn-lg px-5">
                <i class="fas fa-phone me-2"></i> Call Now
            </a>
        </div>
    </div>
</section>

<!-- Video Modals for Services -->
@foreach($services as $service)
@if($service->video_link)
<div class="modal fade" id="videoModal{{ $service->id }}" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">{{ $service->title }}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="ratio ratio-16x9">
                    {!! $service->video_link !!}
                </div>
            </div>
        </div>
    </div>
</div>
@endif
@endforeach
@endsection

@section('scripts')
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.4/js/lightbox.min.js"></script>
<script>
    lightbox.option({
        'resizeDuration': 200,
        'wrapAround': true,
        'albumLabel': 'Image %1 of %2',
        'disableScrolling': true
    });
    
    // Statistics counter animation
    document.addEventListener('DOMContentLoaded', function() {
        const counters = document.querySelectorAll('.stat-number');
        const speed = 200;
        
        counters.forEach(counter => {
            const updateCount = () => {
                const target = parseInt(counter.textContent.replace('+', ''));
                const count = parseInt(counter.innerText.replace('+', ''));
                const increment = Math.ceil(target / speed);
                
                if (count < target) {
                    counter.innerText = count + increment + '+';
                    setTimeout(updateCount, 1);
                } else {
                    counter.innerText = target + '+';
                }
            };
            
            updateCount();
        });
    });
</script>
@endsection
EOF

    print_success "Views dibuat (Layout, Homepage)"
}

# ==================== BUAT MIGRATIONS ====================
create_migrations() {
    print_status "Membuat migrations..."
    
    # Migration untuk settings table
    cat > "$DATABASE_DIR/migrations/2024_01_01_000001_create_settings_table.php" << 'EOF'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('settings', function (Blueprint $table) {
            $table->id();
            $table->string('key')->unique();
            $table->text('value')->nullable();
            $table->string('type')->default('text');
            $table->string('group')->default('general');
            $table->text('description')->nullable();
            $table->integer('order')->default(0);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('settings');
    }
};
EOF

    # Migration untuk contact messages
    cat > "$DATABASE_DIR/migrations/2024_01_01_000002_create_contact_messages_table.php" << 'EOF'
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('contact_messages', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('email');
            $table->string('phone')->nullable();
            $table->string('subject');
            $table->text('message');
            $table->string('ip_address')->nullable();
            $table->text('user_agent')->nullable();
            $table->boolean('read')->default(false);
            $table->boolean('replied')->default(false);
            $table->text('admin_notes')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('contact_messages');
    }
};
EOF

    print_success "Migrations dibuat"
}

# ==================== BUAT SEEDERS ====================
create_seeders() {
    print_status "Membuat seeders..."
    
    # Database Seeder
    cat > "$DATABASE_DIR/seeders/DatabaseSeeder.php" << 'EOF'
<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->call([
            UserSeeder::class,
            AboutSeeder::class,
            BlogCategorySeeder::class,
            BlogSeeder::class,
            ServiceSeeder::class,
            BuyerSeeder::class,
            CertificateSeeder::class,
            GallerySeeder::class,
            SettingSeeder::class,
        ]);
    }
}
EOF

    # User Seeder
    cat > "$DATABASE_DIR/seeders/UserSeeder.php" << 'EOF'
<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        // Admin User
        User::create([
            'name' => 'Admin PHS',
            'email' => 'admin@phs.com',
            'password' => Hash::make('password'),
            'role' => 'admin',
            'email_verified_at' => now(),
        ]);

        // Regular User
        User::create([
            'name' => 'Test User',
            'email' => 'user@phs.com',
            'password' => Hash::make('password'),
            'role' => 'user',
            'email_verified_at' => now(),
        ]);

        // Create 10 random users
        User::factory(10)->create();
    }
}
EOF

    print_success "Seeders dibuat"
}

# ==================== BUAT HELPER FUNCTIONS ====================
create_helpers() {
    print_status "Membuat helper functions..."
    
    mkdir -p "$APP_DIR/Helpers"
    
    # Global Helpers
    cat > "$APP_DIR/Helpers/GlobalHelpers.php" << 'EOF'
<?php

if (!function_exists('getSetting')) {
    function getSetting($key, $default = null)
    {
        try {
            $setting = \App\Models\Setting::where('key', $key)->first();
            return $setting ? $setting->value : $default;
        } catch (\Exception $e) {
            return $default;
        }
    }
}

if (!function_exists('formatDate')) {
    function formatDate($date, $format = 'd M Y')
    {
        if (!$date) return '';
        return \Carbon\Carbon::parse($date)->format($format);
    }
}

if (!function_exists('formatDateTime')) {
    function formatDateTime($date, $format = 'd M Y H:i')
    {
        if (!$date) return '';
        return \Carbon\Carbon::parse($date)->format($format);
    }
}

if (!function_exists('uploadFile')) {
    function uploadFile($file, $folder = 'uploads', $disk = 'public')
    {
        if (!$file) return null;
        
        $extension = $file->getClientOriginalExtension();
        $filename = time() . '_' . uniqid() . '.' . $extension;
        $path = $file->storeAs($folder, $filename, $disk);
        
        return $path;
    }
}

if (!function_exists('deleteFile')) {
    function deleteFile($path, $disk = 'public')
    {
        if ($path && \Storage::disk($disk)->exists($path)) {
            return \Storage::disk($disk)->delete($path);
        }
        return false;
    }
}

if (!function_exists('getFileUrl')) {
    function getFileUrl($path, $disk = 'public')
    {
        if (!$path) return null;
        
        if (\Storage::disk($disk)->exists($path)) {
            return \Storage::disk($disk)->url($path);
        }
        
        return null;
    }
}

if (!function_exists('generateSlug')) {
    function generateSlug($string)
    {
        return \Illuminate\Support\Str::slug($string);
    }
}

if (!function_exists('truncateText')) {
    function truncateText($text, $length = 100, $suffix = '...')
    {
        if (strlen($text) <= $length) {
            return $text;
        }
        
        return substr($text, 0, $length) . $suffix;
    }
}

if (!function_exists('activeMenu')) {
    function activeMenu($routeName, $class = 'active')
    {
        return request()->routeIs($routeName) ? $class : '';
    }
}

if (!function_exists('isAdmin')) {
    function isAdmin()
    {
        return auth()->check() && auth()->user()->role === 'admin';
    }
}

if (!function_exists('getInitials')) {
    function getInitials($name)
    {
        $words = explode(' ', $name);
        $initials = '';
        
        foreach ($words as $word) {
            $initials .= strtoupper(substr($word, 0, 1));
        }
        
        return substr($initials, 0, 2);
    }
}

if (!function_exists('formatCurrency')) {
    function formatCurrency($amount, $currency = 'IDR')
    {
        if ($currency === 'IDR') {
            return 'Rp ' . number_format($amount, 0, ',', '.');
        }
        
        return number_format($amount, 2);
    }
}

if (!function_exists('getRandomColor')) {
    function getRandomColor()
    {
        $colors = ['primary', 'secondary', 'success', 'danger', 'warning', 'info'];
        return $colors[array_rand($colors)];
    }
}
EOF

    # Admin Helpers
    cat > "$APP_DIR/Helpers/AdminHelpers.php" << 'EOF'
<?php

if (!function_exists('adminAsset')) {
    function adminAsset($path)
    {
        return asset('assets/admin/' . ltrim($path, '/'));
    }
}

if (!function_exists('getAdminStats')) {
    function getAdminStats()
    {
        return [
            'total_users' => \App\Models\User::count(),
            'total_blogs' => \App\Models\Blog::whereNull('deleted_at')->count(),
            'total_gallery' => \App\Models\Gallery::whereNull('deleted_at')->count(),
            'unread_messages' => \App\Models\ContactMessage::where('read', false)->count(),
            'recent_activities' => \App\Models\ActivityLog::latest()->limit(10)->get(),
        ];
    }
}

if (!function_exists('getNotificationCount')) {
    function getNotificationCount()
    {
        return \App\Models\Notification::where('read', false)
            ->where('user_id', auth()->id())
            ->count();
    }
}

if (!function_exists('getSidebarMenu')) {
    function getSidebarMenu()
    {
        $menu = [
            [
                'title' => 'Dashboard',
                'icon' => 'fas fa-tachometer-alt',
                'route' => 'admin.dashboard',
                'permission' => 'view_dashboard',
            ],
            [
                'title' => 'Blog Management',
                'icon' => 'fas fa-newspaper',
                'children' => [
                    ['title' => 'All Posts', 'route' => 'admin.blogs.index'],
                    ['title' => 'Add New', 'route' => 'admin.blogs.create'],
                    ['title' => 'Categories', 'route' => 'admin.blog-categories.index'],
                ],
                'permission' => 'manage_blogs',
            ],
            [
                'title' => 'Gallery',
                'icon' => 'fas fa-images',
                'route' => 'admin.gallery.index',
                'permission' => 'manage_gallery',
            ],
            [
                'title' => 'Buyers',
                'icon' => 'fas fa-handshake',
                'route' => 'admin.buyers.index',
                'permission' => 'manage_buyers',
            ],
            [
                'title' => 'Certificates',
                'icon' => 'fas fa-certificate',
                'route' => 'admin.certificates.index',
                'permission' => 'manage_certificates',
            ],
            [
                'title' => 'Services',
                'icon' => 'fas fa-cogs',
                'route' => 'admin.services.index',
                'permission' => 'manage_services',
            ],
            [
                'title' => 'About Page',
                'icon' => 'fas fa-info-circle',
                'route' => 'admin.about.edit',
                'permission' => 'manage_about',
            ],
            [
                'title' => 'Contact Messages',
                'icon' => 'fas fa-envelope',
                'route' => 'admin.contact-messages.index',
                'badge' => \App\Models\ContactMessage::where('read', false)->count(),
                'permission' => 'view_contact_messages',
            ],
            [
                'title' => 'Users',
                'icon' => 'fas fa-users',
                'route' => 'admin.users.index',
                'permission' => 'manage_users',
            ],
            [
                'title' => 'Settings',
                'icon' => 'fas fa-cog',
                'route' => 'admin.settings',
                'permission' => 'manage_settings',
            ],
            [
                'title' => 'Backup',
                'icon' => 'fas fa-database',
                'route' => 'admin.backup.index',
                'permission' => 'manage_backup',
            ],
        ];

        // Filter menu based on permissions
        return array_filter($menu, function($item) {
            if (isset($item['permission'])) {
                return auth()->user()->can($item['permission']);
            }
            return true;
        });
    }
}

if (!function_exists('getBreadcrumbs')) {
    function getBreadcrumbs()
    {
        $routeName = request()->route()->getName();
        $breadcrumbs = [];
        
        $segments = explode('.', $routeName);
        $url = '';
        
        foreach ($segments as $segment) {
            $url .= ($url ? '.' : '') . $segment;
            $breadcrumbs[] = [
                'name' => ucfirst(str_replace('-', ' ', $segment)),
                'url' => route($url),
                'active' => $url === $routeName,
            ];
        }
        
        return $breadcrumbs;
    }
}
EOF

    print_success "Helper functions dibuat"
}

# ==================== BUAT CONFIG FILES ====================
create_configs() {
    print_status "Membuat config files..."
    
    # Config: app.php
    cat > "$BACKEND_DIR/config/app.php" << 'EOF'
<?php

return [
    'name' => env('APP_NAME', 'PHS - PT Dwi Prima Sentosa'),
    'env' => env('APP_ENV', 'production'),
    'debug' => (bool) env('APP_DEBUG', false),
    'url' => env('APP_URL', 'http://localhost'),
    'asset_url' => env('ASSET_URL'),
    'timezone' => env('APP_TIMEZONE', 'Asia/Jakarta'),
    'locale' => 'id',
    'fallback_locale' => 'en',
    'faker_locale' => 'id_ID',
    'key' => env('APP_KEY'),
    'cipher' => 'AES-256-CBC',
    'maintenance' => [
        'driver' => 'file',
    ],
    'providers' => [
        // Laravel Framework Service Providers...
        Illuminate\Auth\AuthServiceProvider::class,
        Illuminate\Broadcasting\BroadcastServiceProvider::class,
        Illuminate\Bus\BusServiceProvider::class,
        Illuminate\Cache\CacheServiceProvider::class,
        Illuminate\Foundation\Providers\ConsoleSupportServiceProvider::class,
        Illuminate\Cookie\CookieServiceProvider::class,
        Illuminate\Database\DatabaseServiceProvider::class,
        Illuminate\Encryption\EncryptionServiceProvider::class,
        Illuminate\Filesystem\FilesystemServiceProvider::class,
        Illuminate\Foundation\Providers\FoundationServiceProvider::class,
        Illuminate\Hashing\HashServiceProvider::class,
        Illuminate\Mail\MailServiceProvider::class,
        Illuminate\Notifications\NotificationServiceProvider::class,
        Illuminate\Pagination\PaginationServiceProvider::class,
        Illuminate\Pipeline\PipelineServiceProvider::class,
        Illuminate\Queue\QueueServiceProvider::class,
        Illuminate\Redis\RedisServiceProvider::class,
        Illuminate\Auth\Passwords\PasswordResetServiceProvider::class,
        Illuminate\Session\SessionServiceProvider::class,
        Illuminate\Translation\TranslationServiceProvider::class,
        Illuminate\Validation\ValidationServiceProvider::class,
        Illuminate\View\ViewServiceProvider::class,

        // Package Service Providers...
        Intervention\Image\ImageServiceProvider::class,
        Maatwebsite\Excel\ExcelServiceProvider::class,
        Spatie\Backup\BackupServiceProvider::class,
        Yajra\DataTables\DataTablesServiceProvider::class,

        // Application Service Providers...
        App\Providers\AppServiceProvider::class,
        App\Providers\AuthServiceProvider::class,
        App\Providers\BroadcastServiceProvider::class,
        App\Providers\EventServiceProvider::class,
        App\Providers\RouteServiceProvider::class,
    ],
    'aliases' => [
        'App' => Illuminate\Support\Facades\App::class,
        'Arr' => Illuminate\Support\Arr::class,
        'Artisan' => Illuminate\Support\Facades\Artisan::class,
        'Auth' => Illuminate\Support\Facades\Auth::class,
        'Blade' => Illuminate\Support\Facades\Blade::class,
        'Broadcast' => Illuminate\Support\Facades\Broadcast::class,
        'Bus' => Illuminate\Support\Facades\Bus::class,
        'Cache' => Illuminate\Support\Facades\Cache::class,
        'Config' => Illuminate\Support\Facades\Config::class,
        'Cookie' => Illuminate\Support\Facades\Cookie::class,
        'Crypt' => Illuminate\Support\Facades\Crypt::class,
        'Date' => Illuminate\Support\Facades\Date::class,
        'DB' => Illuminate\Support\Facades\DB::class,
        'Eloquent' => Illuminate\Database\Eloquent\Model::class,
        'Event' => Illuminate\Support\Facades\Event::class,
        'File' => Illuminate\Support\Facades\File::class,
        'Gate' => Illuminate\Support\Facades\Gate::class,
        'Hash' => Illuminate\Support\Facades\Hash::class,
        'Http' => Illuminate\Support\Facades\Http::class,
        'Lang' => Illuminate\Support\Facades\Lang::class,
        'Log' => Illuminate\Support\Facades\Log::class,
        'Mail' => Illuminate\Support\Facades\Mail::class,
        'Notification' => Illuminate\Support\Facades\Notification::class,
        'Password' => Illuminate\Support\Facades\Password::class,
        'Queue' => Illuminate\Support\Facades\Queue::class,
        'RateLimiter' => Illuminate\Support\Facades\RateLimiter::class,
        'Redirect' => Illuminate\Support\Facades\Redirect::class,
        'Request' => Illuminate\Support\Facades\Request::class,
        'Response' => Illuminate\Support\Facades\Response::class,
        'Route' => Illuminate\Support\Facades\Route::class,
        'Schema' => Illuminate\Support\Facades\Schema::class,
        'Session' => Illuminate\Support\Facades\Session::class,
        'Storage' => Illuminate\Support\Facades\Storage::class,
        'Str' => Illuminate\Support\Str::class,
        'URL' => Illuminate\Support\Facades\URL::class,
        'Validator' => Illuminate\Support\Facades\Validator::class,
        'View' => Illuminate\Support\Facades\View::class,
        
        // Custom Facades
        'Image' => Intervention\Image\Facades\Image::class,
        'Excel' => Maatwebsite\Excel\Facades\Excel::class,
        'DataTables' => Yajra\DataTables\Facades\DataTables::class,
    ],
];
EOF

    print_success "Config files dibuat"
}

# ==================== BUAT README DAN DOKUMENTASI ====================
create_documentation() {
    print_status "Membuat dokumentasi..."
    
    # README Project
    cat > "$PROJECT_DIR/README.md" << 'EOF'
# PHS Web - PT Dwi Prima Sentosa

![PHP Version](https://img.shields.io/badge/PHP-8.2%2B-blue)
![Laravel Version](https://img.shields.io/badge/Laravel-12-red)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Active-success)

Company profile website and management system for **PT Dwi Prima Sentosa** - Footwear manufacturer with 23+ years experience.

## ✨ Features

### 🌐 Frontend Website
- ✅ Modern responsive design with Bootstrap 5
- ✅ Homepage with company overview & statistics
- ✅ About Us page with company history
- ✅ News/Blog system with categories
- ✅ Gallery with image showcase
- ✅ Contact form with email notification
- ✅ Buyers/Partners showcase
- ✅ Certificates display
- ✅ SEO optimized
- ✅ Multi-language ready (ID/EN)

### ⚙️ Admin Panel
- ✅ Metronic 8 based admin interface
- ✅ Dashboard with analytics
- ✅ Blog Management (CRUD with WYSIWYG)
- ✅ Gallery Management (bulk upload)
- ✅ Buyer Management
- ✅ Certificate Management
- ✅ Service Management
- ✅ About Page Editor
- ✅ Contact Messages inbox
- ✅ User Management
- ✅ Settings configuration
- ✅ Database backup system

### 🔧 Technical Features
- ✅ Laravel 12 with PHP 8.4
- ✅ MySQL database with migrations
- ✅ Authentication & Authorization
- ✅ Role-based permissions
- ✅ File upload with validation
- ✅ Image optimization
- ✅ SEO friendly URLs
- ✅ Email notifications
- ✅ Activity logging
- ✅ API ready
- ✅ Docker support

## 🚀 Quick Installation

### Prerequisites
- PHP 8.2 or higher
- MySQL 8.0 or higher
- Composer 2.0 or higher
- Node.js 18 or higher
- NPM or Yarn

### Step-by-Step Installation

```bash
# 1. Clone or copy project files
git clone [repository-url] phs_web
cd phs_web

# 2. Install PHP dependencies
composer install

# 3. Install NPM dependencies
npm install

# 4. Setup environment
cp .env.example .env
php artisan key:generate

# 5. Configure database in .env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=phs_db
DB_USERNAME=root
DB_PASSWORD=your_password

# 6. Create database
mysql -u root -p -e "CREATE DATABASE phs_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# 7. Run migrations and seeders
php artisan migrate --seed

# 8. Create storage link
php artisan storage:link

# 9. Build assets
npm run build

# 10. Start development server
php artisan serve