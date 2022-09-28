@csrf 
<label class="uppercase text-gray-700 text-xs" >Estados</label>
<input type="text" id="estado"  name ="estado" class="rounded border-gray-200 w-full mb-4" value="{{ $estados->estado}}"  >



<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('estados.index')}}">volver</a>
<input type="submit" value="Registrar funcion "  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
