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
        Schema::create('colaborador_sede', function (Blueprint $table) {
            $table->increments('id_colaborador_sede',11);

            $table->unsignedInteger('id_colaborador');
            $table->foreign('id_colaborador')->references('id_colaborador')->on('colaboradores');
            $table->unsignedInteger('id_sede');
            $table->foreign('id_sede')->references('id_sede')->on('sedes');
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
        Schema::dropIfExists('colaborador_sede');
    }
};
