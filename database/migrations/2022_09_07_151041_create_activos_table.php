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
            $table->unsignedInteger('id_activo',11);
            $table->string('activo',7);
            $table->unsignedInteger('id_equipo');
            // se hace la relacion de la tabla
            $table->foreign('id_equipo')->references('id_equipo')->on('equipos');
            $table->unsignedInteger('id_marca');
            // se hace la relacion de la tabla
            $table->foreign('id_marca')->references('id_marca')->on('marcas');
            $table->string('serial', 100);
            $table->string('activocontable', 4);
            $table->double('costo',100);
            $table->string('modelo', 50);
            // se hace la relacion de la tabla
            $table->unsignedInteger('id_propietario');
            // se hace la relacion de la tabla
            $table->foreign('id_propietario')->references('id_propietario')->on('propietarios');
            $table->unsignedInteger('id_proveedor');
            // se hace la relacion de la tabla
            $table->foreign('id_proveedor')->references('id_proveedor')->on('proveedores');
            // // se hace la relacion de la tabla
            $table->unsignedInteger('id_estado');
            // se hace la relacion de la tabla
            $table->foreign('id_estado')->references('id_estado')->on('estados');
            // // se hace la relacion de la tabla
            $table->unsignedInteger('id_tipoEquipo');
            // se hace la relacion de la tabla
            $table->foreign('id_tipoEquipo')->references('id_equipo')->on('tipo_de_equipos');

            $table->unsignedInteger('id_cliente');
            // se hace la relacion de la tabla
            $table->foreign('id_cliente')->references('id_cliente')->on('clientes');

            $table->unsignedInteger('id_sede');
            // se hace la relacion de la tabla
            $table->foreign('id_sede')->references('id_sede')->on('sedes');
            // // se hace la relacion de la tabla
            $table->integer('id_user');
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
        Schema::dropIfExists('activo');
    }
};
