<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

use App\Providers\RouteServiceProvider;
use Illuminate\Auth\Events\Registered;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;
use PhpParser\Node\Stmt\Use_;
use Spatie\Permission\Models\Role;

class UsuariosController extends Controller
{

    public function __construct()
    {
        $this->middleware('can:usuarios.index');
    }
  
    public function index(){
         

        return view('usuarios.index', [ 'usuarios' => $usuarios = User::latest()->paginate()

        ]);
    }

    public function create(){


        return view('usuarios.create');

    }

    public function store( Request $request){
        $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'identificacion' => ['required', 'string', 'max:255'],
            'id_rol' => ['', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ]);
    
        $user = new User();
        $user->name =  ucfirst(strtolower($request->name));
        $user->identificacion = $request->identificacion;
        $user->estado = ucfirst(strtolower($request->estado));
        $user->email = $request->email;
        $user->password = Hash::make($request->password);
        $user->save();

        event(new Registered($user));
        return redirect()->route('usuarios.index');

    }

    public function edit($user){

        $roles = Role::get(['id', 'name']);
        $user = User::find($user);

        return view('usuarios.edit',['roles' => $roles, 'user' => $user  ]);
    
    }
    
    public function update( Request $request,  $user){

        $user = User::find($user);
        $user->roles()->sync( $request->roles);

        return redirect()->route('usuarios.index');

    }

    public function destroy($user){

        $user = User::find($user);
        $user->delete();
        return back();


    }
}
