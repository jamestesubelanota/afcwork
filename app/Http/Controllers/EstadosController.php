<?php

namespace App\Http\Controllers;

use App\Models\Estados;
use Illuminate\Http\Request;

class EstadosController extends Controller
{
    //
    public function __construct()
    {
        $this->middleware('can:estados.index');
    }
    public function index(){

        return view('estados.index', [ "estados" =>Estados::all() ]);
    }

    public function create(Estados $estado ){

         return view( 'estados.create', ['estados' => $estado] );
    }
     public function store( Request $request){

        $estado =  new Estados();
        $request->validate([

            'estado'=> 'required | unique:estados,estado'
        ]);
        $estado->estado = ucfirst(strtolower($request->estado));
        $estado->save();

        return redirect()->route('estados.index');
     }




        public function edit($estado){

            $estado = Estados::find    ($estado);
            return view('estados.edit', ['estados' => $estado]);
        }
        public function update(  Request $request,  $estado){
try {
    $estado = Estados::find( $estado);
    $estado->estado= $request->estado;
    $estado->save();

   return redirect()->route('estados.edit' ,$estado)->with('success', 'departamento se actualizo con éxito');
   //view('estados.edit', ['estados' => $estado])->with('success', 'departamento se actualizo con éxito');
} catch (\Throwable $th) {
    return redirect()->route('estados.edit' ,$estado)->with('error', 'no se puedo actualizar ');
}

        }




    public function destroy($estado){

        $estado = Estados::find($estado);
        $estado->delete();
        return back();
    }


}
