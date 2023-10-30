@extends('adminlte::page')

@section('title', 'Asignar Colaboradores ')

@section('content_header')

@stop

@section('content')
    <x-app-layout>
        <x-slot name="header">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Asignacion de empleados a sedes </a></li>
                    <li class="breadcrumb-item active" aria-current="page">vista</li>
                </ol>
            </nav>


        </x-slot>

        <div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
            class="vh-100 gradient-custom">
            <br>
            <div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
            class="vh-100 gradient-custom">
            <br>
            <section>
                <div class="card ">
                    <div class="card-header">
                        <nav class="navbar bg-light">
                            <div class="container-fluid">
                                <a class="btn btn-primary" href="{{ route('asignarcolaborador.create') }}"> Asignar Encargado  a sede  </a>
                            </div>
                        </nav>

                    </div>
                    <div class="card-body">
                        <table id="Funcionalidades" class="table table-striped" style="width:100%">

                            <thead>
                                <tr>
                                    <th>Colaborador</th>
                                    <th>Cargo</th>
                                    <th>Sede</th>
                                    <th>Cliente</th>
                                    <th>Opciones</th>

                                </tr>
                            </thead>
                            <tbody>

                                @foreach ($encargados as $encargado)
                                    <tr>
                                        <td>{{ $encargado->colaborador->nombre_colaborador}}</td>

                                        <td>{{ $encargado->colaborador->cargos->cargo }}</td>
                                        <td>{{ $encargado->sedes->nombre_sede }}</td>
                                        <td>{{ $encargado->sedes->cliente->nombre_cliente }}</td>




                                        <td class="px-6 py-6 ">
                                            <div class="dropdown">
                                                <a class="btn btn-secondary dropdown-toggle" href="#" role="button"
                                                    id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
                                                    aria-expanded="false">
                                                    Acciones
                                                </a>

                                                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                                    <li>   <a href="{{ route('asignarcolaborador.edit', $encargado) }}"
                                                        class="dropdown-item active">editar</a></li>


                                                    <form action="   {{ route('asignarcolaborador.destroy', $encargado) }}"
                                                        method="POST">

                                                        @csrf
                                                        @method('DELETE')
                                                        <li> <input type="submit" value="Eliminar" class="dropdown-item"
                                                            onclick="return confirm('desea eliminar ?')"> </li>

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

        <br>


        </div>

    </x-app-layout>
@stop

@section('css')
    <link rel="stylesheet" href="/css/admin_custom.css">
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

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
            $('#ciudad').DataTable({

                language: {
                    "search": "Buscar:",

                    //
                    "info": "Mostrando _START_ a _END_ de _TOTAL_ ciudades",


                    "paginate": {
                        "first": "Primero",
                        "last": "Ultimo",
                        "next": "Siguiente",
                        "previous": "Anterior",
                        "Show": "mostrar",
                        "infoFiltered": "(Filtrado de _MAX_ total entradas)"

                    },

                }

            });
        });
    </script>

@stop
