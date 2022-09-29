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
        Schema::create('cabezera_movimientos', function (Blueprint $table) {
            $table->id('id_cabezera');
            $table->unsignedBigInteger('id_cliente');
            // se hace la relacion de la tabla
            $table->foreign('id_cliente')->references('id_cliente')->on('clientes');
            $table->unsignedBigInteger('id_sede');
            // se hace la relacion de la tabla
            $table->foreign('id_sede')->references('id_sede')->on('sedes');
            $table->unsignedBigInteger('id_tmovimiento');
            // se hace la relacion de la tabla
            $table->foreign('id_tmovimiento')->references('id_tmovimiento')->on('tipo_movimientos');
            $table->unsignedBigInteger('id_user');
            // se hace la relacion de la tabla
            $table->foreign('id_user')->references('id_user')->on('users');
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
        Schema::dropIfExists('cabezera_movimiento');
    }
};
