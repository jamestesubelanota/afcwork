<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Ciudades;

class CiudadesController extends Controller
{
   
    public function index(){


        return view('ciudades.index', [ 'ciudad' =>  Ciudades::latest()->paginate()]);
    }

    //metodo de crear es pasarle nuestra ciudad  basia 
    public function create( Ciudades $ciudad ){

        return view('ciudades.create' ,[ 'ciudad' => $ciudad]);
     }
    // el meotod store es elm metodo de crear en laravel y le pasamos lo que viene de los imput con el metodo reque
    public function store( Request $request){

        //
        $ciudad = new Ciudades();
        $ciudad->departamento  = $request->departamento;
        $ciudad->nombre_ciudad = $request->nombre_ciudad ;
        $ciudad->save();

       return redirect()->route('ciudades.index', []);
    }

    //metodo para actualizar 
    //metodo edit paramos a la ciudad  que queremos editar 
     public function edit(  $ciudad ){
        $ciudad = Ciudades::find($ciudad);
        return view('ciudades.edit' ,[ 'ciudad' => $ciudad]);
     }

     public function update(Request $request,  $ciudad)
    
        {
            $ciudad = Ciudades::find($ciudad);
            $ciudad->departamento  = $request->departamento;
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
