<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Logcolaboradores extends Model
{
    public $timestamps = false;
    protected $primaryKey= 'id_log';
    protected $fillable =['id_colaborador', 'nombre_colaborador', 'identificacion', 'telefono', 'id_cargo', 'usuario', 'accion'];

}
