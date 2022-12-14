
@extends('adminlte::page')

@section('title', 'Editar Ciudad')

@section('content_header')
    <h1>Activos fijos</h1>
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Editar rol') }}
        </h2>
    </x-slot>

    <div class="row">

   
        <div class="card border-black mb-3" >
            <div class="card-header">Lista de permisos</div>
            <div class="card-body text-primary">

                <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                        <div class="p-6 bg-white border-b border-gray-200">

                        
                            <form action="   {{route('roles.update',  $roles)}}" method="POST" >
                                <!--esitar methodo put-->   @csrf
                                  @method('PUT')
                                  @include('roles._form')
                                  
                                  </form>
                            
                   
                        </div>
                    </div>
                </div>

            </div>
        </div>
      
    </div>



  
    
</x-app-layout>

@stop

@section('css')
    <link rel="stylesheet" href="/css/admin_custom.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap5.min.css">
@stop

@section('js')

    <script src=" https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
    <script src="   https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#roles').DataTable();
        });
    </script>

@stop