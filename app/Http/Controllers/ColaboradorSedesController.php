<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ColaboradorSedes;
use App\Models\Sede;
use App\Models\Colaboradores;
use App\Models\Clientes;

class ColaboradorSedesController extends Controller
{
    //
    public function index(){


        return view('asignarcolaborador.index',[  'encargados' =>  ColaboradorSedes::all()]);
    }


    public function create(){

        $cliente = Clientes::all();
        $sede = Sede::all();
        $colaborador = Colaboradores::all();


        return view(
        'asignarcolaborador.create', [
                                       'sede'        =>   $sede  ,
                                       'colaborador' => $colaborador,
                                       'cliente'     =>  $cliente
                                       ]
    );
    }
    public function store( Request $request  ){
        $asginacionDeColaborador = new ColaboradorSedes();

        $asginacionDeColaborador->id_colaborador =  $request->colaborador;
        $asginacionDeColaborador->id_sede = $request->sede;
        $asginacionDeColaborador->save();

return redirect()->route('asignarcolaborador.create')->with('success', 'Empleado asginado con éxito');

    }
}
