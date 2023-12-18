<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Logclientes extends Model
{
    use HasFactory;

    public $timestamps = false;
    protected $primaryKey= 'id_log';
    protected $fillable =['id_cliente', 'nombre_cliente', 'usuario', 'accion', 'fecha' ];

}
