<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Departamentos;

class Ciudades extends Model
{
    use HasFactory;
    protected $primaryKey ='id_ciudad';
    protected $fillable =
    [  'departamento',
       'nombre_ciudad'
    ];

    public function departamento(){

        return $this->belongsTo(Departamentos::class, "id_departamento");
    }
}
