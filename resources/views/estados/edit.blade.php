
@extends('adminlte::page')

@section('title', 'Editar Estados')

@section('content_header')
  
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Editar Estados') }}
        </h2>
    </x-slot >
    <div class="container"   style=  "background:linear-gradient(30deg, white,#004593, white, #004593, white); "
    class="vh-100 gradient-custom">
    <div class="row">
    <div class="col-md-4"></div> 
    <div class="card border-black mb-3" style="max-width: 20rem;">
        <div class="card-header">Editar estado</div>
        <div class="card-body text-primary">

            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 bg-white border-b border-gray-200">
                        <form action="   {{route('estados.update',  $estados)}}" method="POST" >
                            <!--esitar methodo put-->
                            @csrf
                              @method('PUT')
                              @include('estados._form')
                              
                              </form>

                    </div>
                </div>
            </div>

        </div>
    </div>
    
    <div class="col-md-4"></div>
</div>
    </div>
    <br>
  
</x-app-layout>

@stop

@section('css')
    <link rel="stylesheet" href="/css/admin_custom.css">
@stop

@section('js')
    <script> console.log('Hi!'); </script>
@stop