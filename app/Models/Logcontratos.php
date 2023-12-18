<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Logcontratos extends Model
{
    use HasFactory;

    use HasFactory;
    public $timestamps = false;
    protected $primaryKey= 'id_log';
    protected $fillable =['id_contrato', 'tipo_de_contrato', 'codigo', 'id_cliente', 'usuario', 'fecha', 'accion'];

}
