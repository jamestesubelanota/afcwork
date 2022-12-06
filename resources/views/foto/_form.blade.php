



@csrf 
<label class="uppercase text-gray-700 text-xs" >Agregar Foto</label>
<span class="text-xs" style="color: red">@error('foto') {{$message}} @enderror  </span>
<input type="file">

<label class="uppercase text-gray-700 text-xs" >Asignar Activo </label>
<span class="text-xs" style="color: red">@error('activo') {{$message}} @enderror  </span>
<select name="activo" id="activo">
         @foreach ($activos as $activo)
         <option value="{{$activo->id_activo}}"> {{$activo->activo}} </option>
         @endforeach
   
</select>



<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('foto.index')}}">volver</a>
<input type="submit" value="Guardar "  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
