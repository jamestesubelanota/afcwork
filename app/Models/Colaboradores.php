<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Spatie\Permission\Contracts\Role as ContractsRole;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;


class Colaboradores extends Model
{
    use HasFactory;

    protected $primaryKey = "id_colaborador";
    protected $fillable =['nombre_colaborador', 'identificacion', 'telefono', 'id_cargo'];

   
    public function cargos(){
        return $this->belongsTo( Cargo::class, 'id_cargo');
    }
}
