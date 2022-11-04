<?php

namespace App\Http\Controllers;
use App\Models\TipoDeEquipo;
use Illuminate\Http\Request;

class TipoDeEquipoController extends Controller
{
    

    public function index(){
      $equipo =  TipoDeEquipo::latest()->paginate();
      return view('tipoEquipo.index', ['equipos' => $equipo ]);
    }


    public function create(){
     

      return view('tipoEquipo.create', ['equipo' => $equipo = new TipoDeEquipo()] );

    }

    public function store(Request $request){

      $equipo = new TipoDeEquipo();
      $request->validate([ 'tipo_equipo'=> 'required']);
      $equipo->tipo_de_equipo = $request->tipo_equipo;
      $equipo->save();
             

      return redirect()->route('tipoEquipo.index', ['equipos' => $equipo ]);
    }

    public function edit(  $equipo){
      $equipo= TipoDeEquipo::find( $equipo);
      return view('tipoEquipo.edit' ,[ 'equipo' =>  $equipo]);
   }
    public function update( Request $request , $equipo ){

        
          $equipos = TipoDeEquipo::find($equipo);
          $request->validate([ 'tipo_equipo'=> 'required']);
          $equipos->tipo_de_equipo = $request->tipo_equipo;
          $equipos->save();

          return redirect()->route('tipoEquipo.index', ['equipos' => $equipo ]);
    }




    public function destroy($equipo){

         $equipo = TipoDeEquipo::find($equipo);
         $equipo->delete();
         return back();
    }

}
