<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetalleMovimiento extends Model
{
    use HasFactory;

    protected $primaryKey = 'id';
    protected $fillable = ['id_activo','id_cabezera', 'inicio', 'fin', 'detalle'];


    public  function activo(){

        return $this->belongsTo(Activo::class, "id_activo");
    }
    public  function cabecera(){

        return $this->belongsTo(CabezeraMovimiento::class, "id_cabezera");
    }
}
