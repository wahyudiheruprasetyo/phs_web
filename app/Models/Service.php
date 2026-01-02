<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Service extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'service_detail';
    protected $primaryKey = 'id';

    protected $fillable = [
        'id_service_FK',
        'title',
        'description',
        'path_image',
        'created_at',
        'updated_at',
        'deleted_at',
        'video_link'
    ];

    protected $dates = ['created_at', 'updated_at', 'deleted_at'];

    protected $appends = ['image_url'];

    public function getImageUrlAttribute()
    {
        if ($this->path_image) {
            return asset('storage/' . $this->path_image);
        }
        return asset('assets/images/default-service.jpg');
    }
}