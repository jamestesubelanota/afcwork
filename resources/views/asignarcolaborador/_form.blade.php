@csrf

@if(session('success'))
    <div class="alert alert-success">
        {{ session('success') }}
    </div>
@endif
<h4>Cliente</h4>
<select class="form-select" id="cliente" name="cliente">

    @foreach ( $cliente as  $clientes)
        @if (old('cliente') ==  $clientes->id_cliente)
            <option value="{{ $clientes->id_cliente}}" selected> {{ $clientes->nombre_cliente}}</option>
        @else
            <option value="{{ $clientes->id_cliente}}"> {{ $clientes->nombre_cliente}}</option>
        @endif
    @endforeach


</select>
<h4>Sedes</h4>
<select class="form-select" id="sede" name="sede">

    @foreach ( $sede  as  $sedes)
        @if (old('sede') ==  $sedes->id_sede)
            <option value="{{ $sedes->id_sede }}" selected> {{ $sedes->nombre_sede }}</option>
        @else
            <option value="{{ $sedes->id_sede }}"> {{ $sedes->nombre_sede}}</option>
        @endif
    @endforeach


</select>
<h4>Empleado</h4>
<select class="form-select" id="colaborador" name="colaborador">

    @foreach ($colaborador as  $colaboradores )
        @if (old('colaborador') ==  $colaboradores->id_colaborador)
            <option value="{{ $colaboradores->id_colaborador}}" selected> {{ $colaboradores->nombre_colaborador }}</option>
        @else
            <option value="{{ $colaboradores->id_colaborador }}"> {{ $colaboradores->nombre_colaborador}}</option>
        @endif
    @endforeach


</select>
<hr>
<div>
<a   class="btn btn-dark"  href="{{route('asignarcolaborador.index')}}">volver</a>
<input type="submit" value="Guardar "  class="btn btn-dark" >
</div>


