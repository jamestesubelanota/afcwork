<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Spatie\Permission\Contracts\Role as ContractsRole;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Auth;
use App\Models\Logcolaboradores;


class Colaboradores extends Model
{
    use HasFactory;

    protected $primaryKey = "id_colaborador";
    protected $fillable =['nombre_colaborador', 'identificacion', 'telefono', 'id_cargo'];


    public function cargos(){
        return $this->belongsTo( Cargo::class, 'id_cargo');
    }


    public static function boot(){
        parent::boot();
        static::created(function($colaborador) {

            Logcolaboradores::create([
             'id_colaborador' => $colaborador->id_colaborador,
             'nombre_colaborador'=> $colaborador->nombre_colaborador,
             'identificacion'=> $colaborador->identificacion,
             'telefono' => $colaborador->telefono,
             'id_cargo' => $colaborador->id_cargo,
             'usuario'=>  Auth::user()->name,
             'accion' => 'insert'


            ]);
        });


        static::updated(function($colaborador) {

            Logcolaboradores::create([

                'id_colaborador' => $colaborador->id_colaborador,
                'nombre_colaborador'=> $colaborador->nombre_colaborador,
                'identificacion'=> $colaborador->identificacion,
                'telefono' => $colaborador->telefono,
                'id_cargo' => $colaborador->id_cargo,
                'usuario'=>  Auth::user()->name,
                'accion' => 'update'
            ]);
        });
        static::deleted(function($colaborador) {

            Logcolaboradores::create([
                'id_colaborador' => $colaborador->id_colaborador,
                'nombre_colaborador'=> $colaborador->nombre_colaborador,
                'identificacion'=> $colaborador->identificacion,
                'telefono' => $colaborador->telefono,
                'id_cargo' => $colaborador->id_cargo,
                'usuario'=>  Auth::user()->name,
                'accion' => 'delete'

            ]);
        });


    }

}
