<?php

namespace App\Http\Controllers;

use App\Models\CabezeraMovimiento;
use App\Models\Activo;
use App\Models\Clientes;
use App\Models\DetalleMovimiento;
use App\Models\Sede;
use App\Models\TipoMovimiento;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
class CabezeraMovimientoController extends Controller
{
    public function index()
    {

        $movimientos = CabezeraMovimiento::latest()->paginate();
        return view(
            'movimientos.index',
            [
                'movimientos' => $movimientos
            ]
        );
    }


    public function create(Request $request)
    {
        $activos = Activo::latest()->paginate();
        $movimiento = TipoMovimiento::all();
        $cliente = Clientes::get(["nombre_cliente", "id_cliente"]);
        $sede =  Sede::where('cliente_id', $request->cliente_id)->get();
        if (count($sede) > 0) {
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
        $cabezeraMovimiento  = new CabezeraMovimiento();
        $cabezeraMovimiento->id_cliente = $request->cliente;
        $cabezeraMovimiento->id_sede = $request->sede;
        $cabezeraMovimiento->id_tmovimiento = $request->id_movimiento;
        $cabezeraMovimiento->id_user =  Auth::id('id_user');
        $cabezeraMovimiento->save();

        if ($cabezeraMovimiento) {
            foreach ($request->id_activo as $check) {


                $cabezeraMovimiento = CabezeraMovimiento::latest('id_cabezera')->first();
                $detalleMovimiento = new DetalleMovimiento();
                $detalleMovimiento->id_activo =  $check;
                $detalleMovimiento->id_cabezera =   $cabezeraMovimiento->id_cabezera;
                $detalleMovimiento->inicio =  $request->inicio;
                $detalleMovimiento->fin =  $request->fin;
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
