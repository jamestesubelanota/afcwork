<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CabeceraMovimiento;
use App\Models\DetalleMovimiento;
use PDF;
use Illuminate\Support\Facades\DB;


class ReporteCartaDeEnvioController extends Controller
{
    public function index(){


      return  view('reportes.pdf');



    }
    public function pdf($otro){
        $detalleCabecera =   CabeceraMovimiento::where('id_cabecera', $otro)->get();
        $DetalleMovimiento = DetalleMovimiento::where('id_cabecera', $otro)->get();



        $pdf = PDF::loadView('reportes.show', ['DetalleMovimiento' => $DetalleMovimiento , 'detalleCabecera' =>  $detalleCabecera ]);

       return $pdf->stream();

   }
}
