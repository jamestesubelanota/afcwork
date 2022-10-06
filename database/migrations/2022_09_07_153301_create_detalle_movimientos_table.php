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
            $table->id('id_detalle',11);
            $table->unsignedBigInteger('id_activo');
            // se hace la relacion de la tabla
            $table->foreign('id_activo')->references('id_activo')->on('activos');
            $table->unsignedBigInteger('id_cabezera');
            // se hace la relacion de la tabla
            $table->foreign('id_cabezera')->references('id_cabezera')->on('cabezera_movimientos');
            $table->date('inicio');
            $table->date('fin');
            $table->string('detalle',30);
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
