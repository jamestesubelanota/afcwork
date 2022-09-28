<?php

namespace App\Http\Controllers;

use App\Models\Activo;
use App\Models\CabezeraMovimiento;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Http\Request;

class DetalleMovimientoController extends Controller
{
    protected $primaryKey =  'id' ;
    protected $fillable= ['id', 'id_activo', 'id_cabezera', 'inicio',  'fin',  'detalle'];

   public function activo(){

    return $this->belongsTo(Activo::class, 'id_activo' );
   }

   public function cabezera(){

    return $this->belongsTo(CabezeraMovimiento::class, 'id_cabezera' );
   }
}
