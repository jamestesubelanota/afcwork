<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Clientes extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_cliente';
        protected $fillable =  ['id_cliente','nombre_cliente', 'nit', 'razon_social', 'detalle','id_colaborador'] ;

        public  function cliente(){

            return $this->belongsTo(Sede::class, "id_cliente");
        }
        public  function colaborador(){

            return $this->belongsTo(Colaboradores::class, "id_colaborador");
        }
    }


