<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Certificate extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'certificate';
    protected $primaryKey = 'id';

    protected $fillable = [
        'judul',
        'path',
        'created_at',
        'updated_at',
        'deleted_at'
    ];

    protected $dates = ['created_at', 'updated_at', 'deleted_at'];

    protected $appends = ['certificate_url'];

    public function getCertificateUrlAttribute()
    {
        if ($this->path) {
            return asset('storage/' . $this->path);
        }
        return asset('assets/images/default-certificate.png');
    }
}