<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Logmovimientos extends Model
{
    use HasFactory;

    public $timestamps = false;
    protected $primaryKey= 'id_log';
    protected $fillable =['id_cabecera', 'id_cliente', 'id_sede', 'usuario', 'detalle', 'fecha', 'accion', 'id_tmovimiento'];

}
