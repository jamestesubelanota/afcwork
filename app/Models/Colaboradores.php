<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Colaboradores extends Model
{
    use HasFactory;

    protected $primaryKey = "id_colaborador";
    protected $fillable =['nombre_colaborador', 'identificacion', 'telefono', 'id_rol'];

    public function rol(){

        return $this->belongsTo( Roles::class ,'id_rol');
    }
}
