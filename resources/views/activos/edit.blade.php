
@extends('adminlte::page')

@section('title', 'Editar Activos')

@section('content_header')
    <h1>Activos fijos</h1>
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800">
            {{ __('Editar Activos') }}
        </h2>
    </x-slot>
    <div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
    class="vh-100 gradient-custom">
    <br>
    <div class="row">

        <div class="col-md-4"></div>
        <div class="mb-3 border-black card" style="max-width: 30rem;">
            <div class="card-header">Agregar  activos</div>
            <div class="card-body text-primary">

                <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
                    <div class="overflow-hidden bg-white shadow-sm sm:rounded-lg">
                        <div class="p-6 bg-white border-b border-gray-200">
                            <form action="   {{route('activos.update', $activo)}}" method="POST" enctype="multipart/form-data" >
                                <!--esitar methodo put-->
                                @csrf
                                  @method('PUT')



<!--INICIO IMPUT  file -->
<span style="color: red"> @error('foto')
    {{ $message }}
@enderror </span>
<input value="{{old('foto')}}"  class="form-control" type="file" id="foto" name="foto[]" multiple>

<!--FIN IMPUT  FILE -->
<br>

<!--INICIO IMPUT  ACTIVO -->
<label class="text-xs text-gray-700 uppercase">Activo</label>
<br>
<span style="color: red"> @error('activo')
        {{ $message }}
    @enderror </span>
<input type="text" id="activo" name="activo" class="form-control"
    value="{{ old('activo', $activo->activo) }}">
    <br>

    <!--FIN IMPUT  ACTIVO -->


    <!--INICIO IMPUT  ACTIVO CONTABLE-->
    <label class="text-xs text-gray-700 uppercase">Activo  contable</label>
    <br>
    <span style="color: red"> @error('activo')
            {{ $message }}
        @enderror </span>
    <input type="text" id="activocontable" name="activocontable" class="form-control"
        value="{{ old('activo', $activo->activocontable) }}">

    <!-- FIN IMPUT  ACTIVO CONTABLE -->
<br>

<!--INICIO IMPUT  EQUIPO -->
<label class="text-xs text-gray-700 uppercase">Seleccione Equipo </label>


<br>
<span style="color: red"> @error('equipo')
        {{ $message }}
    @enderror </span>
<select class="form-select" id="equipo" name="equipo">

    @foreach ($equipos as $equipo)
    @if(old('equipo') == $equipo->id_equipo)
    <option value="{{$equipo->id_equipo}}" selected> {{ $equipo->equipo }}</option>
@else
    <option value="{{$equipo->id_equipo}}"> {{$equipo->equipo }}</option>

    @endif

    @endforeach

    @if ( isset($tipoEquipo2) )


    @endif
</select>
<br>
<!--FIN IMPUT  EQUIPO -->
<br>


<!--INICIO IMPUT  MARCA -->
<label class="text-xs text-gray-700 uppercase">Marca </label>
<br>

<span style="color: red"> @error('marca')
        {{ $message }}
    @enderror </span>
<select class="form-select" id="marca" name="marca">


    @foreach ($marcas as $marca)

    @if(old('marca') == $marca->id_marca)

    <option value="{{$marca->id_marca}}" > {{ $marca->marca }}</option>
@else
    <option value="{{$marca->id_marca}}"> {{ $marca->marca }}</option>
@endif

    @endforeach
@if (isset($marcas2))
@foreach ($marcas2 as $marca)

@if(old('marca') == $marca->id_marca)

<option value="{{$marca->id_marca}}" > {{ $marca->marca }}</option>
@else
<option value="{{$marca->id_marca}}"> {{ $marca->marca }}</option>
@endif

@endforeach
@endif

</select>
<br>
<!--FIN IMPUT  MARCA -->




<!--INICIO IMPUT SERIAL-->

<label class="text-xs text-gray-700 uppercase">Serial</label>
<br>
<span style="color: red"> @error('serial')
        {{ $message }}
    @enderror </span>
<input type="text" id="serial" name="serial" class="form-control"
    value="{{ old('serial' , $activo->serial) }}">

    <!--FIN IMPUT  SERIAL   -->

    <!--INICIO IMPUT  Costo -->
<label class="text-xs text-gray-700 uppercase">Costo</label>
<br>
<span style="color: red"> @error('costo')
        {{ $message }}
    @enderror </span>
<input type="number" id="costo" name="costo" class="form-control"
    value="{{old('costo', $activo->costo) }}">

    <!--Fin IMPUT  costo -->



    <!--INICIO IMPUT  Modelo-->
<label class="text-xs text-gray-700 uppercase">Modelo</label>
<br>
<span style="color: red"> @error('modelo')
        {{ $message }}
    @enderror </span>
<input type="text" id="modelo" name="modelo" class="form-control"
    value="{{old('modelo', $activo->modelo) }}">
<!--fin IMPUT  modelo -->



<label class="text-xs text-gray-700 uppercase"> Selcciones Propietario</label>
<br>
<span style="color: red"> @error('propietario')
    {{ $message }}
@enderror </span>
<select class="form-select" id="propietario" name="propietario">


@foreach ($propietario as $propietario)

@if(old('propietario') == $propietario->id_propietario)
<option value="{{$propietario->id_propietario}}" selected> {{ $propietario->nombre_propietario }}</option>
@else
<option value="{{$propietario->id_propietario}}"> {{$propietario->nombre_propietario }}</option>

@endif

@endforeach

@if (isset($propietarios))

@foreach ($propietarios as $propietario)

@if(old('propietario') == $propietario->id_propietario)
<option value="{{$propietario->id_propietario}}" selected> {{ $propietario->nombre_propietario }}</option>
@else
<option value="{{$propietario->id_propietario}}"> {{$propietario->nombre_propietario }}</option>

@endif

@endforeach
@endif
</select>
<br>



<!--INICIO IMPUT  PROVEEDOR -->
<label class="text-xs text-gray-700 uppercase">Seleccione Proveedor </label>
<br>
<span style="color: red"> @error('id_proveedor')
        {{ $message }}
    @enderror </span>
<select class="form-select" id="id_proveedor" name="id_proveedor">

    @foreach ($proveedor as $proveedor)
    @if(old('id_proveedor') == $proveedor->id_proveedor)
    <option value="{{$proveedor->id_proveedor}}" selected> {{ $proveedor->nombre_proveedor }}</option>
@else
    <option value="{{ $proveedor->id_proveedor}}"> {{ $proveedor->nombre_proveedor }}</option>

    @endif

    @endforeach
    @if (isset($proveedores ))
    @foreach ($proveedores as $proveedor)
    @if(old('id_proveedor') == $proveedor->id_proveedor)
    <option value="{{$proveedor->id_proveedor}}" selected> {{ $proveedor->nombre_proveedor }}</option>
@else
    <option value="{{ $proveedor->id_proveedor}}"> {{ $proveedor->nombre_proveedor }}</option>

    @endif

    @endforeach
    @endif
</select>

<!--FINIMPUT  MARCA -->


<br>

<!--INICIO IMPUT  Estado -->
<label class="text-xs text-gray-700 uppercase">Estado</label>
<br>
<span style="color: red"> @error('id_proveedor')
        {{ $message }}
    @enderror </span>
<select class="form-select" id="id_estado" name="id_estado">

    @foreach ($estados as $estado)
    @if(old('id_estado') == $proveedor->id_proveedor)
    <option value="{{$estado->id_estado}}" selected> {{ $estado->estado }}</option>
@else
    <option value="{{ $estado->id_estado}}"> {{$estado->estado }}</option>

    @endif

    @endforeach

    @if (isset($estados2 ))

    @foreach ($estados2 as $estado)

    @if(old('id_estado') == $proveedor->id_proveedor)
    <option value="{{$estado->id_estado}}" selected> {{ $estado->estado }}</option>
@else
    <option value="{{ $estado->id_estado}}"> {{$estado->estado }}</option>

    @endif

    @endforeach
    @endif
</select>


<!--Fin IMPUT  ESTADO -->


<br>

<!--INICIO IMPUT  CARACTERISTICA -->
<label class="text-xs text-gray-700 uppercase">Caracteristica de equipo </label>
<br>
<span style="color: red"> @error('tipo_de_equipo')
    {{ $message }}
@enderror </span>
<select class="form-select" id="tipo_de_equipo" name="tipo_de_equipo">



@foreach ($tipoEquipo as $tipoEquipos)
@if(old('tipo_de_equipo') == $tipoEquipos->id_equipo)
<option value="{{ $tipoEquipos->id_equipo}}" selected> {{ $tipoEquipos->tipo_de_equipo }}</option>
@else
<option value="{{  $tipoEquipos->id_equipo}}"> {{ $tipoEquipos->tipo_de_equipo }}</option>

@endif

@endforeach



</select>

<!--- FIN IMPUT  CARACTERISTICA -->


<!---INICIO DE SELEC TIPO DE EQUIPO-->


<!---FINDE SELEC TIPO DE EQUIPO-->
<br>
<label class="text-xs text-gray-700 uppercase">Cliente</label>
<br>
<span style="color:red"> @error('cliente')
        {{ $message }}
    @enderror
</span>
<br>

<!---INICIO DE SELEC TIPO DE CLIENTE-->

 <select class="form-select" id="cliente" name="cliente">

    @foreach ($clientes as $cliente)

    @if(old('cliente') == $cliente->id_cliente)
    <option value="{{$cliente->id_cliente}}" selected> {{ $cliente->nombre_cliente}}</option>
@else
    <option value="{{$cliente->id_cliente}}"> {{$cliente->nombre_cliente }}</option>

    @endif

    @endforeach
</select>

<br>



<!---INICIO DE SELEC TIPO DE SEDE-->

<span style="color: red"> @error('sede')
    {{ $message }}
@enderror </span>
<label class="text-xs text-gray-700 uppercase">Sede </label>
<br>
<select class="form-select" id="sede" name="sede">

    @foreach ($sedes as $sede)

    @if(old('sede') ==  $sede->id_sede)
    <option value="{{ $sede->id_sede}}" selected> {{ $sede->nombre_sede}}</option>
@else
    <option value="{{ $sede->id_sede}}"> {{$sede->nombre_sede }}</option>

    @endif

    @endforeach
</select>
<br>








<div>
    <a class="px-4 py-2 text-white bg-gray-800 rounded" href="{{ route('activos.index') }}">volver</a>
    <input type="submit" value="Guardar" class="btn btn-primary">
</div>




                                  </form>

                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="col-md-4"></div>
    </div>

</div>

</x-app-layout>

@stop

@section('css')

@stop

@section('js')


<script>

    $(document).ready(function () {
        $('#example').DataTable();
    });
    </script>


<script src=" https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
<script src="   https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
<script type="text/javascript">





         </script>






@stop
