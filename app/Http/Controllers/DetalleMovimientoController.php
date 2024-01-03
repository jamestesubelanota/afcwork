<?php

namespace App\Http\Controllers;

use App\Models\Activo;
use App\Models\CabeceraMovimiento;
use App\Models\Clientes;
use App\Models\DetalleMovimiento;
use App\Models\Sede;
use App\Models\TipoMovimiento;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Http\Request;

class DetalleMovimientoController extends Controller
{




public function edit($id , Request $request){
    $cabecera   =  CabeceraMovimiento::find($id);
    $destalles  =  DetalleMovimiento::where('id_cabecera', $id)->get();
    $movimiento =  TipoMovimiento::where('id_tmovimiento', $cabecera->id_tmovimiento)->get();
    $cliente    =  Clientes::where('id_cliente', $cabecera->id_cliente)->get();

    $sede =  Sede::where('id_sede', $cabecera->id_sede)->get();





    return view('detalles.edit', [
        'destalles' => $destalles,
         'clientes' => $cliente,
        'sedes'  => $sede,
        'movimientos' => $movimiento,
        'cabecera' =>$cabecera
    ]);

}
    public function destroy($id, Request $request){
        $cabecera = CabeceraMovimiento::find($id);

        if ($cabecera){
            $detallesAEliminar = DetalleMovimiento::where('id_cabecera', $id)
                                ->where('id_activo', $request->id_activo)
                                ->get();

            // Verificamos si hay detalles a eliminar antes de proceder
            if ($detallesAEliminar->isNotEmpty()) {
                foreach ($detallesAEliminar as $detalle) {
                    $detalle->delete();
                }
            }

            return back();
        }
    }



}
