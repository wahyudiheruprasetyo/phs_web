<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

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

    protected $appends = ['excerpt', 'image_url', 'published_date'];

    // ✅ TAMBAHKAN INI
    public function category()
    {
        return $this->belongsTo(BlogCategory::class, 'id_blogcategory');
    }

    public function getExcerptAttribute()
    {
        return \Str::limit(strip_tags($this->description), 150);
    }

    public function getImageUrlAttribute()
    {
        if ($this->path_img) {
            return asset('storage/' . $this->path_img);
        }
        return asset('assets/images/default-blog.jpg');
    }

    public function getPublishedDateAttribute()
    {
        return $this->created_at->format('F d, Y');
    }
}