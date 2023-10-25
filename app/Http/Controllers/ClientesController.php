<?php

namespace App\Http\Controllers;

use App\Models\Clientes;
use App\Models\Colaboradores;
use Illuminate\Http\Request;

class ClientesController extends Controller
{
   

    public function __construct()
    {
        $this->middleware('can:clientes.index');
    }
  
    public function index(){
        $clientes = Clientes::all();
      return view('clientes.index', ['clientes' => $clientes ]);

    }

    public function create(Clientes $cliente){
        

        return view('clientes.create', ['cliente' => $cliente ]);
    }

    public function store(Request $request){

         $clientes = new Clientes(); 
         $request->validate([
            'nombre_cliente' => 'required',
            'nit' => 'required | unique:clientes,nombre_cliente',
            'razon_social' => 'required',
            'detalle' => 'required',
            
        ]);
         $clientes->nombre_cliente =  ucfirst(strtolower( $request->nombre_cliente));
         $clientes->nit = $request->nit;
         $clientes->razon_social =  ucfirst(strtolower($request->razon_social));
         $clientes->detalle =  ucfirst(strtolower($request->detalle));
       
         $clientes->save();

         return redirect()->route('clientes.index');

    }

    public function edit($cliente){
        
        $clientes = Clientes::find($cliente);
        return view('clientes.edit', ['cliente' =>  $clientes]);
    }

    public function update(Request $request , $clientes){
        $clientes = Clientes::find($clientes) ;  
        $clientes->nombre_cliente = $request->nombre_cliente;
        $clientes->nit = $request->nit;
        $clientes->razon_social = $request->razon_social;
        $clientes->detalle = $request->detalle;
    
        $clientes->save();
        return redirect()->route('clientes.index');
    }

    public function destroy($cliente){

        $clientes = Clientes::find($cliente);
        $clientes->delete();

      return back();
    }
}
