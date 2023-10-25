
@extends('adminlte::page')

@section('title', 'Movimientos')

@section('content_header')

@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Movimientos') }}
            <a  class="bg-gray-800 text-white rounded px-4 py-2"
            href="{{route('movimientos.create')}}"> Generar movimientos</a>

        </h2>
    </x-slot>


    <section>
        <div class="card ">
            <div class="card-header">

                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                     Generar movimientos
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                      <a class="dropdown-item " href="{{ route('movimientos.create') }}"> Generar un proximo movimiento  </a>
                       <button type="button" class="dropdown-item" data-toggle="modal" data-target="#exampleModal" data-whatever="@fat">movimiento de entrada</button>

                    </div>
                  </div>





            </div>
            <div class="card-body">
                <table id="movimientos" class="table table-striped" style="width:80%">

                    <thead>
                        <tr>

                            <th>Cliente</th>
                            <th>Sede</th>
                            <th>Movimiento</th>
                            <th>Detalle</th>
                            <th>Fecha</th>
                            <th>Opciones</th>


                        </tr>
                    </thead>
                    <tbody>

                      @foreach ( $movimientos as $movimiento)
                      <tr>

                        <td>{{ $movimiento->clientes->nombre_cliente    }}</td>
                        <td>{{ $movimiento->sedes->nombre_sede          }}</td>
                        <td>{{ $movimiento->tipoMovimiento->movimiento  }}</td>
                        <td>{{ $movimiento->detalle ?? ''    }}</td>
                        <td>{{ $movimiento->inicio                      }}</td>
                        <td class="">

                            <div class="dropdown">
                                <a class="btn btn-secondary dropdown-toggle" href="#" role="button"
                                    id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
                                    aria-expanded="false">
                                    Acciones
                                </a>

                                <div class="dropdown-menu dropdown-menu-dark"
                                aria-labelledby="dropdownMenuLink">

                                <li>  <a href="{{route('reportes.show',  $movimiento )}}"   class="dropdown-item " >Generar carta</a></li>
                                <li>  <a href="{{route('movimientos.edit',  $movimiento )}}"   class="dropdown-item " >Generar formato de prestamo</a></li>
                                <li>  <a href="{{route('movimientos.edit',  $movimiento )}}"   class="dropdown-item " >Generar Boleta</a></li>






                            </div>

                            </div>
                        </td>


                    </tr>
                      @endforeach

                    </tbody>
                </table>

            </div>
            <div class="card-footer text-muted">

            </div>
        </div>


    </section>
<hr>
</div>

<!----nodal-->

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Selecciona hospital y sede</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">

           <form action="{{route('entrada.create')}}">
          @csrf
            <div class="col-md-6">

              <div class="input-group-prepend">

                  <label class="input-group-text" for="inputGroupSelect01">Cliente</label>
              </div>
              <select name="cliente" class="custom-select" id="cliente">
                  <option selected>Selecione el cliente</option>
                  @foreach ($clientes as $cliente)
                      <option value="{{ $cliente->id_cliente }}" selected>
                          {{ $cliente->nombre_cliente }}</option>
                  @endforeach
              </select>
          </div>
          <div class="col-md-6">
              <label class="input-group-text" for="inputGroupSelect01">Sedes</label>

              <select class="custom-select" name="sede" id="sede">
                  <option selected>Seleccione la sede </option>
                  @foreach ($sedes as $sede)
                      <option value="{{ $sede->id_sede }}" selected>{{ $sede->nombre_sede }}</option>
                  @endforeach
              </select>
          </div>
<hr>


   <input class="btn btn-primary" type="submit" value="generar movmiento de entrada">

           </form>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>

        </div>
      </div>
    </div>
  </div>
</x-app-layout>
@stop

@section('css')
    <link rel="stylesheet" href="/css/admin_custom.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap5.min.css">

@stop

@section('js')
    <script> console.log('Hi!'); </script>
    <script src=" https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
    <script src="   https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
  <script>

  </script>
  <script>
    $(document).ready(function() {
        $('#movimientos').DataTable({
            language: {
    "search": "Buscar:",
    "infoFiltered": "(Filtrado de _MAX_ total entradas)",

        //
    "info": "Mostrando _START_ a _END_ de _TOTAL_ ciudades",


    "paginate": {

"first": "Primero",
"last": "Ultimo",
"next": "Siguiente",
"previous": "Anterior"
}

}

        });
    });
</script>
<script>
  $(document).ready(function() {
      $('#clientes').DataTable({
         order: [[3, 'desc']],
language: {
    "search": "Buscar:",

        //
    "info": "Mostrando _START_ a _END_ de _TOTAL_ Movimientos",


    "paginate": {
"first": "Primero",
"last": "Ultimo",
"next": "Siguiente",
"previous": "Anterior"
}
}

}
   );
  });
</script>

<script type="text/javascript">

  $(document).ready(function () {
              $('#cliente').on('change', function () {
                  var cliente_id = this.value;
                  $('#sede').html('');
                  $.ajax({
                      url: '{{ route('movimientos.create') }}?cliente_id='+ cliente_id,
                      type: 'get',
                      success: function (res) {
                          $('#sede').html('<option value="">Seleccione sede</option>');

                          $.each(res, function (key, value) {
                              $('#sede').append('<option value="' + value
                                  .id_sede + '">' + value.nombre_sede + '</option>');
                          });




                      }
                  });
              });

          });





           </script>


@stop
