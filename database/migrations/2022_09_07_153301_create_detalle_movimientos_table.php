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
        Schema::create('detalle_movimientos', function (Blueprint $table) {
            $table->unsignedInteger('id_detalle', 11);
            // se hace la relacion de la tabla
            $table->unsignedInteger('id_activo');
            $table->foreign('id_activo')->references('id_activo')->on('activos');
         // se hace la relacion de la tabla
            $table->unsignedInteger('id_cabecera',11);
            $table->foreign('id_cabecera')->references('id_cabecera')->on('cabecera_movimientos');


            $table->string('detalle',150);
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
        Schema::dropIfExists('detalle_movimiento');


    }
};
