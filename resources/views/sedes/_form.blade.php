@csrf 
<label class="uppercase text-gray-700 text-xs"  >cliente</label>
<br>
    <select class="uppercase text-gray-700 text-xs" id="cliente_id"  name ="cliente_id"  >
     @foreach ($cliente as $clientes)
     <option value=" {{$clientes->id_cliente}}">{{$clientes->nombre_cliente}}</option>
     @endforeach
    
    
 
    </select>
    <br>
    <label class="uppercase text-gray-700 text-xs"  >Ciudad</label>
    <br>
    <select class="uppercase text-gray-700 text-xs" id="ciudad_id"  name ="ciudad_id"   >
    
      @foreach ($ciudad as $ciudades)
      <option value="{{$ciudades->id_ciudad}}" >{{$ciudades->nombre_ciudad}} </option>
      @endforeach
    </select>
    <br>

<label class="uppercase text-gray-700 text-xs" >nombre_sede</label>
<input type="text" id="nombre_sede"  name ="nombre_sede" class="rounded border-gray-200 w-full mb-4" value="{{$sede->nombre_sede  }}"  >

<label class="uppercase text-gray-700 text-xs" >direccion</label>
<input type="text" id="direccion" name ="direccion" class="rounded border-gray-200 w-full mb-4" value="{{ $sede->direccion }}"  >

<label class="uppercase text-gray-700 text-xs" >contacto</label>
<input type="text" id="contacto	" name ="contacto" class="rounded border-gray-200 w-full mb-4" value="{{ $sede->contacto}}"  >
<label class="uppercase text-gray-700 text-xs" >Telefono</label>
<input type="text" id="telefono" name ="telefono" class="rounded border-gray-200 w-full mb-4" value="{{ $sede->telefono}}"  >

<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('clientes.index')}}">volver</a>
<input type="submit" value="Registrar sede del cliente "  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
