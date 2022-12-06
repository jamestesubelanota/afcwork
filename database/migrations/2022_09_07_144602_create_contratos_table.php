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
            $table->id('id_contrato',4);
            $table->string('tipo_de_contrato',20);
            $table->date('inicio');
            $table->date('fin');
            $table->string('estado',20);
            $table->unsignedBigInteger('id_cliente');
            $table->foreign('id_cliente')->references('id_cliente')->on('clientes');
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
