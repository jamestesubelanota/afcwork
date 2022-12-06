@csrf 
<label class="uppercase text-gray-700 text-xs"  >cliente</label>
<br>
<span> @error('cliente_id') {{$message}}
    
@enderror</span>
<br>
    <select class="uppercase text-gray-700 text-xs" id="cliente_id"  name ="cliente_id"  >
      <option value=" ">Selecione el cliente</option>
     @foreach ($cliente as $clientes)
     <option value=" {{ old('cliente_id',$clientes->id_cliente)}}">{{$clientes->nombre_cliente}}</option>
     @endforeach
    
    
 
    </select>
    <br>
    <label class="uppercase text-gray-700 text-xs"  >Ciudad</label>
    <br>
<span> @error('ciudad_id') {{$message}}
    
@enderror</span>
    <br>
    <select class="uppercase text-gray-700 text-xs" id="ciudad_id"  name ="ciudad_id"   >
      <option value=" ">Selecione la ciudad</option>
      @foreach ($ciudad as $ciudades)
      <option value="{{ old('ciudad_id',$ciudades->id_ciudad)}}" >{{$ciudades->nombre_ciudad}} </option>
      @endforeach
    </select>
    <br>

<label class="uppercase text-gray-700 text-xs" >nombre_sede</label>
<br>
<span> @error('nombre_sede') {{$message}}
    
@enderror</span>
<input type="text" id="nombre_sede"  name ="nombre_sede" class="rounded border-gray-200 w-full mb-4" value="{{ old('nombre_sede',$sede->nombre_sede ) }}"  >

<label class="uppercase text-gray-700 text-xs" >direccion</label>
<br>
<span> @error('direccion') {{$message}}
    
@enderror</span>
<input type="text" id="direccion" name ="direccion" class="rounded border-gray-200 w-full mb-4" value="{{old('direccion', $sede->direccion) }}"  >

<label class="uppercase text-gray-700 text-xs" >contacto</label>
<br>
<span> @error('contacto') {{$message}}
    
@enderror</span>
<input type="text" id="contacto	" name ="contacto" class="rounded border-gray-200 w-full mb-4" value="{{ old('contacto', $sede->contacto) }}"  >
<label class="uppercase text-gray-700 text-xs" >Telefono</label>
<br>
<span> @error('telefono') {{$message}}
    
@enderror</span>
<input type="text" id="telefono" name ="telefono" class="rounded border-gray-200 w-full mb-4" value="{{ old( 'telefono',$sede->telefono)}}"  >
<br>
<span> @error('zona') {{$message}}
    
@enderror</span>
<input type="text" id="zona" name ="zona" class="rounded border-gray-200 w-full mb-4" value="{{ old( 'telefono',$sede->zona)}}"  >

<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('clientes.index')}}">volver</a>
<input type="submit" value="Guardar"  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
