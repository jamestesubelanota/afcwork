<?php

namespace App\Http\Controllers;

use App\Models\Clientes;
use App\Models\Contrato;
use Illuminate\Http\Request;

class ContratoController extends Controller
{
    public function __construct()
    {
        $this->middleware('can:contratos.index');
    }
    public function index(){


return view('contratos.index',[
    'contratos'=> $contratos = Contrato::latest()->paginate()]);
    }




    public function create( Contrato $contrato){


         $cliente = Clientes::all();

         
          return view('contratos.create',[
             'cliente'  =>  $cliente ,
             'contrato' => $contrato ]);

    }

    public function store(Request $request){


         $request->validate(
            [
                'tipo_de_contrato' => 'required ',
                'inicio'           => 'required',
                'fin'              => 'required',
                'cliente'          => 'required',
                'codigo' => 'required | unique:contratos,codigo'
            ]
         );
        $contrato = new Contrato();
        $contrato->tipo_de_contrato = $request->tipo_de_contrato;
        $contrato->codigo           = $request->codigo;
        $contrato->inicio           = $request->inicio;
        $contrato->fin              = $request->fin;
        $contrato->id_cliente       = $request->cliente;
        $contrato->estado           = $request->estado;
        $contrato->save();

        return redirect()->route('contratos.index');

    }

    public function edit($contrato){
        $contrato          = Contrato::find($contrato);
         $cliente          = Clientes::all();
        return view('contratos.edit',
    [ 
        'cliente'    =>  $cliente, 
        'contrato'   =>  $contrato
    ]);
    }

    public function update( Request $request, $contrato ){

        $request->validate(
            [
                'tipo_de_contrato' => 'required',
                'inicio'           => 'required',
                'fin'              => 'required',
                'cliente'          => 'required',
                'codigo'           => 'required'
            ]
         );
         $contrato =  Contrato::find($contrato);
        $contrato->tipo_de_contrato = ucfirst(strtolower($request->tipo_de_contrato));
        $contrato->codigo           = $request->codigo;
        $contrato->inicio           = $request->inicio;
        $contrato->fin              = $request->fin;
        $contrato->id_cliente       = $request->cliente;
        $contrato->estado           = ucfirst(strtolower($request->estado));
        $contrato->save();

    

        return redirect()->route('contratos.index');




    }

    public function destroy($id_contrato){

        $contratoEliminar   =   Contrato::find($id_contrato); 
        $contratoEliminar->delete();
        return(back());
    }
}



 