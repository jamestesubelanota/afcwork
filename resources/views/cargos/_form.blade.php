@csrf

<label class="text-xs text-gray-700 uppercase" >cargos-</label>
<span class="text-xs" style="color: red">@error('cargo') {{$message}} @enderror  </span>

<input type="text" id="cargo"  name ="cargo" class="form-control" value="{{ old('cargo',$cargo->cargo) }}"  >
<hr>
<br>

<div>
<a   class="btn btn-dark"  href="{{route('ciudades.index')}}">volver</a>
<input type="submit" value="Guardar "  class="btn btn-dark" >
</div>
