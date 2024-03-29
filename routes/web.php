<?php

use App\Http\Controllers\ActivoController;
use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\CabeceraMovimientoController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CiudadesController;
use App\Http\Controllers\ClientesController;
use App\Http\Controllers\ColaboradoresController;
use App\Http\Controllers\ColaboradorSedesController;
use App\Http\Controllers\CargoController;
use App\Http\Controllers\EstadosController;
use App\Http\Controllers\TipoDeEquipoController;
use App\Http\Controllers\DetalleMovimientoController;
use App\Http\Controllers\ProveedoresController;
use App\Http\Controllers\RolesController;
use App\Http\Controllers\SedeController;
use App\http\Controllers\TipoMovimientoController;
use App\http\Controllers\MarcaController;
use App\http\Controllers\EquipoController;
use App\http\Controllers\FotosController;
use App\http\Controllers\CartaEnvioController;
use App\http\Controllers\EntradaController;
use App\Http\Controllers\ContratoController;
use App\Http\Controllers\PropietariosController;
use App\Http\Controllers\UsuariosController;
use App\Http\Controllers\ReporteCartaDeEnvioController;
use App\Http\Controllers\DepartamentosController;
use App\Models\Usuarios;
use App\Models\DetalleMovimiento;


/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
|
|
*/


Route::controller(ActivoController::class)->group(function(){

    Route::resource('activos', ActivoController::class);

});


Route::controller(ClientesController::class)->group( function(){


  Route::resource('clientes', ClientesController::class);


})->middleware('can:clientes.index');
Route::controller(ContratoController::class)->group(function(){


    Route::resource('contratos', ContratoController::class);


  });

Route::controller(RolesController::class)->group( function(){

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

Route::controller(CabeceraMovimientoController::class)->group(function(){

    Route::resource('movimientos', CabeceraMovimientoController::class);

});
Route::controller(EntradaController::class)->group(function(){

    Route::resource('entrada', EntradaController::class);

});
Route::controller(UsuariosController::class)->group(function(){

    Route::resource('usuarios', UsuariosController::class);

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
Route::controller(FotosController::class)->group(function(){

    Route::resource('foto', FotosController::class);
});
Route::controller(PropietariosController::class)->group(function(){

    Route::resource('propietarios', PropietariosController::class);
});

Route::controller(ReporteCartaDeEnvioController::class)->group(function(){

    Route::resource('reportes',ReporteCartaDeEnvioController::class);
});
Route::controller(CargoController::class)->group(function(){

    Route::resource('cargos',CargoController::class);
});
Route::controller(ColaboradorSedesController::class)->group(function(){

    Route::resource('asignarcolaborador',ColaboradorSedesController::class);
});


Route::controller( DetalleMovimientoController::class)->group(function(){

    Route::resource('detalles', DetalleMovimientoController::class);
});

Route::controller(DepartamentosController::class)->group(function(){

    Route::resource('departamentos',DepartamentosController::class);
});
Route::get('ReporteCarta/{otro}',[App\Http\Controllers\ReporteCartaDeEnvioController::class,'pdf'])->name('reportes.show');


Route::get('/', function () {
    return view('auth.login');
});


Route::get('dashboard', function () {

    return view('dashboard');
})->middleware(['auth'])->name('dashboard');

require __DIR__.'/auth.php';
