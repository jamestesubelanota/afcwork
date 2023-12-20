@extends('adminlte::page')

@section('title', 'Crear un activo')

@section('content_header')

@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800">
            {{ __('Activo / Ver activos') }}
        </h2>
    </x-slot >
    <div class="container"  >
        <div class="text-center border-0 card">
            <div class="bg-transparent border-0 card-header">
                <h1 class="text-uppercase">Activo</h1>
            </div>
            <div class="card-body row" >
                <div class="col-md-6">
                    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-indicators">
                            @foreach($fotos as $key => $foto)
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="{{ $key }}" @if($key === 0) class="active" @endif aria-label="Slide {{ $key + 1 }}"></button>
                            @endforeach
                        </div>
                        <div class="carousel-inner">
                            @foreach($fotos as $key => $foto)
                            <div class="carousel-item @if($key === 0) active @endif">
                                <img src="{{$foto->foto}}" class="d-block w-100" alt="...">
                            </div>
                            @endforeach
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Anterior</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Siguiente</span>
                        </button>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="border-0 card">
                        <div class="bg-transparent border-0 card-header">
                            <h5>Activo Fijos: {{$activo->activo}}</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <p class="fs-5">Equipo {{$activo->tipoEquipo->tipo_de_equipo}}</p>
                            </div>
                            <div class="mb-3">
                                <p class="fs-5">Este equipo se encuentra en el cliente {{$activo->cliente->nombre_cliente}} en la sede {{$activo->sede->nombre_sede}}</p>
                            </div>
                            <!-- Resto de tu formulario -->
                            <!-- ... -->
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer text-muted">
                @foreach ($movimientos as $movimiento)
                <li class="list-group-item">Activo: {{$movimiento->activo->activo}}<br>
                    <p>Ubicacion: {{$movimiento->cabecera->sedes->nombre_sede}}<br>{{$movimiento->cabecera->inicio}}</p>
                    {{$movimiento->cabecera->tipoMovimiento->movimiento}}
                </li>
                @endforeach
            </div>
        </div>
    </div>
</x-app-layout>
@stop

@section('css')
    <style>

        /* Estilos para la apariencia de interfaz de carro Tesla */
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .carousel-indicators {
            bottom: 10px;
        }

        .carousel-indicators button {
            background-color: #d4d4d4;
            border-radius: 50%;
            border: none;
            width: 12px;
            height: 12px;
            margin: 0 5px;
        }

        .carousel-indicators .active {
            background-color: #000;
            width: 12px;
            height: 12px;
        }

        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            background-color: #000;
        }

        .carousel-control-prev,
        .carousel-control-next {
            width: 5%;
        }

        .card-header {
            background-color: #000;
            color: #fff;
            border-bottom: none;
            border-radius: 15px 15px 0 0;
        }

        .card-body {
            background-color: #f5f5f5;
        }

        .card-footer {
            background-color: #0f0101;
            border-top: none;
            border-radius: 0 0 15px 15px;
        }

        .list-group-item {
            background-color: #f5f5f5;
            border: none;
            border-radius: 10px;
            margin-bottom: 5px;
        }
    </style>
@stop


@section('js')
    <!-- Aquí puedes agregar scripts si es necesario -->
@stop
