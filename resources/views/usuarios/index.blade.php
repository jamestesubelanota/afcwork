
@extends('adminlte::page')

@section('title', 'Dashboard')

@section('content_header')
   
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Activos') }}
        </h2>
    </x-slot>

    <div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
    class="vh-100 gradient-custom">
    <br>
    <div class="row">
        @csrf
  
    
        <div class="card border-black mb-3" >
            <div class="card-header"> <nav class="navbar bg-light">
                <div class="container-fluid">
                    <a class="btn btn-primary" href="{{ route('usuarios.create') }}"> Agregar usuario </a>
                </div>
            </nav></div>
            <div class="card-body text-primary">

                <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                        <div class="p-6 bg-white border-b border-gray-200">
                            <table id="activos" class="table table-striped" style="width:80%">
                     
                                <thead>
                                    <tr>
                                        <th>id</th>
                                       
                                        <th>usuario</th>
                                        <th>Identificacion</th>
                                        <th>email</th>
                                   
                                        <th>opciones</th>
                                    
                                       
                                    </tr>
                                </thead>
                                <tbody>
        
                                  @foreach ($usuarios as $us )
                                  <tr>
                                    <td>{{ $us->id_user }}</td>
                                    <td>{{ $us->name}}</td>
                                    <td>{{ $us->identificacion}}</td>
                                    <td>{{ $us->email }}</td>
                            
                   
                                                      <td class=" px-6 py-6">
                                                    <div class="dropdown">
                                                        <a class="btn btn-secondary dropdown-toggle" href="#"
                                                            role="button" id="dropdownMenuLink" data-toggle="dropdown"
                                                            aria-haspopup="true" aria-expanded="false">
                                                            Acciones
                                                        </a>
        
                                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                                         
                                                              <a    href="{{ route('usuarios.edit', $us) }}" class="dropdown-item">Asignar rol</a>
                
                                                
                                                                <form
                                                                action="{{ route('usuarios.destroy', $us) }}"
                                                                method="POST">
                
                                                                @csrf
                                                                @method('DELETE')
                                                                <input type="submit" value="Eliminar"
                                                                class="dropdown-item"
                                                                    onclick="return confirm('desea eliminar ?')">
                
                                                            </form>
        
        
                                                        </div>
                                                    </div>
                                                </td>
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
                                
                                </tr>
                                  @endforeach
        
                                </tbody>
                        </table>

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
    <script> console.log('Hi!'); </script>
    <script src=" https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
    <script src="   https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
  <script>
      $(document).ready(function () {
        $('#activos').DataTable({
            language: {
    "search": "Buscar:",
    "infoFiltered": "(Filtrado de _MAX_ total entradas)",

        //
    "info": "Mostrando _START_ a _END_ de _TOTAL_ Usuarios",


    "paginate": {
       
"first": "Primero",
"last": "Ultimo",
"next": "Siguiente",
"previous": "Anterior"
}

}

        }
       );
    });
  </script>
 
@stop