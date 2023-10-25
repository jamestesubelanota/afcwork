<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetalleMovimiento extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_detalle';
    protected $fillable = ['id_activo','id_cabecera', 'inicio', 'fin', 'detalless'];


    public  function activo(){

        return $this->belongsTo(Activo::class, "id_activo");
    }
    public  function cabecera(){

        return $this->belongsTo(CabeceraMovimiento::class, "id_cabecera");

    }
   
}
