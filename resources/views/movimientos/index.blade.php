
@extends('adminlte::page')

@section('title', 'Movimientos')

@section('content_header')
   
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Movimientos') }}
            <a  class="bg-gray-800 text-white rounded px-4 py-2" 
            href="{{route('movimientos.create')}}"> Generar movimientos</a>
            <p>Codigo del proximo movimiento : <li>{{$proximo->id_cabezera}}</li> </p> 
        </h2>
    </x-slot>

    <div class="py-12">
        
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
       
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                    <table id="movimientos" class="table table-striped" style="width:80%">
                     
                        <thead>
                            <tr>
                               
                                <th>Cliente</th>
                                <th>Sede</th>
                                <th>Movimiento</th>
                                <th>Opciones</th>
                              
                               
                            </tr>
                        </thead>
                        <tbody>

                          @foreach ( $movimientos as $movimiento)
                          <tr>
                        
                            <td>{{ $movimiento->clientes->nombre_cliente}}</td>
                            <td>{{ $movimiento->sedes->nombre_sede}}</td>
                            <td>{{ $movimiento->tipoMovimiento->movimiento}}</td>
                            <td class=" px-6 py-6">
                              
                                <div class="dropdown">
                                    <a class="btn btn-secondary dropdown-toggle" href="#" role="button"
                                        id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">
                                        Acciones
                                    </a>

                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">

                                        
                                        <a href="{{route('movimientos.edit', $movimiento)}}"   class="bg-gray-800 text-white rounded px-4 py-2" >editar</a>
                                       

                                        <form action="   {{route('movimientos.destroy', $movimiento)}}" method="POST" >
            
                                            @csrf
                                            @method('DELETE')
                                                <input 
                                                type="submit" 
                                                value="Eliminar" 
                                                class="bg-gray-800 text-white rounded px-4 py-2" 
                                                onclick="return confirm('desea eliminar ?')"
                                                >
                                
                                            </form>

                                            <a href="{{route('movimientos.edit', $movimiento)}}"   class="bg-gray-800 text-white rounded px-4 py-2" >Generar carta</a>
                                            <a href="{{route('movimientos.edit', $movimiento)}}"   class="bg-gray-800 text-white rounded px-4 py-2" >Generar Formato prestamos</a>
                                    </div>
                                    
                                </div>
                            </td>
                             
                               
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
<link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap5.min.css">
@stop

@section('js')
    <script> console.log('Hi!'); </script>
    <script src=" https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
    <script src="   https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
  <script>
   
  </script>
  <script>
    $(document).ready(function() {
        $('#movimientos').DataTable();
    });
</script>
@stop