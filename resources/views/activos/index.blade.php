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

        <section>

        </section>
        <section>
            <div class="container-fluid bg-white">

                <table id="Proveedores" class="table table-striped" style="width:80%">

                    <thead>
                        <tr>
                            <th>Activo</th>
                            <th>Equipo</th>
                            <th>Marca</th>
                            <th>Serial</th>
                            <th>Costo</th>
                            <th>Ubicacion Actual</th>
                            <th>Proveedor</th>
                            <th>Estado</th>
                            <th>tipo</th>
                            <!---usuario--->
                            <th>Opciones</th>



                        </tr>
                    </thead>
                    <tbody>

                        @foreach ($activos as $activo)
                            <tr>
                                <td>{{ $activo->activo }}</td>
                                <td>{{ $activo->equipo->equipo }}</td>
                                <td>{{ $activo->marca->marca }}</td>
                                <td>{{ $activo->serial }}</td>
                                <td>{{ $activo->costo }}</td>
                                <td>{{ $activo->sede->nombre_sede }}</td>
                                <td>{{ $activo->proveedor->nombre_proveedor }}</td>
                                <td>{{ $activo->estado->estado }}</td>
                                <td>{{ $activo->tipoEquipo->tipo_de_equipo }}</td>

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
          

        </section>




    </x-app-layout>
@stop

@section('css')
    <link rel="stylesheet" href="	https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
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
            $('#Proveedores').DataTable();
        });
    </script>

@stop