<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Logclientes;
use Illuminate\Support\Facades\Auth;

class Clientes extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_cliente';
        protected $fillable =  ['id_cliente','nombre_cliente', 'nit', 'razon_social', 'detalle','id_colaborador'] ;

        public  function cliente(){

            return $this->belongsTo(Sede::class, "id_cliente");
        }
        public  function colaborador(){

            return $this->belongsTo(Colaboradores::class, "id_colaborador");
        }


        protected static function boot() {
            parent::boot();


            static::created(function($cliente) {
                // Registrar en el log la creación de clientes
                Logclientes::create([
                    'id_cliente' => $cliente->id_cliente,
                    'nombre_cliente' =>$cliente->nombre_cliente,
                    'usuario' => Auth::user()->name,
                    'accion' => 'insert'



                ]);
            });

            static::updated(function($cliente) {
                // Registrar en el log la creación de clientes
                Logclientes::create([

                    'id_cliente' => $cliente->id_cliente,
                    'nombre_cliente' =>$cliente->nombre_cliente,
                    'usuario' => Auth::user()->name,
                    'accion' => 'update'


                ]);
            });
            static::deleted(function($cliente) {
                // Registrar en el log la creación de equipo
                Logclientes::create([
                    'id_cliente' => $cliente->id_cliente,
                    'nombre_cliente' =>$cliente->nombre_cliente,
                    'usuario' => Auth::user()->name,
                    'accion' => 'delete'


                ]);
            });


        }
    }


