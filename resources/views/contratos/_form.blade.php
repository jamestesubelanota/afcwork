@csrf


<label class="form-label"> Tipo de contrato</label>
<br>
<span style="color: red">
    @error('tipo_de_contrato')
        {{ $message }}
    @enderror
</span>
<input type="text" id="tipo_de_contrato" name="tipo_de_contrato" class="form-control"
    value="{{ $contrato->tipo_de_contrato }}">
<br>

<label class="form-label">Codigo de contrato</label>
<br>
<span style="color: red">
    @error('codigo')
        {{ $message }}
    @enderror
</span>
<input type="text" id="codigo" name="codigo" class="form-control" value="{{ $contrato->codigo  }}">
<br>
<label class="form-label">Inicio de contrato</label>
<br>
<span style="color: red">
    @error('inicio')
        {{ $message }}
    @enderror
</span>
<input type="date" id="inicio" name="inicio" class="form-control" value="{{ $contrato->inicio }}">
<br>




<label class="form-label">Fin de contrato</label>
<br>
<span style="color: red">
    @error('fin')
        {{ $message }}
    @enderror
</span>
<input type="date" id="fin" name="fin" class="form-control" value="{{ $contrato->fin }}">
<br>


<label class="form-label">Cliente</label>
<br>
<span style="color: red">
    @error('cliente')
        {{ $message }}
    @enderror
</span>
<select class="form-select" name="cliente" id="cliente">
    @foreach ($cliente as $cliente)

    @if(old('cliente') == $cliente->id_cliente )
    <option value="{{$cliente->id_cliente }}" selected> {{ $cliente->nombre_cliente }}</option>
@else
    <option value="{{$cliente->id_cliente }}"> {{$cliente->nombre_cliente }}</option>

    @endif
        
    @endforeach
</select>
<br>
<label class="form-label">Estado</label>
<br>
<span style="color: red">
    @error('cliente')
        {{ $message }}
    @enderror
</span>
<select class="form-select" name="estado" id="estado">


    <option value="Activo"> Activo </option>
    <option value="Inactivo"> Inactivo </option>

</select>
<br>

<div>
    <a class="bg-gray-800 text-white rounded px-4 py-2" href="{{ route('contratos.index') }}">volver</a>
    <input type="submit" value="Guardar" class="btn btn-primary">
</div>
