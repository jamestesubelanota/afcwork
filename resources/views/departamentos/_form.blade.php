@csrf


@if(session('success'))
    <div class="alert alert-success">
        {{ session('success') }}
    </div>
@endif
@if(session('error'))
    <div class="alert alert-danger">
        {{ session('error') }}
    </div>
@endif

<label class="text-xs text-gray-700 uppercase" >Departamento</label>
<br>
<span style="color: red">@error('') {{$message}}

@enderror</span>
<input type="text" id="departamento"  name ="departamento" class="form-control" value="{{$departamento->nombreDepartamento}}"  >


<br>

<div>
<a   class="px-4 py-2 text-white bg-gray-800 rounded"  href="{{route('clientes.index')}}">volver</a>
<input type="submit" value="Guardar"  class="btn btn-primary" >
</div>
