@csrf 
<span style="color: red" > @error('name') {{$message}}
    
    @enderror </span>
<label  class="form-control" for="">Nombre</label>
<input id="name" name="name" class="form-control" type="text" value="{{old( 'name', $roles->name ) }}">
<input type="submit">
  
<hr>

<h2 class="h3"> Lista de permisos</h2>

<table id="roles" class="table table-striped" style="width:90%">

    <thead>
        <tr>
            <th>Permisos</th>
        </tr>
    </thead>
    <tbody>
        @foreach ($permisos as $pr)
             <tr>
             <td>   <input type="checkbox"id="permissions[]" name="permissions[]"  value="{{ $pr->id }}"> {{$pr->descripcion}}  </td>
             </tr>
        @endforeach
    </tbody>
</table>
