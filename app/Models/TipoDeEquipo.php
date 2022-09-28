<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoDeEquipo extends Model
{
    use HasFactory;
    protected $primaryKey = "id_equipo";
    protected $fillable = 
    [  'tipo_de_equipo',
       
    ];
 }