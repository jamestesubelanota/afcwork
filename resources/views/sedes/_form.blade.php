@csrf
<label class="form-label">
    clientes</label>
<br>
<span> @error('cliente_id')
        {{ $message }}
    @enderror
</span>
<br>
<select class="form-select" id="cliente_id" name ="cliente_id">
    @foreach ($cliente as $clientes)
    <option value=" {{ old('cliente_id', $clientes->id_cliente) }}">{{ $clientes->nombre_cliente }}</option>
@endforeach





</select>
<br>
<label class="form-label">Ciudad</label>
<br>
<span> @error('ciudad_id')
        {{ $message }}
    @enderror
</span>
<br>
<select class="form-select" id="ciudad_id" name ="ciudad_id">
    @foreach ($ciudad as $ciudades)
        <option value="{{ old('ciudad_id', $ciudades->id_ciudad) }}">{{ $ciudades->nombre_ciudad }} </option>
    @endforeach


</select>
<br>

<label class="form-label">nombre_sede</label>
<br>
<span> @error('nombre_sede')
        {{ $message }}
    @enderror
</span>
<input type="text" id="nombre_sede" name ="nombre_sede" class="form-control"
    value="{{ old('nombre_sede', $sede->nombre_sede) }}">

<label class="form-label">direccion</label>
<br>
<span> @error('direccion')
        {{ $message }}
    @enderror
</span>
<input type="text" id="direccion" name ="direccion" class="form-control"
    value="{{ old('direccion', $sede->direccion) }}">

<label class="form-label">contacto</label>
<br>
<span> @error('contacto')
        {{ $message }}
    @enderror
</span>
<input type="text" id="contacto	" name ="contacto" class="form-control"
    value="{{ old('contacto', $sede->contacto) }}">
<label class="form-label">Telefono</label>
<br>
<span> @error('telefono')
        {{ $message }}
    @enderror
</span>
<input type="text" id="telefono" name ="telefono" class="form-control"
    value="{{ old('telefono', $sede->telefono) }}">
<br>
<label class="form-label" for="zona">Zona</label>
<span> @error('zona')
        {{ $message }}
    @enderror
</span>
<input type="text" id="zona" name ="zona" class="form-control" value="{{ old('zona', $sede->zona) }}">













<hr>
<div>
    <a class="px-4 py-2 text-white bg-gray-800 rounded" href="{{ route('clientes.index') }}">volver</a>
    <input type="submit" value="Guardar" class="btn btn-primary">
</div>
