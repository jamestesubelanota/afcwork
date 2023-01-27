<?php

namespace App\Http\Controllers;

use App\Models\Propietarios;

use Illuminate\Http\Request;

class PropietariosController extends Controller
{
    //

    public function index(){

        return view('propietarios.index', [ 'propietarios' => $propietarios = Propietarios::latest()->paginate() ] );

    }

    public function create( Propietarios $propietarios){

        return view('propietarios.create' ,[ 'propietario'=> $propietarios]);
    }

    public function store (Request $request){
        $request->validate([
            'nombre'=> 'required',
            'razon'=> 'required',
            'numero'=> 'required'
]);

        $propietario = new Propietarios();
        $propietario->nombre_propietario = $request->nombre;
        $propietario->razon_social = $request->razon;
        $propietario->numero_telefono = $request->numero;
        $propietario->save();

        return redirect()->route('propietarios.index');

    }
    public function edit(   $propietarios){

        $propietarios = Propietarios::find($propietarios);



        return view('propietarios.create' ,[ 'propietario'=>  $propietarios]);
    }
    public function update( Request $request ,  Propietarios $propietarios){


        $propietarios = Propietarios::find($propietarios);
        
        
        $request->validate([
            'nombre'=> 'required | unique:propietarios,nombre_propiestario',
            'razon'=> 'required',
            'numero'=> 'required'
]);
$propietarios->nombre_propiestario = $request->nombre;
$propietarios->razon_social = $request->razon;
$propietarios->numero_telefono = $request->numero;
$propietarios->save();

return redirect()->route('propietarios.index');

    }

    public function destroy(  $propietarios){
        $propiestarioEliminar = Propietarios::find($propietarios);
        $propiestarioEliminar->delete();

        return back();

    }
}
