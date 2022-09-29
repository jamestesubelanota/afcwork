<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('sedes', function (Blueprint $table) {
            $table->id('id_sede' , 11);
            $table->string('nombre_sede', 20);
            $table->string('direccion',30);
            $table->string('contacto',20);
            $table->integer('telefono',16);
            //se crea campo a relacionar
            $table->unsignedBigInteger('ciudad_id',11);
            // se hace la relacion de la tabla
            $table->foreign('ciudad_id')->references('id_ciudad')->on('ciudades');
            //campo a relacionar
            $table->unsignedBigInteger('cliente_id',11);
            // se hace la relacion de la tabla
            $table->foreign('cliente_id')->references('id_cliente')->on('clientes');
            $table->timestamps();
            
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('sede');
    }
};
