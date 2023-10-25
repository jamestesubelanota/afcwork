<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CabeceraMovimiento extends Model
{
    use HasFactory;

    protected $primaryKey = "id_cabecera";
    protected $fillable =  ["id_cliente", "id_sede", "id_tmovimiento"] ;

  
    public  function clientes(){

        return $this->belongsTo(clientes::class, "id_cliente");
    }
    public  function sedes(){

        return $this->belongsTo(Sede::class, "id_sede");
    }
    public  function tipoMovimiento(){

        return $this->belongsTo(TipoMovimiento::class, "id_tmovimiento");
    }
    public  function detalle(){

        return $this->belongsTo(DetalleMovimiento::class, "id_cabecera");
    }

}
