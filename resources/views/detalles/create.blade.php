
@extends('adminlte::page')

@section('title', 'Registrar movimiento')

@section('content_header')
    <h1>Activos fijos</h1>
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="text-xl font-semibold leading-tight text-gray-800">
            {{ __('Registrar movimieto') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="mx-auto max-w-7xl sm:px-6 lg:px-8">
            <div class="overflow-hidden bg-white shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                <form action=" {{route('movimientos.store')}}" method="POST" >
              <!--esitar methodo put-->
              @csrf
                @include('movimientos._form')

                </form>

                </div>
            </div>
        </div>
    </div>
</x-app-layout>

@stop

@section('css')
<link rel="stylesheet" href="	https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap5.min.css">
@stop

@section('js')


<script>

    $(document).ready(function () {
        $('#example').DataTable({

language: {
    "search": "Buscar:",

        //
    "info": "Mostrando _START_ a _END_ de _TOTAL_ ciudades",


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


<script src=" https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
<script src="   https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap5.min.js"></script>
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
