<?php

namespace App\Http\Controllers;


use App\Models\TipoMovimiento;
use Illuminate\Http\Request;

class TipoMovimientoController extends Controller
{
    

  
    public function index(){

        $movimiento = TipoMovimiento::latest()->paginate();
       return  view('tipoMovimiento.index', ['movimiento' => $movimiento]);
  
      }


    public function create( TipoMovimiento $movimiento ){
       
       return view( 'tipoMovimiento.create', ['movimiento' =>$movimiento] );

    }

    public function store(Request $request){
          $movimiento = new TipoMovimiento();
          $request->validate(['movimiento' => 'required | unique:tipo_movimientos,movimiento' ]);
          $movimiento->movimiento = $request->movimiento;
          $movimiento->save();
          return redirect()->route( 'tipoMovimiento.index' , ['movimiento' => $movimiento] );
    } 

    public function edit(   $movimiento){

        $movimiento = TipoMovimiento::find($movimiento);
  
        return view( 'tipoMovimiento.edit', ['movimiento' => $movimiento] );


    }

    public function update( Request $request, $movimiento){

        $movimiento = TipoMovimiento::find($movimiento);
        $movimiento->movimiento = $request->movimiento;
        $movimiento->save();
        return redirect()->route( 'tipoMovimiento.index', ['movimiento' => $movimiento] );


    }

    public function destroy($movimiento){

        $movimiento = TipoMovimiento::find($movimiento);
        $movimiento->delete();
        return back();

     

    }


}
