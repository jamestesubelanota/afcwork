<?php

namespace App\Http\Controllers;

use App\Models\Colaboradores;
use App\Models\Roles;
use Illuminate\Http\Request;

class ColaboradoresController extends Controller
{
    public function index(){


        return view('colaboradores.index', ['colaboradores' => Colaboradores::latest()->paginate()]);
    }

    public function create(Colaboradores $colaboradores){

          $roles = Roles::all();

        return view('colaboradores.create', [ 'colaboradores' =>$colaboradores , 'roles'=> $roles

        ]);
    }

    public function store( Request $request  ){

        $colaboradores = new Colaboradores();

        $request->validate([
            'nombre' => 'required',
            'identificacion' => 'required',
            'telefono' => 'required',
            'id_rol' => 'required',
        ]);
        $colaboradores->nombre_colaborador = $request->nombre;
        $colaboradores->identificacion = $request->identificacion;
        $colaboradores->telefono = $request->telefono;
        $colaboradores->id_rol = $request->rol;
        $colaboradores->save();
           
        return redirect()->route('colaboradores.index');
    }

    public function edit( $colaboradores ){
         $colaborador = Colaboradores::find( $colaboradores);
        $roles = Roles::all();
        return view('colaboradores.edit' , ['colaboradores' => $colaborador , 'roles' => $roles ]);
    }

    public function update(  Request $request  , $colaboradores  ){
        $colaborador = Colaboradores::find( $colaboradores);
        $colaborador->nombre_colaborador = $request->nombre;
        $colaborador->identificacion = $request->identificacion;
        $colaborador->telefono = $request->telefono;
        $colaborador->id_rol = $request->rol;
        $colaborador->save();
       return redirect()->route('colaboradores.index');
   }

   public function destroy($colaboradores){

      $colaborador = Colaboradores::find($colaboradores);
       $colaborador->delete();
       return back(); 
   }
}


