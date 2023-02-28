@extends('adminlte::page')

@section('title', 'Activos')

@section('content_header')

@stop

@section('content')

    <x-app-layout>
        <x-slot name="header">
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                {{ __('Activos') }}
                <a class="bg-gray-800 text-white rounded px-4 py-2" href="{{ route('activos.create') }}"> crear</a>
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
                            <a class="btn btn-primary" href="{{ route('activos.create') }}"> Agregar un activo </a>
                        </div>
                    </nav>
    
                </div>
                <div class="card-body">
                    
                <table id="Proveedores" class="table table-striped" style="width:80%">

                    <thead>
                        <tr>
                            <th>Activo</th>
                            <th>Equipo</th>
                            <th>Marca</th>
                            <th>Serial</th>
                            <th>Costo</th>
                            <th>Cliente</th>
                            <th>Ubicacion Actual</th>
                            <th>Proveedor</th>
                            <th>Estado</th>
                            <th>tipo</th>
                            <th>Modelo</th>
                            <th>Propietario</th>
                            <th>id activo pgadmin</th>
                            <!---usuario--->
                            <th>Opciones</th>



                        </tr>
                    </thead>
                    <tbody>

                        @foreach ($activos as $activo)
                            <tr>
                                <td>   <a href="{{ route('activos.show', $activo->id_activo) }}"
                                    class="btn btn-light">{{ $activo->activo}}</a></td>
                                <td>{{ $activo->equipo->equipo }}</td>
                                <td>{{ $activo->marca->marca }}</td>
                                <td>{{ $activo->serial }}</td>
                                <td>{{number_format($activo->costo)  }}</td>
                                <td>{{$activo->cliente->nombre_cliente ?? ''  }}</td>
                                <td>{{ $activo->sede->nombre_sede }}</td>
                                <td>{{ $activo->proveedor->nombre_proveedor }}</td>
                                <td>{{ $activo->estado->estado }}</td>
                                <td>{{ $activo->tipoEquipo->tipo_de_equipo }}</td>
                                <td>{{ $activo->modelo }}</td>
                                <td>{{ $activo->propietario->nombre_propietario }}</td>
                                <td>{{ $activo->id_activo }}</td>

                                <td class=" px-6 py-6">
                                    <div class="dropdown">
                                        <a class="btn btn-secondary dropdown-toggle" href="#" role="button"
                                            id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
                                            aria-expanded="false">
                                            Acciones
                                        </a>

                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                            <a href="{{ route('activos.edit', $activo->id_activo) }}"
                                                class="dropdown-item">Editar</a>
                                            <a href="{{ route('activos.show', $activo->id_activo) }}"
                                                class="dropdown-item">ver</a>

                                            <form action="   {{ route('activos.destroy', $activo->id_activo) }}"
                                                method="POST">

                                                @csrf
                                                @method('DELETE')
                                                <input type="submit" value="Eliminar" class="dropdown-item"
                                                    onclick="return confirm('desea eliminar ?')">

                                            </form>



                                        </div>
                                    </div>
                                </td>

                            </tr>
                        @endforeach

                    </tbody>
                </Table>
    
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
    <link rel="stylesheet" href="	https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap5.min.css">
@stop

@section('js')

    <script src=" https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
    <script src="   https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#Proveedores').DataTable({

                
                scrollX: true,
                scrollY: '200px',
        scrollCollapse: true,
        paging: false,
                language: {
    "search": "Buscar:",

        //
    "info": "Mostrando _START_ a _END_ de _TOTAL_ Activos",


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
