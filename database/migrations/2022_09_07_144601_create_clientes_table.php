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
            $table->string('nombre_cliente', 100);
            $table->string('nit' , 40);
            $table->string('razon_social' ,100);
            $table->string('detalle', 150);
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
