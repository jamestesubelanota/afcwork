@csrf
<span style="color: red">@error('nombre') {{$message}}

    @enderror</span>
<label class="form-label" >Nombre propietario</label>
<br>
<input type="text" id="nombre"  name ="nombre" class="form-control" value="{{old('nombre', $propietario->nombre_propietario)}}"  >
 <br>
 <span style="color: red">@error('razon') {{$message}}

    @enderror</span>
<label class="form-label" >Razon_social</label>
<br>
<input type="text" id="razon"  name ="razon" class="form-control" value="{{old('razon', $propietario->razon_social)}}"  >
 <br>
 <span style="color: red">@error('numero') {{$message}}

    @enderror</span>
 <label class="form-label" >Numero_telefono</label>
<br>
<input type="text" id="numero"  name ="numero" class="form-control" value="{{old('numero', $propietario->numero_telefono)}}"  >
 <br>

<hr>
<div>
<a   class=""  href="{{route('propietarios.index')}}">volver</a>
<input type="submit" value="Guardar"  class="btn btn-primary" >
</div>
