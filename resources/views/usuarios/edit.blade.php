
@extends('adminlte::page')

@section('title', 'Editar Ciudad')

@section('content_header')
<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="#">Usuarios </a></li>
        <li class="breadcrumb-item active" aria-current="page">Editar usuario</li>
    </ol>
</nav>
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
      
    </x-slot>

  

    <div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
    class="vh-100 gradient-custom">
    <br>
    <div class="row">

        <div class="col-md-4"></div>
        <div class="card border-black mb-3" style="max-width: 20rem;">
            <div class="card-header">Editar y asignar rol a un usuario</div>
            <div class="card-body text-primary">

                <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                        <div class="p-6 bg-white border-b border-gray-200">
                          {!! Form::model($user, ['route'=> ['usuarios.update', $user], 'method' => 'put'])   !!}
                            

                          {{$user->name}}
                          {!!  Form::submit('asignar rol',['class' => 'btn btn-primary']) !!}

                          <h2>Listado de roles</h2>   

                          @foreach ($roles as   $role)

                          
                             <div>
                                {!! Form::Checkbox('roles[]', $role->id, null,['class'=> 'mr-1'] ) !!}
                                {{$role->name}}
                             </div>
                          @endforeach
                           {!! Form::close() !!}
                        </div>
                    </div>
                </div>

            </div>
            <div class="col-md-4"></div>
        </div>
    </div>
</div>
</x-app-layout>

@stop

@section('css')
    <link rel="stylesheet" href="/css/admin_custom.css">
@stop

@section('js')
    <script> console.log('Hi!'); </script>
@stop