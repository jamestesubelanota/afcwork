@csrf 
<label class="uppercase text-gray-700 text-xs" >Departamento</label>
<span class="text-xs">@error('departamento') {{$message}} @enderror  </span>
<input type="text" id="departamento"  name ="departamento" class="rounded border-gray-200 w-full mb-4" value="{{ old('departamento',$ciudad->departamento) }}"  >

<label class="uppercase text-gray-700 text-xs" >Nombre ciudad</label>
<span class="text-xs">@error('nombre_ciudad') {{$message}} @enderror  </span>
<input type="text" id="nombre_ciudad" name ="nombre_ciudad" class="rounded border-gray-200 w-full mb-4" value="{{ old('nombre_ciudad' ,$ciudad->nombre_ciudad)  }}"  >




<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('ciudades.index')}}">volver</a>
<input type="submit" value="Guardar "  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
