



<label class="uppercase text-gray-700 text-xs">Imagen<label> 
<input type="file" id="foto" name="foto[]" multiple>

<br>
<label class="uppercase text-gray-700 text-xs">Activo</label>
<br>
<span style="color: red"> @error('activo')
        {{ $message }}
    @enderror </span>
<input type="text" id="activo" name="activo" class="rounded border-gray-200 w-full mb-4"
    value="{{ old('activo', $activo->activo) }}">

<br>
<label class="uppercase text-gray-700 text-xs">Equipo </label>


<br>
<span style="color: red"> @error('equipo')
        {{ $message }}
    @enderror </span>
<select class="custom-select" id="equipo" name="equipo">
    <option value="">Seleccione el equipo </option>
    @foreach ($equipos as $equipo)
        <option value="{{ $equipo->id_equipo }}"> {{ $equipo->equipo }} </option>
    @endforeach
</select>
<br>

<br>

<label class="uppercase text-gray-700 text-xs">Marca </label>
<br>

<span style="color: red"> @error('marca')
        {{ $message }}
    @enderror </span>
<select class="custom-select" id="marca" name="marca">
    <option value="">Seleccione La marca </option>
    @foreach ($marcas as $marca)
        <option value=" {{ $marca->id_marca }}">{{ $marca->marca }}</option>
    @endforeach
</select>
<br>


<br>


<label class="uppercase text-gray-700 text-xs">Serial</label>
<br>
<span style="color: red"> @error('serial')
        {{ $message }}
    @enderror </span>
<input type="text" id="serial" name="serial" class="rounded border-gray-200 w-full mb-4"
    value="{{ old('serial' , $activo->serial) }}">
<label class="uppercase text-gray-700 text-xs">Costo</label>
<br>
<span style="color: red"> @error('costo')
        {{ $message }}
    @enderror </span>
<input type="text" id="costo" name="costo" class="rounded border-gray-200 w-full mb-4"
    value="{{old('costo', $activo->costo) }}">
<label class="uppercase text-gray-700 text-xs">Modelo</label>
<br>
<span style="color: red"> @error('modelo')
        {{ $message }}
    @enderror </span>
<input type="text" id="modelo" name="modelo" class="rounded border-gray-200 w-full mb-4"
    value="{{old('modelo', $activo->modelo) }}">

<label class="uppercase text-gray-700 text-xs">Propietario</label>
<br>
<span style="color: red"> @error('propietario')
        {{ $message }}
    @enderror </span>
<input type="text" id="propietario" name="propietario" class="rounded border-gray-200 w-full mb-4"
    value="{{ old('propietario', $activo->propietario) }}">


<label class="uppercase text-gray-700 text-xs">Proveedor </label>
<br>
<span style="color: red"> @error('id_proveedor')
        {{ $message }}
    @enderror </span>
<select class="custom-select" id="id_proveedor" name="id_proveedor">
    <option value="">Seleccione el proveedor </option>
    @foreach ($proveedor as $proveedor)
        <option value=" {{ $proveedor->id_proveedor }}">{{ $proveedor->nombre_proveedor }}</option>
    @endforeach
</select>
<br>
<label class="uppercase text-gray-700 text-xs">estado</label>
<br>
<span style="color: red"> @error('id_proveedor')
        {{ $message }}
    @enderror </span>
<select class="custom-select" id="id_estado" name="id_estado">
    @foreach ($estados as $estado)
        <option value=" {{ $estado->id_estado }}">{{ $estado->estado }}</option>
    @endforeach
</select>
<br>
<br>
<label class="uppercase text-gray-700 text-xs">Caracterisitica de equipo </label>
<br>
<span style="color: red"> @error('tipo_de_equipo')
        {{ $message }}
    @enderror
</span>
<br>
<select class="custom-select" id="tipo_de_equipo" name="tipo_de_equipo">
    <option value="">Seleccione Caracterisitica</option>
    @foreach ($tipoEquipo as $tipoEquipo)
        <option value=" {{ $tipoEquipo->id_equipo }}">{{ $tipoEquipo->tipo_de_equipo }}</option>
    @endforeach
</select>
<br>
<br>
<label class="uppercase text-gray-700 text-xs">Cliente</label>
<br>
<span style="color:red"> @error('cliente')
        {{ $message }}
    @enderror
</span>
<br>
<select class="custom-select" id="cliente" name="cliente">
    <option value=" ">Seleccione el cliente </option>
    @foreach ($clientes as $cliente)
        <option value=" {{ $cliente->id_cliente }}">{{ $cliente->nombre_cliente }}</option>
    @endforeach
</select>

<br>
<label class="uppercase text-gray-700 text-xs">Sede </label>
<br>
<select class="custom-select" id="sede" name="sede">
    <option value=" ">selecione</option>
    @foreach ($sedes as $sede)
        <option value=" {{ $sede->id_sede }}">{{ $sede->nombre_sede }}</option>
    @endforeach
</select>
<br>








<div>
    <a class="bg-gray-800 text-white rounded px-4 py-2" href="{{ route('activos.index') }}">volver</a>
    <input type="submit" value="Guardar" class="bg-gray-800 text-white rounded px-4 py-2">
</div>


