<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Departamentos;

class DepartamentosController extends Controller
{
    //

    public function index(){
        $deprtamento = Departamentos::latest()->paginate();

        return view('departamentos.index',['departamentos' =>   $deprtamento]);
    }

    public function create(){

     $departamento=  new Departamentos();

        return view('departamentos.create', ['departamento' => $departamento ]);
    }

    public function store( Request $request){

        $request->validate([
        'departamento' => 'required'

        ]);
        Departamentos::create([

           'nombreDepartamento' => $request->departamento

        ]);

      return  redirect()->route('departamentos.create')->with('success', 'departamento con éxito');

    }

    public function edit($id){
        $departamento =  Departamentos::find($id);


        return view('departamentos.edit', ['departamento' => $departamento ]);


    }

    public function update(Request $request, $id ){

        $request->validate([
            'departamento' => 'required'
            ]);

        $departamento =  Departamentos::find($id);
        $departamento->nombreDepartamento =  $request->departamento;
        $departamento->save();

        return  redirect()->route('departamentos.edit',$id )->with('success', 'departamento se actualizo con éxito');
    }

    public function destroy($id){
     $departamento =  Departamentos::find($id);
     $departamento->delete();

     return back();



    }



}


