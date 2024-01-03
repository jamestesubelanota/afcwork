@extends('adminlte::page')

@section('title', 'Registrar movimiento')

@section('content_header')
    <h1>Activos fijos</h1>
@stop

@section('content')
    <x-app-layout>
        <x-slot name="header">
            <h2 class="text-xl font-semibold leading-tight text-gray-800">
                {{ __('Registrar movimieto') }}
            </h2>
        </x-slot>

        <div class="py-12">
            <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
                <div class="overflow-hidden bg-white shadow-sm sm:rounded-lg">
                    <div class="p-6 bg-white border-b border-gray-200">
                        <form action=" {{ route('movimientos.store') }}" method="POST">
                            <!--esitar methodo put-->
                            @csrf
                            @csrf
                            <div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
                                class="vh-100 gradient-custom">
                                <br>
                                <div class="container">

                                    <div class="card">
                                        <form action="">

                                            <h5 class="card-header">Registrar movimiento </h5>
                                            <div class="card-body">
                                                <div class="">
                                                    <div class="col-md-6 ">

                                                        <div class="card">
                                                            <div class="card-header">

                                                            </div>
                                                            <div class="card-body">
                                                                <div class="row">

                                                                    <div class="col-md-6">

                                                                        <div class="input-group-prepend">

                                                                            <label class="input-group-text"
                                                                                for="inputGroupSelect01">Cliente</label>
                                                                        </div>
                                                                        <span style="color: red">
                                                                            @error('cliente')
                                                                                {{ $message }}
                                                                            @enderror
                                                                        </span>
                                                                        <select name="cliente" class="custom-select"
                                                                            id="cliente">

                                                                            @foreach ($clientes as $cliente)
                                                                                @if (old('cliente') == $cliente->id_cliente)
                                                                                    <option
                                                                                        value="{{ $cliente->id_cliente }}"
                                                                                        selected>
                                                                                        {{ $cliente->nombre_cliente }}
                                                                                    </option>
                                                                                @else
                                                                                    <option
                                                                                        value="{{ $cliente->id_cliente }}">
                                                                                        {{ $cliente->nombre_cliente }}
                                                                                    </option>
                                                                                @endif
                                                                            @endforeach
                                                                        </select>
                                                                    </div>
                                                                    <div class="col-md-6">

                                                                        <span style="color: red">
                                                                            @error('sede')
                                                                                {{ $message }}
                                                                            @enderror
                                                                        </span>
                                                                        <label class="input-group-text"
                                                                            for="inputGroupSelect01">Sedes</label>

                                                                        <select class="custom-select" name="sede"
                                                                            id="sede">

                                                                            @foreach ($sedes as $sede)
                                                                                @if (old('sede') == $sede->id_sede)
                                                                                    <option value="{{ $sede->id_sede }}"
                                                                                        selected> {{ $sede->nombre_sede }}
                                                                                    </option>
                                                                                @else
                                                                                    <option value="{{ $sede->id_sede }}">
                                                                                        {{ $sede->nombre_sede }}</option>
                                                                                @endif
                                                                            @endforeach
                                                                        </select>
                                                                    </div>

                                                                </div>
                                                                <hr>
                                                                <div class="row">
                                                                    <div class="col-md-6">
                                                                        <span style="color: red">
                                                                            @error('id_movimiento')
                                                                                {{ $message }}
                                                                            @enderror
                                                                        </span>
                                                                        <label class="input-group-text"
                                                                            for="inputGroupSelect01">Tipo de movimiento
                                                                        </label>

                                                                        <select class="custom-select" name="id_movimiento"
                                                                            id="id_movimiento">

                                                                            @foreach ($movimientos as $movimiento)
                                                                                <option
                                                                                    value="{{ $movimiento->id_tmovimiento }}">
                                                                                    {{ $movimiento->id_tmovimiento }}
                                                                                    {{ $movimiento->movimiento }}
                                                                                </option>
                                                                            @endforeach
                                                                        </select>

                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <span style="color: red">
                                                                            @error('inicio')
                                                                                {{ $message }}
                                                                            @enderror
                                                                        </span>
                                                                        <label for="formGroupExampleInput">inicio</label>
                                                                        <input type="date" class="form-control"
                                                                            name="inicio" id="inicio" placeholder=""
                                                                            value="{{ $cabecera->inicio }}">
                                                                    </div>

                                                                </div>
                                                                <hr>

                                                                <div class="row">
                                                                    <span style="color: red">
                                                                        @error('detalle')
                                                                            {{ $message }}
                                                                        @enderror
                                                                    </span>
                                                                    <div class="col-md-12">
                                                                        <label for="formGroupExampleInput"> Descripcion del
                                                                            movimiento </label>
                                                                        <input type="text" class="form-control"
                                                                            name="detalle" id="detalle"
                                                                            value="{{ $cabecera->detalle }}">
                                                                    </div>

                                                                </div>
                                                                <hr>

                                                            </div>
                                                        </div>


                                                    </div>

                                                    <div class="header">
                                                        <hr>
                                                        <h2>Seleccione el activo</h2>
                                                        <hr>
                                                    </div>
                                                    <div class="col-md-12 ">

                                                        <table id="example" class="table table-striped table-bordered"
                                                            style="background-color:rgb(185, 186, 189)">
                                                            <thead>
                                                                <tr>
                                                                    <th>Activo</th>
                                                                    <th>Sede</th>
                                                                    <th>equipo</th>
                                                                    <th>serial</th>
                                                                    <th>marca</th>
                                                                    <th>costo</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                @foreach ($destalles as $destalle)
                                                                    <tr>
                                                                        <td> <input type="checkbox"id="id_activo"
                                                                                name="id_activo[]"
                                                                                value="{{ $destalle->activo->id_activo }}">...{{ $destalle->activo->activo }}
                                                                        </td>
                                                                        <td>{{ $destalle->activo->sede->nombre_sede }}</td>
                                                                        <td>{{ $destalle->activo->equipo->equipo }}</td>
                                                                        <td>{{ $destalle->activo->marca->marca }}</td>
                                                                        <td>{{ $destalle->activo->serial }}</td>
                                                                        <td>{{ $destalle->activo->costo }}</td>

                                                                    </tr>
                                                                @endforeach
                                                            </tbody>
                                                            </tfoot>
                                                        </table>
                                                    </div>
                                                    <div class="row">

                                                        <div style="text-align: center" class="col-md-12">
                                                            <button type="sutmit" name="Submit"
                                                                class="btn btn-primary">Registrar
                                                                movimiento</button>
                                                            <form
                                                                action="   {{ route('movimientos.destroy', $destalle->activo->id_activo) }}"
                                                                method="POST">

                                                                @csrf
                                                                @method('POST')
                                                                <button type="sutmit" name="Submit"
                                                                    class="btn btn-primary">Eliminar Activo</button>
                                                            </form>

                                                        </div>
                                                    </div>
                                                    <!---segunda secciom--->


                                                </div>
                                            </div>
                                        </form>

                                    </div>

                                </div>
                                <br>
                            </div>





                        </form>

                    </div>
                </div>
            </div>
        </div>
    </x-app-layout>

@stop

@section('css')
    <link rel="stylesheet" href="	https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap5.min.css">
@stop

@section('js')


    <script>
        $(document).ready(function() {
            $('#example').DataTable({

                language: {
                    "search": "Buscar:",

                    //
                    "info": "Mostrando _START_ a _END_ de _TOTAL_ ciudades",


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


    <script src=" https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
    <script src="   https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
    <script type="text/javascript"></script>






@stop
