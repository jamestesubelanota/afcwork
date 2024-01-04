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
<label class="text-xs text-gray-700 uppercase" >Estados</label>
<span  style="color: red" class="text-xs">@error('estado') {{$message}} @enderror  </span>
<input type="text" id="estado"  name ="estado" class="form-control" value="{{old('estado', $estados->estado)}}"  >

<hr>

<div>
<a   class="btn btn-primary"  href="{{route('estados.index')}}">volver</a>
<input type="submit" value="Guardar"  class="btn btn-primary" >
</div>
