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
        Schema::create('clientes', function (Blueprint $table) {
            $table->id('id_cliente', 11);
            $table->string('nombre_cliente', 20);
            $table->integer('nit');
            $table->string('razon_social' ,30);
            $table->string('detalle', 20);
            $table->timestamps();
            $table->unsignedBigInteger('id_colaborador');
            $table->foreign('id_colaborador')->references('id_colaborador')->on('colaboradores');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('clientes');
    }
};
