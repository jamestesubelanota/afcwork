<?php

namespace App\Models;

use App\Http\Controllers\EstadosController;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Activo extends Model
{
    use HasFactory;

    protected $primaryKey = "id_activo";
    protected $fillable = 
    ["activo",
    "activocontable",
    "id_equipo",
    "id_marca",
    "serial",
    "costo",
    "modelo",
    "id_propietario",
    "id_proveedor",
     "id_estado",
     "id_tipoEquipo",
     "id_cliente",
     "id_sede",
     "id_usuario",
     "foto", 
     "foto2"
    ];


    public  function equipo(){

        return $this->belongsTo(Equipo::class, 'id_equipo');
    }  public  function marca(){

        return $this->belongsTo(Marca::class, 'id_marca');
    }
    public  function proveedor(){

        return $this->belongsTo(Proveedores::class, 'id_proveedor');
    }
    public  function estado(){

        return $this->belongsTo(Estados::class, "id_estado");
    }
    public  function tipoequipo(){

        return $this->belongsTo(TipoDeEquipo::class, "id_tipoEquipo");
    }
    public  function cliente(){

        return $this->belongsTo(Clientes::class, "id_cliente");
    }
    public  function sede(){

        return $this->belongsTo(Sede::class, "id_sede");
    }
    public  function usuario(){

        return $this->belongsTo(User::class, "id_usuario");
    }
    public  function propietario(){

        return $this->belongsTo(Propietarios::class, "id_propietario");
    }

}
