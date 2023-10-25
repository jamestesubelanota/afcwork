@extends('adminlte::page')

@section('title', 'Sedes')

@section('content_header')

@stop

@section('content')
    <x-app-layout>
        <x-slot name="header">
          
        </x-slot>


        <div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
        class="vh-100 gradient-custom">
        <br>
    
        <section>
            <div class="card ">
                <div class="card-header">
                    <nav class="navbar bg-light">
                        <div class="container-fluid">
                            <a class="btn btn-primary" href="{{ route('sedes.create') }}"> Agregar una sede </a>
                        </div>
                    </nav>
    
                </div>
                <div class="card-body">
                    <table id="Proveedores" class="table table-striped" style="width:80%">

                        <thead>
                            <tr>
                                <th>Nombre_sede</th>
                                <th>Direccion</th>
                                <th>Contacto</th>
                                <th>Telefono</th>
                                <th>Ciudad</th>
                                <th>Cliente</th>
                                <th>Opciones</th>


                            </tr>
                        </thead>
                        <tbody>

                            @foreach ($sedes as $sede)
                                <tr>
                                    <td>{{ $sede->nombre_sede }}</td>
                                    <td>{{ $sede->direccion }}</td>
                                    <td>{{ $sede->contacto }}</td>
                                    <td>{{ $sede->telefono }}</td>
                                    <td> <Span>{{ $sede->ciudad->nombre_ciudad }}</Span> </td>
                                    <td> <Span>{{ $sede->cliente->nombre_cliente }}</Span> </td>


                                    <td class=" px-6 py-6">

                                        <div class="dropdown">
                                            <a class="btn btn-secondary dropdown-toggle" href="#" role="button"
                                                id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
                                                aria-expanded="false">
                                                Acciones
                                            </a>

                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                              <li><a href="{{ route('sedes.edit', $sede->id_sede) }}"
                                                class="dropdown-item active">Editar</a></li>  

                                                <form action="   {{ route('sedes.destroy', $sede->id_sede) }}"
                                                    method="POST">

                                                    @csrf
                                                    @method('DELETE')
                                                   <li> <input type="submit" value="Eliminar"
                                                    class="dropdown-item"
                                                    onclick="return confirm('desea eliminar ?')"></li>

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
    <script>
        console.log('Hi!');
    </script>
    <script src=" https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
    <script src="   https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#Proveedores').DataTable({

language: {
    "search": "Buscar:",

        //
    "info": "Mostrando _START_ a _END_ de _TOTAL_ Sedes",


    "paginate": {
"first": "Primero",
"last": "Ultimo",
"next": "Siguiente",
"previous": "Anterior"
}
}

});
        });
    </script>

@stop
