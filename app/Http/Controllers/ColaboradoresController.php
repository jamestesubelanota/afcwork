<?php

namespace App\Http\Controllers;

use App\Models\Colaboradores;
use App\Models\Roles;
use Illuminate\Http\Request;

class ColaboradoresController extends Controller
{
    public function __construct()
    {
        $this->middleware('can:colaboradores.index');
    }
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
            'cargo' => 'required'
           
        ]);
        $colaboradores->nombre_colaborador = $request->nombre;
        $colaboradores->identificacion = $request->identificacion;
        $colaboradores->telefono = $request->telefono;
        $colaboradores->cargo = $request->cargo;
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
        $request->validate([
            'nombre' => 'required',
            'identificacion' => 'required',
            'telefono' => 'required',
            'cargo' => 'required',
        ]);
        $colaborador->nombre_colaborador = $request->nombre;
        $colaborador->identificacion = $request->identificacion;
        $colaborador->telefono = $request->telefono;
        $colaboradores->cargo = $request->cargo;
        $colaborador->save();
       return redirect()->route('colaboradores.index');
   }

   public function destroy($colaboradores){

      $colaborador = Colaboradores::find($colaboradores);
       $colaborador->delete();
       return back(); 
   }
}


