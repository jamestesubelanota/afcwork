<?php

namespace App\Http\Controllers;
use App\Models\Cargo;

use Illuminate\Http\Request;

class CargoController extends Controller
{
    public function index (){

          $cargo =  Cargo::latest()->paginate();
        return view('cargos.index', [ 'cargo' =>  Cargo::latest()->paginate()]);
    }

    public function create(Cargo $cargo ){


    return view('cargos.create', ['cargo'  => $cargo]);
    }


    public function store(Request $request)
{
    $request->validate([
        'cargo' => 'required', // Cambio 'require' a 'required'
    ]);

    // Utiliza el método create para crear un nuevo registro
    Cargo::create([
        'cargo' => $request->cargo,
    ]);

    // Utiliza el método route para redirigir a la ruta 'cargos.index'
    return redirect()->route('cargos.create')->with('success', 'Cargo creado con éxito');
}

    public function edit($cargo){

        $cargoEditar = Cargo::find($cargo) ;


return view('cargos.edit', ['cargo' => $cargoEditar]);


    }
    public function update( Request $request, $cargo){
         $cargoUpdate = Cargo::find($cargo);

         $request->validate(['cargo' => 'required']);
         $cargoUpdate->cargo =  $request->cargo;
         $cargoUpdate->save();

         return redirect()->route('cargos.create')->with('success', 'Cargo actualizado con éxito');

    }

    public function destroy($cargo){

        $cargoEliminar = Cargo::find($cargo);
        $cargoEliminar->delete();
        return back();


    }



}
