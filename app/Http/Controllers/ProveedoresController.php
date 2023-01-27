<?php

namespace App\Http\Controllers;

use App\Models\Proveedores;
use Illuminate\Http\Request;

class ProveedoresController extends Controller
{

    public function __construct()
    {
        $this->middleware('can:proveedores.index');
    }

    public function index(){
        $proveedores = Proveedores::all();
         return view('proveedores.index', ['proveedores' => $proveedores  ]);

    }


    public function create( Proveedores $proveedores){

        return view('proveedores.create',[ 'proveedores' => $proveedores] );

    }

    public function store( Request $request , Proveedores $proveedores){

        $proveedores = new Proveedores();
        $request->validate([
        'nombre_proveedor' =>'required',
        'nit' =>'required',
        'direccion' =>'required',
        'razon_social' =>'required',
        'numero' =>'required',]);
        $proveedores->nombre_proveedor = $request->nombre_proveedor;
        $proveedores->nit= $request->nit;
        $proveedores->direccion = $request->direccion;
        $proveedores->razon_social = $request->razon_social;
        $proveedores->numero = $request->numero;
        $proveedores->save();

        return redirect()->route('proveedores.index',[ 'proveedores' => $proveedores] );
    }


    public function edit( $proveedor){
        $proveedoreditar = Proveedores::find($proveedor);

        return view('proveedores.edit', ['proveedores' =>  $proveedoreditar]);
    }

    public function update( Request $request, $proveedor){
      $proveedorUpdate = Proveedores::find( $proveedor);
      $request->validate([
        'nombre_proveedor' =>'required',
        'nit' =>'required',
        'direccion' =>'required',
        'razon_social' =>'required',
        'numero' =>'required',
    ]);
      $proveedorUpdate->nombre_proveedor = $request->nombre_proveedor;
      $proveedorUpdate->nit = $request->nit;
      $proveedorUpdate->direccion = $request->direccion;
      $proveedorUpdate->razon_social = $request->razon_social;
      $proveedorUpdate->numero = $request->numero;
      
      $proveedorUpdate->save();
      return redirect()->route('proveedores.index');
    }

    public function destroy( $proveedor){
     $proveedorEliminar = Proveedores::find($proveedor);
     $proveedorEliminar->delete();

     return back();

    }
}
