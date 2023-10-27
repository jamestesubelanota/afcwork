
@extends('adminlte::page')

@section('title', 'Clientes')

@section('content_header')

@stop

@section('content')
<x-app-layout>
    <x-slot name="header">

    </x-slot>
    <div class="container">
        <div class="bg-gradient">
            <br>
            <section>
                <div class="card">
                    <div class="card-header">
                        <nav class="navbar bg-light">
                            <div class="container-fluid">
                                <a class="btn btn-primary" href="{{ route('clientes.create') }}"> Agregar un cliente </a>
                            </div>
                        </nav>
                    </div>
                    <div class="card-body">
                        <table id="ClientesTable" class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Nombre Cliente</th>
                                    <th>NIT</th>
                                    <th>Razón Social</th>
                                    <th>Detalle</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($clientes as $cliente)
                                    <tr>
                                        <td>{{ $cliente->nombre_cliente }}</td>
                                        <td>{{ $cliente->nit }}</td>
                                        <td>{{ $cliente->razon_social }}</td>
                                        <td>{{ $cliente->detalle }}</td>
                                        <td class="options">
                                            <div class="dropdown">
                                                <a class="btn btn-secondary dropdown-toggle" href="#" role="button"
                                                    id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
                                                    aria-expanded="false">
                                                    Acciones
                                                </a>
                                                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                                    <li><a href="{{ route('clientes.edit', $cliente->id_cliente) }}"
                                                            class="dropdown-item active">Editar</a></li>
                                                    <form action="{{ route('clientes.destroy', $cliente->id_cliente) }}"
                                                        method="POST">
                                                        @csrf
                                                        @method('DELETE')
                                                        <li><input type="submit" value="Eliminar" class="dropdown-item"
                                                                onclick="return confirm('¿Desea eliminar?')"></li>
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

        {
            language: {
    "search": "Buscar:",
    "infoFiltered": "(Filtrado de _MAX_ total entradas)",

        //
    "info": "Mostrando _START_ a _END_ de _TOTAL_ Clientes",


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
