@csrf 
<label class="uppercase text-gray-700 text-xs" >Rol</label>
<br>
<span> @error('rol') {{$message}}
    
@enderror </span>
<input type="text" id="rol"  name ="rol" class="rounded border-gray-200 w-full mb-4" value="{{ $roles->rol}}"  >




<div>
<a   class="bg-gray-800 text-white rodunded px-4 py-2"  href="{{route('roles.index')}}">volver</a>
<input type="submit" value="Guardar"  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
