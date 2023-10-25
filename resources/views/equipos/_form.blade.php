@csrf 
<label class="uppercase text-gray-700 text-xs" >Equipo</label>
<br>
<span>@error('equipo')  {{$message}}
    
@enderror</span>
<input type="text" id="equipo"  name ="equipo" class="form-control" value="{{ old('equipo',$equipos->equipo)}}"  >

<hr>

<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('equipos.index')}}">volver</a>
<input type="submit" value="Guardar"  class="btn btn-primary" >
</div>
