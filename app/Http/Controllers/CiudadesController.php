<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Ciudades;
use App\Models\Departamentos;

class CiudadesController extends Controller
{


    public function __construct()
    {
        $this->middleware('can:ciudades.index');
    }
    public function index(){


        return view('ciudades.index', [ 'ciudad' =>  Ciudades::all()]);
    }

    //metodo de crear es pasarle nuestra ciudad  basia
    public function create( Ciudades $ciudad ){
        $departamento =  Departamentos::all();
        return view('ciudades.create' ,[ 'ciudad' => $ciudad , 'departamento' =>  $departamento]);
     }
    // el meotod store es elm metodo de crear en laravel y le pasamos lo que viene de los imput con el metodo reque
    public function store( Request $request){

        //
        $departamento =  Departamentos::all();
        $ciudad = new Ciudades();
        $request->validate([

                    'cod_dane' => 'required',
                    'departamento' => 'required',
                    'nombre_ciudad' => 'required | unique:ciudades,nombre_ciudad',


        ]);
        $ciudad->cod_dane  =ucfirst(strtolower($request->cod_dane));
        $ciudad->id_departamento  =ucfirst(strtolower($request->departamento));
        $ciudad->nombre_ciudad = ucfirst(strtolower($request->nombre_ciudad ));
        $ciudad->save();

       return redirect()->route('ciudades.index', ['departamento' =>  $departamento]);
    }

    //metodo para actualizar
    //metodo edit paramos a la ciudad  que queremos editar
     public function edit(  $ciudad ){
        $departamento =  Departamentos::all();
        $ciudad = Ciudades::find($ciudad);
        return view('ciudades.edit' ,[ 'ciudad' => $ciudad, 'departamento' =>  $departamento]);
     }

     public function update(Request $request,  $ciudad)

        {
            $ciudad = Ciudades::find($ciudad);
            $request->validate([
                'cod_dane' => 'required',
                'departamento' => 'required',
                'nombre_ciudad' => 'required '


    ]);
            $ciudad->cod_dane  =ucfirst(strtolower($request->cod_dane));
            $ciudad->id_departamento   = $request->departamento;
            $ciudad->nombre_ciudad = $request->nombre_ciudad ;
            $ciudad->save();

        return  redirect()->route('ciudades.index', $ciudad );
        }

        //metodo eliminar
        public function destroy($ciudad){
            $ciudad = Ciudades::find($ciudad);
             $ciudad->delete();
             return back();


        }

}
