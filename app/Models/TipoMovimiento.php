<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoMovimiento extends Model
{
    use HasFactory;

     protected  $primaryKey = 'id_tmovimiento';
     protected $fillable = ['movimiento'];
}
