
@extends('adminlte::page')

@section('title', 'Sedes')

@section('content_header')
   
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Sedes') }}
            <a  class="bg-gray-800 text-white rounded px-4 py-2" 
            href="{{route('sedes.create')}}"> crear</a>
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                    <table id="Proveedores" class="table table-striped" style="width:80%">
                     
                        <thead>
                            <tr>
                                <th>nombre_sede</th>
                                <th>direccion</th>
                                <th>contacto</th>
                                <th>telefono</th>
                                <th>ciudad</th>
                                <th>cliente</th>
                                <th>Opciones</th>
                                <th>Opciones</th>
                               
                            </tr>
                        </thead>
                        <tbody>

                          @foreach ($sedes as $sede)
                          <tr>
                            <td>{{ $sede->nombre_sede}}</td>
                            <td>{{  $sede->direccion}}</td>
                            <td>{{ $sede->contacto	}}</td>
                            <td>{{  $sede->telefono}}</td>
                            <td> <Span>{{  $sede->ciudad->nombre_ciudad}}</Span> </td>
                            <td> <Span>{{  $sede->cliente->nombre_cliente}}</Span> </td>
                           
                            
                            <td class=" px-6 py-6">
                                <a href="{{route('sedes.edit', $sede->id_sede)}}"   class="bg-gray-800 text-white rounded px-4 py-2" >editar</a>
                            
                            </td>
                             <td>    <form action="   {{route('sedes.destroy', $sede->id_sede)}}" method="POST" >
            
                                @csrf
                                @method('DELETE')
                                    <input 
                                    type="submit" 
                                    value="Eliminar" 
                                    class="bg-gray-800 text-white rounded px-4 py-2" 
                                    onclick="return confirm('desea eliminar ?')"
                                    >
                    
                                </form>
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
      $(document).ready(function () {
        $('#Proveedores').DataTable(
       );
    });
  </script>
 
@stop