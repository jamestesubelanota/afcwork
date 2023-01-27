@csrf
<div class="container"style="background:linear-gradient(30deg, white,#004593, white, #004593, white);"
class="vh-100 gradient-custom">
<br> 
<div class="container">

    <div class="card">
        <form action="">

            <h5 class="card-header">Registrar movimiento </h5>
            <div class="card-body">
                <div class="">
                    <div class="col-md-6 ">

                        <div class="card">
                            <div class="card-header">
                           
                            </div>
                            <div class="card-body">
                                <div class="row">

                                    <div class="col-md-6">
        
                                        <div class="input-group-prepend">
        
                                            <label class="input-group-text" for="inputGroupSelect01">Cliente</label>
                                        </div>
                                        <span style="color: red">@error('cliente') {{$message}}
    
                                            @enderror</span>
                                        <select name="cliente" class="custom-select" id="cliente">
                                            <option selected>Seleccione el cliente</option>
                                            @foreach ($clientes as $cliente)

                                            @if(old('cliente') == $cliente->id_cliente)
                                            <option value="{{$cliente->id_cliente}}" selected> {{$cliente->nombre_cliente }}</option>
                                        @else
                                            <option value="{{$cliente->id_cliente}}"> {{$cliente->nombre_cliente }}</option>
                                        
                                            @endif
                                                
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="col-md-6">

                                        <span style="color: red">@error('sede') {{$message}}
    
                                            @enderror</span>
                                        <label class="input-group-text" for="inputGroupSelect01">Sedes</label>
        
                                        <select class="custom-select" name="sede" id="sede">
                                            <option selected>Seleccione la sede </option>
                                            @foreach ($sedes as $sede)

                                            @if(old('sede') == $sede->id_sede)
                                            <option value="{{$sede->id_sede}}" selected> {{$sede->nombre_sede }}</option>
                                        @else
                                            <option value="{{$sede->id_sede}}"> {{$sede->nombre_sede }}</option>
                                        
                                            @endif
                                             
                                            @endforeach
                                        </select>
                                    </div>
        
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-md-6">
                                        <span style="color: red">@error('id_movimiento') {{$message}}
    
                                            @enderror</span>
                                        <label class="input-group-text" for="inputGroupSelect01">Tipo de movimiento </label>
        
                                        <select class="custom-select" name="id_movimiento" id="id_movimiento">
                                            <option selected>Seleccione el timpo de movimiento </option>
                                            @foreach ($movimientos as $movimiento)
                                                <option value="{{ $movimiento->id_tmovimiento }}">
                                                    {{ $movimiento->id_tmovimiento }} {{ $movimiento->movimiento }}
                                                </option>
                                            @endforeach
                                        </select>
        
                                    </div>
                                    <div class="col-md-6">
                                        <span style="color: red">@error('inicio') {{$message}}
    
                                            @enderror</span>
                                        <label for="formGroupExampleInput">inicio</label>
                                        <input type="date" class="form-control" name="inicio" id="inicio"
                                            placeholder="Example input">
                                    </div>
        
                                </div>
                                <hr>
        
                                <div class="row">
                                    <span style="color: red">@error('detalle') {{$message}}
    
                                        @enderror</span>
                                    <div class="col-md-12">
                                        <label for="formGroupExampleInput"> Descripcion del movimiento </label>
                                        <input type="text" class="form-control" name="detalle" id="detalle"
                                            placeholder="Example input">
                                    </div>
        
                                </div>
                                <hr>
                              
                            </div>
                        </div>
                     

                    </div>

                    <div class="header">
                       <hr>
                     <h2>Seleccione el activo</h2>
                     <hr>
                    </div>
                    <div class="col-md-12 " >
                        
                        <table id="example" class="table table-striped table-bordered" style="background-color:rgb(185, 186, 189)">
                            <thead>
                                <tr>
                                    <th>Activo</th>
                                    <th>Sede</th>
                                    <th>equipo</th>
                                    <th>serial</th>
                                    <th>marca</th>
                                    <th>costo</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($activos as $activo)
                                    <tr>
                                        <td> <input type="checkbox"id="id_activo" name="id_activo[]"  value="{{ $activo->id_activo }}">...{{ $activo->activo }}</td>
                                        <td>{{ $activo->sede->nombre_sede }}</td>
                                        <td>{{ $activo->equipo->equipo }}</td>
                                        <td>{{ $activo->marca->marca }}</td>
                                        <td>{{ $activo->serial }}</td>
                                        <td>{{ $activo->costo }}</td>

                                    </tr>
                                @endforeach
                            </tbody>
                            </tfoot>
                        </table>
                    </div>
                    <div class="row">
        
                        <div style="text-align: center" class="col-md-12">
                            <button type="sutmit" name="Submit" class="btn btn-primary">Registrar
                                movimiento</button>
                        </div>
                    </div>
                    <!---segunda secciom--->
                   

                </div>
            </div>
        </form>

    </div>

</div>
<br>
</div>


