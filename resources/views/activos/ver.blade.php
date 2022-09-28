
@extends('adminlte::page')

@section('title', 'Crear un activo')

@section('content_header')
  
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Activo / Ver activos') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
              
                    <div class="jumbotron">

                        <div class="row">
                        
                         <div class="card" style="width: 18rem;">
                          
                          <div> <img class="card-img-top" src="{{asset($activo->foto2)}}" alt="Card image cap"></div>
                          </div>
                          <div class="card" style="width: 18rem;">
                          
                            <img class="card-img-top" src="{{asset($activo->foto)}}" alt="Card image cap">
                            </div>
                        </div>
                           <div> <h1 class="display-4">Activo, {{$activo->activo}}</h1>
                            <div class="alert alert-primary" role="alert">
                                <p class="lead">Equipo {{$activo->tipoEquipo->tipo_de_equipo}}</p></div>
                                <div class="alert alert-success" role="alert">
                                <p class="lead">Este equipo su sede actual es {{$activo->sede->nombre_sede}}</p></div>
                                <a class= "btn btn-dark  " href="{{route('activos.index')}}" >volver</a>
                        </div>
                    
                          </div>
                        
                        <hr class="my-4">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                              <span class="input-group-text" id="basic-addon1">Marca</span></div>
                          <p class="form-control">{{ $activo->marca->marca}}</p>
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                              <span class="input-group-text" id="basic-addon1">Equipo</span></div>
                          <p class="form-control">{{  $activo->equipo->equipo}}</p>
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                              <span class="input-group-text" id="basic-addon1">Serial</span></div>
                          <p class="form-control">{{  $activo->serial}}</p>
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                              <span class="input-group-text" id="basic-addon1">Costo</span></div>
                          <p class="form-control">{{  $activo->costo}}</p>
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                              <span class="input-group-text" id="basic-addon1">Proveedor</span></div>
                          <p class="form-control">{{  $activo->proveedor->nombre_proveedor}}</p>
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                              <span class="input-group-text" id="basic-addon1">Estado</span></div>
                          <p class="form-control">{{  $activo->estado->estado}}</p>
                        </div>
                      
                      
                        
                           
                           <hr>
                           <ul class="list-group">
                            
                      @foreach ($movimientos as $movimiento)
                      <li class="list-group-item "> Activo: {{$movimiento->activo->activo}}  <p >Ubicacion  :{{$movimiento->cabecera->sedes->nombre_sede}} </p> </li>
                      
                        @endforeach
              
                                  </ul>
                                    
                          
                          
                        
               
                      </div>
          
               
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
<script type="text/javascript">


       
         </script>
  
    
@stop