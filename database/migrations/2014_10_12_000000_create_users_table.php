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
        Schema::create('users', function (Blueprint $table) {
            $table->id('id_user');
            $table->string('name', 50);
            $table->string('email', 60)->unique();
            $table->integer('identificacion',20)->unique();
            $table->unsignedBigInteger('rol_id',11)->nullable();
            // se hace la relacion de la tabla
            $table->foreign('rol_id')->references('id_rol')->on('roles');
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password', 30);
            $table->rememberToken();
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
        Schema::dropIfExists('users');
    }
};