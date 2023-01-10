@extends('adminlte::page')

@section('title', 'Colaboradores')

@section('content_header')

@stop

@section('content')
    <x-app-layout>
        <x-slot name="header">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Colaboradores </a></li>
                    <li class="breadcrumb-item active" aria-current="page">Ver Colaboradores</li>
                </ol>
            </nav>
        </x-slot>
        <div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
        class="vh-100 gradient-custom">
        <br>
        <div class="card ">
            <div class="card-header">
                <nav class="navbar bg-light">
                    <div class="container-fluid">
                        <a class="btn btn-primary" href="{{ route('colaboradores.create') }}"> Agregar un Colaborador </a>
                    </div>
                  </nav>
               
            </div>
            <div class="card-body">
              
                <table id="colaboradores" class="table table-striped" style="width:*90%">

                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Identificacion</th>
                            <th>Telefono</th>
                            <th>Cargo</th>    
                            <th>Opcciones</th>


                        </tr>
                    </thead>
                    <tbody>

                        @foreach ($colaboradores as $colaboradores)
                            <tr>
                                <td>{{ $colaboradores->nombre_colaborador }}</td>
                                <td>{{ $colaboradores->identificacion }}</td>
                                <td>{{$colaboradores->telefono}} </td>
                                <td> {{$colaboradores->cargo}} </td>



                                <td class=" px-6 py-6">
                                    <div class="dropdown">
                                        <a class="btn btn-secondary dropdown-toggle" href="#" role="button"
                                            id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
                                            aria-expanded="false">
                                            Acciones
                                        </a>

                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                            <li><a href="{{ route('colaboradores.edit', $colaboradores->id_colaborador) }}"
                                                class="dropdown-item active">Editar</a></li>


                                            <form action="   {{ route('colaboradores.destroy',  $colaboradores->id_colaborador) }}"
                                                method="POST">

                                                @csrf
                                                @method('DELETE')
                                                <li><input type="submit" value="Eliminar"
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
          <hr>
        </div>
      
    </x-app-layout>
@stop

@section('css')
    <link rel="stylesheet" href="/css/admin_custom.css">

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
            $('#colaboradores').DataTable({
            language: {
    "search": "Buscar:",
    "infoFiltered": "(Filtrado de _MAX_ total entradas)",

        //
    "info": "Mostrando _START_ a _END_ de _TOTAL_ Colaboradores",


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
