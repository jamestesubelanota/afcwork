<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ColaboradorSedes;

class ColaboradorSedesController extends Controller
{
    //
    public function index(){


        return view('asignarcolaborador.index',[  'encargados' =>  ColaboradorSedes::all()]);
    }
}
