<?php

namespace App\Http\Controllers;
use App\Models\Marca;
use Illuminate\Http\Request;

class MarcaController extends Controller
{
    //


    public function index(){


        return view('marcas.index', ['marcas' => $marcas = Marca::latest()->paginate() ]);
    
    }


    public function create( Marca $marcas){

        return view('marcas.create', ['marcas' => $marcas]);
    }

    public function store( Request $request){

        $marca = new Marca();
        $request->validate(['marca' => 'required']);
        $marca->marca = $request->marca;
        $marca->save();

         return redirect()->route('marcas.index');


    }


    public function edit ($marca){

        $marca = Marca::find($marca);

     return view('marcas.edit' , ['marcas' => $marca]);
    
    }

    public function update(Request $request, $marca){
        $marca = Marca::find($marca);

        $marca->marca = $request->marca;
        $marca->save();
        return redirect()->route('marcas.index');
    }

    public function destroy( $marca){

        $marca = Marca::find($marca);
        $marca->delete();
        return back();
    }
}
