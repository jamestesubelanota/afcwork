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
        Schema::create('cabecera_movimientos', function (Blueprint $table) {
            $table->increments('id_cabecera', 11);
            $table->unsignedInteger('id_cliente');
            // se hace la relacion de la tabla
            $table->foreign('id_cliente')->references('id_cliente')->on('clientes');
            $table->unsignedInteger('id_sede');
            // se hace la relacion de la tabla
            $table->foreign('id_sede')->references('id_sede')->on('sedes');
            $table->unsignedInteger('id_tmovimiento');
            // se hace la relacion de la tabla
            $table->foreign('id_tmovimiento')->references('id_tmovimiento')->on('tipo_movimientos');
            $table->unsignedInteger('id_user');
            // se hace la relacion de la tabla
            $table->foreign('id_user')->references('id_user')->on('users');
            $table->date('inicio');
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
        Schema::dropIfExists('cabecera_movimiento');
    }
};
