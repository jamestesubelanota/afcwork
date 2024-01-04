@csrf
<label class="text-xs text-gray-700 uppercase" >Nombre</label>
<span style="color:red">@error('nombre') {{$message}}

    @enderror</span>
<input type="text" id="nombre"  name ="nombre" class="form-control" value="{{ old('nombre', $colaboradores->nombre_colaborador)}}"  >
<label class="text-xs text-gray-700 uppercase" >Identificacion</label>
<span style="color:red">@error('identificacion') {{$message}}

    @enderror</span>
<input type="text" id="identificacion"  name ="identificacion" class="form-control" value="{{ old('identificacion',$colaboradores->identificacion)}}"  >

<label class="text-xs text-gray-700 uppercase" >Telefono </label>
<span style="color:red">@error('telefono') {{$message}}

    @enderror</span>
<input type="text" id="telefono" name ="telefono" class="form-control" value="{{ old('telefono',$colaboradores->telefono) }}"  >

<label class="text-xs text-gray-700 uppercase">Cargo </label>
<br>



<span style="color: red"> @error('cargo')
    {{ $message }}
@enderror </span>
<select class="form-select" id="cargo" name="cargo">
<option value="">Seleccione el cargo </option>

@if (isset($cargo))
    @foreach ($cargo as $cl)
    @if(old('cargo') == $cl->id_cargo)
    <option value="{{$cl->id_cargo}}" selected> {{$cl->cargo }}</option>
@else
    <option value="{{ $cl->id_cargo}}"> {{ $cl->cargo }}</option>

    @endif

    @endforeach
    @endif
    @foreach ($roles as $cl)
    @if(old('cargo') == $cl['id_cargo'])
    <option value="{{$cl['id_cargo']}}" selected> {{$cl->cargo }}</option>
@else
    <option value="{{ $cl['id_cargo']}}"> {{ $cl->cargo }}</option>

    @endif

    @endforeach

</select>

<br>
<hr>

<div>
<a class="btn btn-primary" href="{{route('colaboradores.index')}}">volver</a>
<input type="submit" value="Guardar"  class="btn btn-primary" >
</div>
