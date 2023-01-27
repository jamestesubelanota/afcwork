@extends('adminlte::page')

@section('title', 'Crear un Ciudad')

@section('content_header')

    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="#">Agregar usuario </a></li>
            <li class="breadcrumb-item active" aria-current="page">Agregar Usuario</li>
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
                <div class="card border-black mb-3" style="max-width: 20rem;">
                    <div class="card-header">Agregar un usuario</div>
                    <div class="card-body text-primary">

                        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                                <div class="p-6 bg-white border-b border-gray-200">
                                    <form action="  {{route('usuarios.store')}}" method="POST">
                                 
                                    @csrf
                                    <label class="uppercase text-gray-700 text-xs" >Nombre</label>
                                    <span class="text-xs" style="color: red">@error('name') {{$message}} @enderror  </span>
                                    <input type="text" id="name"  name ="name" class="form-control" value=""  >
                                       <br>
                                       <label class="uppercase text-gray-700 text-xs" >identificacion</label>
                                       <span class="text-xs" style="color: red">@error('identificacion') {{$message}} @enderror  </span>
                                       <input type="text" id="identificacion"  name ="identificacion" class="form-control" value=""
                                         >
                                         <br>
                                         <span class="text-xs" style="color: red">@error('estado') {{$message}} @enderror  </span>
                                        
                                    
                                       <label class="uppercase text-gray-700 text-xs" >Estado</label>
                                       <select name="estado" id="estado"  class="form-select">
                                        <option value="">Seleccione estado </option>
                                         <option value="Activo">Activo</option>
                                         <option value="Inactivo">Inactivo</option>

                                       </select>
                                  
                                    <label class="uppercase text-gray-700 text-xs" >Email</label>
                                    <span class="text-xs" style="color: red">@error('email') {{$message}} @enderror  </span>
                                    <input type="text" id="email"  name ="email" class="form-control" value=""  >
                                  <br>
                                  <label class="uppercase text-gray-700 text-xs" >Contraseña</label>
                                  <span class="text-xs" style="color: red">@error('password') {{$message}} @enderror  </span>
                                  <input type="password" id="password"  name ="password" class="form-control" value="" 
                                   >
                                   <label class="uppercase text-gray-700 text-xs" >Verificacion de contraseña</label>
                                   <span class="text-xs" style="color: red">@error('password_confirmation') {{$message}} @enderror  </span>
                                   <input type="password" id="password_confirmation"  name ="password_confirmation" class="form-control" value="" >
                                  <hr>
                                  <input class="btn btn-primary" type="submit" value="Guardar">
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
<link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap5.min.css">
@stop

@section('js')
    <script> console.log('Hi!'); </script>
    <script src=" https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
    <script src="   https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
  <script>
      $(document).ready(function () {
        $('#ciudad').DataTable(
       );
    });
  </script>
 
@stop