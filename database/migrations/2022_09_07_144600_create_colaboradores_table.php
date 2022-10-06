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
        Schema::create('colaboradores', function (Blueprint $table) {
            $table->id('id_colaborador', 11);
            $table->string('nombre_colaborador');
            $table->string('identificacion');
            $table->integer('telefono', 15);
            $table->integer('id_rol',11);
            $table->foreign('id_rol')->references('id_rol')->on('rol');
           
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('colaboradores');
    }
};