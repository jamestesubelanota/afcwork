<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Propietarios extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_propietario';
    protected $fillable = ['nombre_propietario', 'razon_social', 'numero_telefono'];
}
