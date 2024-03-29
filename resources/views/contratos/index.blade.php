
@extends('adminlte::page')

@section('title', 'Clientes')

@section('content_header')
   
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
      
    </x-slot>
    <div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
    class="vh-100 gradient-custom">
    <br>
    <section style="background-color : white">

        <div class="card ">
            <div class="card-header">
                <nav class="navbar bg-light">
                    <div class="container-fluid">
                        <a class="btn btn-primary" href="{{ route('contratos.create') }}"> Agregar un contrato </a>
                    </div>
                </nav>

            </div>
            <div class="card-body">
                <table id="Proveedores" class="table table-striped" style="width:80%">
                     
                    <thead>
                        <tr>
                            <th>Contrato</th>
                            <th>Codigo </th>
                            <th>inicio de contrato</th>
                            <th>Fin de contrato</th>
                            <th>Estado </th>
                            <th>Cliente </th>
                           
                            <th>Opciones</th>
                          
                           
                        </tr>
                    </thead>
                    <tbody>

                      @foreach ($contratos as $contrato)
                      <tr>
                        <td>{{ $contrato->tipo_de_contrato}}</td>
                        <td> {{ $contrato->codigo }}
                        <td>{{ $contrato->inicio}}</td>
                        <td>{{ $contrato->fin}}</td>
                        <td>{{ $contrato->estado}}</td>
                        <td>{{ $contrato->clientes->nombre_cliente}}</td>
                        <td class=" px-6 py-6">
                            <div class="dropdown">
                                <a class="btn btn-secondary dropdown-toggle" href="#" role="button"
                                    id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
                                    aria-expanded="false">
                                    Acciones
                                </a>

                                <div class="dropdown-menu dropdown-menu-dark"
                                    aria-labelledby="dropdownMenuLink">
                                   
                                      
                                  <li><a href="{{ route('contratos.edit', $contrato) }}"
                                    class="dropdown-item active">Editar</a></li>
                                  <li> <form action="   {{route('contratos.destroy', $contrato->id_contrato)}}" method="POST" >
        
                                    @csrf
                                    @method('DELETE')
                                       <li><input 
                                        type="submit" 
                                        value="Eliminar" 
                                        class="dropdown-item" 
                                        onclick="return confirm('desea eliminar ?')"
                                        ></li> 
                        
                                    </form></li>
                                   



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
        
</div>

</section>
<br>


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
      $(document).ready(function () {
        $('#Proveedores').DataTable({

language: {
    "search": "Buscar:",

        //
    "info": "Mostrando _START_ a _END_ de _TOTAL_ Contratos",


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
 
@stop