@csrf
<div class="container">
    <div class="row">

        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <form>
                        <div class="row">
                          <button type="sutmit" name="Submit" class="btn btn-primary">Registrar movimiento</button>
                            <div class="col">
                              
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
                            <div class="col">
                                <label class="input-group-text" for="inputGroupSelect01">Sedes</label>

                                <select class="custom-select" name="sede" id="sede">
                                    <option selected>Seleccione la sede </option>
                                    @foreach ($sedes as $sede)
                                        <option value="{{ $sede->id_sede }}" selected>{{ $sede->nombre_sede }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col">
                                <label class="input-group-text" for="inputGroupSelect01">Tipo de movimiento </label>

                                <select class="custom-select"   name="id_movimiento" id="id_movimiento">
                                    <option selected>Seleccione el timpo de movimiento </option>
                                    @foreach ($movimientos as $movimiento)
                                        <option value="{{ $movimiento->id_tmovimiento }}"> {{ $movimiento->id_tmovimiento }} {{ $movimiento->movimiento }}
                                        </option>
                                    @endforeach
                                </select>

                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">inicio</label>
                                <input type="date" class="form-control" name="inicio" id="inicio" placeholder="Example input">
                              </div>
                              <div class="form-group">
                                <label for="formGroupExampleInput">fin</label>
                                <input type="date" class="form-control" name="fin" id="fin" placeholder="Example input">
                              </div>
                              <div class="form-group">
                                <label for="formGroupExampleInput"></label>
                                <input type="text" class="form-control" name="detalle" id="detalle" placeholder="Example input">
                              </div>
                           
                        </div>
                      <div  style="height: 10px" ></div>
                        <table id="example" class="table table-striped table-bordered" style="width:100%">
                            <thead>
                                <tr>
                                    <th>Activo</th>
                                    <th>equipo</th>
                                    <th>serial</th>
                                    <th>marca</th>
                                    <th>costo</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach ($activos as $activo)
                                    <tr>
                                        <td> <input  type="checkbox"id="id_activo" name="id_activo[]" value="{{ $activo->id_activo }}">...{{ $activo->activo }}</td>
                                        <td>{{  $activo->equipo->equipo}}</td>
                                         <td>{{ $activo->marca->marca}}</td>
                                        <td>{{  $activo->serial}}</td>
                                       <td>{{  $activo->costo}}</td>

                                    </tr>
                                @endforeach
                            </tbody>
                            </tfoot>
                        </table>
                    </form>


                </div>
            </div>
        </div>

    </div>
