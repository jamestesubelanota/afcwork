<?php

namespace App\Http\Controllers;

use App\Models\Equipo;
use Illuminate\Http\Request;
use PhpParser\Node\Expr\BinaryOp\Equal;

class EquipoController extends Controller
{
    //

    public function index(){

        return  view('equipos.index', ['equipos' => $equipos = Equipo::get(['id_equipo', 'equipo'])]);
    }


    public function create( Equipo $equipo){
  

       return view('equipos.create', ['equipos' =>$equipo]);
    }
     
    public function store(Request $request ){

        $equipo = new Equipo();
        $equipo->equipo = $request->equipo;
        $equipo->save();
        return redirect()->route('equipos.index');


    }

    public function edit(  $equipo ){

        $equipo = Equipo::find( $equipo);
      
        return view('equipos.edit', ['equipos' =>$equipo  ]);


    }

    public function update(Request $request,  $equipo){
        $equipo = Equipo::find( $equipo);
        $equipo->equipo = $request->equipo;
        $equipo->save();

        return redirect()->route('equipos.index');
    }

     public function destroy( $equipo){
        $equipo = Equipo::find( $equipo);
        $equipo->delete();
        return back();

     }


}