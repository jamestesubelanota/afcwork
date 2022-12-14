<?php

namespace App\Http\Controllers;

use App\Models\CabeceraMovimiento;
use App\Models\Activo;
use App\Models\Clientes;
use App\Models\DetalleMovimiento;
use App\Models\Sede;
use App\Models\TipoMovimiento;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
class CabeceraMovimientoController extends Controller
{
    public function __construct()
    {
        $this->middleware('can:movimientos.index');
    }
    public function index( Request $request)
    {
        // $prosimoMovimientop =  CabezeraMovimiento::orderBy('id_cabezera', 'desc')->first();
       //   if( $prosimoMovimientop != null){
      //    $prosimoMovimientop->id_cabezera += 1 ;
     //    $proximoMovi=  $prosimoMovimientop  ;
    // }
        
       
       $cliente            = Clientes::get(["nombre_cliente", "id_cliente"]);
       $sede               = Sede::where('cliente_id', $request->cliente_id)->get();
   
       if (count($sede) > 0) {
         return response()->json($sede);
       }
      
     
 
        $movimientos = CabeceraMovimiento::latest()->paginate();
        return view(
            'movimientos.index',
            [
                'movimientos' => $movimientos,
                'clientes' =>  $cliente,
                'sedes' =>     $sede  
             
            ]
        );
    }


    public function create(Request $request)
    {
        $activos = Activo::latest()->paginate();
        $movimiento = TipoMovimiento::all();
        $cliente = Clientes::get(["nombre_cliente", "id_cliente"]);

        $sede =  Sede::where('cliente_id', $request->cliente_id)->get();


        if (count($sede) > 0)
        {
            return response()->json($sede);
        }


        return view('movimientos.create', [
            'activos' => $activos, 'clientes' => $cliente,
            'sedes'  => $sede,
            'movimientos' => $movimiento
        ]);
    }



    public function store(Request $request)
    {
        
        $cabeceraMovimiento  = new CabeceraMovimiento();
        $cabeceraMovimiento->id_cliente = $request->cliente;
        $cabeceraMovimiento->id_sede = $request->sede;
        $cabeceraMovimiento->inicio =  $request->inicio;
        $cabeceraMovimiento->id_tmovimiento = $request->id_movimiento;
        $cabeceraMovimiento->id_user =  Auth::id('id_user');
        $cabeceraMovimiento->save();

        if ($cabeceraMovimiento) {
            foreach ($request->id_activo as $check) {


                $cabeceraMovimiento = CabeceraMovimiento::latest('id_cabecera')->first();
                $detalleMovimiento = new DetalleMovimiento();
                $detalleMovimiento->id_activo =  $check;
                $detalleMovimiento->id_cabecera =   $cabeceraMovimiento->id_cabecera;
                $detalleMovimiento->detalle =  $request->detalle;
                $detalleMovimiento->save();

                if ($detalleMovimiento) 
                
                {
                    $activoActualizarSedeActual = $detalleMovimiento->id_activo =  $check;
                    $activoActualizarSedeActual = Activo::find($activoActualizarSedeActual);
                    $activoActualizarSedeActual->id_sede =  $cabeceraMovimiento->id_sede = $request->sede;
                    $activoActualizarSedeActual->save();
                }
            }
        }

        return redirect()->route('movimientos.index');
    }

 
}
