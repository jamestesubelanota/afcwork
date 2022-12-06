<?php

namespace App\Http\Controllers;

use App\Models\Ciudades;
use App\Models\Clientes;
use App\Models\Sede;
use Illuminate\Http\Request;

class SedeController extends Controller
{
    public function index(  ){

      
         $sede = Sede::latest()->paginate();

        return view('sedes.index', ['sedes' =>$sede ]);
    }

    public function create( Sede $sede ){
        $ciudad =  Ciudades::all();
        $cliente = Clientes::all();
    
        return view('sedes.create', [ 'ciudad'=> $ciudad, 'sede' => $sede ,'cliente'=> $cliente ]);
    }

    public function store(Request $request){

            $sede = new Sede();
            $request->validate([
                'nombre_sede'=>'required',
                'direccion'=>'required',
                'contacto'=>'required',
                'telefono'=>'required',
                'ciudad_id'=>'required',
                'cliente_id'=>'required',
                'zona' =>'required']);
            $sede->nombre_sede = $request->nombre_sede;
            $sede->direccion = $request->direccion;
            $sede->contacto = $request->contacto;
            $sede->telefono = $request->telefono;
            $sede->ciudad_id = $request->ciudad_id;
            $sede->cliente_id = $request->cliente_id;
            $sede->zona = $request->zona;
            $sede->save();
        return redirect()->route('sedes.index');
    }

    public function edit( $sede){
        $sede = Sede::find($sede);
        $ciudad =  Ciudades::all();
        $cliente = Clientes::all();
        
        return view('sedes.create', [ 'sede'=> $sede , 'ciudad'=> $ciudad, 'cliente'=> $cliente ]);
    }

    public function update(Request $request, $sede){
        $sede = Sede::find($sede);
        $request->validate([
            'nombre_sede'=>'required',
            'direccion'=>'required',
            'contacto'=>'required',
            'telefono'=>'required',
            'ciudad_id'=>'required',
            'cliente_id'=>'required',
            'zona' =>'required']);
        $sede->nombre_sede = $request->nombre_sede;
        $sede->direccion = $request->direccion;
        $sede->contacto = $request->contacto;
        $sede->telefono = $request->telefono;
        $sede->ciudad_id = $request->ciudad_id;
        $sede->cliente_id = $request->cliente_id;
        $sede->zona = $request->zona;
        $sede->save();

    }


    public function destroy($sede){

      $sede = Sede::find($sede);
      $sede->delete();
      return back();


    }
}
