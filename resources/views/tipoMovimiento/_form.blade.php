@csrf 
<label class="uppercase text-gray-700 text-xs" >Tipo de movimiento</label>
<input type="text" id="movimiento"  name ="movimiento" class="rounded border-gray-200 w-full mb-4" value="{{ $movimiento->movimiento }}"  >




<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('tipoMovimiento.index')}}">volver</a>
<input type="submit" value="Registrar Ciudad "  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
