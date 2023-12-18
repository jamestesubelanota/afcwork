<?php

namespace App\Models;
use App\Models\Logs;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class Equipo extends Model
{


    use HasFactory;

    protected $primaryKey = 'id_equipo';
    protected $fillable =['equipo'];


    protected static function boot() {
        parent::boot();
        $latestEquipo = Equipo::latest()->first();
        if ($latestEquipo) {
        static::created(function($latestEquipo) {
            // Registrar en el log la creación del equipo
            Logs::create([
                'tabla_afectada' => 'equipos',
                'id_equipo' => $latestEquipo->id_equipo,
                'accion' => 'insert',
                'usuario' => Auth::user()->name // Obtener el nombre de usuario actual
            ]);
        });



        static::updated(function($equipo) {
            // Registrar en el log la actualización del equipo
            Logs::create([
                'tabla_afectada' => 'equipos',
                'id_equipo' => $equipo->getOriginal('id_equipo'),
                'accion' => 'update',
                'usuario' => Auth::user()->name // Obtener el nombre de usuario actual
            ]);
        });



        static::deleted(function($equipo) {
            // Registrar en el log la eliminación del equipo
            Logs::create([
                'tabla_afectada' => 'equipos',
                'id_equipo' => $equipo->getOriginal('id_equipo'),
                'accion' => 'delete',
                'usuario' => Auth::user()->name // Obtener el nombre de usuario actual
            ]);
        });
    }
}

}



