









@csrf 
<label class="uppercase text-gray-700 text-xs" >Caracteristica de equipo</label>
<input type="text" id="tipo_equipo"  name ="tipo_equipo" class="rounded border-gray-200 w-full mb-4" value="{{ $equipo->tipo_de_equipo}}"  >



<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('tipoEquipo.index')}}">volver</a>
<input type="submit" value="Registrar Caracteristica "  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
