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
use App\Models\Fotos;
use App\Models\Marca;
use App\Models\User;
use GuzzleHttp\Client;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ActivoController extends Controller
{
  public function index()
  {


    return view('activos.index', ['activos' => $activos = Activo::latest()->paginate(),]);
  }




  public function create(Request $request,  Activo $activo)
  {

    // se imboca un objeto basio 
    $equipos = Equipo::all();
    $marcas  = Marca::all();
    $proveedor          = Proveedores::all();
    $estados     =  Estados::all();
    $tipoEquipo         = TipoDeEquipo::all();
    $cliente            = Clientes::get(["nombre_cliente", "id_cliente"]);
    $sede               = Sede::where('cliente_id', $request->cliente_id)->get();

    if (count($sede) > 0) {
      return response()->json($sede);
    }
    $user = User::all();


    // retorna la vista
    return view(
      'activos.create',
      [
        'activo' => $activo,
        'equipos' => $equipos,
        'marcas' => $marcas,
        'proveedor'      =>  $proveedor,
        'estados'  =>  $estados,
        'tipoEquipo'     => $tipoEquipo,
        'clientes'        => $cliente,
        'sedes'  => $sede,

        'user'           => $user
      ]
    );
  }




  public function store(Request $request)
  {


    $activo = new Activo();
    #validacion
    $request->validate([
      'foto' => 'required',
      'activo' => 'required | unique:activos,activo',
      'activocontable' => 'required | unique:activos,activocontable',
      'equipo' => 'required ',
      'marca' => 'required',
      'serial' => 'required | unique:activos,serial',
      'costo' => 'required',
      'modelo' => 'required',
      'propietario' => 'required',
      'id_proveedor' => 'required',
      'id_estado' => 'required',
      'tipo_de_equipo' => 'required',
    ]);

    #fin validadacion
  
   

  
    
    $activo->activo            =  $request->activo;
    $activo->activocontable  =  $request->activocontable;
    $activo->id_equipo         =  $request->equipo;
    $activo->id_marca          =  $request->marca;
    $activo->serial            =  $request->serial;
    $activo->costo             =  $request->costo;
    $activo->modelo            =  $request->modelo;
    $activo->propietario          =  $request->propietario;
    $activo->id_proveedor      =  $request->id_proveedor;
    $activo->id_estado         =  $request->id_estado;
    $activo->id_tipoEquipo     =  $request->tipo_de_equipo;
    $activo->id_sede    =  $request->sede;
    $activo->id_user =  Auth::id('id_user');

    $activo->save();
    

      if( $activo){

        
        $request->hasFile('foto');
        $archivo = $request->file('foto'); 

        foreach($archivo as $file){

          $type  = pathinfo(  $file , PATHINFO_EXTENSION);
  
          $data = file_get_contents(  $file);
          $imagenBase64 = 'data:image/' . $type . ';base64,' . base64_encode($data);
         
          $foto = new Fotos();
  
          $foto->foto =  $imagenBase64;
          $idAc = Activo::latest('id_activo')->first();
          $foto->id_activo =   $idAc->id_activo;
          $foto->save();

        }
      
        
    }
      



  
         
  

    return redirect()->route('activos.index');
  }

 




  public function edit(Request $request, $activo)
  {

    $activo       = Activo::find($activo);
    $equipos      = Equipo::all();
    $proveedor    = Proveedores::all();
    $estados      =  Estados::all();
    $tipoEquipo   = TipoDeEquipo::all();
    $marcas       = Marca::all();
    $cliente      = Clientes::get(["nombre_cliente", "id_cliente"]);
    $sede         = Sede::where('cliente_id', $request->cliente_id)->get();
    $user         = User::all();



    return view(
      'activos.edit',

      [
        'activo'      => $activo, 
        'proveedor'   => $proveedor, 
        'estados'     => $estados, 
        'tipoEquipo'  =>  $tipoEquipo,
        'equipos'     => $equipos,
        'marcas'      => $marcas,
        'clientes'    => $cliente,
        'sedes'       => $sede,
      ]
    );
  }



  public function update(Request $request, $activo)
  {

    $activos = Activo::find($activo);

    $activos->activo             =  $request->activo;
    $activos->equipo             =  $request->equipo;
    $activos->marca              =  $request->marca;
    $activos->serial             =  $request->serial;
    $activos->costo              =  $request->costo;
    $activos->id_proveedor       =  $request->id_proveedor;
    $activo->id_estado           =  $request->id_estado;
    $activos->id_tipoEquipo      =  $request->tipo_de_equipo;
    $activo->id_sede             =  $request->sede;

    $activos->save();



    return redirect()->route('activos.index');
  }



  public function destroy($activo)
  {
    $activo = Activo::find($activo);
    $activo->delete();



    return back();
  }

  public function show($activo)
  {
    $activo = Activo::find($activo);
    $foto = Fotos::where('id_activo', $activo->id_activo)->get(['id_activo', 'foto']);
   
    $movimientos = DetalleMovimiento::where('id_activo', $activo->id_activo)->get(['id_activo', 'id_cabezera']);
    
    return view('activos.ver', ['activo' =>  $activo, 'movimientos' =>  $movimientos, 'fotos' => $foto ]);
  }
}





  //  if ($request->hasFile('foto')) {
    //  $file = $request->file('foto');
     // $detinoPhat = 'fotos/';
    //$filename = time() . '-' . $file->getClientOriginalName();
     // $uploadSuccess = $request->file('foto')->move($detinoPhat,  $filename);
     // $activo->foto =    $detinoPhat .  $filename;
    //}