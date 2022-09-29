<?php

namespace App\Http\Controllers;

use App\Models\Roles;

use Illuminate\Http\Request;

class RolesController extends Controller
{
    public function index(){
        $rol = Roles::latest()->paginate();
        return view('roles.index', ['roles' => $rol ]);
      }
      
   
       public function create( Roles $rol ){
           
          return  view('roles.create', ['roles' => $rol]);
   
       }
   
       public function store(Request $request){
   
           $rol = new Roles();
           $rol->rol = $request->rol;
           $rol->save();
   
           return redirect()->route('roles.index'); 
       
       }
   
       public function edit(  $rol){
   
              $rol = Roles::find($rol);
             
              return view('roles.edit', ['roles' =>  $rol ]);
   
       }
   
       public function update(Request $request, $rol){
   
           $rol = Roles::find($rol);
           $rol->rol = $request->rol;
           $rol->save();
   
               return redirect()->route('roles.index');
       }
   
       public function destroy($rol){
   
           $rol =  Roles::find($rol);
           $rol->delete();
           return back();
   
       }
   
}