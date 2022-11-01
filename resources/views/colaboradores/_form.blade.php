@csrf 
<label class="uppercase text-gray-700 text-xs" >Nombre</label>
<span>@error('nombre') {{$message}}
    
    @enderror</span>
<input type="text" id="nombre"  name ="nombre" class="rounded border-gray-200 w-full mb-4" value="{{ old('nombre', $colaboradores->nombre_colaborador)}}"  >
<label class="uppercase text-gray-700 text-xs" >identificacion</label>
<span>@error('identificacion') {{$message}}
    
    @enderror</span>
<input type="text" id="identificacion"  name ="identificacion" class="rounded border-gray-200 w-full mb-4" value="{{ old('identificacion',$colaboradores->identificacion)}}"  >

<label class="uppercase text-gray-700 text-xs" >telefono </label>
<span>@error('telefono') {{$message}}
    
    @enderror</span>
<input type="text" id="telefono" name ="telefono" class="rounded border-gray-200 w-full mb-4" value="{{ old('telefono',$colaboradores->telefono) }}"  >

<label class="uppercase text-gray-700 text-xs">Rol </label>
<br>
<select class="custom-select" id="rol" name="rol">
    @foreach ($roles as $rol)
        <option value=" {{ $rol->id_rol }}">{{ $rol->rol }}</option>
    @endforeach
</select>
<br>


<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('colaboradores.index')}}">volver</a>
<input type="submit" value="Registrar Colaborador "  class="bg-gray-800 text-white rounded px-4 py-2" >
</div>
