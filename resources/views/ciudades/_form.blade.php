@csrf
<label class="text-xs text-gray-700 uppercase" >Codigo dane</label>
<span class="text-xs" style="color: red">@error('cod_dane') {{$message}} @enderror  </span>
<input type="text" id="cod_dane"  name ="cod_dane" class="form-control" value="{{ old('cod_dane',$ciudad->cod_dane) }}"  >

<label class="text-xs text-gray-700 uppercase" >Departamento</label>
<span class="text-xs" style="color: red">@error('departamento') {{$message}} @enderror  </span>

<select class="form-select" id="departamento" name ="departamento">

    @foreach ($departamento as $departamentos)
        <option value=" {{ old('departamento', $departamentos->id_departamento) }}">{{ $departamentos->nombreDepartamento }}</option>
    @endforeach

</select>
<br>


<label class="text-xs text-gray-700 uppercase" >Nombre ciudad</label>
<span class="text-xs" style="color: red">@error('nombre_ciudad') {{$message}} @enderror  </span>

<input type="text" id="nombre_ciudad"  name ="nombre_ciudad" class="form-control" value="{{ old('nombre_ciudad',$ciudad->nombre_ciudad) }}"  >
<hr>
<br>

<div>
<a   class="btn btn-dark"  href="{{route('ciudades.index')}}">volver</a>
<input type="submit" value="Guardar "  class="btn btn-dark" >
</div>
