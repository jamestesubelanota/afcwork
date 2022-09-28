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
        Schema::create('contratos', function (Blueprint $table) {
            $table->id('id_contrato');
            $table->string('tipo_de_contrato');
            $table->date('inicio');
            $table->date('fin');
            $table->string('estado');
            $table->unsignedBigInteger('cliente_id');
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
        Schema::dropIfExists('_contrato');
    }
};
