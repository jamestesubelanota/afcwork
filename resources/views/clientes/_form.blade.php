@csrf 


<label class="uppercase text-gray-700 text-xs" >Nombre del Cliente</label>
<br>
<span style="color: red">@error('nombre_cliente') {{$message}}
    
@enderror</span>
<input type="text" id="nombre_cliente"  name ="nombre_cliente" class="form-control" value="{{$cliente->nombre_cliente  }}"  >


<label class="uppercase text-gray-700 text-xs" >Nit</label>
<br>
<span style="color: red">@error('nit') {{$message}}
    
@enderror</span>
<input type="text" id="nit" name ="nit" class="form-control" value="{{ $cliente->nit }}"  >

<label class="uppercase text-gray-700 text-xs" >razon_social</label>
<br>
<span style="color: red">@error('razon_social') {{$message}}
    
@enderror</span>

<input type="text" id="razon_social" name ="razon_social" class="form-control" value="{{ $cliente->razon_social}}"  >
<label class="uppercase text-gray-700 text-xs" >Destalle</label>
<br>
<span style="color: red">@error('detalle') {{$message}}
    
@enderror</span>
<input type="text" id="detalle" name ="detalle" class="form-control" value="{{ $cliente->detalle}}"  >



<br>

<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('clientes.index')}}">volver</a>
<input type="submit" value="Guardar"  class="btn btn-primary" >
</div>
