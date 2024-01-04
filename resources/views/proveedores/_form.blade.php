@csrf
<label class="form-label" >Nombre del proveedor</label>
<br>
<span style="color: red"> @error('nombre_proveedor') {{$message}}

@enderror </span>
<input type="text" id="nombre_proveedor"  name ="nombre_proveedor" class="form-control" value="{{old( 'nombre_proveedor', $proveedores->nombre_proveedor ) }}">

<label class="form-label" >Nit</label>
<br>
<span style="color: red" > @error('nit') {{$message}}

    @enderror </span>
<input type="text" id="nit" name ="nit" class="form-control" value="{{ old('nit', $proveedores->nit) }}"  >

<label class="form-label" >Direccion</label>
<br>
<span style="color: red" > @error('direccion') {{$message}}

    @enderror </span>
<input type="text" id="direccion" name ="direccion" class="form-control" value="{{ old('direccion', $proveedores->direccion) }}"  >

<label class="form-label" >Razon social</label>
<br>
<span style="color: red" > @error('razon_social') {{$message}}

    @enderror </span>
<input type="text" id="razon_social" name ="razon_social" class="form-control" value="{{ old('razon_social', $proveedores->razon_social)}}"  >
 <br>

 <label class="form-label" >Numero</label>
<br>
<span style="color: red" > @error('numero') {{$message}}

    @enderror </span>
<input type="text" id="numero" name ="numero" class="form-control" value="{{ old('numero', $proveedores->numero_telefono)}}"  >


<div>
<a   class="btn btn-primary"  href="{{route('proveedores.index')}}">volver</a>
<input type="submit" value="Guardar"  class="btn btn-primary" >
</div>
