<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Proveedores extends Model
{
    use HasFactory;

    protected $primaryKey ='id_proveedor';
    protected $fillable = ['nombre_proveedor', 'nit', 'direccion', 'Razon_social'];
}
