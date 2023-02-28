


<!--INICIO IMPUT  file -->
<span style="color: red"> @error('foto')
    {{ $message }}
@enderror </span>
<input value="{{old('foto')}}"  class="form-control" type="file" id="foto" name="foto[]" multiple>

<!--FIN IMPUT  FILE -->
<br>

<!--INICIO IMPUT  ACTIVO -->
<label class="uppercase text-gray-700 text-xs">Activo</label>
<br>
<span style="color: red"> @error('activo')
        {{ $message }}
    @enderror </span>
<input type="text" id="activo" name="activo" class="form-control"
    value="{{ old('activo', $activo->activo) }}">
    <br>

    <!--FIN IMPUT  ACTIVO -->


    <!--INICIO IMPUT  ACTIVO CONTABLE-->
    <label class="uppercase text-gray-700 text-xs">Activo  contable</label>
    <br>
    <span style="color: red"> @error('activo')
            {{ $message }}
        @enderror </span>
    <input type="text" id="activocontable" name="activocontable" class="form-control"
        value="{{ old('activo', $activo->activocontable) }}">
    
    <!-- FIN IMPUT  ACTIVO CONTABLE -->
<br>

<!--INICIO IMPUT  EQUIPO -->
<label class="uppercase text-gray-700 text-xs">Seleccione Equipo </label>


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
<label class="uppercase text-gray-700 text-xs">Marca </label>
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

<label class="uppercase text-gray-700 text-xs">Serial</label>
<br>
<span style="color: red"> @error('serial')
        {{ $message }}
    @enderror </span>
<input type="text" id="serial" name="serial" class="form-control"
    value="{{ old('serial' , $activo->serial) }}">

    <!--FIN IMPUT  SERIAL   -->

    <!--INICIO IMPUT  Costo -->
<label class="uppercase text-gray-700 text-xs">Costo</label>
<br>
<span style="color: red"> @error('costo')
        {{ $message }}
    @enderror </span>
<input type="number" id="costo" name="costo" class="form-control"
    value="{{old('costo', $activo->costo) }}">

    <!--Fin IMPUT  costo -->



    <!--INICIO IMPUT  Modelo-->
<label class="uppercase text-gray-700 text-xs">Modelo</label>
<br>
<span style="color: red"> @error('modelo')
        {{ $message }}
    @enderror </span>
<input type="text" id="modelo" name="modelo" class="form-control"
    value="{{old('modelo', $activo->modelo) }}">
<!--fin IMPUT  modelo -->



<label class="uppercase text-gray-700 text-xs"> Selcciones Propietario</label>
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
<label class="uppercase text-gray-700 text-xs">Seleccione Proveedor </label>
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
<label class="uppercase text-gray-700 text-xs">Estado</label>
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
<label class="uppercase text-gray-700 text-xs">Caracteristica de equipo </label>
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
<label class="uppercase text-gray-700 text-xs">Cliente</label>
<br>
<span style="color:red"> @error('cliente')
        {{ $message }}
    @enderror
</span>
<br>
<!---INICIO DE SELEC TIPO DE CLIENTE-->

<select class="form-select" id="cliente" name="cliente">
    <option value=" ">Seleccione el cliente </option>
    @foreach ($clientes as $cliente)

    @if(old('cliente') == $cliente->id_cliente)
    <option value="{{$cliente->id_cliente}}" selected> {{ $cliente->nombre_cliente}}</option>
@else
    <option value="{{$cliente->id_cliente}}"> {{$cliente->nombre_cliente }}</option>

    @endif
     
    @endforeach
</select>
<!---FIN DE SELEC TIPO DE CLIENTE-->
<br>



<!---INICIO DE SELEC TIPO DE SEDE-->

<span style="color: red"> @error('sede')
    {{ $message }}
@enderror </span>
<label class="uppercase text-gray-700 text-xs">Sede </label>
<br>
<select class="form-select" id="sede" name="sede">
    <option value="">seleccione</option>
    @foreach ($sedes as $sede)

    @if(old('sede') ==  $sede->id_sede)
    <option value="{{ $sede->id_sede}}" selected> {{ $sede->nombre_sede}}</option>
@else
    <option value="{{ $sede->id_sede}}"> {{$sede->nombre_sede }}</option>

    @endif
        
    @endforeach
</select>
<br>

<!---FIN DE SELEC TIPO DE SEDE-->






<div>
    <a class="bg-gray-800 text-white rounded px-4 py-2" href="{{ route('activos.index') }}">volver</a>
    <input type="submit" value="Guardar" class="btn btn-primary">
</div>


