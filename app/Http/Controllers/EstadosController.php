<?php

namespace App\Http\Controllers;

use App\Models\Estados;
use Illuminate\Http\Request;

class EstadosController extends Controller
{
    //

    public function index(){

        return view('estados.index', [ "estados" =>Estados::all() ]);
    }

    public function create(Estados $estado ){

         return view( 'estados.create', ['estados' => $estado] );
    }  
     public function store( Request $request){

        $estado =  new Estados();
        $estado->estado = $request->estado;
        $estado->save();
        
        return redirect()->route('estados.index');
     }


       
     
        public function edit($estado){

            $estado = Estados::find    ($estado);
            return view('estados.edit', ['estados' => $estado]);
        }
        public function update(  Request $request,  $estado){

             $estado = Estados::find( $estado);
             $estado->estado= $request->estado;
             $estado->save();


            return view('estados.edit', ['estados' => $estado]);
        }




    public function destroy($estado){
      
        $estado = Estados::find($estado);
        $estado->delete();
        return back();
    }

   
}
