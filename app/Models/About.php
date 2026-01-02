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

    public function getImageUrlAttribute()
    {
        if ($this->path_image) {
            return asset('storage/' . $this->path_image);
        }
        return asset('assets/images/default-about.jpg');
    }
}