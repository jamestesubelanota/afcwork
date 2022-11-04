@csrf 
<label class="uppercase text-gray-700 text-xs" >Nombre del proveedor</label>
<br>
<span > @error('nombre_proveedor') {{$message}}
    
@enderror </span>
<input type="text" id="nombre_proveedor"  name ="nombre_proveedor" class="rounded border-gray-200 w-full mb-4" value="{{old( 'nombre_proveedor', $proveedores->nombre_proveedor ) }}">

<label class="uppercase text-gray-700 text-xs" >Nit</label>
<br>
<span > @error('nit') {{$message}}
    
    @enderror </span>
<input type="text" id="nit" name ="nit" class="rounded border-gray-200 w-full mb-4" value="{{ old('nit', $proveedores->nit) }}"  >

<label class="uppercase text-gray-700 text-xs" >Direccion</label>
<br>
<span > @error('direccion') {{$message}}
    
    @enderror </span>
<input type="text" id="direccion" name ="direccion" class="rounded border-gray-200 w-full mb-4" value="{{ old('direccion', $proveedores->direccion) }}"  >

<label class="uppercase text-gray-700 text-xs" >Razon social</label>
<br>
<span > @error('razon_social') {{$message}}
    
    @enderror </span>
<input type="text" id="razon_social" name ="razon_social" class="rounded border-gray-200 w-full mb-4" value="{{ old('razon_social', $proveedores->Razon_social)}}"  >


<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('proveedores.index')}}">volver</a>
<input type="submit" value="Registrar Proveedor  "  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
