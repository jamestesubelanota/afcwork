<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Sedes;
use App\Models\Colaboradores;

class ColaboradorSedes extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_colaborador_sede';
    protected $fillable =  ['id_colaborador_sede','id_colaborador', 'id_sede'] ;


    public  function colaborador(){

        return $this->belongsTo(Colaboradores::class, "id_colaborador");
    }
    public  function sedes(){

        return $this->belongsTo(Sede::class, "id_sede");
    }
}
