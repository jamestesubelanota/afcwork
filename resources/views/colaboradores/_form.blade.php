@csrf 
<label class="uppercase text-gray-700 text-xs" >Nombre</label>
<span style="color:red">@error('nombre') {{$message}}
    
    @enderror</span>
<input type="text" id="nombre"  name ="nombre" class="form-control" value="{{ old('nombre', $colaboradores->nombre_colaborador)}}"  >
<label class="uppercase text-gray-700 text-xs" >identificacion</label>
<span style="color:red">@error('identificacion') {{$message}}
    
    @enderror</span>
<input type="text" id="identificacion"  name ="identificacion" class="form-control" value="{{ old('identificacion',$colaboradores->identificacion)}}"  >

<label class="uppercase text-gray-700 text-xs" >telefono </label>
<span style="color:red">@error('telefono') {{$message}}
    
    @enderror</span>
<input type="text" id="telefono" name ="telefono" class="form-control" value="{{ old('telefono',$colaboradores->telefono) }}"  >

<label class="uppercase text-gray-700 text-xs">Cargo </label>
<br>



<span style="color: red"> @error('cargo')
    {{ $message }}
@enderror </span>
<select class="form-select" id="cargo" name="cargo">
<option value="">Seleccione el cargo </option>

@foreach ($roles as $rol)
@if(old('cargo') == $rol->id_cargo)
<option value="{{$rol->id_cargo}}" selected> {{ $rol->cargo }}</option>
@else
<option value="{{$rol->id_cargo}}"> {{$rol->cargo }}</option>

@endif
   
@endforeach
</select>

<br>
<hr>

<div>
<a   class="bg-gray-800 text-white rounded px-4 py-2"  href="{{route('colaboradores.index')}}">volver</a>
<input type="submit" value="Guardar"  class="btn btn-primary" >
</div>
