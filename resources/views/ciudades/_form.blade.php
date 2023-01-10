@csrf 
<label class="uppercase text-gray-700 text-xs" >Departamento</label>
<span class="text-xs" style="color: red">@error('departamento') {{$message}} @enderror  </span>
<input type="text" id="departamento"  name ="departamento" class="form-control" value="{{ old('departamento',$ciudad->departamento) }}"  >

<label class="uppercase text-gray-700 text-xs" >Nombre ciudad</label>
<span class="text-xs" style="color: red">@error('nombre_ciudad') {{$message}} @enderror  </span>

<input type="text" id="nombre_ciudad"  name ="nombre_ciudad" class="form-control" value="{{ old('nombre_ciudad',$ciudad->nombre_ciudad) }}"  >
<hr>
<br>

<div>
<a   class="btn btn-dark"  href="{{route('ciudades.index')}}">volver</a>
<input type="submit" value="Guardar "  class="btn btn-dark" >
</div>
