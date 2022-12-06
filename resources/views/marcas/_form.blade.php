@csrf 
<label class="uppercase text-gray-700 text-xs" >Equipo</label>
<br>
<span style="color: red">@error('marca') {{$message}}
    
@enderror</span>
<input type="text" id="marca"  name ="marca" class="form-control" value="{{old('marca', $marcas->marca)}}"  >

<hr>

<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('marcas.index')}}">volver</a>
<input type="submit" value="Guardar"  class="btn btn-primary" >
</div>
