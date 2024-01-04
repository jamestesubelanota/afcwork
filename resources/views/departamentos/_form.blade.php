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
<span style="color: red"> @error('departamento')
    {{ $message }}
@enderror </span>
<input type="text" id="departamento"  name ="departamento" class="form-control" value="{{$departamento->nombreDepartamento}}"  >


<br>

<div>
<a   class="btn btn-primary" href="{{route('departamentos.index')}}">volver</a>

<input type="submit" value="Guardar"  class="btn btn-primary" >
</div>
