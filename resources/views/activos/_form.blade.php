@csrf
<label class="uppercase text-gray-700 text-xs">Foto</label>
<input type="file" id="foto" name="foto" class="rounded border-gray-200 w-full mb-4">
<label class="uppercase text-gray-700 text-xs">Foton serial</label>
<input type="file" id="foto2" name="foto2" class="rounded border-gray-200 w-full mb-4">
<label class="uppercase text-gray-700 text-xs">activo</label>
<input type="text" id="activo" name="activo" class="rounded border-gray-200 w-full mb-4" value="{{ $activo->activo }}">


<label class="uppercase text-gray-700 text-xs">equipo </label>
<br>
<select class="custom-select" id="equipo" name="equipo">
    @foreach ($equipos as $equipo)
 
        <option value="{{ $equipo->id_equipo}}"> {{ $equipo->equipo}}  </option>
    @endforeach
</select>
<br>

<br>

<label class="uppercase text-gray-700 text-xs">marca </label>
<br>
<select class="custom-select" id="marca" name="marca">
    @foreach ($marcas as $marca)
        <option value=" {{ $marca->id_marca }}">{{ $marca->marca }}</option>
    @endforeach
</select>
<br>

<br>


<label class="uppercase text-gray-700 text-xs">serial</label>
<input type="text" id="serial" name="serial" class="rounded border-gray-200 w-full mb-4"
    value="{{ $activo->serial }}">
<label class="uppercase text-gray-700 text-xs">costo</label>
<input type="text" id="costo" name="costo" class="rounded border-gray-200 w-full mb-4"
    value="{{ $activo->costo }}">

<label class="uppercase text-gray-700 text-xs">proveedor </label>
<br>
<select class="custom-select" id="id_proveedor" name="id_proveedor">
    @foreach ($proveedor as $proveedor)
        <option value=" {{ $proveedor->id_proveedor }}">{{ $proveedor->nombre_proveedor }}</option>
    @endforeach
</select>
<br>
<label class="uppercase text-gray-700 text-xs">estado</label>
<br>
<select class="custom-select" id="id_estado" name="id_estado">
    @foreach ($estados as $estado)
        <option value=" {{ $estado->id_estado }}">{{ $estado->estado }}</option>
    @endforeach
</select>
<br>
<br>
<label class="uppercase text-gray-700 text-xs">Caracterisitica de equipo </label>
<br>
<select class="custom-select" id="tipo_de_equipo" name="tipo_de_equipo">
    @foreach ($tipoEquipo as $tipoEquipo)
        <option value=" {{ $tipoEquipo->id_equipo }}">{{ $tipoEquipo->tipo_de_equipo }}</option>
    @endforeach
</select>
<br>








<div>
    <a class="bg-gray-800 text-white rounded px-4 py-2" href="{{ route('activos.index') }}">volver</a>
    <input type="submit" value="Registrar Activo " class="bg-gray-800 text-white rounded px-4 py-2">
</div>
