<?php

namespace App\Http\Controllers;

use App\Models\Cargo;
use App\Models\Colaboradores;
use App\Models\Roles;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class ColaboradoresController extends Controller
{
    public function __construct()
    {
        $this->middleware('can:contratos.index');
    }
    public function index(){

        return view('colaboradores.index', ['colaboradores' => Colaboradores::all() ]);
    }

    public function create(Colaboradores $colaboradores){

          $roles = Cargo::all();

        return view('colaboradores.create', [ 'colaboradores' =>$colaboradores , 'roles'=> $roles

        ]);
    }

    public function store( Request $request  ){

        $colaboradores = new Colaboradores();

        $request->validate([
            'nombre' => 'required',
            'identificacion' => 'required',
            'telefono' => 'required',
            'cargo' => 'required'

        ]);
        $colaboradores->nombre_colaborador =  ucfirst(strtolower($request->nombre));
        $colaboradores->identificacion     = $request->identificacion;
        $colaboradores->telefono           = $request->telefono;
        $colaboradores->id_cargo              = $request->cargo;
        $colaboradores->save();

        return redirect()->route('colaboradores.index');
    }

    public function edit( $colaboradores ){


        $colaborador = Colaboradores::find($colaboradores); // Asumiendo que $colaboradores contiene el ID del colaborador que deseas encontrar

        if (!$colaborador) {
            // Manejar el caso en el que no se encuentra el colaborador
        }

        $cargo = Cargo::find($colaborador); // Supongo que el campo 'id_cargo' está en la tabla 'colaboradores'

        $roles = Cargo::all();
        return view('colaboradores.edit', ['colaboradores' => $colaborador, 'roles' => $roles, 'cargo' => $cargo]);
    }

    public function update(  Request $request  , $colaboradores  ){
        $colaboradores = Colaboradores::find( $colaboradores);
        $request->validate([
            'nombre' => 'required',
            'identificacion' => 'required',
            'telefono' => 'required',
            'cargo' => 'required'

        ]);
        $colaboradores->nombre_colaborador = $request->nombre;
        $colaboradores->identificacion = $request->identificacion;
        $colaboradores->telefono = $request->telefono;
        $colaboradores->id_cargo = $request->cargo;
        $colaboradores->save();

        return redirect()->route('colaboradores.index');
   }

   public function destroy($colaboradores){

      $colaborador = Colaboradores::find($colaboradores);
       $colaborador->delete();
       return back();
   }
}


