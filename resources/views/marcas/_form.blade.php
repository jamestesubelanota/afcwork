@csrf 
<label class="uppercase text-gray-700 text-xs" >Equipo</label>
<input type="text" id="marca"  name ="marca" class="rounded border-gray-200 w-full mb-4" value="{{ $marcas->marca}}"  >



<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('marcas.index')}}">volver</a>
<input type="submit" value="Registrar marca"  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
