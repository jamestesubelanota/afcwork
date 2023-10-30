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
            <div class="row">

                <div class="col-md-4"></div>
                <div class="mb-3 border-black card" style="max-width: 20rem;">
                    <div class="card-header">Agregar una Ciudad</div>
                    <div class="card-body text-primary">

                        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
                            <div class="overflow-hidden bg-white shadow-sm sm:rounded-lg">
                                <div class="p-6 bg-white border-b border-gray-200">
                                    <form action=" {{ route('cargos.store') }}" method="POST">
                                        <!--esitar methodo put-->
                                        @csrf
                                        @include('cargos._form')

                                    </form>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="col-md-4"></div>
            </div>
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
