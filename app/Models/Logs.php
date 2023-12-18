<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Logs extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $primaryKey= 'id';
    protected $fillable =['tabla_afectada', 'id_equipo', 'accion', 'usuario', 'fecha'];

}
