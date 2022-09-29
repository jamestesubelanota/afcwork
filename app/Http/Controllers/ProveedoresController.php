<?php

namespace App\Http\Controllers;

use App\Models\Proveedores;
use Illuminate\Http\Request;

class ProveedoresController extends Controller
{
    public function index(){
        $proveedores = Proveedores::latest()->paginate();
         return view('proveedores.index', ['proveedores' => $proveedores  ]);

    }


    public function create( Proveedores $proveedores){

        return view('proveedores.create',[ 'proveedores' => $proveedores] );

    }

    public function store( Request $request , Proveedores $proveedores){

        $proveedores = new Proveedores();
        $proveedores->nombre_proveedor = $request->nombre_proveedor;
        $proveedores->nit= $request->nit;
        $proveedores->direccion = $request->direccion;
        $proveedores->Razon_social = $request->razon_social;
        $proveedores->save();

        return redirect()->route('proveedores.index',[ 'proveedores' => $proveedores] );
    }


    public function edit( $proveedor){
        $proveedoreditar = Proveedores::find($proveedor);

        return view('proveedores.edit', ['proveedores' =>  $proveedoreditar]);
    }

    public function update( Request $request, $proveedor){
      $proveedorUpdate = Proveedores::find( $proveedor);
      $proveedorUpdate->nombre_proveedor = $request->nombre_proveedor;
      $proveedorUpdate->nit = $request->nit;
      $proveedorUpdate->direccion = $request->direccion;
      $proveedorUpdate->Razon_social = $request->razon_social;
      $proveedorUpdate->save();
      return redirect()->route('proveedores.index');
    }

    public function destroy( $proveedor){
     $proveedorEliminar = Proveedores::find($proveedor);
     $proveedorEliminar->delete();

     return back();

    }
}