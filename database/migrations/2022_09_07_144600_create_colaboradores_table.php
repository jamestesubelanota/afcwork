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
            $table->unsignedInteger('id_colaborador', 4);
            $table->string('nombre_colaborador',100);
            $table->string('identificacion' ,50);
            $table->double('telefono',16);
            $table->unsignedInteger('id_cargo');
            $table->foreign('id_cargo')->references('id_cargo')->on('cargos');

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
        Schema::dropIfExists('colaboradores');
    }
};
