@csrf 
<label class="uppercase text-gray-700 text-xs" >Equipo</label>
<br>
<span>@error('equipo')  {{$message}}
    
@enderror</span>
<input type="text" id="equipo"  name ="equipo" class="rounded border-gray-200 w-full mb-4" value="{{ old('equipo',$equipos->equipo)}}"  >



<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('equipos.index')}}">volver</a>
<input type="submit" value="Guardar"  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
