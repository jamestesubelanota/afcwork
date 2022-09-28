@csrf 
<label class="uppercase text-gray-700 text-xs" >Departamento</label>
<input type="text" id="departamento"  name ="departamento" class="rounded border-gray-200 w-full mb-4" value="{{ $ciudad->departamento}}"  >

<label class="uppercase text-gray-700 text-xs" >Nombre ciudad</label>
<input type="text" id="nombre_ciudad" name ="nombre_ciudad" class="rounded border-gray-200 w-full mb-4" value="{{$ciudad->nombre_ciudad }}"  >




<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('ciudades.index')}}">volver</a>
<input type="submit" value="Registrar Ciudad "  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
