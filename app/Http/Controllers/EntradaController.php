<?php

namespace App\Http\Controllers;

use App\Models\Activo;
use App\Models\CabeceraMovimiento;
use App\Models\Clientes;
use App\Models\DetalleMovimiento;
use App\Models\Sede;
use App\Models\TipoMovimiento;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class EntradaController extends Controller
{


    public function __construct()
    {
        $this->middleware('can:entrada.index');
    }
    public function index( )

    {

    }
    public function create( Request $request  )

    {
        
        $activos = Activo::where('id_sede', $request->sede)->get();
        $clientess =Clientes::get(['id_cliente', 'nombre_cliente'])->where('id_cliente', $request->cliente);
     
        $movimiento = TipoMovimiento::get(['id_tmovimiento','movimiento'])->where('id_tmovimiento',1); 
        $cliente = Clientes::get(['id_cliente','nombre_cliente'])->where('id_cliente',1); 
         $sede =  Sede::where('cliente_id', $request->cliente_id)->get();
         if (count($sede) > 0) {
             return response()->json($sede);
         }
 
 
         return view('entrada.create', [
             'activos' => $activos, 'clientes' => $cliente,
             'sedes'  => $sede,
             'movimientos' => $movimiento,
             'clientess' => $clientess
            
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


                $cabezeraMovimiento = CabeceraMovimiento::latest('id_cabecera')->first();
                $detalleMovimiento = new DetalleMovimiento();
                $detalleMovimiento->id_activo =  $check;
                $detalleMovimiento->id_cabezera =   $cabezeraMovimiento->id_cabecera;
                $detalleMovimiento->detalle =  $request->detalle;
                $detalleMovimiento->save();
                if ($detalleMovimiento) 
                {
                    $activoActualizarSedeActual = $detalleMovimiento->id_activo =  $check;
                    $activoActualizarSedeActual = Activo::find($activoActualizarSedeActual);
                    $activoActualizarSedeActual->id_sede =  $cabezeraMovimiento->id_sede = $request->sede;
                    $activoActualizarSedeActual->save();
                }
            }
        }

        return redirect()->route('movimientos.index');
    }


    
}
