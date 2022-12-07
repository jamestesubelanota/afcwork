
@extends('adminlte::page')

@section('title', 'Crear una sede')

@section('content_header')
    <h1>Activos fijos</h1>
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Crear una sede') }}
        </h2>
    </x-slot>
    <div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
    class="vh-100 gradient-custom">
    <br>
    <div class="row">

        <div class="col-md-4"></div>
        <div class="card border-black mb-3" style="max-width: 30rem;">
            <div class="card-header">Agregar una sede</div>
            <div class="card-body text-primary">

                <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                        <div class="p-6 bg-white border-b border-gray-200">
                            <form action=" {{route('sedes.store')}}" method="POST" >
                                @csrf
                          <!--esitar methodo put-->
                         
                            @include('sedes._form')
                            
                            </form>

                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="col-md-4"></div>
    </div>

</div>
 
</x-app-layout>

@stop

@section('css')
    <link rel="stylesheet" href="/css/admin_custom.css">
@stop

@section('js')
    <script> console.log('Hi!'); </script>
@stop