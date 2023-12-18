<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use App\Models\Logcontratos;

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

        protected static function boot() {
            parent::boot();
            static::created(function($contrato) {
                // Registrar en el log la creación del equipo
                Logcontratos::create([
                    'id_contrato' => $contrato->id_contrato,
                    'tipo_de_contrato'=> $contrato->tipo_de_contrato,
                    'codigo' => $contrato->codigo,
                    'id_cliente' => $contrato->id_cliente,
                    'usuario' => Auth::user()->name,
                    'accion' => 'insert '

                ]);
            });


            static::updated(function($contrato) {
                // Registrar en el log la creación del equipo
                Logcontratos::create([

                    'id_contrato' => $contrato->id_contrato,
                    'tipo_de_contrato'=> $contrato->tipo_de_contrato,
                    'codigo' => $contrato->codigo,
                    'id_cliente' => $contrato->id_cliente,
                    'usuario' => Auth::user()->name,
                    'accion' => 'update'

                ]);
            });
            static::deleted(function($contrato) {
                // Registrar en el log la creación del equipo
                Logcontratos::create([
                    'id_contrato' => $contrato->getOriginal('id_contrato'),
                    'tipo_de_contrato'=> $contrato->getOriginal('tipo_de_contrato'),
                    'codigo' => $contrato->getOriginal('codigo'),
                    'id_cliente' => $contrato-> getOriginal('id_cliente'),
                    'usuario' => Auth::user()->name,
                    'accion' => 'delete'
                ]);
            });


        }

}
