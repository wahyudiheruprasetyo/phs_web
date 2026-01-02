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

    protected $appends = ['image_url'];

    public function getImageUrlAttribute()
    {
        if ($this->path) {
            return asset('storage/' . $this->path);
        }
        return asset('assets/images/default-gallery.jpg');
    }
}