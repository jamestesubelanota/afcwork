<!doctype html>
<html>

<head>
    <meta charset="utf-8" />
    <meta name="description" content="Resumen del contenido de la página">
    <title>Carta de envio</title>
    <!-- Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
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
    @foreach ($detalleCabecera as $detalleCabeceras)
        <div style="text-align: justify">
            Bogota, D.C {{ $detalleCabeceras->inicio }} <p style="text-align: right">
                CL<?php

                $date = date_create($detalleCabeceras->inicio);
                echo date_format($date, 'Y'); ?>/{{ $detalleCabeceras->id_cabecera }}</p>
        </div>
        <p>Señores</p>
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
                        <th> </th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th>Total : $ {{ number_format($sumaCosto) }}</th>

                        <th></th>

                    </tr>
                </tfoot>
            </table>



        </section>
        <section>
            @foreach ($detalleCabecera as $detalleCabeceras)
                <p style="text-align: justify"> Los señores
                    <strong>{{ $detalleCabeceras->clientes->nombre_cliente }}</strong> se comprometen a tener los
                    equipos de cómputo y biomedicos de la serie en referencia en las mismas condiciones y con todos sus
                    accesorios
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
                <br>
            @endforeach





        </section>
    </main>

    <table style="width: 100%;">
        <tr>
            <td style="text-align: center; vertical-align: middle;">
                <div style=padding: 10px; border-radius: 5px; margin: 5px; font-size: 18px; font-weight: bold; color:
                    #333;">
                    <strong> Secretaria de ingeniería <br> Personal TIC </strong>
                </div>
            </td>
            <td style="text-align: center; vertical-align: middle;">

            </td>
            <td style="text-align: center; vertical-align: middle;">
                <div
                    style="padding: 10px; border-radius: 5px; margin: 5px; font-size: 18px; font-weight: bold; color: #333;">
                    <strong>Director de ingenieria <br> Coordinador de sistemas</strong>
                </div>
            </td>
        </tr>
    </table>





    <h3> Recibido por : </h3>
    <p>Firma :__________________</p>
    <p>Nombre:_________________</p>
    <p>Cargo :__________________</p>
    <footer style="  /* Color de fondo azul */

    border-radius: 5px; /* Bordes redondeados */
    font-size: 13px; /* Tamaño de letra pequeña */
    color: #007bff; /* Color del texto blanco */
    text-align: center  "> © SOMOS IMPORTADORES Y DISTRIBUIDORES EXCLUSIVOS DE LA LINEA HUMAN EN COLOMBIA
        <P> Bogota D.C. Calle 116 70c -40 © PBX DIGITAL 742 64 86</P>
        <p> E-mail: administracion@comprola.com © www.comprolab.com</P>
    </footer>
</body>


</html>
