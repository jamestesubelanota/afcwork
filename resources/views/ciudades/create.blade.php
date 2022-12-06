@extends('adminlte::page')

@section('title', 'Crear un Ciudad')

@section('content_header')

    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="#">Ciudades </a></li>
            <li class="breadcrumb-item active" aria-current="page">Agregar ciudad</li>
        </ol>
    </nav>
@stop

@section('content')
    <x-app-layout>
        <x-slot name="header">

        </x-slot>

        <div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
            class="vh-100 gradient-custom">
            <br>
          
        </div>
        </div>
    </x-app-layout>

@stop

@section('css')
    <link rel="stylesheet" href="/css/admin_custom.css">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
@stop

@section('js')
    <script>
        console.log('Hi!');
    </script>
@stop
