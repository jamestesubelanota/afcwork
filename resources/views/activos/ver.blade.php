
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
<div class="container">
  <div class="card text-center  ">
    <div class="card-header border border-primary">
    <h1>Activo </h1>
    </div>
    <div class="card-body">
     <div class="row">

      <div class="col-md-6" > <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="true">
        <div class="carousel-indicators">
          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
          <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
       @foreach($fotos as $foto)
          <div class="carousel-item active">
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
      </div></div>
      <div class="col-md-6" >

        <div class="card">
          <div class="card-header">
           <h5> Activo Fijos :{{$activo->activo}}</h5> 
           
          </div>
          <div class="card-body">
            <blockquote style="text-align: left" class="blockquote mb-0">
              <div> 
                <div class="alert alert-primary" role="alert">
                    <p class="">Equipo {{$activo->tipoEquipo->tipo_de_equipo}}</p></div>
                    <div class="alert alert-success" role="alert">
                    <p class="lead">Este equipo se encuentra en la sede {{$activo->sede->nombre_sede}}</p></div>
               
            </div>
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
            </blockquote>
          </div>
        </div>
      

      </div>
     </div>
    </div>
    <div style="text-align: left" class="card-footer text-muted">
           
      @foreach ($movimientos as $movimiento)
      <li class="list-group-item "> Activo: {{$movimiento->activo->activo}}  <br> <p >Ubicacion  :{{$movimiento->cabecera->sedes->nombre_sede}}  <br> {{$movimiento->cabecera->inicio}} </p> </li>
      
        @endforeach
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    
@stop