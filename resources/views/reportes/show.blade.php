<!doctype html>
<html>

<head>
    <meta charset="utf-8" />
    <meta name="description" content="Resumen del contenido de la página">
    <title>Carta de envio</title>
    <!-- Fonts -->
    <link rel="stylesheet" href="">
    <link rel="stylesheet" href="https://fonts.bunny.net/css2?family=Nunito:wght@400;600;700&display=swap">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" href="{{ public_path('css/app.css') }}" rel="stylesheet" type="text/css">
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous">
    </script>


</head>

<body style="font-size: 13ch">
    <header>
        <img src="vendor/adminlte/dist/img/EncabezadoCarta.jpg" display:block; margin:auto; alt="">

    </header>
    <br>
    <br>
    @foreach ($detalleCabecera as $detalleCabeceras)
        <div style="text-align: justify">
            Bogota, D.C {{ $detalleCabeceras->inicio }} <p style="text-align: right">
                CL<?php

                $date = date_create($detalleCabeceras->inicio);
                echo date_format($date, 'Y'); ?>/{{ $detalleCabeceras->id_cabecera }}</p>
        </div>

        <h3><strong> {{ $detalleCabeceras->clientes->nombre_cliente }},
                {{ $detalleCabeceras->sedes->nombre_sede }}</strong></h3>

        LABORATORIO CLINICO

        <br>
        Dir.: {{ $detalleCabeceras->sedes->direccion }}
        <br>
        Tel.:{{ $detalleCabeceras->sedes->telefono }}

        <br>
        {{ $detalleCabeceras->sedes->ciudad->nombre_ciudad }}

        <nav>
            <br>

            <strong>
                <h3>REF.:{{ $detalleCabeceras->detalle }}</h3>
            </strong>
        </nav>
    @endforeach
    <main>
        <section>
            <p style="text-align: justify"> Por medio de la presente es nuestro deseo dejar constancia de la entrega del
                siguientes equipos de computo referenciados a continuación, en calidad de comodato: </p>
        </section>
        <br>
        <section>

            <table id="movimientos" class="table table-striped" style="border: black 1px solid ">
                <thead style="border: black 1px solid">
                    <tr style="border: black 1px solid">
                        <th style="border: black 1px solid">
                            <h4> Codigo </h4>
                        </th>
                        <th style="border: black 1px solid">
                            <h4> Equipo o accesorios</h4>
                        </th>
                        <th style="border: black 1px solid">
                            <h4> Activo fijo</h4>
                        </th>
                        <th style="border: black 1px solid">
                            <h4> No.Serie</h4>
                        </th>
                        <th style="border: black 1px solid">
                            <h4> Valor comercial</h4>
                        </th>
                        <th style="border: black 1px solid">
                            <h4> Tiempo()<br> Duracion del prestamos</h4>
                        </th>
                    </tr>
                </thead>

                <tbody style="border: black 1px solid">

                    @foreach ($DetalleMovimiento as $DetalleMovimientos)
                        <tr style="border: black 1px solid">
                            <td style="border: black 1px solid"> {{ $DetalleMovimientos->activo->activo }} </td>
                            <td style="border: black 1px solid">{{ $DetalleMovimientos->activo->equipo->equipo }}</td>
                            <td style="border: black 1px solid">{{ $DetalleMovimientos->activo->activo }}</td>
                            <td style="border: black 1px solid">{{ $DetalleMovimientos->activo->serial }}</td>
                            <td style="border: black 1px solid"> $
                                {{ number_format($DetalleMovimientos->activo->costo) }}</td>
                            <td style="border: black 1px solid">Por contrato</td>

                        </tr>
                       ¡
                    @endforeach

                </tbody>
                <tfoot>
                    <tr>
                        <th>Codigo </th>
                        <th>Position</th>
                        <th>Office</th>
                        <th>Extn.</th>
                        <th>Start date</th>

                        <th></th>

                    </tr>
                </tfoot>
            </table>



        </section>
        <section>
            @foreach ($detalleCabecera as $detalleCabeceras)
                <p style="text-align: justify"> Los señores
                    <strong>{{ $detalleCabeceras->clientes->nombre_cliente }}</strong> se comprometen a tener los
                    equipos de cómputo de la serie en referencia en las mismas condiciones y con todos sus accesorios
                    tal como les es entregado dentro del tiempo establecido en común acuerdo.

                    En caso de deterioro físico, daño parcial o total, Los señores
                    <strong>{{ $detalleCabeceras->clientes->nombre_cliente }}</strong> se harán responsables de los
                    gastos de reparación parcial o reposición total del Dispositivo al valor comercial vigente.

                    Sin otro particular por el momento, les saludamos.
                    <br>

                    Cordialmente,
                    <br>
                    <br>
                    COMPROLAB S.A.S
                </p>
            @endforeach
        </section>
    </main>
    <footer> © pie de la página </footer>
</body>

</html>
