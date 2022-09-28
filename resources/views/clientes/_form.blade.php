@csrf 
<label class="uppercase text-gray-700 text-xs" >Nombre del Cliente</label>
<input type="text" id="nombre_cliente"  name ="nombre_cliente" class="rounded border-gray-200 w-full mb-4" value="{{$cliente->nombre_cliente  }}"  >

<label class="uppercase text-gray-700 text-xs" >Nit</label>
<input type="text" id="nit" name ="nit" class="rounded border-gray-200 w-full mb-4" value="{{ $cliente->nit }}"  >

<label class="uppercase text-gray-700 text-xs" >razon_social</label>
<input type="text" id="razon_social" name ="razon_social" class="rounded border-gray-200 w-full mb-4" value="{{ $cliente->razon_social}}"  >
<label class="uppercase text-gray-700 text-xs" >Destalle</label>
<input type="text" id="detalle" name ="detalle" class="rounded border-gray-200 w-full mb-4" value="{{ $cliente->detalle}}"  >


<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('clientes.index')}}">volver</a>
<input type="submit" value="Registrar cliente  "  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
