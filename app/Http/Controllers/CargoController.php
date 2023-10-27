<?php

namespace App\Http\Controllers;
use App\Models\Cargo;

use Illuminate\Http\Request;

class CargoController extends Controller
{
    public function index (){

          $cargo =  Cargo::latest()->paginate();
        return view('cargos.index', [ 'cargo' =>  Cargo::latest()->paginate()]);
    }

    public function create(Cargo $cargo ){


    return view('cargos.create', ['cargo'  => $cargo]);
    }
    public function store(){

    }

    public function edit(){

    }
    public function updaye(){

    }

    public function destroy(){

    }



}
