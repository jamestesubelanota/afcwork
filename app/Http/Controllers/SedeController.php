<?php

namespace App\Http\Controllers;

use App\Models\Ciudades;
use App\Models\Clientes;
use App\Models\Colaboradores;
use App\Models\Sede;
use Illuminate\Http\Request;

class SedeController extends Controller
{

    public function __construct()
    {
        $this->middleware('can:sedes.index');
    }
    public function index( ){

      
         $sede = Sede::all();

        return view('sedes.index', ['sedes' =>$sede ]);
    }

    public function create( Sede $sede ){
        $ciudad =  Ciudades::all();
        $cliente = Clientes::all();
        $bacteriologo = Colaboradores::where('id_cargo', '=', 1)->get();
        $ingeniero = Colaboradores::where('id_cargo', '=', 2)->get();
        return view('sedes.create', [ 'ciudad'=> $ciudad, 'sede' => $sede ,'cliente'=> $cliente ,  'bacteriologo' =>   $bacteriologo , 'ingeniero' => $ingeniero ]);
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
            $sede->id_colaborador = $request->bat;
            $sede->id_colaborador2 = $request->ing;
            $sede->save();
        return redirect()->route('sedes.index');
    }

    public function edit( $sede){
        $sede = Sede::find($sede);
        $ciudad =  Ciudades::all();
        $cliente = Clientes::all();
        $bacteriologo = Colaboradores::where('id_rol', '=', 5)->get();
        $ingeniero = Colaboradores::where('id_rol', '=', 4)->get();
        return view('sedes.create', [ 'sede'=> $sede , 'ciudad'=> $ciudad, 'cliente'=> $cliente, 'bacteriologo' =>   $bacteriologo , 'ingeniero' => $ingeniero ]);
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
            'zona' =>'required',
        'bat'=> 'required',
         'ing' => 'ing'
    ]);
        $sede->nombre_sede = ucfirst(strtolower( $request->nombre_sede));
        $sede->direccion = ucfirst(strtolower($request->direccion));
        $sede->contacto = ucfirst(strtolower($request->contacto));
        $sede->telefono = $request->telefono;
        $sede->ciudad_id = $request->ciudad_id;
        $sede->cliente_id = $request->cliente_id;
        $sede->zona = $request->zona;
        $sede->id_colaborador = $request->bat;
        $sede->id_colaborador2 = $request->ing;
        $sede->save();

    }


    public function destroy($sede){

      $sede = Sede::find($sede);
      $sede->delete();
      return back();


    }
}
