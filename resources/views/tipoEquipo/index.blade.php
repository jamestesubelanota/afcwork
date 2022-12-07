@extends('adminlte::page')

@section('title', 'Equipos')

@section('content_header')

@stop

@section('content')
    <x-app-layout>
        <x-slot name="header">
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                {{ __('Caracteristica de equipos') }}
                <a class="bg-gray-800 text-white rounded px-4 py-2" href="{{ route('tipoEquipo.create') }}"> crear</a>
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
                                <a class="btn btn-primary" href="{{ route('tipoEquipo.create') }}"> Agregar caracteristica de equipos </a>
                            </div>
                        </nav>

                    </div>
                    <div class="card-body">
                        <table id="Funcionalidades" class="table table-striped" style="width:90%">

                            <thead>
                                <tr>
                                    <th>Caracteristicas</th>
                                    <th>Opciones</th>
                                  


                                </tr>
                            </thead>
                            <tbody>

                                @foreach ($equipos as $equipo)
                                    <tr>
                                        <td>{{ $equipo->tipo_de_equipo }}</td>
                                    



                                        <td class=" px-6 py-6">
                                            <div class="dropdown">
                                                <a class="btn btn-secondary dropdown-toggle" href="#" role="button"
                                                    id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
                                                    aria-expanded="false">
                                                    Acciones
                                                </a>

                                                <div class="dropdown-menu dropdown-menu-dark"
                                                    aria-labelledby="dropdownMenuLink">
                                                    <li> <a href="{{ route('tipoEquipo.edit', $equipo->id_equipo) }}"
                                                        class="dropdown-item active">editar</a></li>


                                                        <form action="   {{ route('tipoEquipo.destroy', $equipo) }}" method="POST">
        
                                                            @csrf
                                                            @method('DELETE')
                                                            <li> <input type="submit" value="Eliminar"
                                                                class="dropdown-item "
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
                        2 days ago
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
            $('#Funcionalidades').DataTable();
        });
    </script>

@stop
