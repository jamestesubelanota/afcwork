@csrf 
<label class="form-label" >Tipo de movimiento</label>
<br>
<span style="color: red">@error('movimiento') {{$message}}
    
@enderror
</span>
<input type="text" id="movimiento"  name ="movimiento" class="form-control" value="{{ old('movimiento', $movimiento->movimiento )}}"  >


<hr>

<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('tipoMovimiento.index')}}">volver</a>
<input type="submit" value="Guardar"  class="btn btn-primary" >
</div>
