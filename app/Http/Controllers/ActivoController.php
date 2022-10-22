<?php

namespace App\Http\Controllers;

use App\Models\Activo;
use App\Models\Clientes;
use App\Models\Estados;
use App\Models\Proveedores;
use App\Models\Sede;
use App\Models\TipoDeEquipo;
use App\Models\DetalleMovimiento;
use App\Models\Equipo;
use App\Models\Marca;
use App\Models\User;
use GuzzleHttp\Client;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ActivoController extends Controller
{
  public function index( ){

    
    return view('activos.index', ['activos' => $activos = Activo::latest()->paginate(),  ] );
  }




public function create( Request $request ,  Activo $activo){
      
    // se imboca un objeto basio 
        $equipos = Equipo::all();
        $marcas  = Marca::all();
        $proveedor          = Proveedores::all();
        $estados     =  Estados::all();
        $tipoEquipo         = TipoDeEquipo::all();
        $cliente            = Clientes::get(["nombre_cliente", "id_cliente"]);
        $sede               = Sede::where('cliente_id', $request->cliente_id)->get();
        
                                 if (count( $sede) > 0) 
                                 {
                                         return response()->json( $sede);
                                 }
        $user = User::all();


// retorna la vista
    return view('activos.create', 
                   ['activo' =>$activo,
                   'equipos' => $equipos ,
                   'marcas' =>$marcas,
                    'proveedor'      =>  $proveedor,
                    'estados'  =>  $estados  ,
                    'tipoEquipo'     => $tipoEquipo,
                    'cliente'        => $cliente  ,
                    'sede'  => $sede, 
                   
                    'user'           =>$user
                    ]);
}




public function store(Request $request){


      $activo = new Activo();
      if($request->hasFile('foto')){
         $file = $request->file('foto');
         $detinoPhat = 'fotos/';
         $filename= time() . '-' . $file->getClientOriginalName(); 
         $uploadSuccess = $request->file('foto')->move(  $detinoPhat,  $filename );
         $activo->foto =    $detinoPhat .  $filename ;
      }
      
      if($request->hasFile('foto2')){
        $file2 = $request->file('foto2');
        $detinoPhat2 = 'fotos/';
        $filename2= time() . '-' . $file2->getClientOriginalName(); 
        $uploadSuccess2 = $request->file('foto2')->move(  $detinoPhat2,  $filename2 );
        $activo->foto2 =    $detinoPhat2 .  $filename2 ;
     }
      $activo->activo            =  $request->activo;
      $activo->id_equipo         =  $request->equipo;  
      $activo->id_marca          =  $request->marca;     
      $activo->serial            =  $request->serial;
      $activo->costo	           =  $request->costo;
      $activo->id_proveedor      =  $request->id_proveedor;
      $activo->id_estado         =  $request->id_estado;
      $activo->id_tipoEquipo     =  $request->tipo_de_equipo;
      $activo->id_user =  Auth::id('id_user');
  

      $activo->save();
       

 
    return redirect()->route('activos.index');
}




public function edit( Request $request , $activo){
      
      $activo = Activo::find($activo);

      $proveedor          = Proveedores::all();
      $estados     =  Estados::all();
      $tipoEquipo         = TipoDeEquipo::all();
     
      $user = User::all();



  return view('activos.edit', 
                 ['activo' =>$activo, 'proveedor' => $proveedor , 'estados' => $estados 
                 ,'tipoEquipo' =>  $tipoEquipo ,   
                  ]);
}

 

public function update(Request $request, $activo){

  $activos= Activo::find($activo);
  
  $activos->activo            =  $request->activo;
  $activos->equipo            =  $request->equipo;  
  $activos->marca             =  $request->marca;     
  $activos->serial            =  $request->serial;
  $activos->costo	            =  $request->costo;
  $activos->id_proveedor      =  $request->id_proveedor;
  $activo->id_estado         =  $request->id_estado;
  $activos->id_tipoEquipo     =  $request->tipo_de_equipo;

  $activos->save();
   
 

 return redirect()->route('activos.index');
}



public function destroy( $activo){
  $activo = Activo::find($activo);
  $activo->delete();



  return back();
}

public function show($activo){
  $activo = Activo::find($activo);

  $movimientos = DetalleMovimiento::where('id_activo' ,$activo->id_activo )->get([ 'id_activo', 'id_cabezera']);
  return view('activos.ver' , ['activo' =>  $activo , 'movimientos' =>  $movimientos]);

}


}