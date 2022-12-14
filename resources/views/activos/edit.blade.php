
@extends('adminlte::page')

@section('title', 'Editar Activos')

@section('content_header')
    <h1>Activos fijos</h1>
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Editar Activos') }}
        </h2>
    </x-slot>
    <div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
    class="vh-100 gradient-custom">
    <br>
    <div class="row">

        <div class="col-md-4"></div>
        <div class="card border-black mb-3" style="max-width: 30rem;">
            <div class="card-header">Agregar  activos</div>
            <div class="card-body text-primary">

                <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                        <div class="p-6 bg-white border-b border-gray-200">
                            <form action="   {{route('activos.update', $activo)}}" method="POST" enctype="multipart/form-data" >
                                <!--esitar methodo put-->
                                @csrf
                                  @method('PUT')
                                  @include('activos._form')
                                  
                                  </form>

                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="col-md-4"></div>
    </div>

</div>
   
</x-app-layout>

@stop

@section('css')
   
@stop

@section('js')


<script>
 
    $(document).ready(function () {
        $('#example').DataTable();
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