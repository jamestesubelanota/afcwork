
@extends('adminlte::page')

@section('title', 'Editar foto')

@section('content_header')
    <h1>Activos fijos</h1>
@stop

@section('content')
<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Editar Ciudad') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                <form action="   {{route('foto.update',  $ciudad)}}" method="POST"  enctype="multipart/form-data">
              <!--esitar methodo put-->
                @method('PUT')
                @include('foto._form')
                @csrf
                </form>
               
                </div>
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