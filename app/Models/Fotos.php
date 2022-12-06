<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Fotos extends Model
{
    use HasFactory;
   protected $primaryKey= 'id_foto';
   protected $fillable =['foto', 'id_activo', 'created_at'];

   public  function activos(){

    return $this->belongsTo(Activos::class, 'id_activo');
}
    
}
