@extends('adminlte::page')

@section('title', 'Ciudades')

@section('content_header')

@stop

@section('content')
    <x-app-layout>
        <x-slot name="header">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Ciudad </a></li>
                    <li class="breadcrumb-item active" aria-current="page">Ciudades</li>
                </ol>
            </nav>


        </x-slot>

        <div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
            class="vh-100 gradient-custom">
            <br>
            <section style="background-color : white">

                <div class="card ">
                    <div class="card-header">
                        <nav class="navbar bg-light">
                            <div class="container-fluid">
                                @can('ciudades.create')
                                <a class="btn btn-primary" href="{{ route('ciudades.create') }}"> Agregar una ciudad </a>
                                @endcan
                             
                            </div>
                        </nav>

                    </div>
                    <div class="card-body">
                        <table id="ciudad" class="table table-striped" style="width:90%">

                            <thead>
                                <tr>
                                    <th>Departamento</th>
                                    <th>Ciudad</th>
                                    <th>Opcciones</th>


                                </tr>
                            </thead>
                            <tbody>

                                @foreach ($ciudad as $ciudad)
                                    <tr>
                                        <td>{{ $ciudad->departamento }}</td>
                                        <td>{{ $ciudad->nombre_ciudad }}</td>



                                        <td class=" px-6 py-6">
                                            <div class="dropdown">
                                                <a class="btn btn-secondary dropdown-toggle" href="#" role="button"
                                                    id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
                                                    aria-expanded="false">
                                                    Acciones
                                                </a>

                                                <div class="dropdown-menu dropdown-menu-dark"
                                                    aria-labelledby="dropdownMenuLink">
                                                    <li> <a href="{{ route('ciudades.edit', $ciudad) }}"
                                                            class="dropdown-item active">Editar</a></li>


                                                    <form action="   {{ route('ciudades.destroy', $ciudad) }}"
                                                        method="POST">

                                                        @csrf
                                                        @method('DELETE')
                                                        <li> <input type="submit" value="Eliminar" class="dropdown-item "
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
                        2 days ago
                    </div>
                </div>
                
        </div>

        </section>
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
            $('#ciudad').DataTable();
        });
    </script>

@stop
