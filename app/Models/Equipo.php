<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Equipo extends Model
{

   
    use HasFactory;

    protected $primaryKey = 'id_equipo';
    protected $fillable =['equipo'];
}
