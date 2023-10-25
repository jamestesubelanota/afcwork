









@csrf 
<label class="uppercase text-gray-700 text-xs" >Caracteristica de equipo</label>
<br>
<span style="color: red">@error('tipo_equipo') {{$message}}
    
@enderror
<input type="text" id="tipo_equipo"  name ="tipo_equipo" class="form-control" value="{{ old('tipo_equipo', $equipo->tipo_de_equipo) }}"  >

<hr>

<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('tipoEquipo.index')}}">volver</a>
<input type="submit" value="Guardar"  class= "btn-primary ">
</div>
