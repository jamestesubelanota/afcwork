
@extends('adminlte::page')

@section('title', 'Crear un rol')

@section('content_header')
   
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
   
    </x-slot>
    <div class="container"
    class="vh-100 gradient-custom">
    <br>
    <div class="row">

   
        <div class="card border-black mb-3   "  >
            <div class="card-header   ">Lista de permisos</div>
            <div class="card-body text-primary">

                <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                        <div class="p-6 bg-white border-b border-gray-200">

                            <form action=" {{ route('roles.store') }}" method="POST">
                                @csrf
                                <span style="color: red" > @error('name') {{$message}}
    
                                    @enderror </span>
                                <label  class="form-control" for="">Nombre</label>
                                <input id="name" name="name" class="form-control" type="text">
                                <input type="submit">
                                  
                                <hr>

                                <h2 class="h3"> Lista de permisos</h2>

                                <table id="roles" class="table table-striped" style="width:90%">

                                    <thead>
                                        <tr>
                                            <th>Permisos</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach ($permisos as $pr)
                                             <tr>
                                             <td>   <input type="checkbox"id="permissions[]" name="permissions[]"  value="{{ $pr->id }}"> {{$pr->descripcion}}  </td>
                                             </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                              
                              
                            </form>
                      
                       

                   
                        </div>
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
            $('#roles').DataTable({
                languaje : {
                    "search": "Buscar:"
                }
            });
        });
    </script>

@stop