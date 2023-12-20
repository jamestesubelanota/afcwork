<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Clientes;
class Sede extends Model
{
    use HasFactory;



    protected $primaryKey = 'id_sede';
    protected $fillable= [
        'nombre_sede',
         'direccion',
         'contacto' ,
         'telefono',
         'ciudad_id',
         'cliente_id'];


         public  function cliente(){

            return $this->belongsTo(Clientes::class , 'cliente_id');
        }
        public  function ciudad(){

            return $this->belongsTo(Ciudades::class , 'ciudad_id');
        }
        public  function departamento(){

            return $this->belongsTo(Departamentos::class , 'id_departamento');
        }


}
