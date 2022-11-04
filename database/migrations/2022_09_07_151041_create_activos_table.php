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
        Schema::create('activos', function (Blueprint $table) {
            $table->id('id_activo',11);
            $table->string('activo',20);
            $table->unsignedBigInteger('id_equipo');
            // se hace la relacion de la tabla
            $table->foreign('id_equipo')->references('id_equipo')->on('equipos');
            $table->unsignedBigInteger('id_marca');
            // se hace la relacion de la tabla
            $table->foreign('id_marca')->references('id_marca')->on('marcas');
            $table->string('serial', 40);
            $table->double('costo',30);
            $table->string('modelo', 40);
            $table->string('propietario', 40);
            $table->unsignedBigInteger('id_proveedor');
            // se hace la relacion de la tabla
            $table->foreign('id_proveedor')->references('id_proveedor')->on('proveedores');
            // // se hace la relacion de la tabla
            $table->unsignedBigInteger('id_estado');
            // se hace la relacion de la tabla
            $table->foreign('id_estado')->references('id_estado')->on('estados');
            // // se hace la relacion de la tabla
            $table->unsignedBigInteger('id_tipoEquipo');
            // se hace la relacion de la tabla
            $table->foreign('id_tipoEquipo')->references('id_equipo')->on('tipo_de_equipos');
            $table->unsignedBigInteger('id_sede');
            // se hace la relacion de la tabla
            $table->foreign('id_sede')->references('id_sede')->on('sedes');
            // // se hace la relacion de la tabla
            $table->unsignedBigInteger('id_user');
            // se hace la relacion de la tabla
            $table->foreign('id_user')->references('id_user')->on('users');
            $table->string('foto');
            $table->string('foto2');
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
        Schema::dropIfExists('activo');
    }
};
