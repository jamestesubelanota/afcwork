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
    public function store(Request $request)
    {
        $sedeId = $request->sede;
        $colaboradorId = $request->colaborador;

        // Verifica cuántos colaboradores ya están registrados en la sede
        $colaboradoresCount = ColaboradorSedes::where('id_sede', $sedeId)->count();

        if ($colaboradoresCount >= 2) {
            return redirect()->route('asignarcolaborador.create')->with('error', 'Ya hay dos colaboradores en esta sede.');
        }

        // Crea y guarda la nueva asignación de colaborador
        $asignacionDeColaborador = new ColaboradorSedes();
        $asignacionDeColaborador->id_colaborador = $colaboradorId;
        $asignacionDeColaborador->id_sede = $sedeId;
        $asignacionDeColaborador->save();

        return redirect()->route('asignarcolaborador.create')->with('success', 'Empleado asignado con éxito');
    }
}
