<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Logactivos extends Model
{
    use HasFactory;

    public $timestamps = false;
    protected $primaryKey= 'id_loga';
    protected $fillable =['id_activo', 'activo', 'serial', 'usuario', 'accion','tablaafectada','fecha' ];

}
