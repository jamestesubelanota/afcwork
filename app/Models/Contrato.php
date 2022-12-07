<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Contrato extends Model
{
    use HasFactory;

    protected  $primaryKey= 'id_contrato';
    protected $fillable =
     [
          'tipo_de_contrato',
          'inicio',
          'fin',
          'estado',
          'id_cliente'
    ];
   
   
           public  function clientes()
        {

            return $this->belongsTo(Clientes::class, 'id_cliente');
        }
}
