<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Fotos;
use App\Models\Activo;
use Symfony\Component\CssSelector\Node\FunctionNode;

class FotosController extends Controller
{
    //

    public function index(){


        return view( 'foto.index' , ['Fotos' => $fotos = Fotos::latest()->paginate() ]);
    }

    public function create(){

      $activos = Activo::all();


        return view('foto.create', ['activos' =>  $activos ]);
    }


    public function store(Request $request ){

          
            if($request->hasFile('foto')){
                $archivo = $request->file('foto'); 
                //extencion de la imagen 
                $type  = pathinfo(  $archivo , PATHINFO_EXTENSION);
    
                $data = file_get_contents( $archivo);
                $imagenBase64 = 'data:image/' . $type . ';base64,' . base64_encode($data);

            }

            //Creamos el objeto 
            $foto = new Fotos();
            $foto->foto = $imagenBase64;
            $foto->id_activo = $request->id_activo;
            $foto->save();

            return redirect()->route('foto.index');
    }


    public function edit($foto){

        $foto = Fotos::find($foto);

        $activos = Activo::all();
        return view('fotos.edit', ['activos' =>  $activos , 'fotos' =>$foto]);

    }

    public function update(Request $request, $foto){


        if($request->hasFile('foto')){
            $archivo = $request->file('foto'); 
            //extencion de la imagen 
            $type  = pathinfo(  $archivo , PATHINFO_EXTENSION);

            $data = file_get_contents( $archivo);
            $imagenBase64 = 'data:image/' . $type . ';base64,' . base64_encode($data);

        }

        //Creamos el objeto 
        $foto = Fotos::find($foto);
        $foto->foto = $imagenBase64;
        $foto->id_activo = $request->id_activo;
        $foto->save();

        return redirect()->route('foto.index');
    }

    public function show(){}


}
