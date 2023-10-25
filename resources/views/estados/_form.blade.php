@csrf 
<label class="uppercase text-gray-700 text-xs" >Estados</label>
<span  style="color: red" class="text-xs">@error('estado') {{$message}} @enderror  </span>
<input type="text" id="estado"  name ="estado" class="form-control" value="{{old('estado', $estados->estado)}}"  >

<hr>

<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('estados.index')}}">volver</a>
<input type="submit" value="Guardar"  class="btn btn-primary" >
</div>
