<?php

use App\Http\Controllers\ActivoController;
use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\CabezeraMovimientoController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CiudadesController;
use App\Http\Controllers\ClientesController;
use App\Http\Controllers\ColaboradoresController;
use App\Http\Controllers\EstadosController;
use App\Http\Controllers\TipoDeEquipoController;
use App\Http\Controllers\ProveedoresController;
use App\Http\Controllers\RolesController;
use App\Http\Controllers\SedeController;
use App\http\Controllers\TipoMovimientoController;
use App\http\Controllers\MarcaController;
use App\http\Controllers\EquipoController;
use App\http\Controllers\CartaEnvioController;



/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


Route::controller(ActivoController::class)->group(function(){
 
    Route::resource('activos', ActivoController::class);

});


Route::controller(ClientesController::class)->group(function(){


  Route::resource('clientes', ClientesController::class);


});

Route::controller(RolesController::class)->group(function(){

       Route::resource('roles', RolesController::class);

});

Route::controller(TipoMovimientoController::class)->group(function(){


Route::resource('tipoMovimiento', TipoMovimientoController::class);

});


Route::controller(CiudadesController::class)->group(function()
{  
    Route::resource('ciudades', CiudadesController::class);

});

Route::controller(EstadosController::class)->group(function()
{  
    Route::resource('estados', EstadosController::class);

});

Route::controller(TipoDeEquipoController::class)->group(function(){

    Route::resource('tipoEquipo', TipoDeEquipoController::class);
    
});

Route::controller(ProveedoresController::class)->group(function(){

    Route::resource('proveedores', ProveedoresController::class);
    
});

Route::controller(SedeController::class)->group(function(){

    Route::resource('sedes',SedeController::class);
});

Route::controller(CabezeraMovimientoController::class)->group(function(){

    Route::resource('movimientos', CabezeraMovimientoController::class);

});
Route::controller(CabezeraMovimientoController::class)->group(function(){

    Route::resource('usuarios', RegisteredUserController::class);

});
Route::controller(EquipoController::class)->group(function(){

    Route::resource('equipos', EquipoController::class);

});
Route::controller(MarcaController::class)->group(function(){

    Route::resource('marcas', MarcaController::class);

});


Route::controller(ColaboradoresController::class)->group(function(){

    Route::resource('colaboradores', ColaboradoresController::class);
});



Route::get('/', function () {
    return view('welcome');
});


Route::get('dashboard', function () {

    return view('dashboard');
})->middleware(['auth'])->name('dashboard');

require __DIR__.'/auth.php';
