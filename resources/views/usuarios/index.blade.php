@extends('adminlte::page')

@section('title', 'Usuarios')

@section('content_header')

@stop

@section('content')
    <x-app-layout>
        <x-slot name="header">
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                {{ __('Usuarios') }}
                <a class="bg-gray-800 text-white rounded px-4 py-2" href="{{ route('auth.register') }}"> crear</a>
            </h2>
        </x-slot>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 bg-white border-b border-gray-200">
                        <table id="ciudad" class="table table-striped" style="width:80%">

                            <thead>
                                <tr>
                                    <th>Municipio</th>
                                    <th>Ciudad</th>
                                    <th>Opcciones</th>


                                </tr>
                            </thead>
                            <tbody>

                                @foreach ($usuarios as $usuario)
                                    <tr>
                                        <td></td>
                                        <td></td>



                                    
                                    </tr>
                                @endforeach

                            </tbody>

                    </div>
                </div>
            </div>
        </div>
    </x-app-layout>
@stop

@section('css')
    <link rel="stylesheet" href="/css/admin_custom.css">

@stop

@section('js')
    <script>
        console.log('Hi!');
    </script>
    <script src=" https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
    <script src="   https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#ciudad').DataTable();
        });
    </script>

@stop
