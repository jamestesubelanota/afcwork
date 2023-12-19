<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use App\Models\Logmovimientos;
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


    public static function boot(){
        parent::boot();
        static::created(function($movimiento) {

            Logmovimientos::create([
                'id_cabecera' => $movimiento->id_cabecera,
                'id_cliente' => $movimiento->id_cliente,
                'id_sede' => $movimiento->id_sede,
                'usuario' => Auth::user()->name,
                'detalle' => $movimiento->detalle,
                'accion'=> 'insert',
                'id_tmovimiento'  => $movimiento->id_tmovimiento

            ]);
        });


        static::updated(function($movimiento) {

            Logmovimientos::create([


            ]);
        });
        static::deleted(function($movimiento) {

            Logmovimientos::create([

            ]);
        });


    }

}
