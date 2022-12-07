
@extends('adminlte::page')

@section('title', 'Proveedores')

@section('content_header')
   
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Proveedores') }}
            <a  class="bg-gray-800 text-white rounded px-4 py-2" 
            href="{{route('proveedores.create')}}"> crear</a>
        </h2>
    </x-slot>
    <div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
    class="vh-100 gradient-custom">
    <br>
    <section>
        <div class="card ">
            <div class="card-header">
                <nav class="navbar bg-light">
                    <div class="container-fluid">
                        <a class="btn btn-primary" href="{{ route('proveedores.create') }}"> Agregar caracteristica de equipos </a>
                    </div>
                </nav>

            </div>
            <div class="card-body">
                <table id="Proveedores" class="table table-striped" style="width:90%">

                    <thead>
                        <tr>
                            <th>Nombre_proveedor</th>
                            <th>Nit</th>
                            <th>Direccion</th>
                            <th>Razon_social</th>
                            <th>Opciones</th>
                           
                        </tr>
                    </thead>
                    <tbody>

                        @foreach ($proveedores as $proveedor)
                            <tr>
                                <td>{{  $proveedor->nombre_proveedor}}</td>
                            <td>{{  $proveedor->nit}}</td>
                            <td>{{  $proveedor->direccion}}</td>
                            <td>{{  $proveedor->Razon_social}}</td>
                            



                                <td class=" px-6 py-6">
                                    <div class="dropdown">
                                        <a class="btn btn-secondary dropdown-toggle" href="#" role="button"
                                            id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
                                            aria-expanded="false">
                                            Acciones
                                        </a>

                                        <div class="dropdown-menu dropdown-menu-dark"
                                            aria-labelledby="dropdownMenuLink">
                                            <li>  <a href="{{route('proveedores.edit', $proveedor->id_proveedor )}}"   class="dropdown-item active" >editar</a></li>


                                            <form action="   {{route('proveedores.destroy', $proveedor->id_proveedor)}}" method="POST" >
            
                                                @csrf
                                                @method('DELETE')
                                                    <input 
                                                    type="submit" 
                                                    value="Eliminar" 
                                                    class="dropdown-item " 
                                                    onclick="return confirm('desea eliminar ?')"
                                                    >
                                    
                                                </form>



                                        </div>
                                    </div>
                                </td>

                            </tr>
                        @endforeach

                    </tbody>
                </table>
      

            </div>
            <div class="card-footer text-muted">
                2 days ago
            </div>
        </div>

    </section>
<hr>
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
        $('#Proveedores').DataTable(
       );
    });
  </script>
 
@stop