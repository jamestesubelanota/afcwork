<?php

namespace App\Http\Controllers;

use App\Models\Roles;

use Illuminate\Http\Request;
use Spatie\Permission\Models\Permission;

class RolesController extends Controller
{
    public function __construct()
    {
        $this->middleware('can:roles.index');
    }
    public function index(){
        $rol = Roles::latest()->paginate();
        return view('roles.index', ['roles' => $rol ]);
      }
      
   
       public function create( Roles $rol ){
        $permisos = Permission::all();
           
          return  view('roles.create', ['roles' => $rol , 'permisos' =>  $permisos   ]);
   
       }
   
       public function store(Request $request){
   
           $rol = new Roles();
           $request->validate(['rol' => 'required | unique:roles,rol']);
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
