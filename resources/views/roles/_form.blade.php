@csrf 
<label class="form-label" >Rol</label>
<br>
<span style="color: red"> @error('rol') {{$message}}
    
@enderror </span>
<input type="text" id="rol"  name ="rol" class="form-control" value="{{ $roles->rol}}"  >


<hr>

<div>
<a   class="bg-gray-800 text-white rodunded px-4 py-2"  href="{{route('roles.index')}}">volver</a>
<input type="submit" value="Guardar"  class="btn btn-primary" >
</div>
