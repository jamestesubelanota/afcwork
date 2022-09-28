
@extends('adminlte::page')

@section('title', 'Crear un activo')

@section('content_header')
    <h1>Activos fijos</h1>
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Crear un activos') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                <form action=" {{route('activos.store')}}" method="POST" enctype="multipart/form-data">
              <!--esitar methodo put-->
             
                @include('activos._form')
                
                </form>
               
                </div>
            </div>
        </div>
    </div>
</x-app-layout>

@stop

@section('css')
  
@stop

@section('js')
    <script> console.log('Hi!'); </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>

  
    
@stop