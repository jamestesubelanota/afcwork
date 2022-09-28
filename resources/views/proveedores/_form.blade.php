@csrf 
<label class="uppercase text-gray-700 text-xs" >Nombre del proveedor</label>
<input type="text" id="nombre_proveedor"  name ="nombre_proveedor" class="rounded border-gray-200 w-full mb-4" value="{{$proveedores->nombre_proveedor  }}"  >

<label class="uppercase text-gray-700 text-xs" >Nit</label>
<input type="text" id="nit" name ="nit" class="rounded border-gray-200 w-full mb-4" value="{{ $proveedores->nit }}"  >

<label class="uppercase text-gray-700 text-xs" >Direccion</label>
<input type="text" id="direccion" name ="direccion" class="rounded border-gray-200 w-full mb-4" value="{{ $proveedores->direccion }}"  >
<label class="uppercase text-gray-700 text-xs" >Razon social</label>
<input type="text" id="razon_social" name ="razon_social" class="rounded border-gray-200 w-full mb-4" value="{{ $proveedores->Razon_social}}"  >


<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('proveedores.index')}}">volver</a>
<input type="submit" value="Registrar Proveedor  "  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
