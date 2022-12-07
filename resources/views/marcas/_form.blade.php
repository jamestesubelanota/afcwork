@csrf 
<label class="form-label" >Equipo</label>
<br>
<span style="color: red">@error('marca') {{$message}}
    
@enderror</span>
<input type="text" id="marca"  name ="marca" class="form-control" value="{{old('marca', $marcas->marca)}}"  >

<hr>
<hr>
<div>
<a   class=""  href="{{route('marcas.index')}}">volver</a>
<input type="submit" value="Guardar"  class="btn btn-primary" >
</div>
