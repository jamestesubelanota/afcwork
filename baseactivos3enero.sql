PGDMP                          |            cp-activos2    14.4    14.4 "   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    43498    cp-activos2    DATABASE     X   CREATE DATABASE "cp-activos2" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
    DROP DATABASE "cp-activos2";
                postgres    false            $           1255    48013    log_registro_cliente()    FUNCTION     �  CREATE FUNCTION public.log_registro_cliente() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO logclientes (id_cliente, nombre_cliente, usuario, accion) 
        VALUES (new.id_cliente, new.nombre_cliente, current_user, 'insert');
        RETURN NULL;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO logclientes (id_cliente, nombre_cliente, usuario, accion) 
        VALUES (new.id_cliente, new.nombre_cliente, current_user, 'update');
        RETURN NULL;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO logclientes (id_cliente, nombre_cliente, usuario, accion) 
        VALUES (old.id_cliente, old.nombre_cliente, current_user, 'delete');
        RETURN NULL;
    END IF;
    RETURN NULL;
END $$;
 -   DROP FUNCTION public.log_registro_cliente();
       public          postgres    false            (           1255    64342    registrar_cambios()    FUNCTION     �  CREATE FUNCTION public.registrar_cambios() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE 
    valores_anteriores JSONB;
    valores_nuevos JSONB;
BEGIN 
    valores_anteriores := jsonb_build_object(
        'id_activo', old.id_activo,
        'activo', old.activo,
        'id_equipo', old.id_equipo,
        'id_marca', old.id_marca,
        'serial', old.serial, 
        'activocontable', old.activocontable,
        'costo', old.costo,
        'modelo', old.modelo,
        'id_propietario', old.id_propietario,
        'id_proveedor', old.id_proveedor,
        'id_estado', old.id_estado,
        'id_cliente', old.id_cliente,
        'id_sede', old.id_sede,
        'id_user', old.id_user
    );
    valores_nuevos := jsonb_build_object(
        'id_activo', new.id_activo,
        'activo', new.activo,
        'id_equipo', new.id_equipo,
        'id_marca', new.id_marca,
        'serial', new.serial, 
        'activocontable', new.activocontable,
        'costo', new.costo,
        'modelo', new.modelo,
        'id_propietario', new.id_propietario,
        'id_proveedor', new.id_proveedor,
        'id_estado', new.id_estado,
        'id_cliente', new.id_cliente,
        'id_sede', new.id_sede,
        'id_user', new.id_user
    );
    
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO registroCambios (tabla_afectada, accion_realizada, valor_anterior, varlor_actual, usuario)
        VALUES ('ACTIVOS', 'INSERT', NULL::JSONB, valores_nuevos, CURRENT_USER);
    ELSIF  (TG_OP = 'UPDATE') THEN
        INSERT INTO registroCambios (tabla_afectada, accion_realizada, valor_anterior, varlor_actual, usuario)
        VALUES ('ACTIVOS', 'UPDATE', valores_anteriores, valores_nuevos, CURRENT_USER);
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO registroCambios (tabla_afectada, accion_realizada, valor_anterior, varlor_actual, usuario)
        VALUES ('ACTIVOS', 'DELETE', valores_anteriores, NULL::JSONB, CURRENT_USER);
    END IF;
    
    RETURN NULL;
END;
$$;
 *   DROP FUNCTION public.registrar_cambios();
       public          postgres    false            "           1255    47984    registrar_log_activos()    FUNCTION     P  CREATE FUNCTION public.registrar_log_activos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    last_id INTEGER;
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO logactivos (id_activo, activo, serial, usuario, accion, tablaafectada)
        VALUES (NEW.id_activo, NEW.activo, NEW.serial, current_user, 'insert', 'activos')
        RETURNING id_activo INTO last_id;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO logactivos (id_activo, activo, serial, usuario, accion, tablaafectada)
        VALUES (OLD.id_activo, OLD.activo, OLD.serial, current_user, 'update', 'activos');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO logactivos (id_activo, activo, serial, usuario, accion, tablaafectada)
        VALUES (OLD.id_activo, OLD.activo, OLD.serial, current_user, 'delete', 'activos');
    END IF;
    RETURN NULL;
END;
$$;
 .   DROP FUNCTION public.registrar_log_activos();
       public          postgres    false            &           1255    48048    registrar_log_colaboradores()    FUNCTION     �  CREATE FUNCTION public.registrar_log_colaboradores() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO logcolaboradores (id_colaborador, nombre_colaborador, identificacion, telefono, id_cargo, usuario, accion)
        VALUES (NEW.id_colaborador, NEW.nombre_colaborador, NEW.identificacion, NEW.telefono, NEW.id_cargo,current_user, 'insert');
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO logcolaboradores (id_colaborador, nombre_colaborador, identificacion, telefono, id_cargo, usuario, accion)
        VALUES (NEW.id_colaborador, NEW.nombre_colaborador, NEW.identificacion, NEW.telefono, NEW.id_cargo, current_user, 'update');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO logcolaboradores (id_colaborador, nombre_colaborador, identificacion, telefono, id_cargo, usuario, accion)
        VALUES (OLD.id_colaborador, OLD.nombre_colaborador, OLD.identificacion, OLD.telefono, OLD.id_cargo, current_user, 'delete');
    END IF;

    RETURN NULL;
END;
$$;
 4   DROP FUNCTION public.registrar_log_colaboradores();
       public          postgres    false            #           1255    48007    registrar_log_contratos()    FUNCTION     �  CREATE FUNCTION public.registrar_log_contratos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE  
    last_id INTEGER;
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO logcontratos (id_contrato, tipo_de_contrato, codigo, id_cliente, usuario, accion) 
        VALUES (new.id_contrato, new.tipo_de_contrato, new.codigo, new.id_cliente, current_user, 'insert') 
        RETURNING id_contrato INTO last_id;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO logcontratos (id_contrato, tipo_de_contrato, codigo, id_cliente, usuario, accion) 
        VALUES (new.id_contrato, new.tipo_de_contrato, new.codigo, old.id_cliente, current_user, 'update');
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO logcontratos (id_contrato, tipo_de_contrato, codigo, id_cliente, usuario, accion) 
        VALUES (old.id_contrato, old.tipo_de_contrato, old.codigo, old.id_cliente, current_user, 'delete');
    END IF;
    RETURN NULL;
END;
$$;
 0   DROP FUNCTION public.registrar_log_contratos();
       public          postgres    false                       1255    47972    registrar_log_equipo()    FUNCTION       CREATE FUNCTION public.registrar_log_equipo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    last_id INTEGER;
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO logs (tabla_afectada, id_equipo, accion, usuario)
        VALUES ('equipos', NEW.id_equipo, 'insert', current_user)
        RETURNING id_equipo INTO last_id;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO logs (tabla_afectada, id_equipo, accion, usuario)
        VALUES ('equipos', OLD.id_equipo, 'update', current_user);
        last_id := OLD.id_equipo;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO logs (tabla_afectada, id_equipo, accion, usuario)
        VALUES ('equipos', OLD.id_equipo, 'delete', current_user);
        last_id := OLD.id_equipo;
    END IF;
    RETURN NULL;
END;
$$;
 -   DROP FUNCTION public.registrar_log_equipo();
       public          postgres    false            '           1255    48058    registrar_log_sedes()    FUNCTION     �  CREATE FUNCTION public.registrar_log_sedes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
    IF TG_OP = 'INSERT' THEN
        INSERT INTO logsedes (nombre_sede, direccion, contacto, telefono, ciudad_id, cliente_id, usuario, accion)
        VALUES (NEW.nombre_sede, NEW.direccion, NEW.contacto, NEW.telefono, NEW.ciudad_id, NEW.cliente_id, current_user, 'insert');
        
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO logsedes (nombre_sede, direccion, contacto, telefono, ciudad_id, cliente_id, usuario, accion)
        VALUES (NEW.nombre_sede, NEW.direccion, NEW.contacto, NEW.telefono, NEW.ciudad_id, NEW.cliente_id, current_user, 'update');
        
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO logsedes (nombre_sede, direccion, contacto, telefono, ciudad_id, cliente_id, usuario, accion)
        VALUES (OLD.nombre_sede, OLD.direccion, OLD.contacto, OLD.telefono, OLD.ciudad_id, OLD.cliente_id, current_user, 'delete');
    END IF;
    
    RETURN NULL;
END;
$$;
 ,   DROP FUNCTION public.registrar_log_sedes();
       public          postgres    false            %           1255    48032    regitrar_log_movimiento()    FUNCTION     e  CREATE FUNCTION public.regitrar_log_movimiento() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN 
IF TG_OP = 'INSERT' THEN 
insert into logmovimientos (id_cabecera, id_cliente, id_sede, Usuario, detalle, accion ,id_tmovimiento)
values(new.id_cabecera, new.id_cliente, new.id_sede,current_user, new.detalle, 'insert', new.id_tmovimiento );

ELSEIF TG_OP = 'UPDATE' THEN 
insert into logmovimientos (id_cabecera, id_cliente, id_sede, Usuario, detalle, accion,id_tmovimiento )
values(new.id_cabecera, new.id_cliente, new.id_sede,current_user, new.detalle, 'insert', new.id_tmovimiento );


ELSEIF TG_OP = 'DELETE' THEN 
insert into logmovimientos (id_cabecera, id_cliente, id_sede, Usuario, detalle, accion,id_tmovimiento )
values(old.id_cabecera, old.id_cliente, old.id_sede, current_user, old.detalle, 'insert', old.id_tmovimiento );

END IF;
RETURN NULL;
END
$$;
 0   DROP FUNCTION public.regitrar_log_movimiento();
       public          postgres    false            �            1259    43719    activos    TABLE     �  CREATE TABLE public.activos (
    id_activo integer NOT NULL,
    activo character varying(7) NOT NULL,
    id_equipo integer NOT NULL,
    id_marca integer NOT NULL,
    serial character varying(100) NOT NULL,
    activocontable character varying(4) NOT NULL,
    costo double precision NOT NULL,
    modelo character varying(50) NOT NULL,
    "fechaDeCompra" date NOT NULL,
    id_propietario integer NOT NULL,
    id_proveedor integer NOT NULL,
    id_estado integer NOT NULL,
    "id_tipoEquipo" integer NOT NULL,
    id_cliente integer NOT NULL,
    id_sede integer NOT NULL,
    id_user integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.activos;
       public         heap    postgres    false            �            1259    43718    activos_id_activo_seq    SEQUENCE     �   CREATE SEQUENCE public.activos_id_activo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.activos_id_activo_seq;
       public          postgres    false    253            �           0    0    activos_id_activo_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.activos_id_activo_seq OWNED BY public.activos.id_activo;
          public          postgres    false    252            �            1259    43771    cabecera_movimientos    TABLE     v  CREATE TABLE public.cabecera_movimientos (
    id_cabecera integer NOT NULL,
    id_cliente integer NOT NULL,
    id_sede integer NOT NULL,
    id_tmovimiento integer NOT NULL,
    id_user integer NOT NULL,
    inicio date NOT NULL,
    detalle character varying(150) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 (   DROP TABLE public.cabecera_movimientos;
       public         heap    postgres    false            �            1259    43770 $   cabecera_movimientos_id_cabecera_seq    SEQUENCE     �   CREATE SEQUENCE public.cabecera_movimientos_id_cabecera_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.cabecera_movimientos_id_cabecera_seq;
       public          postgres    false    255            �           0    0 $   cabecera_movimientos_id_cabecera_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.cabecera_movimientos_id_cabecera_seq OWNED BY public.cabecera_movimientos.id_cabecera;
          public          postgres    false    254            �            1259    43636    cargos    TABLE     �   CREATE TABLE public.cargos (
    id_cargo integer NOT NULL,
    cargo character varying(30) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.cargos;
       public         heap    postgres    false            �            1259    43635    cargos_id_cargo_seq    SEQUENCE     �   CREATE SEQUENCE public.cargos_id_cargo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.cargos_id_cargo_seq;
       public          postgres    false    237            �           0    0    cargos_id_cargo_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.cargos_id_cargo_seq OWNED BY public.cargos.id_cargo;
          public          postgres    false    236            �            1259    43681    ciudades    TABLE     #  CREATE TABLE public.ciudades (
    id_ciudad bigint NOT NULL,
    cod_dane character varying(30) NOT NULL,
    nombre_ciudad character varying(30) NOT NULL,
    id_departamento integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.ciudades;
       public         heap    postgres    false            �            1259    43680    ciudades_id_ciudad_seq    SEQUENCE        CREATE SEQUENCE public.ciudades_id_ciudad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.ciudades_id_ciudad_seq;
       public          postgres    false    247            �           0    0    ciudades_id_ciudad_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.ciudades_id_ciudad_seq OWNED BY public.ciudades.id_ciudad;
          public          postgres    false    246            �            1259    43655    clientes    TABLE     [  CREATE TABLE public.clientes (
    id_cliente integer NOT NULL,
    nombre_cliente character varying(100) NOT NULL,
    nit character varying(40) NOT NULL,
    razon_social character varying(100) NOT NULL,
    detalle character varying(150) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.clientes;
       public         heap    postgres    false            �            1259    43654    clientes_id_cliente_seq    SEQUENCE     �   CREATE SEQUENCE public.clientes_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.clientes_id_cliente_seq;
       public          postgres    false    241            �           0    0    clientes_id_cliente_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.clientes_id_cliente_seq OWNED BY public.clientes.id_cliente;
          public          postgres    false    240                       1259    43815    colaborador_sedes    TABLE     �   CREATE TABLE public.colaborador_sedes (
    id_colaborador_sede integer NOT NULL,
    id_colaborador integer NOT NULL,
    id_sede integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 %   DROP TABLE public.colaborador_sedes;
       public         heap    postgres    false                       1259    43814 (   colaborador_sede_id_colaborador_sede_seq    SEQUENCE     �   CREATE SEQUENCE public.colaborador_sede_id_colaborador_sede_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.colaborador_sede_id_colaborador_sede_seq;
       public          postgres    false    259            �           0    0 (   colaborador_sede_id_colaborador_sede_seq    SEQUENCE OWNED BY     v   ALTER SEQUENCE public.colaborador_sede_id_colaborador_sede_seq OWNED BY public.colaborador_sedes.id_colaborador_sede;
          public          postgres    false    258            �            1259    43643    colaboradores    TABLE     [  CREATE TABLE public.colaboradores (
    id_colaborador integer NOT NULL,
    nombre_colaborador character varying(100) NOT NULL,
    identificacion character varying(50) NOT NULL,
    telefono double precision NOT NULL,
    id_cargo integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 !   DROP TABLE public.colaboradores;
       public         heap    postgres    false            �            1259    43642     colaboradores_id_colaborador_seq    SEQUENCE     �   CREATE SEQUENCE public.colaboradores_id_colaborador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.colaboradores_id_colaborador_seq;
       public          postgres    false    239            �           0    0     colaboradores_id_colaborador_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.colaboradores_id_colaborador_seq OWNED BY public.colaboradores.id_colaborador;
          public          postgres    false    238            �            1259    43662 	   contratos    TABLE       CREATE TABLE public.contratos (
    id_contrato integer NOT NULL,
    tipo_de_contrato character varying(30) NOT NULL,
    codigo character varying(40) NOT NULL,
    inicio date NOT NULL,
    fin date NOT NULL,
    estado character varying(20) NOT NULL,
    id_cliente integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.contratos;
       public         heap    postgres    false            �            1259    43661    contratos_id_contrato_seq    SEQUENCE     �   CREATE SEQUENCE public.contratos_id_contrato_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.contratos_id_contrato_seq;
       public          postgres    false    243            �           0    0    contratos_id_contrato_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.contratos_id_contrato_seq OWNED BY public.contratos.id_contrato;
          public          postgres    false    242            �            1259    43674    departamentos    TABLE     �   CREATE TABLE public.departamentos (
    id_departamento bigint NOT NULL,
    "nombreDepartamento" character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 !   DROP TABLE public.departamentos;
       public         heap    postgres    false            �            1259    43673 !   departamentos_id_departamento_seq    SEQUENCE     �   CREATE SEQUENCE public.departamentos_id_departamento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.departamentos_id_departamento_seq;
       public          postgres    false    245            �           0    0 !   departamentos_id_departamento_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.departamentos_id_departamento_seq OWNED BY public.departamentos.id_departamento;
          public          postgres    false    244                       1259    43798    detalle_movimientos    TABLE       CREATE TABLE public.detalle_movimientos (
    id_detalle integer NOT NULL,
    id_activo integer NOT NULL,
    id_cabecera integer NOT NULL,
    detalle character varying(150) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 '   DROP TABLE public.detalle_movimientos;
       public         heap    postgres    false                        1259    43797 "   detalle_movimientos_id_detalle_seq    SEQUENCE     �   CREATE SEQUENCE public.detalle_movimientos_id_detalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.detalle_movimientos_id_detalle_seq;
       public          postgres    false    257            �           0    0 "   detalle_movimientos_id_detalle_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.detalle_movimientos_id_detalle_seq OWNED BY public.detalle_movimientos.id_detalle;
          public          postgres    false    256            �            1259    43629    equipos    TABLE     �   CREATE TABLE public.equipos (
    id_equipo integer NOT NULL,
    equipo character varying(20) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.equipos;
       public         heap    postgres    false            �            1259    43628    equipos_id_equipo_seq    SEQUENCE     �   CREATE SEQUENCE public.equipos_id_equipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.equipos_id_equipo_seq;
       public          postgres    false    235            �           0    0    equipos_id_equipo_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.equipos_id_equipo_seq OWNED BY public.equipos.id_equipo;
          public          postgres    false    234            �            1259    43615    estados    TABLE     �   CREATE TABLE public.estados (
    id_estado integer NOT NULL,
    estado character varying(20) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.estados;
       public         heap    postgres    false            �            1259    43614    estados_id_estado_seq    SEQUENCE     �   CREATE SEQUENCE public.estados_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.estados_id_estado_seq;
       public          postgres    false    231            �           0    0    estados_id_estado_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.estados_id_estado_seq OWNED BY public.estados.id_estado;
          public          postgres    false    230                       1259    43832    fotos    TABLE     �   CREATE TABLE public.fotos (
    id_foto integer NOT NULL,
    foto character varying NOT NULL,
    id_activo integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.fotos;
       public         heap    postgres    false                       1259    43831    fotos_id_foto_seq    SEQUENCE     �   CREATE SEQUENCE public.fotos_id_foto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.fotos_id_foto_seq;
       public          postgres    false    261            �           0    0    fotos_id_foto_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.fotos_id_foto_seq OWNED BY public.fotos.id_foto;
          public          postgres    false    260            	           1259    47977 
   logactivos    TABLE     I  CREATE TABLE public.logactivos (
    id_loga integer NOT NULL,
    id_activo integer,
    activo character varying(6),
    serial character varying(50),
    usuario character varying(50),
    accion character varying(6),
    tablaafectada character varying(10),
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.logactivos;
       public         heap    postgres    false                       1259    47976    logactivos_id_loga_seq    SEQUENCE     �   CREATE SEQUENCE public.logactivos_id_loga_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.logactivos_id_loga_seq;
       public          postgres    false    265            �           0    0    logactivos_id_loga_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.logactivos_id_loga_seq OWNED BY public.logactivos.id_loga;
          public          postgres    false    264                       1259    48016    logclientes    TABLE     	  CREATE TABLE public.logclientes (
    id_log integer NOT NULL,
    id_cliente integer,
    nombre_cliente character varying(50),
    usuario character varying(30),
    accion character varying(10),
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.logclientes;
       public         heap    postgres    false                       1259    48015    logclientes_id_log_seq    SEQUENCE     �   CREATE SEQUENCE public.logclientes_id_log_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.logclientes_id_log_seq;
       public          postgres    false    269            �           0    0    logclientes_id_log_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.logclientes_id_log_seq OWNED BY public.logclientes.id_log;
          public          postgres    false    268                       1259    48035    logcolaboradores    TABLE     9  CREATE TABLE public.logcolaboradores (
    id_log integer NOT NULL,
    id_colaborador integer,
    nombre_colaborador character varying(50),
    identificacion character varying(10),
    telefono character varying(10),
    id_cargo integer,
    usuario character varying(50),
    accion character varying(10)
);
 $   DROP TABLE public.logcolaboradores;
       public         heap    postgres    false                       1259    48034    logcolaboradores8_id_log_seq    SEQUENCE     �   CREATE SEQUENCE public.logcolaboradores8_id_log_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.logcolaboradores8_id_log_seq;
       public          postgres    false    273            �           0    0    logcolaboradores8_id_log_seq    SEQUENCE OWNED BY     \   ALTER SEQUENCE public.logcolaboradores8_id_log_seq OWNED BY public.logcolaboradores.id_log;
          public          postgres    false    272                       1259    47996    logcontratos    TABLE     7  CREATE TABLE public.logcontratos (
    id_log integer NOT NULL,
    id_contrato integer,
    tipo_de_contrato character varying,
    codigo character varying,
    id_cliente integer,
    usuario character varying,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    accion character varying
);
     DROP TABLE public.logcontratos;
       public         heap    postgres    false            
           1259    47995    logcontratos_id_log_seq    SEQUENCE     �   CREATE SEQUENCE public.logcontratos_id_log_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.logcontratos_id_log_seq;
       public          postgres    false    267            �           0    0    logcontratos_id_log_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.logcontratos_id_log_seq OWNED BY public.logcontratos.id_log;
          public          postgres    false    266                       1259    48024    logmovimientos    TABLE     N  CREATE TABLE public.logmovimientos (
    id_log integer NOT NULL,
    id_cabecera integer,
    id_cliente integer,
    id_sede integer,
    usuario character varying(50),
    detalle character varying(60),
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    accion character varying(7),
    id_tmovimiento integer
);
 "   DROP TABLE public.logmovimientos;
       public         heap    postgres    false                       1259    48023    logmovimientos_id_log_seq    SEQUENCE     �   CREATE SEQUENCE public.logmovimientos_id_log_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.logmovimientos_id_log_seq;
       public          postgres    false    271            �           0    0    logmovimientos_id_log_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.logmovimientos_id_log_seq OWNED BY public.logmovimientos.id_log;
          public          postgres    false    270                       1259    47965    logs    TABLE     �   CREATE TABLE public.logs (
    id integer NOT NULL,
    tabla_afectada character varying(50),
    id_equipo integer,
    accion character varying(20),
    usuario character varying(50),
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.logs;
       public         heap    postgres    false                       1259    47964    logs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.logs_id_seq;
       public          postgres    false    263            �           0    0    logs_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;
          public          postgres    false    262                       1259    48051    logsedes    TABLE     �  CREATE TABLE public.logsedes (
    id_log integer NOT NULL,
    nombre_sede character varying(60),
    direccion character varying(60),
    contacto character varying(50),
    telefono character varying(50),
    ciudad_id integer,
    cliente_id integer,
    usuario character varying(50),
    accion character varying(10),
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.logsedes;
       public         heap    postgres    false                       1259    48050    logsedes_id_log_seq    SEQUENCE     �   CREATE SEQUENCE public.logsedes_id_log_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.logsedes_id_log_seq;
       public          postgres    false    275            �           0    0    logsedes_id_log_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.logsedes_id_log_seq OWNED BY public.logsedes.id_log;
          public          postgres    false    274            �            1259    43622    marcas    TABLE     �   CREATE TABLE public.marcas (
    id_marca integer NOT NULL,
    marca character varying(20) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.marcas;
       public         heap    postgres    false            �            1259    43621    marcas_id_marca_seq    SEQUENCE     �   CREATE SEQUENCE public.marcas_id_marca_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.marcas_id_marca_seq;
       public          postgres    false    233            �           0    0    marcas_id_marca_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.marcas_id_marca_seq OWNED BY public.marcas.id_marca;
          public          postgres    false    232            �            1259    43500 
   migrations    TABLE     �   CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);
    DROP TABLE public.migrations;
       public         heap    postgres    false            �            1259    43499    migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.migrations_id_seq;
       public          postgres    false    210            �           0    0    migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;
          public          postgres    false    209            �            1259    43528    model_has_permissions    TABLE     �   CREATE TABLE public.model_has_permissions (
    permission_id integer NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id integer NOT NULL
);
 )   DROP TABLE public.model_has_permissions;
       public         heap    postgres    false            �            1259    43537    model_has_roles    TABLE     �   CREATE TABLE public.model_has_roles (
    role_id integer NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id integer NOT NULL
);
 #   DROP TABLE public.model_has_roles;
       public         heap    postgres    false            �            1259    43579    password_resets    TABLE     �   CREATE TABLE public.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);
 #   DROP TABLE public.password_resets;
       public         heap    postgres    false            �            1259    43507    permissions    TABLE     &  CREATE TABLE public.permissions (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    descripcion character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.permissions;
       public         heap    postgres    false            �            1259    43506    permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.permissions_id_seq;
       public          postgres    false    212            �           0    0    permissions_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;
          public          postgres    false    211            �            1259    43585    personal_access_tokens    TABLE     �  CREATE TABLE public.personal_access_tokens (
    id integer NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 *   DROP TABLE public.personal_access_tokens;
       public         heap    postgres    false            �            1259    43594    propietarios    TABLE     D  CREATE TABLE public.propietarios (
    id_propietario integer NOT NULL,
    nombre_propietario character varying(30) NOT NULL,
    razon_social character varying(40) NOT NULL,
    numero_telefono character varying(15) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
     DROP TABLE public.propietarios;
       public         heap    postgres    false            �            1259    43593    propietarios_id_propietario_seq    SEQUENCE     �   CREATE SEQUENCE public.propietarios_id_propietario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.propietarios_id_propietario_seq;
       public          postgres    false    225            �           0    0    propietarios_id_propietario_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.propietarios_id_propietario_seq OWNED BY public.propietarios.id_propietario;
          public          postgres    false    224            �            1259    43601    proveedores    TABLE     �  CREATE TABLE public.proveedores (
    id_proveedor integer NOT NULL,
    nombre_proveedor character varying(30) NOT NULL,
    nit double precision NOT NULL,
    direccion character varying(50) NOT NULL,
    razon_social character varying(50) NOT NULL,
    numero_telefono character varying(16) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.proveedores;
       public         heap    postgres    false            �            1259    43600    proveedores_id_proveedor_seq    SEQUENCE     �   CREATE SEQUENCE public.proveedores_id_proveedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.proveedores_id_proveedor_seq;
       public          postgres    false    227            �           0    0    proveedores_id_proveedor_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.proveedores_id_proveedor_seq OWNED BY public.proveedores.id_proveedor;
          public          postgres    false    226                       1259    64331    registrocambios    TABLE     9  CREATE TABLE public.registrocambios (
    idregistro integer NOT NULL,
    tabla_afectada character varying(10),
    accion_realizada character varying(10),
    valor_anterior text,
    varlor_actual text,
    usuario character varying(50),
    fecha_hora timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 #   DROP TABLE public.registrocambios;
       public         heap    postgres    false                       1259    64330    registrocambios_idregistro_seq    SEQUENCE     �   CREATE SEQUENCE public.registrocambios_idregistro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.registrocambios_idregistro_seq;
       public          postgres    false    277            �           0    0    registrocambios_idregistro_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.registrocambios_idregistro_seq OWNED BY public.registrocambios.idregistro;
          public          postgres    false    276            �            1259    43560    rol    TABLE     �   CREATE TABLE public.rol (
    id_rol integer NOT NULL,
    rol character varying(20) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.rol;
       public         heap    postgres    false            �            1259    43559    rol_id_rol_seq    SEQUENCE     �   CREATE SEQUENCE public.rol_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.rol_id_rol_seq;
       public          postgres    false    219            �           0    0    rol_id_rol_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.rol_id_rol_seq OWNED BY public.rol.id_rol;
          public          postgres    false    218            �            1259    43546    role_has_permissions    TABLE     o   CREATE TABLE public.role_has_permissions (
    permission_id integer NOT NULL,
    role_id integer NOT NULL
);
 (   DROP TABLE public.role_has_permissions;
       public         heap    postgres    false            �            1259    43518    roles    TABLE     �   CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.roles;
       public         heap    postgres    false            �            1259    43517    roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public          postgres    false    214            �           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public          postgres    false    213            �            1259    43693    sedes    TABLE     �  CREATE TABLE public.sedes (
    id_sede integer NOT NULL,
    nombre_sede character varying(100) NOT NULL,
    direccion character varying(100) NOT NULL,
    contacto character varying(100) NOT NULL,
    zona character varying(50) NOT NULL,
    telefono character varying(255) NOT NULL,
    ciudad_id integer NOT NULL,
    cliente_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.sedes;
       public         heap    postgres    false            �            1259    43692    sedes_id_sede_seq    SEQUENCE     �   CREATE SEQUENCE public.sedes_id_sede_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.sedes_id_sede_seq;
       public          postgres    false    249            �           0    0    sedes_id_sede_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.sedes_id_sede_seq OWNED BY public.sedes.id_sede;
          public          postgres    false    248            �            1259    43608    tipo_de_equipos    TABLE     �   CREATE TABLE public.tipo_de_equipos (
    id_equipo integer NOT NULL,
    tipo_de_equipo character varying(20) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 #   DROP TABLE public.tipo_de_equipos;
       public         heap    postgres    false            �            1259    43607    tipo_de_equipos_id_equipo_seq    SEQUENCE     �   CREATE SEQUENCE public.tipo_de_equipos_id_equipo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.tipo_de_equipos_id_equipo_seq;
       public          postgres    false    229            �           0    0    tipo_de_equipos_id_equipo_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.tipo_de_equipos_id_equipo_seq OWNED BY public.tipo_de_equipos.id_equipo;
          public          postgres    false    228            �            1259    43712    tipo_movimientos    TABLE     �   CREATE TABLE public.tipo_movimientos (
    id_tmovimiento integer NOT NULL,
    movimiento character varying(30) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 $   DROP TABLE public.tipo_movimientos;
       public         heap    postgres    false            �            1259    43711 #   tipo_movimientos_id_tmovimiento_seq    SEQUENCE     �   CREATE SEQUENCE public.tipo_movimientos_id_tmovimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.tipo_movimientos_id_tmovimiento_seq;
       public          postgres    false    251            �           0    0 #   tipo_movimientos_id_tmovimiento_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.tipo_movimientos_id_tmovimiento_seq OWNED BY public.tipo_movimientos.id_tmovimiento;
          public          postgres    false    250            �            1259    43567    users    TABLE     �  CREATE TABLE public.users (
    id_user integer NOT NULL,
    name character varying(50) NOT NULL,
    email character varying(60) NOT NULL,
    identificacion character varying(20) NOT NULL,
    estado character varying(10) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    43566    users_id_user_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_user_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_id_user_seq;
       public          postgres    false    221            �           0    0    users_id_user_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_id_user_seq OWNED BY public.users.id_user;
          public          postgres    false    220            0           2604    43722    activos id_activo    DEFAULT     v   ALTER TABLE ONLY public.activos ALTER COLUMN id_activo SET DEFAULT nextval('public.activos_id_activo_seq'::regclass);
 @   ALTER TABLE public.activos ALTER COLUMN id_activo DROP DEFAULT;
       public          postgres    false    253    252    253            1           2604    43774     cabecera_movimientos id_cabecera    DEFAULT     �   ALTER TABLE ONLY public.cabecera_movimientos ALTER COLUMN id_cabecera SET DEFAULT nextval('public.cabecera_movimientos_id_cabecera_seq'::regclass);
 O   ALTER TABLE public.cabecera_movimientos ALTER COLUMN id_cabecera DROP DEFAULT;
       public          postgres    false    255    254    255            (           2604    43639    cargos id_cargo    DEFAULT     r   ALTER TABLE ONLY public.cargos ALTER COLUMN id_cargo SET DEFAULT nextval('public.cargos_id_cargo_seq'::regclass);
 >   ALTER TABLE public.cargos ALTER COLUMN id_cargo DROP DEFAULT;
       public          postgres    false    236    237    237            -           2604    43684    ciudades id_ciudad    DEFAULT     x   ALTER TABLE ONLY public.ciudades ALTER COLUMN id_ciudad SET DEFAULT nextval('public.ciudades_id_ciudad_seq'::regclass);
 A   ALTER TABLE public.ciudades ALTER COLUMN id_ciudad DROP DEFAULT;
       public          postgres    false    247    246    247            *           2604    43658    clientes id_cliente    DEFAULT     z   ALTER TABLE ONLY public.clientes ALTER COLUMN id_cliente SET DEFAULT nextval('public.clientes_id_cliente_seq'::regclass);
 B   ALTER TABLE public.clientes ALTER COLUMN id_cliente DROP DEFAULT;
       public          postgres    false    240    241    241            3           2604    43818 %   colaborador_sedes id_colaborador_sede    DEFAULT     �   ALTER TABLE ONLY public.colaborador_sedes ALTER COLUMN id_colaborador_sede SET DEFAULT nextval('public.colaborador_sede_id_colaborador_sede_seq'::regclass);
 T   ALTER TABLE public.colaborador_sedes ALTER COLUMN id_colaborador_sede DROP DEFAULT;
       public          postgres    false    258    259    259            )           2604    43646    colaboradores id_colaborador    DEFAULT     �   ALTER TABLE ONLY public.colaboradores ALTER COLUMN id_colaborador SET DEFAULT nextval('public.colaboradores_id_colaborador_seq'::regclass);
 K   ALTER TABLE public.colaboradores ALTER COLUMN id_colaborador DROP DEFAULT;
       public          postgres    false    238    239    239            +           2604    43665    contratos id_contrato    DEFAULT     ~   ALTER TABLE ONLY public.contratos ALTER COLUMN id_contrato SET DEFAULT nextval('public.contratos_id_contrato_seq'::regclass);
 D   ALTER TABLE public.contratos ALTER COLUMN id_contrato DROP DEFAULT;
       public          postgres    false    243    242    243            ,           2604    43677    departamentos id_departamento    DEFAULT     �   ALTER TABLE ONLY public.departamentos ALTER COLUMN id_departamento SET DEFAULT nextval('public.departamentos_id_departamento_seq'::regclass);
 L   ALTER TABLE public.departamentos ALTER COLUMN id_departamento DROP DEFAULT;
       public          postgres    false    244    245    245            2           2604    43801    detalle_movimientos id_detalle    DEFAULT     �   ALTER TABLE ONLY public.detalle_movimientos ALTER COLUMN id_detalle SET DEFAULT nextval('public.detalle_movimientos_id_detalle_seq'::regclass);
 M   ALTER TABLE public.detalle_movimientos ALTER COLUMN id_detalle DROP DEFAULT;
       public          postgres    false    257    256    257            '           2604    43632    equipos id_equipo    DEFAULT     v   ALTER TABLE ONLY public.equipos ALTER COLUMN id_equipo SET DEFAULT nextval('public.equipos_id_equipo_seq'::regclass);
 @   ALTER TABLE public.equipos ALTER COLUMN id_equipo DROP DEFAULT;
       public          postgres    false    234    235    235            %           2604    43618    estados id_estado    DEFAULT     v   ALTER TABLE ONLY public.estados ALTER COLUMN id_estado SET DEFAULT nextval('public.estados_id_estado_seq'::regclass);
 @   ALTER TABLE public.estados ALTER COLUMN id_estado DROP DEFAULT;
       public          postgres    false    231    230    231            4           2604    43835    fotos id_foto    DEFAULT     n   ALTER TABLE ONLY public.fotos ALTER COLUMN id_foto SET DEFAULT nextval('public.fotos_id_foto_seq'::regclass);
 <   ALTER TABLE public.fotos ALTER COLUMN id_foto DROP DEFAULT;
       public          postgres    false    260    261    261            7           2604    47980    logactivos id_loga    DEFAULT     x   ALTER TABLE ONLY public.logactivos ALTER COLUMN id_loga SET DEFAULT nextval('public.logactivos_id_loga_seq'::regclass);
 A   ALTER TABLE public.logactivos ALTER COLUMN id_loga DROP DEFAULT;
       public          postgres    false    265    264    265            ;           2604    48019    logclientes id_log    DEFAULT     x   ALTER TABLE ONLY public.logclientes ALTER COLUMN id_log SET DEFAULT nextval('public.logclientes_id_log_seq'::regclass);
 A   ALTER TABLE public.logclientes ALTER COLUMN id_log DROP DEFAULT;
       public          postgres    false    268    269    269            ?           2604    48038    logcolaboradores id_log    DEFAULT     �   ALTER TABLE ONLY public.logcolaboradores ALTER COLUMN id_log SET DEFAULT nextval('public.logcolaboradores8_id_log_seq'::regclass);
 F   ALTER TABLE public.logcolaboradores ALTER COLUMN id_log DROP DEFAULT;
       public          postgres    false    273    272    273            9           2604    47999    logcontratos id_log    DEFAULT     z   ALTER TABLE ONLY public.logcontratos ALTER COLUMN id_log SET DEFAULT nextval('public.logcontratos_id_log_seq'::regclass);
 B   ALTER TABLE public.logcontratos ALTER COLUMN id_log DROP DEFAULT;
       public          postgres    false    266    267    267            =           2604    48027    logmovimientos id_log    DEFAULT     ~   ALTER TABLE ONLY public.logmovimientos ALTER COLUMN id_log SET DEFAULT nextval('public.logmovimientos_id_log_seq'::regclass);
 D   ALTER TABLE public.logmovimientos ALTER COLUMN id_log DROP DEFAULT;
       public          postgres    false    270    271    271            5           2604    47968    logs id    DEFAULT     b   ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);
 6   ALTER TABLE public.logs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    262    263    263            @           2604    48054    logsedes id_log    DEFAULT     r   ALTER TABLE ONLY public.logsedes ALTER COLUMN id_log SET DEFAULT nextval('public.logsedes_id_log_seq'::regclass);
 >   ALTER TABLE public.logsedes ALTER COLUMN id_log DROP DEFAULT;
       public          postgres    false    274    275    275            &           2604    43625    marcas id_marca    DEFAULT     r   ALTER TABLE ONLY public.marcas ALTER COLUMN id_marca SET DEFAULT nextval('public.marcas_id_marca_seq'::regclass);
 >   ALTER TABLE public.marcas ALTER COLUMN id_marca DROP DEFAULT;
       public          postgres    false    233    232    233                       2604    43503    migrations id    DEFAULT     n   ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);
 <   ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    210    210                       2604    43510    permissions id    DEFAULT     p   ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);
 =   ALTER TABLE public.permissions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    212    212            "           2604    43597    propietarios id_propietario    DEFAULT     �   ALTER TABLE ONLY public.propietarios ALTER COLUMN id_propietario SET DEFAULT nextval('public.propietarios_id_propietario_seq'::regclass);
 J   ALTER TABLE public.propietarios ALTER COLUMN id_propietario DROP DEFAULT;
       public          postgres    false    224    225    225            #           2604    43604    proveedores id_proveedor    DEFAULT     �   ALTER TABLE ONLY public.proveedores ALTER COLUMN id_proveedor SET DEFAULT nextval('public.proveedores_id_proveedor_seq'::regclass);
 G   ALTER TABLE public.proveedores ALTER COLUMN id_proveedor DROP DEFAULT;
       public          postgres    false    226    227    227            B           2604    64334    registrocambios idregistro    DEFAULT     �   ALTER TABLE ONLY public.registrocambios ALTER COLUMN idregistro SET DEFAULT nextval('public.registrocambios_idregistro_seq'::regclass);
 I   ALTER TABLE public.registrocambios ALTER COLUMN idregistro DROP DEFAULT;
       public          postgres    false    276    277    277                        2604    43563 
   rol id_rol    DEFAULT     h   ALTER TABLE ONLY public.rol ALTER COLUMN id_rol SET DEFAULT nextval('public.rol_id_rol_seq'::regclass);
 9   ALTER TABLE public.rol ALTER COLUMN id_rol DROP DEFAULT;
       public          postgres    false    218    219    219                       2604    43521    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    214    214            .           2604    43696    sedes id_sede    DEFAULT     n   ALTER TABLE ONLY public.sedes ALTER COLUMN id_sede SET DEFAULT nextval('public.sedes_id_sede_seq'::regclass);
 <   ALTER TABLE public.sedes ALTER COLUMN id_sede DROP DEFAULT;
       public          postgres    false    249    248    249            $           2604    43611    tipo_de_equipos id_equipo    DEFAULT     �   ALTER TABLE ONLY public.tipo_de_equipos ALTER COLUMN id_equipo SET DEFAULT nextval('public.tipo_de_equipos_id_equipo_seq'::regclass);
 H   ALTER TABLE public.tipo_de_equipos ALTER COLUMN id_equipo DROP DEFAULT;
       public          postgres    false    228    229    229            /           2604    43715    tipo_movimientos id_tmovimiento    DEFAULT     �   ALTER TABLE ONLY public.tipo_movimientos ALTER COLUMN id_tmovimiento SET DEFAULT nextval('public.tipo_movimientos_id_tmovimiento_seq'::regclass);
 N   ALTER TABLE public.tipo_movimientos ALTER COLUMN id_tmovimiento DROP DEFAULT;
       public          postgres    false    251    250    251            !           2604    43570    users id_user    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN id_user SET DEFAULT nextval('public.users_id_user_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN id_user DROP DEFAULT;
       public          postgres    false    220    221    221            l          0    43719    activos 
   TABLE DATA           �   COPY public.activos (id_activo, activo, id_equipo, id_marca, serial, activocontable, costo, modelo, "fechaDeCompra", id_propietario, id_proveedor, id_estado, "id_tipoEquipo", id_cliente, id_sede, id_user, created_at, updated_at) FROM stdin;
    public          postgres    false    253   ��      n          0    43771    cabecera_movimientos 
   TABLE DATA           �   COPY public.cabecera_movimientos (id_cabecera, id_cliente, id_sede, id_tmovimiento, id_user, inicio, detalle, created_at, updated_at) FROM stdin;
    public          postgres    false    255   ]�      \          0    43636    cargos 
   TABLE DATA           I   COPY public.cargos (id_cargo, cargo, created_at, updated_at) FROM stdin;
    public          postgres    false    237   ��      f          0    43681    ciudades 
   TABLE DATA           o   COPY public.ciudades (id_ciudad, cod_dane, nombre_ciudad, id_departamento, created_at, updated_at) FROM stdin;
    public          postgres    false    247   	�      `          0    43655    clientes 
   TABLE DATA           r   COPY public.clientes (id_cliente, nombre_cliente, nit, razon_social, detalle, created_at, updated_at) FROM stdin;
    public          postgres    false    241   Z�      r          0    43815    colaborador_sedes 
   TABLE DATA           q   COPY public.colaborador_sedes (id_colaborador_sede, id_colaborador, id_sede, created_at, updated_at) FROM stdin;
    public          postgres    false    259   �      ^          0    43643    colaboradores 
   TABLE DATA           �   COPY public.colaboradores (id_colaborador, nombre_colaborador, identificacion, telefono, id_cargo, created_at, updated_at) FROM stdin;
    public          postgres    false    239   &�      b          0    43662 	   contratos 
   TABLE DATA           �   COPY public.contratos (id_contrato, tipo_de_contrato, codigo, inicio, fin, estado, id_cliente, created_at, updated_at) FROM stdin;
    public          postgres    false    243   x�      d          0    43674    departamentos 
   TABLE DATA           f   COPY public.departamentos (id_departamento, "nombreDepartamento", created_at, updated_at) FROM stdin;
    public          postgres    false    245   ��      p          0    43798    detalle_movimientos 
   TABLE DATA           r   COPY public.detalle_movimientos (id_detalle, id_activo, id_cabecera, detalle, created_at, updated_at) FROM stdin;
    public          postgres    false    257   ה      Z          0    43629    equipos 
   TABLE DATA           L   COPY public.equipos (id_equipo, equipo, created_at, updated_at) FROM stdin;
    public          postgres    false    235   /�      V          0    43615    estados 
   TABLE DATA           L   COPY public.estados (id_estado, estado, created_at, updated_at) FROM stdin;
    public          postgres    false    231   ��      t          0    43832    fotos 
   TABLE DATA           Q   COPY public.fotos (id_foto, foto, id_activo, created_at, updated_at) FROM stdin;
    public          postgres    false    261   ��      x          0    47977 
   logactivos 
   TABLE DATA           o   COPY public.logactivos (id_loga, id_activo, activo, serial, usuario, accion, tablaafectada, fecha) FROM stdin;
    public          postgres    false    265   ��      |          0    48016    logclientes 
   TABLE DATA           a   COPY public.logclientes (id_log, id_cliente, nombre_cliente, usuario, accion, fecha) FROM stdin;
    public          postgres    false    269   ~�      �          0    48035    logcolaboradores 
   TABLE DATA           �   COPY public.logcolaboradores (id_log, id_colaborador, nombre_colaborador, identificacion, telefono, id_cargo, usuario, accion) FROM stdin;
    public          postgres    false    273   �      z          0    47996    logcontratos 
   TABLE DATA           y   COPY public.logcontratos (id_log, id_contrato, tipo_de_contrato, codigo, id_cliente, usuario, fecha, accion) FROM stdin;
    public          postgres    false    267   ��      ~          0    48024    logmovimientos 
   TABLE DATA           �   COPY public.logmovimientos (id_log, id_cabecera, id_cliente, id_sede, usuario, detalle, fecha, accion, id_tmovimiento) FROM stdin;
    public          postgres    false    271   �      v          0    47965    logs 
   TABLE DATA           U   COPY public.logs (id, tabla_afectada, id_equipo, accion, usuario, fecha) FROM stdin;
    public          postgres    false    263   ��      �          0    48051    logsedes 
   TABLE DATA           �   COPY public.logsedes (id_log, nombre_sede, direccion, contacto, telefono, ciudad_id, cliente_id, usuario, accion, fecha) FROM stdin;
    public          postgres    false    275   ҝ      X          0    43622    marcas 
   TABLE DATA           I   COPY public.marcas (id_marca, marca, created_at, updated_at) FROM stdin;
    public          postgres    false    233   V�      A          0    43500 
   migrations 
   TABLE DATA           :   COPY public.migrations (id, migration, batch) FROM stdin;
    public          postgres    false    210   ��      F          0    43528    model_has_permissions 
   TABLE DATA           T   COPY public.model_has_permissions (permission_id, model_type, model_id) FROM stdin;
    public          postgres    false    215   �      G          0    43537    model_has_roles 
   TABLE DATA           H   COPY public.model_has_roles (role_id, model_type, model_id) FROM stdin;
    public          postgres    false    216   0�      M          0    43579    password_resets 
   TABLE DATA           C   COPY public.password_resets (email, token, created_at) FROM stdin;
    public          postgres    false    222   h�      C          0    43507    permissions 
   TABLE DATA           `   COPY public.permissions (id, name, descripcion, guard_name, created_at, updated_at) FROM stdin;
    public          postgres    false    212   ��      N          0    43585    personal_access_tokens 
   TABLE DATA           �   COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
    public          postgres    false    223   ݣ      P          0    43594    propietarios 
   TABLE DATA           �   COPY public.propietarios (id_propietario, nombre_propietario, razon_social, numero_telefono, created_at, updated_at) FROM stdin;
    public          postgres    false    225   ��      R          0    43601    proveedores 
   TABLE DATA           �   COPY public.proveedores (id_proveedor, nombre_proveedor, nit, direccion, razon_social, numero_telefono, created_at, updated_at) FROM stdin;
    public          postgres    false    227   ?�      �          0    64331    registrocambios 
   TABLE DATA           �   COPY public.registrocambios (idregistro, tabla_afectada, accion_realizada, valor_anterior, varlor_actual, usuario, fecha_hora) FROM stdin;
    public          postgres    false    277   ��      J          0    43560    rol 
   TABLE DATA           B   COPY public.rol (id_rol, rol, created_at, updated_at) FROM stdin;
    public          postgres    false    219   3�      H          0    43546    role_has_permissions 
   TABLE DATA           F   COPY public.role_has_permissions (permission_id, role_id) FROM stdin;
    public          postgres    false    217   P�      E          0    43518    roles 
   TABLE DATA           M   COPY public.roles (id, name, guard_name, created_at, updated_at) FROM stdin;
    public          postgres    false    214   �      h          0    43693    sedes 
   TABLE DATA           �   COPY public.sedes (id_sede, nombre_sede, direccion, contacto, zona, telefono, ciudad_id, cliente_id, created_at, updated_at) FROM stdin;
    public          postgres    false    249   ��      T          0    43608    tipo_de_equipos 
   TABLE DATA           \   COPY public.tipo_de_equipos (id_equipo, tipo_de_equipo, created_at, updated_at) FROM stdin;
    public          postgres    false    229   [�      j          0    43712    tipo_movimientos 
   TABLE DATA           ^   COPY public.tipo_movimientos (id_tmovimiento, movimiento, created_at, updated_at) FROM stdin;
    public          postgres    false    251   ��      L          0    43567    users 
   TABLE DATA           �   COPY public.users (id_user, name, email, identificacion, estado, email_verified_at, password, remember_token, created_at, updated_at) FROM stdin;
    public          postgres    false    221   �      �           0    0    activos_id_activo_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.activos_id_activo_seq', 18, true);
          public          postgres    false    252            �           0    0 $   cabecera_movimientos_id_cabecera_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.cabecera_movimientos_id_cabecera_seq', 19, true);
          public          postgres    false    254            �           0    0    cargos_id_cargo_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.cargos_id_cargo_seq', 2, true);
          public          postgres    false    236            �           0    0    ciudades_id_ciudad_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.ciudades_id_ciudad_seq', 2, true);
          public          postgres    false    246            �           0    0    clientes_id_cliente_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.clientes_id_cliente_seq', 6, true);
          public          postgres    false    240            �           0    0 (   colaborador_sede_id_colaborador_sede_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.colaborador_sede_id_colaborador_sede_seq', 1, true);
          public          postgres    false    258            �           0    0     colaboradores_id_colaborador_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.colaboradores_id_colaborador_seq', 4, true);
          public          postgres    false    238            �           0    0    contratos_id_contrato_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.contratos_id_contrato_seq', 5, true);
          public          postgres    false    242            �           0    0 !   departamentos_id_departamento_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.departamentos_id_departamento_seq', 7, true);
          public          postgres    false    244            �           0    0 "   detalle_movimientos_id_detalle_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.detalle_movimientos_id_detalle_seq', 42, true);
          public          postgres    false    256            �           0    0    equipos_id_equipo_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.equipos_id_equipo_seq', 14, true);
          public          postgres    false    234            �           0    0    estados_id_estado_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.estados_id_estado_seq', 1, true);
          public          postgres    false    230            �           0    0    fotos_id_foto_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.fotos_id_foto_seq', 11, true);
          public          postgres    false    260            �           0    0    logactivos_id_loga_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.logactivos_id_loga_seq', 94, true);
          public          postgres    false    264            �           0    0    logclientes_id_log_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.logclientes_id_log_seq', 12, true);
          public          postgres    false    268            �           0    0    logcolaboradores8_id_log_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.logcolaboradores8_id_log_seq', 10, true);
          public          postgres    false    272            �           0    0    logcontratos_id_log_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.logcontratos_id_log_seq', 18, true);
          public          postgres    false    266            �           0    0    logmovimientos_id_log_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.logmovimientos_id_log_seq', 63, true);
          public          postgres    false    270            �           0    0    logs_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.logs_id_seq', 30, true);
          public          postgres    false    262            �           0    0    logsedes_id_log_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.logsedes_id_log_seq', 26, true);
          public          postgres    false    274            �           0    0    marcas_id_marca_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.marcas_id_marca_seq', 1, true);
          public          postgres    false    232            �           0    0    migrations_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.migrations_id_seq', 24, true);
          public          postgres    false    209            �           0    0    permissions_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.permissions_id_seq', 69, true);
          public          postgres    false    211            �           0    0    propietarios_id_propietario_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.propietarios_id_propietario_seq', 1, true);
          public          postgres    false    224            �           0    0    proveedores_id_proveedor_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.proveedores_id_proveedor_seq', 1, true);
          public          postgres    false    226            �           0    0    registrocambios_idregistro_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.registrocambios_idregistro_seq', 18, true);
          public          postgres    false    276            �           0    0    rol_id_rol_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.rol_id_rol_seq', 1, false);
          public          postgres    false    218            �           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 4, true);
          public          postgres    false    213            �           0    0    sedes_id_sede_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.sedes_id_sede_seq', 14, true);
          public          postgres    false    248            �           0    0    tipo_de_equipos_id_equipo_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.tipo_de_equipos_id_equipo_seq', 1, true);
          public          postgres    false    228            �           0    0 #   tipo_movimientos_id_tmovimiento_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.tipo_movimientos_id_tmovimiento_seq', 3, true);
          public          postgres    false    250            �           0    0    users_id_user_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_id_user_seq', 2, true);
          public          postgres    false    220            y           2606    43724    activos activos_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.activos
    ADD CONSTRAINT activos_pkey PRIMARY KEY (id_activo);
 >   ALTER TABLE ONLY public.activos DROP CONSTRAINT activos_pkey;
       public            postgres    false    253            {           2606    43776 .   cabecera_movimientos cabecera_movimientos_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.cabecera_movimientos
    ADD CONSTRAINT cabecera_movimientos_pkey PRIMARY KEY (id_cabecera);
 X   ALTER TABLE ONLY public.cabecera_movimientos DROP CONSTRAINT cabecera_movimientos_pkey;
       public            postgres    false    255            i           2606    43641    cargos cargos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.cargos
    ADD CONSTRAINT cargos_pkey PRIMARY KEY (id_cargo);
 <   ALTER TABLE ONLY public.cargos DROP CONSTRAINT cargos_pkey;
       public            postgres    false    237            s           2606    43686    ciudades ciudades_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.ciudades
    ADD CONSTRAINT ciudades_pkey PRIMARY KEY (id_ciudad);
 @   ALTER TABLE ONLY public.ciudades DROP CONSTRAINT ciudades_pkey;
       public            postgres    false    247            m           2606    43660    clientes clientes_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente);
 @   ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_pkey;
       public            postgres    false    241                       2606    43820 '   colaborador_sedes colaborador_sede_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.colaborador_sedes
    ADD CONSTRAINT colaborador_sede_pkey PRIMARY KEY (id_colaborador_sede);
 Q   ALTER TABLE ONLY public.colaborador_sedes DROP CONSTRAINT colaborador_sede_pkey;
       public            postgres    false    259            k           2606    43648     colaboradores colaboradores_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.colaboradores
    ADD CONSTRAINT colaboradores_pkey PRIMARY KEY (id_colaborador);
 J   ALTER TABLE ONLY public.colaboradores DROP CONSTRAINT colaboradores_pkey;
       public            postgres    false    239            o           2606    43667    contratos contratos_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.contratos
    ADD CONSTRAINT contratos_pkey PRIMARY KEY (id_contrato);
 B   ALTER TABLE ONLY public.contratos DROP CONSTRAINT contratos_pkey;
       public            postgres    false    243            q           2606    43679     departamentos departamentos_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.departamentos
    ADD CONSTRAINT departamentos_pkey PRIMARY KEY (id_departamento);
 J   ALTER TABLE ONLY public.departamentos DROP CONSTRAINT departamentos_pkey;
       public            postgres    false    245            }           2606    43803 ,   detalle_movimientos detalle_movimientos_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.detalle_movimientos
    ADD CONSTRAINT detalle_movimientos_pkey PRIMARY KEY (id_detalle);
 V   ALTER TABLE ONLY public.detalle_movimientos DROP CONSTRAINT detalle_movimientos_pkey;
       public            postgres    false    257            g           2606    43634    equipos equipos_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.equipos
    ADD CONSTRAINT equipos_pkey PRIMARY KEY (id_equipo);
 >   ALTER TABLE ONLY public.equipos DROP CONSTRAINT equipos_pkey;
       public            postgres    false    235            c           2606    43620    estados estados_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.estados
    ADD CONSTRAINT estados_pkey PRIMARY KEY (id_estado);
 >   ALTER TABLE ONLY public.estados DROP CONSTRAINT estados_pkey;
       public            postgres    false    231            �           2606    43837    fotos fotos_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.fotos
    ADD CONSTRAINT fotos_pkey PRIMARY KEY (id_foto);
 :   ALTER TABLE ONLY public.fotos DROP CONSTRAINT fotos_pkey;
       public            postgres    false    261            �           2606    47983    logactivos logactivos_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.logactivos
    ADD CONSTRAINT logactivos_pkey PRIMARY KEY (id_loga);
 D   ALTER TABLE ONLY public.logactivos DROP CONSTRAINT logactivos_pkey;
       public            postgres    false    265            �           2606    48022    logclientes logclientes_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.logclientes
    ADD CONSTRAINT logclientes_pkey PRIMARY KEY (id_log);
 F   ALTER TABLE ONLY public.logclientes DROP CONSTRAINT logclientes_pkey;
       public            postgres    false    269            �           2606    48040 '   logcolaboradores logcolaboradores8_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.logcolaboradores
    ADD CONSTRAINT logcolaboradores8_pkey PRIMARY KEY (id_log);
 Q   ALTER TABLE ONLY public.logcolaboradores DROP CONSTRAINT logcolaboradores8_pkey;
       public            postgres    false    273            �           2606    48004    logcontratos logcontratos_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.logcontratos
    ADD CONSTRAINT logcontratos_pkey PRIMARY KEY (id_log);
 H   ALTER TABLE ONLY public.logcontratos DROP CONSTRAINT logcontratos_pkey;
       public            postgres    false    267            �           2606    48030 "   logmovimientos logmovimientos_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.logmovimientos
    ADD CONSTRAINT logmovimientos_pkey PRIMARY KEY (id_log);
 L   ALTER TABLE ONLY public.logmovimientos DROP CONSTRAINT logmovimientos_pkey;
       public            postgres    false    271            �           2606    47971    logs logs_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.logs DROP CONSTRAINT logs_pkey;
       public            postgres    false    263            �           2606    48057    logsedes logsedes_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.logsedes
    ADD CONSTRAINT logsedes_pkey PRIMARY KEY (id_log);
 @   ALTER TABLE ONLY public.logsedes DROP CONSTRAINT logsedes_pkey;
       public            postgres    false    275            e           2606    43627    marcas marcas_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.marcas
    ADD CONSTRAINT marcas_pkey PRIMARY KEY (id_marca);
 <   ALTER TABLE ONLY public.marcas DROP CONSTRAINT marcas_pkey;
       public            postgres    false    233            E           2606    43505    migrations migrations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.migrations DROP CONSTRAINT migrations_pkey;
       public            postgres    false    210            G           2606    43516 .   permissions permissions_name_guard_name_unique 
   CONSTRAINT     u   ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_guard_name_unique UNIQUE (name, guard_name);
 X   ALTER TABLE ONLY public.permissions DROP CONSTRAINT permissions_name_guard_name_unique;
       public            postgres    false    212    212            I           2606    43514    permissions permissions_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.permissions DROP CONSTRAINT permissions_pkey;
       public            postgres    false    212            Z           2606    43592 :   personal_access_tokens personal_access_tokens_token_unique 
   CONSTRAINT     v   ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);
 d   ALTER TABLE ONLY public.personal_access_tokens DROP CONSTRAINT personal_access_tokens_token_unique;
       public            postgres    false    223            ]           2606    43599    propietarios propietarios_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.propietarios
    ADD CONSTRAINT propietarios_pkey PRIMARY KEY (id_propietario);
 H   ALTER TABLE ONLY public.propietarios DROP CONSTRAINT propietarios_pkey;
       public            postgres    false    225            _           2606    43606    proveedores proveedores_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.proveedores
    ADD CONSTRAINT proveedores_pkey PRIMARY KEY (id_proveedor);
 F   ALTER TABLE ONLY public.proveedores DROP CONSTRAINT proveedores_pkey;
       public            postgres    false    227            �           2606    64339 $   registrocambios registrocambios_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.registrocambios
    ADD CONSTRAINT registrocambios_pkey PRIMARY KEY (idregistro);
 N   ALTER TABLE ONLY public.registrocambios DROP CONSTRAINT registrocambios_pkey;
       public            postgres    false    277            Q           2606    43565    rol rol_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (id_rol);
 6   ALTER TABLE ONLY public.rol DROP CONSTRAINT rol_pkey;
       public            postgres    false    219            K           2606    43527 "   roles roles_name_guard_name_unique 
   CONSTRAINT     i   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_guard_name_unique UNIQUE (name, guard_name);
 L   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_name_guard_name_unique;
       public            postgres    false    214    214            M           2606    43525    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    214            u           2606    43700    sedes sedes_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.sedes
    ADD CONSTRAINT sedes_pkey PRIMARY KEY (id_sede);
 :   ALTER TABLE ONLY public.sedes DROP CONSTRAINT sedes_pkey;
       public            postgres    false    249            a           2606    43613 $   tipo_de_equipos tipo_de_equipos_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.tipo_de_equipos
    ADD CONSTRAINT tipo_de_equipos_pkey PRIMARY KEY (id_equipo);
 N   ALTER TABLE ONLY public.tipo_de_equipos DROP CONSTRAINT tipo_de_equipos_pkey;
       public            postgres    false    229            w           2606    43717 &   tipo_movimientos tipo_movimientos_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.tipo_movimientos
    ADD CONSTRAINT tipo_movimientos_pkey PRIMARY KEY (id_tmovimiento);
 P   ALTER TABLE ONLY public.tipo_movimientos DROP CONSTRAINT tipo_movimientos_pkey;
       public            postgres    false    251            S           2606    43576    users users_email_unique 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_unique;
       public            postgres    false    221            U           2606    43578 !   users users_identificacion_unique 
   CONSTRAINT     f   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_identificacion_unique UNIQUE (identificacion);
 K   ALTER TABLE ONLY public.users DROP CONSTRAINT users_identificacion_unique;
       public            postgres    false    221            W           2606    43574    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_user);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    221            N           1259    43531 /   model_has_permissions_model_id_model_type_index    INDEX     �   CREATE INDEX model_has_permissions_model_id_model_type_index ON public.model_has_permissions USING btree (model_id, model_type);
 C   DROP INDEX public.model_has_permissions_model_id_model_type_index;
       public            postgres    false    215    215            O           1259    43540 )   model_has_roles_model_id_model_type_index    INDEX     u   CREATE INDEX model_has_roles_model_id_model_type_index ON public.model_has_roles USING btree (model_id, model_type);
 =   DROP INDEX public.model_has_roles_model_id_model_type_index;
       public            postgres    false    216    216            X           1259    43584    password_resets_email_index    INDEX     X   CREATE INDEX password_resets_email_index ON public.password_resets USING btree (email);
 /   DROP INDEX public.password_resets_email_index;
       public            postgres    false    222            [           1259    43590 8   personal_access_tokens_tokenable_type_tokenable_id_index    INDEX     �   CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);
 L   DROP INDEX public.personal_access_tokens_tokenable_type_tokenable_id_index;
       public            postgres    false    223    223            �           2620    47985    activos log_activos    TRIGGER     �   CREATE TRIGGER log_activos AFTER INSERT OR DELETE OR UPDATE ON public.activos FOR EACH ROW EXECUTE FUNCTION public.registrar_log_activos();
 ,   DROP TRIGGER log_activos ON public.activos;
       public          postgres    false    290    253            �           2620    47973    equipos log_equipo    TRIGGER     �   CREATE TRIGGER log_equipo AFTER INSERT OR DELETE OR UPDATE ON public.equipos FOR EACH ROW EXECUTE FUNCTION public.registrar_log_equipo();
 +   DROP TRIGGER log_equipo ON public.equipos;
       public          postgres    false    235    281            �           2620    48014    clientes logclientes    TRIGGER     �   CREATE TRIGGER logclientes AFTER INSERT OR DELETE OR UPDATE ON public.clientes FOR EACH ROW EXECUTE FUNCTION public.log_registro_cliente();
 -   DROP TRIGGER logclientes ON public.clientes;
       public          postgres    false    241    292            �           2620    48008    contratos logcontratos    TRIGGER     �   CREATE TRIGGER logcontratos AFTER INSERT OR DELETE OR UPDATE ON public.contratos FOR EACH ROW EXECUTE FUNCTION public.registrar_log_contratos();
 /   DROP TRIGGER logcontratos ON public.contratos;
       public          postgres    false    291    243            �           2620    48049    colaboradores logocolaboradores    TRIGGER     �   CREATE TRIGGER logocolaboradores AFTER INSERT OR DELETE OR UPDATE ON public.colaboradores FOR EACH ROW EXECUTE FUNCTION public.registrar_log_colaboradores();
 8   DROP TRIGGER logocolaboradores ON public.colaboradores;
       public          postgres    false    239    294            �           2620    48033 #   cabecera_movimientos logomovimiento    TRIGGER     �   CREATE TRIGGER logomovimiento AFTER INSERT OR DELETE OR UPDATE ON public.cabecera_movimientos FOR EACH ROW EXECUTE FUNCTION public.regitrar_log_movimiento();
 <   DROP TRIGGER logomovimiento ON public.cabecera_movimientos;
       public          postgres    false    255    293            �           2620    64343     activos registrar_cambio_activos    TRIGGER     �   CREATE TRIGGER registrar_cambio_activos AFTER INSERT OR DELETE OR UPDATE ON public.activos FOR EACH ROW EXECUTE FUNCTION public.registrar_cambios();
 9   DROP TRIGGER registrar_cambio_activos ON public.activos;
       public          postgres    false    253    296            �           2620    48059    sedes trg_log_sedes    TRIGGER     �   CREATE TRIGGER trg_log_sedes AFTER INSERT OR DELETE OR UPDATE ON public.sedes FOR EACH ROW EXECUTE FUNCTION public.registrar_log_sedes();
 ,   DROP TRIGGER trg_log_sedes ON public.sedes;
       public          postgres    false    249    295            �           2606    43755 "   activos activos_id_cliente_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.activos
    ADD CONSTRAINT activos_id_cliente_foreign FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente);
 L   ALTER TABLE ONLY public.activos DROP CONSTRAINT activos_id_cliente_foreign;
       public          postgres    false    241    253    3693            �           2606    43725 !   activos activos_id_equipo_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.activos
    ADD CONSTRAINT activos_id_equipo_foreign FOREIGN KEY (id_equipo) REFERENCES public.equipos(id_equipo);
 K   ALTER TABLE ONLY public.activos DROP CONSTRAINT activos_id_equipo_foreign;
       public          postgres    false    253    3687    235            �           2606    43745 !   activos activos_id_estado_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.activos
    ADD CONSTRAINT activos_id_estado_foreign FOREIGN KEY (id_estado) REFERENCES public.estados(id_estado);
 K   ALTER TABLE ONLY public.activos DROP CONSTRAINT activos_id_estado_foreign;
       public          postgres    false    3683    231    253            �           2606    43730     activos activos_id_marca_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.activos
    ADD CONSTRAINT activos_id_marca_foreign FOREIGN KEY (id_marca) REFERENCES public.marcas(id_marca);
 J   ALTER TABLE ONLY public.activos DROP CONSTRAINT activos_id_marca_foreign;
       public          postgres    false    233    3685    253            �           2606    43735 &   activos activos_id_propietario_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.activos
    ADD CONSTRAINT activos_id_propietario_foreign FOREIGN KEY (id_propietario) REFERENCES public.propietarios(id_propietario);
 P   ALTER TABLE ONLY public.activos DROP CONSTRAINT activos_id_propietario_foreign;
       public          postgres    false    3677    225    253            �           2606    43740 $   activos activos_id_proveedor_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.activos
    ADD CONSTRAINT activos_id_proveedor_foreign FOREIGN KEY (id_proveedor) REFERENCES public.proveedores(id_proveedor);
 N   ALTER TABLE ONLY public.activos DROP CONSTRAINT activos_id_proveedor_foreign;
       public          postgres    false    227    3679    253            �           2606    43760    activos activos_id_sede_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.activos
    ADD CONSTRAINT activos_id_sede_foreign FOREIGN KEY (id_sede) REFERENCES public.sedes(id_sede);
 I   ALTER TABLE ONLY public.activos DROP CONSTRAINT activos_id_sede_foreign;
       public          postgres    false    249    253    3701            �           2606    43750 %   activos activos_id_tipoequipo_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.activos
    ADD CONSTRAINT activos_id_tipoequipo_foreign FOREIGN KEY ("id_tipoEquipo") REFERENCES public.tipo_de_equipos(id_equipo);
 O   ALTER TABLE ONLY public.activos DROP CONSTRAINT activos_id_tipoequipo_foreign;
       public          postgres    false    229    253    3681            �           2606    43765    activos activos_id_user_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.activos
    ADD CONSTRAINT activos_id_user_foreign FOREIGN KEY (id_user) REFERENCES public.users(id_user);
 I   ALTER TABLE ONLY public.activos DROP CONSTRAINT activos_id_user_foreign;
       public          postgres    false    221    3671    253            �           2606    43777 <   cabecera_movimientos cabecera_movimientos_id_cliente_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.cabecera_movimientos
    ADD CONSTRAINT cabecera_movimientos_id_cliente_foreign FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente);
 f   ALTER TABLE ONLY public.cabecera_movimientos DROP CONSTRAINT cabecera_movimientos_id_cliente_foreign;
       public          postgres    false    255    241    3693            �           2606    43782 9   cabecera_movimientos cabecera_movimientos_id_sede_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.cabecera_movimientos
    ADD CONSTRAINT cabecera_movimientos_id_sede_foreign FOREIGN KEY (id_sede) REFERENCES public.sedes(id_sede);
 c   ALTER TABLE ONLY public.cabecera_movimientos DROP CONSTRAINT cabecera_movimientos_id_sede_foreign;
       public          postgres    false    255    3701    249            �           2606    43787 @   cabecera_movimientos cabecera_movimientos_id_tmovimiento_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.cabecera_movimientos
    ADD CONSTRAINT cabecera_movimientos_id_tmovimiento_foreign FOREIGN KEY (id_tmovimiento) REFERENCES public.tipo_movimientos(id_tmovimiento);
 j   ALTER TABLE ONLY public.cabecera_movimientos DROP CONSTRAINT cabecera_movimientos_id_tmovimiento_foreign;
       public          postgres    false    255    251    3703            �           2606    43792 9   cabecera_movimientos cabecera_movimientos_id_user_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.cabecera_movimientos
    ADD CONSTRAINT cabecera_movimientos_id_user_foreign FOREIGN KEY (id_user) REFERENCES public.users(id_user);
 c   ALTER TABLE ONLY public.cabecera_movimientos DROP CONSTRAINT cabecera_movimientos_id_user_foreign;
       public          postgres    false    221    255    3671            �           2606    43687 )   ciudades ciudades_id_departamento_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.ciudades
    ADD CONSTRAINT ciudades_id_departamento_foreign FOREIGN KEY (id_departamento) REFERENCES public.departamentos(id_departamento);
 S   ALTER TABLE ONLY public.ciudades DROP CONSTRAINT ciudades_id_departamento_foreign;
       public          postgres    false    3697    247    245            �           2606    43821 9   colaborador_sedes colaborador_sede_id_colaborador_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.colaborador_sedes
    ADD CONSTRAINT colaborador_sede_id_colaborador_foreign FOREIGN KEY (id_colaborador) REFERENCES public.colaboradores(id_colaborador);
 c   ALTER TABLE ONLY public.colaborador_sedes DROP CONSTRAINT colaborador_sede_id_colaborador_foreign;
       public          postgres    false    239    259    3691            �           2606    43826 2   colaborador_sedes colaborador_sede_id_sede_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.colaborador_sedes
    ADD CONSTRAINT colaborador_sede_id_sede_foreign FOREIGN KEY (id_sede) REFERENCES public.sedes(id_sede);
 \   ALTER TABLE ONLY public.colaborador_sedes DROP CONSTRAINT colaborador_sede_id_sede_foreign;
       public          postgres    false    3701    259    249            �           2606    43649 ,   colaboradores colaboradores_id_cargo_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.colaboradores
    ADD CONSTRAINT colaboradores_id_cargo_foreign FOREIGN KEY (id_cargo) REFERENCES public.cargos(id_cargo);
 V   ALTER TABLE ONLY public.colaboradores DROP CONSTRAINT colaboradores_id_cargo_foreign;
       public          postgres    false    237    239    3689            �           2606    43668 &   contratos contratos_id_cliente_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.contratos
    ADD CONSTRAINT contratos_id_cliente_foreign FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente);
 P   ALTER TABLE ONLY public.contratos DROP CONSTRAINT contratos_id_cliente_foreign;
       public          postgres    false    241    243    3693            �           2606    64346 $   detalle_movimientos detalle_cabecera    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_movimientos
    ADD CONSTRAINT detalle_cabecera FOREIGN KEY (id_cabecera) REFERENCES public.cabecera_movimientos(id_cabecera) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 N   ALTER TABLE ONLY public.detalle_movimientos DROP CONSTRAINT detalle_cabecera;
       public          postgres    false    255    3707    257            �           2606    43804 9   detalle_movimientos detalle_movimientos_id_activo_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_movimientos
    ADD CONSTRAINT detalle_movimientos_id_activo_foreign FOREIGN KEY (id_activo) REFERENCES public.activos(id_activo);
 c   ALTER TABLE ONLY public.detalle_movimientos DROP CONSTRAINT detalle_movimientos_id_activo_foreign;
       public          postgres    false    257    3705    253            �           2606    43838    fotos fotos_id_activo_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.fotos
    ADD CONSTRAINT fotos_id_activo_foreign FOREIGN KEY (id_activo) REFERENCES public.activos(id_activo) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.fotos DROP CONSTRAINT fotos_id_activo_foreign;
       public          postgres    false    3705    253    261            �           2606    43532 A   model_has_permissions model_has_permissions_permission_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;
 k   ALTER TABLE ONLY public.model_has_permissions DROP CONSTRAINT model_has_permissions_permission_id_foreign;
       public          postgres    false    3657    215    212            �           2606    43541 /   model_has_roles model_has_roles_role_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.model_has_roles DROP CONSTRAINT model_has_roles_role_id_foreign;
       public          postgres    false    214    216    3661            �           2606    43549 ?   role_has_permissions role_has_permissions_permission_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;
 i   ALTER TABLE ONLY public.role_has_permissions DROP CONSTRAINT role_has_permissions_permission_id_foreign;
       public          postgres    false    217    212    3657            �           2606    43554 9   role_has_permissions role_has_permissions_role_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;
 c   ALTER TABLE ONLY public.role_has_permissions DROP CONSTRAINT role_has_permissions_role_id_foreign;
       public          postgres    false    3661    214    217            �           2606    43701    sedes sedes_ciudad_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.sedes
    ADD CONSTRAINT sedes_ciudad_id_foreign FOREIGN KEY (ciudad_id) REFERENCES public.ciudades(id_ciudad);
 G   ALTER TABLE ONLY public.sedes DROP CONSTRAINT sedes_ciudad_id_foreign;
       public          postgres    false    249    247    3699            �           2606    43706    sedes sedes_cliente_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.sedes
    ADD CONSTRAINT sedes_cliente_id_foreign FOREIGN KEY (cliente_id) REFERENCES public.clientes(id_cliente);
 H   ALTER TABLE ONLY public.sedes DROP CONSTRAINT sedes_cliente_id_foreign;
       public          postgres    false    241    249    3693            l   �   x�u�;�@D��S����$�"�%(Wٞ�p{
>"��ƣ�'�vv0��;TEQ�p�!�L�is?�e��c�R��ns�R�3,�!�u	! Q�qmkۂ�Y2Ϳ����Fa�:�ScqxD��C�x �p���W?�*��_)�\j5�      n   :   x�3��4�B##]C]�Լ��ĔD����ԤD�����������!61�=... ���      \   R   x�3�tJL.I-����O�Wp,N-�/�4202�54�50S02�20�22�&�eęXZ������bh�`hjebleb�M�+F��� �R�      f   A   x�3�(*MMJ,�t�O�/I�4�4202�54�50S02�20�24��*�XZ�p��qqq �e�      `   �   x�m�1�0��+��X�;b����4F��R�؉��74�Xi5;k�Z��V����L&��!�x��/�>9�y��������[�ZZ.oB��ҀNzdOxĔ�镚,�t"� [��M�O'�uv��#��F)��t1@      r   )   x�3�4�4�4202�54�5�P04�24�20�&����� ���      ^   B   x�3�L��-(��IL�44262����FFƺ�F�f
FV�VFp1CKC+cC�0W�  ��      b      x������ � �      d   2   x�3�t.�K��K�M,JN�4202�54�50S02�20�24�&����� ��      p   H   x�31�4��4��t�+)JLIT((*MMJ�4202�50�50V02�20�24�&�eb�	��@����c���� "\*�      Z   w   x�m�1�@���| ��>_.n�<�&DtH'�REJ�v����{�&ɢe`�P��[�5JW�� m�3GJ��e^�g>܋���d�����Ǻ�ޯs���qd`�g����\,2<� �R<w      V   .   x�3�t,(�/KL��4202�54�5�P04�21�26�&����� t�      t      x��{ǒ�0��Y�BE�;�D����wͯ{w�'E�餍��2Y� ��/E������u	��,]K��m�Z�	iR=2�?�!��� ��$G�<_�X��o ��)̲b9�QVu1(Er=�!Q�&I$�������'�]V�)�?�V*�2�>��l����9i��`l� ��]z��d(�yX���������Tj��3� q��D��=��L%�aE�D|nz��瞤�M�Ȟ�(��zf;1�W3��̔���97���C��� �p=�j*71����[b?/��3��a8f��q��毽��N��O-�)È
ùu�8��1�pipu�{��L����9�,�;ϸ%�s Y�xy~�1L�i��渠v�c�L�0�Xd���h��MG���a�&O����������E����Emz��<��<W����<�Zf�����4��M>���<�?6k'f�q2��'�<!{K���'���e럽��fF��-{�ȵ��vF����Q�;%����9V`F��Q�������g�u�~���g�
�09�xZ�w+|�Xn����>Y�=}#��_q�WB�(���T����0L�����C�0�È�غ'�M:L��#��h\�՜b5S�3��Sb���$�ԚY#������ْk��)?�񡼉�|l&�:*��M�gS��T��c|����i$��Ǧ"Կg�M�,|�I{N���R����̜-����Z���BE:ʺ���۩�b!�����v�'F!8YFnMe�Uu�>� ��S��I������>�%�c�x�i"8S���p��wùO�����{��zO�)΃���~9�^#��ʌ���,�c^qI�Q �X���S�ų@�����D���o(��1����y�����0�����{{�����L��y|ϐ?�퍩�������05�&o����y����!Qx���w�u����!SSo�B�	��4<��^?߫pr6��;<��1;	�Wx���߄}j�N���T�����g�Sd���j�[S���_����N�"�������Y���gm^�K���ǃݭ|��iT��J/��G��1�����G�����������%�Ւ����8-`X�����+®�9�����t�CTs�|?+��mjPÜo�	�/~k?�uh�wr���}Ĵg>F#K3�ߘy���E����"���=>�jF���h��ipS�� �<s���<6}�������y���n�I2���o=J-S3-�8?{�Z´��)3��|pw��xmp#�j���'G�_F�K�w�e���,~���K,�K�����g���e1cܥ���[�O`��������緸|�`>8���B���o
�������x��;����(Z0�?�*0�/vE����|��̹�Ie"�ur����y(+�@ڬ��(��'H���%�d��kyjc�Y�t����2��FJ�ò�7'�@�����"R�Q�%tM�<������[=�f<����󆘶%�^*����T�����1���fg���\�܂�f�������/w^��|�O�R���\��+�}|�y����Y�L�4v?��@����rU��)|X�z
�s�I���/���iiI/��fmiG�#�J���{w�θ"i�)�O�m��>3�..���+�g$,�~Qts��ܙ�;F������`
��z7��uC�-"���+X坉�� �Q������T)a!Λ���Q�q�$�f��y�$a������ L�TU��BI�)>?#����`=E��Hl�l�pm�J�!�,EJ�W��G^i���@v4  ��v��tA8=^�4���$9��>�YV@#V�@D:,Y&++[��3���%|3��>gWR({Gjf�T��(�K�|;��/�S!�tf���;��Z���k�����wv��!^��}��m@�k�E�m��Nf�-�f�?[�؟��g>������?+t}˓��O8*��ݮ8s%�Ju�`���kj_׵BV7�9d2vw#y�߫����f��;�=�|!�E��ދ���j.��X�%w�P�3eC���w�̆=�C���]E\|�{���@��#���PN*��6�X�y���j���L�\HZ�b�5f3�]]����1s���΍h6���ݍ�q���h�	E��zj���F�ؤ��p������<�}�9��������UvM�d�K�؇/��P�{����,ɫn~"ȷ��G}�A���M����
��-a����Ea;�<�;f��]�E$Qw�A��_�U�h_^�ӂ�"r�&r��A:F��$<�\����zw)��؂�\~��^�=�c��9���k pA㼐k����\BO+�4��a��A*+$��������\�58'�3�%�����2�B��6��ěW�n�76�5��3��e��:�Ξin��8j�pm�"����g�����%je��:�"���{��|�)0���,}D��ؽ�b�&��w�@oHc���:VǓxh�	�5���E�n���Nw��ע�0���^$P��ii� fv/ ��J�Z��T2|jp��°����8�jHb$��h������m�ᵿ���i�>��>�ծ5A�4��ϖy��bw�F���5
u�ޯ1fJ�:����[z8���jF�
O��&#�<Hz]��VG����HY��_�^@x+�Z��V쟘������ ��,��*;Ң��#�����#�U�D@U�7��k (�[�la.�E�)ȣ[�S�R�ۙq&R����p�؎ej�>9��J�h���K�.�dg��v4���k�ex�H������	R��Տј��}Q��>8�꽲��a)N�6�}R'���us�~ ng|4�e�-H��PPA�b���á�����H�-��8[���;�qY&��E�j�����i���A��M@hCT���g6L@[��]�/�a��"d ڝ����ϋ8Lb���G&�N�����+&?��tŎ��9�跞��g�B!���4�h� ��)��>#�����P\A��M:�C�ɩ�iǓe�ehL�u_��(��/�h��ǥ_�Y�͍n(5p��mw߉E�/��8�����;�y�iU�5���z����hH�17X�Vy�,.J_XR9	~1��-��<^���~AE0�$�13�`6	/!e�6i�`b�h-)�#�*!��rU��N����[Pħ��3��g��k�i��a8�?����A6X�a��{i�9Ƚ��f[�,.�Jz�AUiG�.�s̏�bD�.+np�/��cB��!����9;�T��2�(/�����X�>���n �N<����~�D���AX�-f����7��|/,{@�؊���ߺ|��������$�+��	���9����~����>r��d "�r�l�OGh������h�_&�����$����cP-��0�Gһዹ��O �^\�5o?�̡��B�j1�W1ۭ�/��ɂ�r r����w��jx$� ���F���A�t��~E��#z�Y`cDs4{��8�� ܲ\AS�V�Ľ{S�|E|Cu�,����\.�zp<MןƳso<��� �w���e��:2W�1��飅H�V�����k��[_����E�x�F� _ԭ�,� .����I3^�����F��ЊR���@�	n��<��sX���e��ޣp/6������/�v2#<��z�;B}�o�"	�g̪K���<�cT�r��ފH�t�H�#�8Ō�"�d5%�Q=Sz�|İ=E�j/~�_3[�JB�ű	dxT���*�;�(_ I�˽G��Z��1dh��6^�%�  �W�J���� �)Q�F`\~��2˭0v�C�A�Ye��J~G��C<���BU{��j��o���Y4����ܮ�e�M���W MVК���ݤ$�(]
.�Sӓ�ްy#��Pp��S���3�z�L
n��Ú�8C�u���=0��EH����@|�^�h����M=��Ξ]���ac6 lx��C1aP s�1}]��� ��-�    �+�����8���<���<��1�ګZ�u$>T���5QlC!X�9E�
��CĥY�����J��܋O��lVԱW]cd����%��z��Cx��Hj�}�B�	}��Z��G�y��|CY�t��o��'�F���H̲��ͺ"b��i��ѕ�b`"�f|i�l������g�h�U��t-�/	J�H%�)��_JV�46T�;H��xT��F����$�c#��K�-�C���ӇK2�뽔��'!+\�|�hP*LS�_lr�VĠ��wW7�=`�y�����U��!B�eJ�gr[+�!ׄӂ����
���*j���RRʨ�+C����A�`���̷׺�Ύ��!��QZC���7۬G·��v~3Dee�J�;��G�����PCl�x;�"��}V����e.�B�$%��Q�����E��z��p�B/8�Da���f\kP����/�NQ�B�p���Z��/���d��{}ڇp�{���+��I��x)7j別Ѱ��Vˣ�����|p����c�ۣ�OV���o;�V��y�&�U�����#N;�kf�v'�i��Plf\^A3�Q{0k_�����oHeRF3��7X���T�#�|�����*��^�f����*��m<�,{�3��c )@e@e
�/y�ۅ���N[@|���<J���
��;�����7dQI��YG�	��8�9V�a�l�S޼�ƨ��
k#22P'A�b���P���0��[K�X���>��l%ؾ�:UfER+F�qǡo�0��l��I�����&�� �5c{�rd�A�J?E	FXL��J8L5��H*t�{'/E��8�^�%��#�Vڠ[B�oϚ����Ƭ�<O]+{���v�v �IW�q�2�`	i�`���)������:�`'c�{��鳣���q£{k{od���G:p8�b��I�0�_D-�kr#�&B��s�����	�ff=`��\��v��.�a�����j�w���tk�Y@�ih
�M�R���*�rF�ɯ��u�5���hS�%�1tjW���zVA����r�3�=c�'{�7���%�ϳ&�*�mo������@��ņh�Ah�?���]<��c�W㴶g%�^>W��^�=�X	�D��O^t[���=TZ��dz8:m���Q�����h(g]�P�s[��y��^X��N�¶�cHe��3��d�ݦ@z����"�F07�l�W�5 ��#Ħصn;gF��X^� w^�!
�{M��q�C7���˜�=����\'ұ�9xUY�@1�:}?����ڼf�����S���r{z
?������e���}���ZE+�)"�麣���ϗ���7�8�%,G�:��lC��#�3���ӄ� ����n���{G0����k������(��9�*��է��f�:�k�y������N�;y�BcG�.�?͡E���8���؟��!��I��a�l���3z@(����gd,z}�H	X��AĠ�6m�����`��R�޹c�f��w��b�k�[��%d�Ǉ_p�x��0%$�=��oo���~o
�y��R��%A�2�W$����!ʏ�р�)2��.�z���o��i��M��a��t^��P��~u�e^��0Fi)5O�yjbx���s�p�Ĩ�O9�@���,�n��(��r��dd��,�.�3�#�������.�B�d.��F�h�Hy#�����e�jȜqR>X.�C.����co�*T/�.}�Q%��W�����&C��ì�>mη�~�]���wme ��۲�@Z)�2���3v�.�y�gg6�����l��6�M �it��h^��Ah���hA��]G���aBV'�7'�n��$oW��"�ҏF�O�bzW뎰tu_G�k�ɷ�V��cY��C�!�Jf�0D�H�L��c�$s��LJBJW�(��e����ҡk3�ڭ]B���ީ��M���Re�{��=�u���Qq�sD13���^�)�$���79�\�\��:=��B�g!�W��hA���N�Uj?}J���DV��-U�m�Ņ^�ԗ�^�n�Wj�D�-6 �d��A�~�t��窹��[pX�	��ےe^�̐�f�����P8o?A�x��Qκ�>νm� }��Ğ��K:	%��F��C>�#�!~0vGsz �mO�V$/)ޘa�ڄ��~�wI��Nگ���*p�=������N���ɣ��g��O��:o��2��c{�l�HʏL�x� F< �<�zm���)	A��1��r(&Ӡ��8��F<�q@�!u�.n���j� �� ��`%�xA��.:�Q���������p�/G�%��Q9��o9�f�6��[>~z?v(rDiM�QLF� ���U.w(�~�$�;ׂ��x���Qa�jA�{dU�T�-�����l�ۃ�qV�-�s�Ƞ3&i����L3LbYA+x�@0v���,R��n�2���Q��" �O|[�l���ON�_���"$�s �����N�����}��W#��5[�"���thӳ��ٌ$�:%�gYl%E�K�U���iJO��P�N��W�1���Pb0T���<1q=Q��B�۝&3����	ˆ�+��i��T��\�1�ub<=�� ⊚#7���H~S�Zo��X);k�l�ŋ��z{��or�E��[����S�Va���Ѭ�'w|	/�0>r��H��.z�|��쫧�>=��6�������5w(/��Īz���U� N��fI1�_�=�@�ٶ�@n\m��/���D�n?ň�=i8��d���v��q�� �-�G��a��e�@�QO6\~�y��!�_���Ǉ�,����/z��R� �it����ߟ�3�|��Ћ��)jmg�>)�u���X�4��}
��!w���7|Z�fX�b0N�л��͊�ރ�1�<՘�Oy����t,m�*����\�e���N�Y�MUv����z}�\���,O.�?I��a�$��}WG�$&���y�g�}#Ein�U�E�+'d���-<�t�e�qc�I=�����/�k S�?�6ٱ��]���)��!��M�z�s]��@"'����1m�gZ�( �F.��'�J|�մ�?����Eb����^t��#��e��>��M�H`��[08+'�29G3`Oz/'��*d�^�D]�(/=u���uD�j�ե}pl�xh��F�{Fp���>R��\��q¸�O�}� ,!̮<���4aH�(L���E��,~�gZ�n���L@��/��v����^�m�K���MP���ю��F���)��_HV�B��9g�L8C��t���һ��]�V�6�/���X"��x�K�}�A؊ފ{Al���ӌ�~3���YCT�b7W�W{_�z5#���z���y�<'�Kު�4��!r
�AH��ISo�e��2;�RC��YYI�a�m=���[e�J�S����>��D�.j�d����^����@��W�:,=j(�f5����7{��lƕ�20Ǔ�GZG�ΈR1k�����=,������n��IA᫙��� (̲K�@�v����/��};YA��	���~i�[2�\C["����ϸʪ ���,�����./�=����ujJ:Ϊn0����F��#�\�m���
(q�\���[�#��0S���<�赱�+/vg4�}K����pI<;���q�(����y��a���"Nl�jU���[����O�jV� -l�^���.��>�25�/�B�?mڶ��MXF������/�bk�~]�5ՠF�̑�ѰQ�<�#�G�
%�]�Դv��=�kL�-_)5�r�0�����V-)�>��=��"�Úk��}����9>8a�@F�ɸ<lu�g�]�������.tNKA�@x�$��Qx����R�^���M�$��6��_�T(���5#��Q��P3��Ki���M]�/�͌�2�?]nv���I��h~��N�8	 ���5#�S�*֬m	"�럿�X�    ��A/j�R?�bw�0�E2�'ߴnE?L�ў�N[A����%��F�a[�V��[�uґ!=C�e:>ջ��pf�#%)�tQ��e�ʲ'��E����Y-�&��=�0��������x��ܘ0��_��}�=L���LDy�)!^8��Wg��Ϊ����x�l�o�o��j�������2tӅU���Vs�9b�ŰbfW�y�������[�o?h�+��ׄ��iK������k|��C�z��:Oͮ��w�)��Z� JԹ̙�&j��J�3'Tl=%��f笐ӳ�
��Z��o{; &����i+�<����uC�؆ﰧG�����Q#��+P^��Pt���E��oH��~��Y2�*���5��;ezU��������z*�x]�NrM�E���λфA���32����0w*N�o �.����T��0uܕ�m��t�=����䠏�C+�s�^^���2:$"Y�� z%6#
]�K=_�O.>\�!�;k��;	�-��ۚj�N�3O���OM�&s��&�ɵ��>�kdtn�Ք-}��r�^i���K�8B��>3W`��e�$�IN����,���O����ngK����8��&�rm	~o�]9��k� ���~�7��;&PA���1yz��gDnf~���,�r_����=��R�̒d�e<��C� �}�xs�yu�r�ֳp(�M������Ë�e�����㋽�Uڂ���'>*���a���ΰ�-8���pf
~�8�雉����ӓ9���~�����S�O�X���߹�*HbU�g��65�`�Y�2!h�D�^�9cO'A�a��>�gL�&`rGUc54�ƻ���$Ȯ����s��e�/�W�wF<B�5ngFZ�(��������=��1F	x����%�� }=E��_�m껈 �$��H�wy����R�a��
��%ZH�|�XVY�מh���G>y9؛�[���\�[�$�G�sO�l¶�cJ�aV�Ӟ�D{�4�ͦ�b҈uo�%	�;���*���Y"�^x��1*�!A�%1{X*��ٖah3�?����r�ZvĦf��^�#�p� N?o���oX��^�+j��������Ʒ��G$�ǵB���t���Z�e��'����~�u�L�&e+fg��m?���i�̖�\��i"}|�����%LJ�UF��K��%B���"O��v��%@ZU�;���3��ͽj���ө�݇��������õ��!Y�e]� �C���2����F�J��XñC�H>Rc�}����36ߎeǞ���D��#� ���ͺ�띜=UUK��'�g�	��Q�/�g��5�i��Í�A���]�P��lp�0�f(4�[(���^ߚ����k��0#��������O��:Ȥ���:節{�6�Φ3I�
���G�yx9J:��쯜�hs�,x�8��i���c��+N��zM�(C�3�Q�6�|� a�9J��!z���$[T;��眫f,jS���q�S�vny(I�o�YC����1*n�B:	d[�D��<�uSU�u��7$'<߲�x����ẜ��쎶�+*�2� hE�p�<�§�>1v������i����em�^M��NYqm?\�X����O)d�U�oY�X�!S:�8Q5Ϲ|5�m��WpBo0虮��
?�>��d����7c��8X�ǜ�Rq�yn@g�WX�)�bˈJ�@�M�����d�ш��Oƌ7������ː�QB�!/Osu��ýJYi>��`ݶtH��=B6�T|lǽ���9S.�K�s)�'L������Op�u-f�m��l��K���D�a|/���{l�]%����pz�����u�izaF qg09�l�	�M�J�VT>�ʋ���A:1�s]ӭ��(4�R����2��uK������A-������������ߞ�Ʋ[~v����B�������I6Sܭ�@�]H=�t�^X�y������\B_������MXu����/W$�A���a=T}�����`�P���/(��M�U!h;!��&ՙF����WDUu1z����!5����&ű\j?ʁA.D�ͺ�5�?�l�x�?��?)샎$-S8lȆP����EY���EޭQ�'�
F�6écxp�̳�F��Y�H=l��9U�`���$\+���Y���ә��6� Y�],�ȋC�Gש��h�rvh�,o5�?
'D�;�Kz�Ǝ5Vj��ǑȺ�[L ca��z��#�.ed�P�Jy��[b{u8f�ຟ7vT���N��zPi魃Q]�J����-�xnؾ�懆VP§'�v�n>.�cH��s)�%��X��f�1���!�e|�3U�g=�u(����A��'LOmi�����0�ڔ�`��k�N��\����l�Zx���
�������R��O����M3/�:�
D��͢u?Z?d����J5dM��2���H�x_��a��~KH�pJ��ɳ3���$]���,�D�)[�)a�����6�>�_�ҧ����;'ޓ�lo��=7ܵ'L[Ҭ����ӊc��� $S������L�<1$g7��.��%z	S�XQЧ���(��
����ܦ8ohU���Y:�>n��]#�&��,���.Y- �%&��(�P@P�L��?��p��#��$ٙ�D�]s���y��ˤ&IW�oGK�uj�*�7�E9�����r�ωw;�i�OX���0���7����EN38���w��R��컊.��
�&�g �2��{��?��fkO^B��UO	�|����
f���IO��أ@�w�{�K1ߕ�M���l�]T����e���y�2o.��X���vI�d��Q���Yf�`����M"��cj*Q��ݑ\�F�A�kEˏ.ij��I�J���ߙ������>�n?�í���.d��S�OB����a` k�g��&/��׮f�H��G��'���0n�QX�&���߲��]�W�4l�j�8�3o���ɷ�\Rlqfb��.��<_[�$�5)R'uP�R6C����|ʀ�O�*����s5^��8�-�X�2�cx��T���iTƖ��B�1���[���X��~��0��;�;��K�����qʕ�Ak��@c�Y��{rD*���_��,�a�x;H�����Mǰ�1G�<2Ag�:�7WM�Ǫ��W�)�b75�?9�f<[���}㴲���Ds�<�x�}UיU��y���2S�||&�@�a'�Eh�J�g���	�\�Zj�T�nҴ����-���Z���e��?o�� V7��4��%;��=u����
,T�9�vu�t�A�O����Ą�Oק�:�B<`�]��̐��Tb&җ����É��5?&-ƔK��.悴���?��^��B�5�:`QM�^�~�h�Q������WY�e"����J���|C�=]�l'��7��ta%�-X� WƁ�p�b�?���1t���CѢ?�,��_q_���zG�ˡJ6~�����CY݈(�el�L5{g�ߔ ��c9$5Q��e��wcT��|�HX�x���_�,��<�ۻ� n(����q����:�Jpڃ��vk�7Y�k��yzu>��"۳��y$�����(��|䢯��ą�S�l�?_��^�kP��>����|�-6��Ss�9OS❥�}?�����.�s���S-D�}�-����6�$���Û���	G\÷�Sk׽d��v�HP�3���'�N�'�Y�&V�Yօ���k���wz�'Ӯ�;~ͪ���v�D��G�W�/��A�2��}yh1<�ԋ�ѵ��	-���`?� ��KeɊ~8�y6Z�iJh��&��^�2bX%�j��oƾ�������*]_��2=Uj�-��m%x�.����j����ߒ�a���Kv2{����p���F^y��ͶJ�e"DE~��@�CA�O�P�� .#�xxs8g�è͊k�v����x��X�ԋ^��C�'���    A۴��O.���|(o%��.?&�rAV�>��STh+�hMF��O��](�G(����v󌳫���oȢ1>NxC@�1�>��+�3'=�7w�}�5�<I���r�?-�HD5�޸N[>M/)'N���Zp^�PݯM�b�*}ǧ�+��1޷p>���{m��2�g�������>R�L���×�B�C*�$�L~;.v�ь)QC�V���-��Kg 3��@GG���x�� ��V������	>To\�C��=;���1g�טK�'���l�^�;䘈��w!-�`΢�h�R�U���7�W�~צ5�Ya� �.~��tkNAo��/-�Wñ�8q���� ��1�)�:9��_R!��emG���5��C4g��T�c��Ȃ���k"���	���|����:��f��C����BLÿ�6�87�T9E(c�.�{�j�=��~I!_��x���>�Yg�I'+ QX�l����ig?=P����0n�Ĳ�&kIA�-K.�p �Ǚq�w��;�Q�CU>�PJ��d݉�����t�E6�΋�[Ӆ����C�@4��}wQ~��$&/dK��Ϊtr�o{���1��q#:�#��	:�\b)�a�@���G����d��4�a^�R$N�m�9��J�s��}3�����>1���i&oe*";�0

Y�7ݢ�cE��D��|o��|�
8������+_c��
ѧơ	��r�$`��3N�2E7��g	'�T�q%�����EaEZaY�Gs�񾩥n��2��l�+ėSX�<y����$��؀��5h$#X�-�#?���r-q<Ч���<c�ܔ=�֤\яu0����g=ԇ.T��s�ZDc�Ҕ���M?��Ƌ��fKd)�����a�
��(��9�.��9)�ؘk-i��L!��'�PI+�!,4Urz�h�~?D=0[m�h�W���$W�������#�!V9����-j���������+�xF!bq����&X��Uj���-�F�[�kF�F%�����r�ҳd�{�D���1����w�z�%sd���:�v��9%��<�G-BG�u�^*�H�@�BZ2X�ڈ��k-Z��|�sɶmS�m������v�W��10`�fH�`��9���������W�c�P�KH�@{�,wj�7�U�O�K+Z�d���QM@�,�����y J�G��dYT��YҋUx2�	���d;֠q1{1Q��B�_7~������J�Ė��q��\\����W�5�	!�v�Q��#~Eţ�%o/��M��0����E���v�����y�k#�|�K�$Y�&/���͓%SF��E��E�����&('`:{`�yUg�w���u���:�D��v�3��0iԚs�w�jOJ,���U��۬���� ?�uR�R[��)��]��t:E3��r� .�V�+ˑ��[3�3�������e��0��4��y��ccU��RR�S(IZ��z˿����n�g�3�D�µ�j�!=i����Hm���M�R���e���;�$�^��A�Ax* �ģ.~�~��[��	�M���o]�-�n��ξǈ�����&-���5�6AZ�6"w3���#/!=DDJw\]�*���f���{��k��Rϔ�8ɤ�u �X)���i�c-��5���$O�Aίz�H�8?ZQ!,�Pr��ҩ�E�H�XI���a�l�x���Ԫ������k�X�e�l��yd�I8��_�b)��@*�b]H��I�"%POb����/�;<SG*�cZ،��R#{Iʗ����^�|����W��&C��
ˡ�G#e�}�6��Q�Dl/��Cx�rGuM��n.b��]g�A��)��0�]��J�g��Ύ��ҦK����w��w��/A<�p��r�;���*Z2��2�_��������?cB��1}b����G�N�3� �$Qa�hOX��C�R�����υ�RS ¤�&휆��݅8`c&�K��h�e�?_3)�ט�s�S.�膊Z&������0Qu���ѧ���d}�kh�HW�3��(�ץ��D����^=�w���j��Hs���h����#���4S,��@ {�֤"w�DRM�"���{�>.mTz��D�pA�C�d���-���^`����x��h��~�e��+�8F���>;t�t�廾E�=K}�i�FK�����]Ϸ�)���X��� 0����xF�X�
��֗��b2��&.�Vd�s�k����@�����U,h��Ǡ	c>�nk�>)�A��{�[�@����#ޯ������RN�8�)��?�����JAJ��4��	E�}�ư�s~�p��r�UI�ǁ�d���2~N�7o��6��b>a\5&z�����*�8CܕX���a��>>E��,�e6�3�f�,3g}N��T��}�|K����$	��O���􏣣.Ii$C鵰<\6�Wʾ]J~����Ǜ5���(�w������:$G	>_kl�J
l�|��&x?�f`E�=^���z�#3��}�g�E�H��Ю�&�kc-��Ɛ��ƒ��IU|�{�J�]�ˤ���L0�6C��8l�XoQ�J�m��l�e��t:�ʦ"�UMN��Ճ�@}N�*\�e�s���l�`�^���� Ɯa�%��~#B�*$��{ך��/���]�垀����t<Т�mB�Qշ�Q�K,_f�����ɽ�<U���`�B�H�4Ey�46��!��m$�e����Գ@&k�?٪����(�۽��Z���I��?X���x��q<�����)mS���w�E�>�F5���_��mYU�xӺ����u�1֦9S:�.n�����Te	k�|Q�D��)e��xD?PF87��CJ����=�7F�ʨ��t_��ؗ�жɛb����H����ݿ���w�}���G�x��>�޽��'k���ўT+ܩ!ע�C׃�1?���>�b�x	�K�25�l�����)��w��O6����]Ç��:�R�xg!�L�0ys���]7��%����i��P����r!:��a<4���zUֳ6�!�P)��ٺ���2��JU�2��
�uHY�Ϟ��:D�]%�Ȕ���OS>rëwm�gc��<���[!�#̸@��Wk�H�t�� v�cLZW{E<u~/t�yl��Y���Q`9�Шdv�\P5�-���쁦��v��+e�#a���$�!�fAlՇ�O�*o��g���
I�$]�Oھ��l�Q5��԰���:Z�	E��힛���	O���!A�B��#���tY�߃鯘�fVt��W�t����ocg�<	�%׃,�Y�s.蓾��G�z���$�OGv���iE邠��c�H�2Ox:O�hg`�_m�0�K�6{��>&c���H��b��"�*�7W	͆4�<gb1CJ�Z�;f��v7Y:x�oj��'���y�Ɣ�?�0,f�=�
�H3��6><h8y��Ն�.��.�{���~Е��y���X)�z���ϽA�ԗD,�G��1�K���i
Ja~�	�A�E�\���*Ku�kX�j�}�W����^hM�ǯ"elaV�Z�aiWu�d4�\����?�⓽|�9�����Q���B�������l�i���*M�U�d�X���ˏ�P��)}v3�<>��$U��1�cW2
jb�Ł4�~-s?��6��C��b��������`6��ط���^O�mOZ�ƛ�ԫ�E#�0�b�M�jDf�s��2���x���4����0��#��+�O�xX��%�A��l�4ɬ~�y��d�f�*&m�D�}_�[��;�%�3o��T:�ZU�.FB5���G��K��옔ѝ��s�W�Y1P@��m�i3[ֶS��Z�Yh{nqܮ�Q�Yjᗴ��V��~�12�m�� ��:���]K*��"/�Y<���j)혲W�[��,1��/�-��g�S'��2k2m�D=Ѹ�(
�!e� ��d���c�⚻�N��.ˉ�����]q������I���J�|S��W3g�    �֬���{]�9�$z���Bc��i��M�d*�����ۊ|)�u_[�xG3E n���-���.�'m�D�%5qj���r�@�����v�����Ӛ�^/o2O`'��\R���^g�,�Y�'�eq,�\&���vn�]�hC�R�s���1�����A� i�?��l�ܪ��`.}#3�ﶩn�f�j�:�*�U�������ա��d*��2�WIu�c���˚\sZ��q���å?��m{��pJ%*��|�L�wh�T��#}�n��W"��J@s�W��\��YV��f�S�6�+�x�V�Ï=�Hˊ�Ю.(W(�lj��k�?�h�L���R.�@�vF���֬��ݚ�Q�ku  E>���%�0��˳ϒ~����u� �Z.�Iw�c��X�ض/ȃd�XU�z5,��-��{7؏�>�]�=u��ד���%j)?�(O���|O<�H}<�"���oh�R��q���B�&[�1l������*ZY�q�lߐe䕙 �s��g�b"�5�{�jT��z��i���ɼbeԯ�����x� Zi2e�PM��j5EE�;�b��z� б�fIG *��A���s*+ذ�k�Ei�Z���G��k�2-@���`A$�{UÍ�`{q<8`7�k�"rSvlw�59���d/���z��=���M��&b����Q��mkg�H��Ѯ�p#􂡭@2��H��k�1�5����і]��N
�κǧ�G#��B�zY�$Ո6���*<V�!�ک�2�ߪg����{��[��Γvm�tPQ����@W��Y�
��o����
�PF�����&��5}�9Wp�����/��/�|��A	�T �#Јg�t'e�����T��*?;��<9D�i�#5���
wC�:���P�NgQ��pe�J?&,'Ǖ&�$�Iu�Y�3�r�]�ؾ�	��QIl�[iL�����zS>�,{�O�a����p`���R�u��iQ��׻7xG���~���A/���X(������@��Ʌ1��r��{�x�l��aq/�ʦRv��y��� �&��m@RS�a��pDo2�Ab��z|Ԯ_�"۩�o��Nzֻ���e`�"�L�0�'@�����KX��	��\�����6���2�β���-�/�"��c��C&���:L���LUHmSI>��ɾŞ����z!@O�z��ljf}��~>��O�Ѭ�8�b��cȓ �'c�Q8b@�닢z�����q;�a�ñ���)`|� -hAs���������0��y�'�c�t]���9�/{^���f+�v)�r<��
��e���%tpt��$��L��ν���_↬&�o�a!Kl3���W9@���5���B����r��֙���vB3��ҌG�����x�'�G-��> @�NR	n�G�LM�d�|�Vcz6�W;���:V-?����ef�����WZvE���!
w�.ߠQ�ŷؠ��#&�u$�/�9`�&���b�<(��ee��k�$K	G�^���#mNX��m����UKFE9���Ri��8����(���!�ֈS ��z��������n9�p��5W79���_�KF�xd�{9a�Z1�&�<��x��s\(@�����kDu�k�d����� ��5����bu�92�I��J�t��'�����g��"
A�) ;��#^��
�A~b�)�t��_���l�Q���(�I�;C(5�MW.�L.A���UPu�5�}�����M�<�282+�Ek�xbc�k@�V���"�W5�ߒ,�ʤjkK��c��H�ث.�6l����2�c�m��}����I�r��e������ ȅ�UYw��3����jL�����,�SA���{ ٰ�>nν��w�h*/T{��|��\+-l�{9R�� ��N�����R͆md�ʭĊ��b�N�T�6���w [0/����E��Q���F�&^��D�&j�!G�.��c�����Q.��(�n����>}S�ț#�#��"Z�'��@�q)Z�V��RU��:�i��HY糞r�E�U�EK�;�7�4����ե����^�|�b�pq�����/\��m ���y���K/�"�n�)V�7�1=Sf��+Ӗ��4K��$_����ov��,����ŊS��BZ3Y�}��hZ�Bq�F�@��r��>�	�N���ܵo"��)�:����(�|���Bاۮ�:���ÑL�����ͮ`-D�b��:��k�����.�9������Y�^�@DfҨ ��W�'���M���������*�[����fv~^��$��['�����er\���Z��z�ZN��h�G?��3M��QS�	4$����S���1}�mj��Q�Wf�e�O�.i�I�s1ͺ׽�1^�y!l9��=p"|�����|_6�.�]����}>���oD�xC��Q� �=��|9�xU:¾F�,"0G��$M��VW�D��}6�j�+��P�L�CϤ8�z/s^+������(��j5u�I̘��'��qLs�(߿��7E}�#I�}�_���W����sa�"�-/��AP�����r�����J&���ZG*� �Y٧Ԡ�]'_wM5�W�a�VE�L(�L��x�I�$�q�6�@��c���>Z�7�PԾ��~��+�d]x�9�:�����jM;��:��<� \:�괛��LLC�b �k[�u���3կ��L�ѥ[40QZ�9p/�j�n��2����>g�Q�1�\�*Q��|�=�Ɉ�YhҀx�kz�>�}/�}R^N.W3p��?1_׶�Uo���,���|�����7*1z1�ŶOH>]���IT�ti�!ȧ�m��w�T=�<�l��_I)�2&<Ï2��*|��K��(��ym���+p�{�_�����)[�X��w)�p��u��>D�[;�M+����Ē&�z1�/�38�uj+?��z�{IV��A����,���bE�F���\�F����~�.�J���� ��f��׋%�A+`��?�f�;�4'��%�xi�6��B�-���!UH��k��2��q��Wɼ�*wF��*�+�2Y�htj�9ژ�C�ly(-��:v6�F�
Rbr*�'1��뗆��^���V�B�X`��$ا�'�yoh����}X�>S��o��j��G�m��B�kYJ��5 a;��v������OD�<�ɲ�8Ac�f�{nd���K�?��?2::�M���m������u����3�b���#7����$0l���b$J�p�{�qe�e�P2=�~>zs7���>��`�p��l��6/E�%������j!�i�5���6�H%�O<�g]����������w���lv4�UT*��#�9ߔ䏒9��HG5 e�g��0#M�r�y!<�U��%�k��hi	S�q�n�:Idկ�g~�Ht�J��ϱ���~>�'�RS�]���d�$���_X�UOV_��)QUK�)o���5DS*�ߞ a���	�x����Є_��J�~�tu˓T�+�J����E���Gc�4^"y��CG�(  ���v��lY+pK�|�.�Ƥ���S� W��a�D�����=\s�˼T�*/�ᓇS�և/�<�ԩ�D��ښ� �}3F��l��QB�+Fgh0*�g���Ș�f�{��5��a�kw������ FǇW۟�YF����vH��.0Cme����ԺHdB.��wD0�!�}z?��#
h^I}|3QJ����U=��}R	@�ͷ{T�|/٧e@T���Sf�'�n�S��s�]��(�o�}�>*F�(d�3������_�����B��	�=�f�Z����#�����|�kÒ��'�mż������w�� ��誻l��w��H��,�\鐔b�}E����OV��x�:~��QJ��_����4d��e{�2�k��F�r&��%E�#�ꢁ�գ�6vL���'I�IA�&I�x�.K�q�� 40T|���MXa?]�z��8����TuL�_�X��ſ�"!"��9i����)�־}�c@�PYT��5Qo���>��    ��ML���uk��X�jS�3�J��_�N�ӨK��<�pK�潩 f1���'�wwR&���+�g��w�4*��W D/ǰ����}�k�޼�eS�� L�d���"aD���)���W�K��m�ؙ/�L��ܩ�?��[ݢ+�1��nƚ���{�T;7�5/���@^�0Y�V�=o�Aqj��~���5:������b��wUذ�B�0��c���F7yη�_N�����_�(,:��9
�0���Q�k��Ϧ�]�Je#��^�L0BPZ��gw��=���Y�Y��Q�Kf_�M��|���S8~���ѣcD��=:N��i��[��\j��S���hwIc�5�g�t�
s8-����rɐ�o���k�|�!|�H��o%�LS3˷�i.�	�+�"�7-�@��3�d���r�>�����?H�����)���.��3�F�먓����u���S_�H���on���*��{<.ZPߏ7��Sim�o���(�ӿ.��]:S�
r��#,�n���f��k�HR��,KT����������͠)Z]�\ᖧ);�9���*��3�aj��ƔR�ғ�,Є+o�'j�	���@@ b�w5;s[�p�T"��R��s<�|�R�c�M
�"�}�%�Jtߺ�b;WH}UM:;5����|��,���>���q���|eR���Tr�p�Տ/���h<�������@��t� �W~5P@J��&���\�B�S�>��I�d|+L�^�2x�iʾ�d-
��l+�ҵ�&�`���D���{���u�
����A3�����	���i�w6#z��QuЃ�lz	o�Lu>Fd���(�J!�0��i��w�m�F��?��~aT?`�w�;�bF�S�����fà�mc��˶p����]ew��p�*w��ڬQq~�1�/�����x�M�f �ZH���V�0�G'�#��|$�EV�a
�n�!��ת$^;�r\����c�����A�n���#�/��`�R�|�%Y�U�'#r�.��o�o)+-ןZޛ�TԚTD�YI�����c�D��=�6��J9��k�g�ly�/���Ʀ��G����,A��͏�w*w����R{Q�)[4'J��I��U$w����`�����puX��[���\>%�B����+~Moi�M�_�(���瓳���S��Y��7���?��Kw=�1�"¬;}��0���A���O��.�d>��X�V�}ֲH�i��$��}�B)�I#gL�C�)1|p`��.'�!b�`�GE���ޅf$_{?{`#̙���G�'����Z�0H{��}6׆�1G ��Vfۦ9���+�0�U���y��V�@r���]"R�Ư����i���q�%SRP���V�/�c7���`�d�[Ds�L����n?���d��Dm֫���: �c'���7���kת�5��gL�c�@�5%l�i�a�8�4(���c ~	�c��T���}�_r�1��%G)fr��fy��S�f��<�gF���A��	��Ad��3�P����~��Qi׆��b������t���f����`�]��
̉�Lt{
R@�>n=&�B��+�Bd�~��c�T^- ��c��Q����K�zg12Mԛ��¸Z'��O����@�>��Y���ʹ`�aӟ"V����'����[�9���X:�f�+��?K�
��dX��v�s��c%��}��FP��,F.��y��P�̴�t�2��p�<ʧ�s̯GV��hs{�+��K��HE�yVS��ml��	b�p�iJ_��ig���ҋ����e��c��W��Xi[^�E��?�� $Y���ތ`2���(��L�ʳ��b^�b�k��>?xP�G�.�v{�vب���^��q%M�)��o9¦-	��e\%�#4�
�͗J��.�P]����ضE�Ǌfg���as�t/G��({S�J{u��l!�v
���53I62����C�)�����b!�d}z����1�?�ZV]��_�y]�/�&r�[��[L���[�-ȿ<ā�T��}[��9�)�r�(%�Y�CL�f��6i��[h�m��ȴ��;�4V�ٸb��j�tx�5����'L�js6�ҏ~�RFٯ=�?��ՠ<Ƚ��楚0x�al�ɽ9�zp���Y��,�z��
�e��dv]p�`F�I�g{�/B��2�IҼW��ZX��>~� +tJg�ٞ܀ �+Fz�v��<��sةK �Z5���M3��L�|zERG���X�ɋmD+�P��9̗V�H���j���Q!�w�\��P�@ݕz-c�/K3�8�"KR'��`K�}M���0�w��i�P��3U��t^߻A,���,�������h�xS8-���,M\�,@�q�z�u^|���?���J�K�W�8MhN�Cf/�I�̅�>.n�I�>J}��]F+� � ��m�Tߟ,G�0s �i�%�Tq$\�1�<5+ϵ�C��R��S��2�U�� �F7���=��p$:��U{�qrŞ�-�.C��w䉌,F�N4�@�n~�y��-$KJ>~G�� ����l�/�<7��!���e���(�R��@�ᢥ|��6�D�Q�&�SbA.�{t;'�.��jڑR����Gg]��k���1��oMz�+M�d��OV����w�@���4�J��)��3�f�2�ʶ��Î�;�z6�yD�0
7�oK彗"�2����(W�R��Z��Z
Ѿ��5� ��)��f�w�D.$T��Dr[�LS��aqT|Q���tk�o[��+�v5�S�_��3�8�_��뫾`�&u���+�$fojA�Q,��D�W>���-א������3�T%w1_��k�}G�n����w�4�֟���;��cPn t�4�"є�3V��H,u�f�MO%�;����q�M#�iex���Ou|^�P��-%�RJ5��(L�O�E�δJ�O�(˹C��^I�59i�|�;��������=�vj� �g)��6��6�T�w��(wU^��;��=1S'��9�,Ơ}�������~�1��v_��#t�2�ݚ������rhҍ�r������%��Y��ET��$T!�(��?εhhE�(�_�}r���ez�D?��[§��3Nw����ޮt�̘�d�"��ZQ��X%��@���A�����G�p�}�$.	����� �"���3hOZ��l���cz��)�/,��t���Wz�����F��J�vba2�6��A�6n_�D2>N	��g��"Ra�_����H���r�**�|a���6�Tr�(������H�%�8�|�w����VM?��c���Fnh+D��{�h� ؂��0+{d[-SHu��!�F1J�5�M�{먴���HR5���T��v/h���LGJS?;�/�<�3�6������K�.�>��'5X�}�U�.��<�` m�؀��G��݀@�
P��G�]�ChY�,��C�Q*�y��Jӎ�z/)/�����/�]��YK��.�9�jʼp�ǟ⎿������B���<*�䘱��!<3���j��.�u)$Sw�Q�����hE�&A�'Ճ)��Ly_�  �
$��Y�Q.�<`�!'w�DP,y�������0��*@�)K���A<?(���a�Ӏ�S>!g�k���	�d�Q��M���{eڄq���!Q0d�n�uV���ƥ(h�=~���ً�$��at�FK��*�"?�;���а�\�"{�Ug1|��CqA���dh���~ M|{�I�N5���T2�E�d5��ll�mL�l�����2>���|)�����d�d���k>5���Q���W%A���ɚT�}U�G(��5�,���dB����V�V��������\VK��cx ��Tߞi�9�:���1蓥,��KR��~�,��_�W?��߯wD���j�q�[�zp_
D�Tȏ�=�c�ڭֿ�7[�i�j���>W�7=䔀�m��Ǵ=��k-�:�9�W�'y�l-���Ϲ)��']Q��qu B�ɇ@�y>���O6ɏ�\�%Q�lq�k��џ�]���c6    f�#~����!�;�ψG���/N����(ó陂���ǿsA�ʃ���"���RM=w/5�_P=f�6�M�g����{k��".&6@��!��BQ� "^�~�/娚�b�\�3��@ziV����Ei�	@���7��'�:��v&Ztz�������9��=)��ɴo?��\HUZ��;�M�O X�	��Ӛ�bz{�y_/h�F��M�K�xM��<�Ч�Z�F)L�)�3b��!��ʸs�/1�A�Yw�S|)��_����!I��)��0��^�|�}�e�x�@���u�̕\����y�r��w�o�~�GE��_S2v!3Y��|_��#�%����Icv
��fp�-�M"�~�)����^��2��W���h��=���h2@�����/ӗL�k��e��<*�����g\��NIs�}2�i�<;�Q֔��0[�D��:���OS\�q?R��zi�}J�W�@}�Ş��]v�
��������~�-33�ك�cI���ˢ3��۾˺���'�)ؾ�Lx��2�ƻ&�/GԀP��J�a�����p^y�Z�ϒ�-\���2c-}@Y?��AK�+���iNW6g80��9���n{�YDP1'j�&'����ĳ���ю���8Yz���n�0H�.������0�!��m��Y(#�}	���A�^���q���o_���҉7�	z��`;�QJf��/B�7��I
�u�$�ɶ��K!\�� >I��m݈7栢GQ@iI
O�I
���0��z�
�Vjq�$?�'F�>���sG�h)�hND�Գ~�a{�R1=	L���g��U�G�Tp�ͼw� �Xr$��}�\xI���'Oue�>T�1:�*�R����k�ʓn�#S2�à }Ć*����g���U��#I�ll?�{&�gzB�X�=�0�Ea�(T+.�w�r\�p�C9!�J�@���v!0F��/�72�3-����)��	@4o)]���I����x'oWV�T�@|��0mi���U:�V��6�����(��d/�~���U��>Z�'v�˟���X����׋����Q���K-��<�B&A�a���$hȱ�A�i�(!%�s��K�?�U�rS��H�-'%@���S#1Z�~x�{�����7��M9P;KY�^n�)-�fz)����D�T`��{<%s��FC��2?����iDi֭E���m�/
�������S�V��8��?�o�*Fj籢��
���5��h���D#:R�O���7}�)㿐H�Oz�����1�-u����� �~Y�\�<>��3�Ç"�s�Ck^��Ĺu��V�]��ϳoOz�-o����NE�/�Z@�E1J[A�e��	o��Z���>P�E71�d�����2M���ѻ�1<M��i��Z�q�XL�X|����1��j�_�bO
hX��9Y�x0UNn�J��o�KBm/�)�e��/|�7�2#����R�>�P�a�gBb6�}�ܳbG��2ӌ�X�ۍZ��s��b-�nX���w�K�4�1Wӕ�����}0���3ƿ�4[)[T,h��CYŁ�ڐ��O�����~l����п�,�!3v�hh3�-Zd��r>�ru�� � )��|f�_P�_��qW>�����N�?�����~�	��FS�@e2��i��B�%�*Sn�h�SDq��q���c�_Q{�?��++J���`ؑg�h�S����ԠB��g�
�}�h�c9� FѮ�S%_�F�r[�sR�?��O�6%ڵ�f^������l��$c^�_����N���8��	%���}y������0͏0a��=��
<��M�ai�.�Iz�v��I�/��\¦8AT���Y(�N�%�'��-d����L���N��s�<#�x�7w#g8�_���?��V$g�J3��>#*(gf�^��M���0��|<��v	>��}�?����{Fz�%H2�4+	� �.-�Qj$(����j�� (	#�e{1�����~"���]���F�>B�������PU4k��V�$�����y\�].��ߛ wZ�tv��gG�8|Xe���.��4'�ң��o+��Q�K.�b�f�Ɉ)��R(S�3a�����\i�{��k�b��+ݽ�5TF�u���"h&�j"��Hm�`|i2��g�L�O�2J�⦒�HT?��!��=ø�������G��t�(��,��.�55���{�"{��d���K���|�"���������<�L��fJd3$���+xИ��GПL�x��+�gr�D2;�������E�3g)�߼ۮ��+�'T>�Q�u���bؒÉb��uT�m7��l'�|4��?����`Ǔ�,�N�:(���s�9�Hd�f���j��F�e1���(ڥ�ؗ��ůN����H$��x�7�Co�aHC��u��`8��c���[�_��8�6Z(���Ǚ���#Rq�}|�*Rć�4����|���H�~Վx� ���j����u}�����?8��m<��}F��]���3hK�M��*D��`�0$g09��9'�o�v����	RU�}�(۱�c�����	u����m��+n�ƀH���1X-7�U��d�6,��D�Rۑ��ŉt�:@-KX�6~OjTU�1i6$��6Ճ�M����1�{�!(�';��;�30�A�a�N���R�]�Oz�c��}!����>z���zЛ5��` ��?y�Â:U� �6�>��
pлaZ�=QΑ�$<w����awf�0�8�,(�EA�3ރ���ڑ�!�6x���j�71-������c���q�B�5�uM��*H+��T-��ϥ[��lY�9��q,E`���[��qE�{*��t��h��V�C|&�*l��<���hz=��8L{�1���)��7�ց��TciMV=�(�!�����>{�����M@�9�p�L��N��Lg	4(��
JM�M���2@vA��XL0σ8�m&�ݓ�Uvztʴ|�mAۙKi{e�r�b�K�8[)���[0������G�wPZ�"ֳ�����W��4��m�L
�\[�yZK{0�>0(��Xk�[<L����(��8j@�T������0�+$���g���&�CtM����I���u�_,�e1��(��P���
'�/�_�S�H��c�2-O~����N2�&zdX0ǎ.͇}L�嚞��)ӿb^�j�����8��A�+�����������r�3�W!5^�d�,�-�6:��.�ٴA����s	'�pFڎ�l-�>C��Ix/2�Df ��Ű�=~y�e�T��֖���Ȗjӗfe��Q��K%*od�f�I7��pi{h�t}������_2$�ò"�Uc�N*l��ahYu�֟��ߎڬ����!N�[����&�*v���0됀!��VIf����O�{��=֡��:�r��W�M1�]����R�wn��!�C��T\�Q^Z���A~?|;R��5��ɢ�I���:j����ܑޚ�<`U���
�_t�*nj�a�aߜO�b��!,KwD���2�%�懣>�P~OLqz��̤�b��kJ�0���~D�Tw~+�_�g��/�`�\U��� ��I��p������& .o@Q_h\�	���������B������!�>s�7�daD��"+�ޱ?ю+7HSD�̑)����D��ghU�-��z�iT�b���F5�_i&�ˏkn�����z]p�|wZJ�=���	�%�:c6<	2݅|��V�#
��fl	����$p�`�\�z�Gft1t�t��tA'��ߣK0���[��|�m��ٳϕ[S+/�f��7T��,|=mQ����Ԯz��3�&=_�1͢4�w� ;!�k#OW+��<�Ptų��<w���G�<O��}�kk2���2�j0s��F ����P���_q�>�;[D��qƨ�e�>RP���מBw�����&�jр��F`H_�_mdhw&��b��m�m�_\    ���a�����S��KWUi�y�W�Q��Hm�J��FT�{���`a4*{8��$u��;��^�e;�����?_=�jQ�����c�d���*-��d��\�	�R�������lN*b��o��CmU.���P�֐�@��;�͗��rM�=��r�Y4�}�R^��(k�#�����
z�8�X�%�jBk�v�}v����<�}�
7���T��5-X�.���iF�s؞1��m�9��1��L��.`T��� _12L=����ٞ�����<̧9����{FF��(��Z+������kY>���:̡!}�H�\7�RR��&|<zN�Y3I<&ߑ���;̣Xi���jhD|��4o�ۯ�2u}�k��Eو���(�2��b�@��a��mlKƪ#���X*�6l@i��Z��QV�z(�k�Ќ*=EB����*���j��zk4BG��������ڔ���b5��0�����z��:⨢A!սvU-_O;��y����mq
?h~k�_�k��䙶�DL��4�G��D<�W�?�k�6�7���EDe�V�)�^C����ߕI{������,
HE?����l���.ɊFwf��k,�:2J�^#�����6�I�����>D��A��3��}�;v=���%���d�ՁTh��f��+�
B��Ӡ���d}�`���"r��N�J�$ڦ��]{�v�־���#c���(�����<=17��@�D<#ɩ��B�H������vD/��(54��.޿�*��{���g�m
1?.c��;�n�Pݫ���3�F���'A�j�=R��t۩����T踤��ц瓀�H���ap}������?£]��^EAY�E9��/^��FՋ��;�G����PɃ;S|Jq����#���Hm��6�=�����4�\1�=ԁ�5�[��������K��t���Up�Ͱ���K�<���U�u*����y���os��8c����("�,z���A��&�S
�����]1KwD�F>��fV|�L�2N]8���Q�~	��1hNb�u�,��g�����k�c�E]Kt���|�����rQ͆؎�ꔘW��=;Jc�=�]O�X�����_���N�e���DZ̆wD�m�^�w��š�LG.סjSN�G^�r�Q���(NN#9����z5}Ո!҇Oʏj�1���[\g���c�tc�ɾ��]�w�դ�ٽ�ف쮋�d_�Z��=9�q���ϭ4����ſ���F^��؇��N7f!B���߀�vQ�ę��9@���=�T�5tL��O�v������s��8q%7�H��g�Q�Y�����?9�E��oh�����=#wG���t�	`�3�<�>_��	�dQ���U!4�'+!_(����,��w���-�j�ȯ����P�v�z|w1؟y�/�P�J$�F�l��.������_��u��/��p�q�}��G�
�v��5*�m�P��&�o��Xߢ�e�tKw�!7��)�v;�6f�{�߭H-��{��mT�9Ֆ�Ը򉭛$�z)	���S(�����YVФC��q��&�Ϣ�������1�l���� �Rq����������	uj[��Ss��A�z�cI"q�<��<��mv���_�n���y
���݅ECܓ5G��(�P��_�����P$�)�ci���w�r��^�
~���x�t�UUe�jq]UOI��@�Z}�a,s�QY��0�|BI��m�����1�`錕6��2߸��]uz��l6�d��%Ћ���HL��k��m{�8[b
����K�OfzbH�[��?\�p䪷.0h��E!�&!�=�҅������7����^j������_��ٲ �����}5ӤW��Ʒ�Vp$2^ [XU,�k�D�I���DR*��<����g��n&�s���ܭ����9�w �c��Ns2ȨD��)�os.G��7�+�ד&I��|P�30�.�'V��l4[΋�1}]jY���ŊZ�w_Iz��,C��B�	'��i8�:��׻qUZ��ߋ#����ԗG=�÷�O��>�������M[��~�F��~M��SЍ˜�ʇ��ou~���a��i�R�G���_� ���#|���3�
�?Ge��v��gS�j�nt������#B���U��mu�=ȥ�N*L��IE�����,@�Xۏ,���������%�97�HQ�|v�csa��t�������d�K c��&��C�~��A�������}c��.���&!���^�y�#�q(i�����&U���k�F\mF��^�ԡ�YO�?��ɚ�4���̑SI�>2�Y�j1p����a߂>��f�L܉�޴��a�;�'�������Nf��d��^��&u��:�a&k���~�$
�W�Uc�~}VU�Uc��V�Q#��j�r��C���ܘ*���{�0��`�����>섺��:zK��c�B���;�kQF�����ԿUG�wƷ[�Ф[Ԁ��G6n��'�)�j�K���G�\naV_0C�	�L��˱�GȆ>�_����*$J�:ۿ^t�"�l-ܐdlՓ�z�|Z�"�Ԓ:�L�Z��2� 	c����+���i�:�vY��9�C���N���{=	_f��L�[�p��"���F�%��Sq�Z'i���@c^c�_w]V�5ti��丶��*M�*�}Xg��]��Qy��Q(6�7��壣��(�H�
��vk&�{�BI��v�+�������0��J�
4��ElfEJ>c#.�c��S�c�f���ϸ�&�����Ɯ(Vΰ��7��]ʿ��W��F�b������9�j�:lI
�Z��+P(�����Z&m*ˉ�-�Ӛ]�AP7K��I�~�7��rh�7<�1JF��,�j���k�~���Wu��	P�қ�4��������͍���h	��Dc��J�>mE����oO�lc&���&��ׄ'�q$�ǀv3�����͉�L/��Hw�����
�T�����vtgَ��^�W��%�#xe��pV3n�)���L�f:����o��G�ڹ>�v�D�P��%��@����G(�]���~S5�}�X+sZ�{�c����P^Z�+ҿF�"�
��o\���R�q����Pq���,iX�H!���|/^��^"��2�S�㫿Q�g2�?t(?=�$D����i�B"aG������K����ս�{�kC��d�u�v�=J9H����cwcXg.�#�%إs�.%��N�V�(΃t��Mp��@ o�"&f���[��A�H��fb%���n��r��h0G�ކǲ�v��p�D)�ۙT�߭<�?sq��
��e�l���b�*��J�+�t���Y�jg�m0+ޯ/H�^`�Y��э�?H4O��0�	�Ɉ݃��qdT�i�;��d�\�_OZ��9��Of[���2��Jl�T�8U˹�.��{����u�S5M�Ⱥk��4l�`���~２�W#k��W+������A�'�e^�����n"�(G^�d�G��%q�k�Su��񎶕��K��t8U��ٴ��xV%{��W_p@C	��6Nhy�GW�ʩ&W]�5��ǹ�̨�l�:�`�x����O�k��9b+���q����EP�k܏D����E$]uE_�}gB�����`�xs����PMZ���~������i6�n����~�z���	�G�����x�j0?�7�hV��B�=���(_ߧ�R�V����[��� 
���Y ���$���=+�w�'FuORR�O�s~d�i��Uju 1�|x�M��[Kn(���ޟ�f��)�x̭�b~��_	�=?�@Z��<ߌ�|6���7z�N�x]�r�b≟���ѷ?\I���O���_w�/��Z�*0U�/c2X��M<��26oχ+��F�n�w�t�/=��R2��݈L�1� "=_-�㼺i�����c(514�����M'JC��:
�VޙH"2-�<fkhA����s���Y���,�]�(5�q��CgqLg�����K���c���9X�:�    c� ���9�πH+|R�^a:�����<Ak��<�������L�������Az�� ٧��u��4p	|�[��wJ�xIa*���O��T�]�,��xj�I/o��n5S7�#%Eew^@��1�1�|(ơ���)��]�,Sј*l�oʵm~���� 	�X�G���*�����y��/�e�!�����ij����Z�v���Ty�bS�+�9�岋T��cֵ��R�S��z:q�w�������ӑ��*6bg��}]Ɨ{B�Sf'�5�HO-�Y{{���K��RO���|�L1��:?�����Z�m���e�e1�S��pD]�f`�;�[��\��S�({��^�_���}��F�8��[h���+�kQ�^F�=	�2M��f�U$^iF1��o���5}X��U�����غ�I��p��!��b�#`h�f�綀q"��x�B8_��N�k#
Z�q���~$����Ei��)���hn[�i�9��<����#���;;fML촣 ��M��o��U�]9i�|�+3ή��F�ƪn������`����ϨFQ��Cb��p���e��.�<�˾�M��w����6����9L�n���+�����?�h��o����Uqg��R��2���?�����뉞9�B
��������<
�z��/2c%��om'cǛ�+f�akb�Y�@x�/����bu�n\1�o���Q��q/̧J{�ZV��ƽ�H<�	�c��x�{����~����Ֆ+}��h� �gM){v��y۬�"H�(�3zÇ��Շ�U�<�}����|�-��7�m\��K�����7�����zAXnh���'i�Zb=2ܺg��N��(đ7U�_7��zw����9;��DowjxX� ��g�_����W�l�Bv((
FGx��"��k��ڦ�Ӱ���{��NX2^D)W��g�694x��:��[�bܸ�k#�x5�]�5ŕ��^`f�揿��%i<�Zl��Y��V�?I��
�\�,YZF�-�M������I�����"G_��i����d������f�����-�R�VBns�
3 ��>����_��f<��>y�~�!�A�M�a�z�4m R)��i�K���j_����@��ѺatU��ѩv[3�T?�U�O`��~�ࢫ�9;�x}B�t���jw	A"g�ʹ~5(������+���ꖶ9D�q�=3�6E>���C�g��F)�ńӃ�Fb΂����g  �U��G3��Cz����b��|E�-7Nxo�k��Lqpѕ��ac��7������f���N:��5�'�����_��	��� ��s~Q^��͙�����ƭ�f�'���z�=�}L������QJ e���Fp0U���������<0�?~-C��p��f�B��,`��l�U�5�Ξ����9��O�r����!�kW �6�R����IfSjd&�9�7��&"툷�j���ܐO���؊j�W�J�'�Վ���U���Z���s��ژBK�(ބy�kA�q�X,»{�����4n��{���Ԍ!�	���p0�D�"����jb��$Y5g�5>oUPGv��Y��$�)V�E�-��X,9�L����D����Uw.�y!֜6�&�/��ȧ}u��V��s|YR�f�HƓ��kW%i��K����l�N��S��W��p�$��f�!?CA�m�C�EP�2L�3?���z��r�����{����a9]ج�:����4y�vҥ��󉼋 �|~�_�w��"���R�_����=��Jñ��{���U�zە�.4�F���}/�~����t7��y�b�sH���׸ZUa��D���1b��z	�i�71��w�����@��T�ŚZL�����?��j�֞/�wv6�ɳ�{G9��D���I�.�����4�S�F����0�f�Э޶��'7����MW�}�@���OꄚC������!?>`�39�Ɇ���M.{YvdI8ԛя�ܗ�yP�<�p�dK���ʜ�����i�T��ʰ��|0��e�dP'I� X�F��8_�fj���������&��e�2^C	`}\��m6(�DgR��|t72;jH�E�if�5K���;�$P��lczb '���L|O=���dO�l�?�H:Uu���_�B��������Aq�;G��T1*�)����:�3bz0�Y�%��b�l̗}G'�Fe���g��d��p�*w�F�����R7��d��?���p�������T�L	BdV��ԉ����L�ˍ"q��:�C�;%-Y�fa��f Z��2�wӖ\�#��+�;O�Dw��WBs��\��耝[�h|x\Ϲ�\l������XHdb�-�3����<Oj�2�M�����T���z\��ExV3���A����nx6M�_� ��=����:Xͅ����7����8H��v�f�����Cl����$`�B���O����5Vh,W�v�i�-��@N���� �듳��^9�r<�Zl�����h/��Kz6�&�B�n��4n�޹�x�;9�E�o�J]�q������?i�}�9?{Vm�ɸ|��V����ʗ*'C�~D��ū��D�ǃr)O�![��Q���{V�>fwJ��Ρ�h��M[~^��d�6ccVT5�?Vo��ɜߴM1��z`ci��k�}Y�.E�ᥙҺ#�GNM�6=7�4�ܽ���CkjQ�{�eG�L��vo�S���׽)���몳:ߔ��Vz��Â�;�^�M	b#$�-�1�w��y�ͳ�@y����`~rc�#W 7ZѬ]�������GH��nv��9�Ž���}�¤'w�M1�%y��q?|�Ҳ�����?��c�. n��˞�
�V� �_�W�1��֧�����1ǚ�m0|�l=�;*��r1p���w��۹�@�'g�����bIs� (�&]��� b3ۙ(�Y��N����;�TQ�� ���svm֍�Yq� ��p|�kR�﷩�'o�m��W�T;���<t�V�n�,{�[��:����K�"���E�%-Q�c���躓D���.��h�u��4t�g$���W=S��fP�2r�����b+�z��Y�|�cgqcY�*�Z�����y��1;sp鮹��X@��8��M�d�_`D̤�]���`:9B��p!d��
7ݩd�J�h}.�.x�5��F��O���ƽ���z������ն���췌x���F�ɢy��6���hބ{o�\z��7��g����VBH�#��P�y���m1�\�z�9]GB�S�����n�g�K��!@��*|����nvWģ��VA�#��0���A�hu�NK{C�:��g�WS��f�[Ӄ�fk���Z��:��9|��\�K�w��g������o�'E����u��-�O^��9Lh�XVP�� ��E%�P�3j���v.��	�q0k͚>@s�����|[�s*�ǋ�َ�g��Ƚ}�$�SN٠���E��Pn��
���U�P�I�Z#�);�_��'��x�T�6�E�nټ�G��J��-�+^X��8�`��K�1�	��{�h�1��#@�����
<�@?G��g5?�u��t�F���B�_��������R��0�ýj�
�@^��3�Q�H�9��~���gM9��(�0!Xu{�����P�.yC��*���m������n�bk|�:�@�0Tjt>�L�?��A�f�PnE���Nuf�ޅ�d��z�jn�<F�+�E�&��"[Cb�r���eU��<30�}���[�T��M�@_��&T/{��>p ��k8Mv ���eR��y�����ׇ2iʌ��jg�"B���l~��B��jZ�5���ƢV��n��ef\*��T���x��zŪǻ��a�l`tFo<  (�3f+y�t%�|�Z�3�y��:���=�n�ܖ���Uˢ��Ǡ�Y���&�/�	��b�#�U~~��:��| '̜�zV�W˛��-�7s}P�Ϗ>�=q?�����"��g1����/4?7*8�O�H�m�!b�5) �    �^�l8ܭ��G��k��ʖ�N��n�h@�hF�MF�"=��M��V�F�)O^6�����d�N�و�X��.H
���Nve������F��HR�����~8�
̮�)�7ZB��񼀞�����{��,�`����8��2l�ś!K A$��Jg�c��]csk����SN�TB%��x�,�ad!��o��v%+��!"˦\� y�4�s��Ҳb�����	������Ӻ�j�:0�f�SA<����|��Y�k���H���c �j���+g���uzJ�!�L� ���X�cz�?ͽ���gE��%��`1���X3���D b����Vg�7�02L||@��ŀ�ʪ�K�U/�-D�HvP�4�8Hݿ>����8����7@Mӂj)p���}"XqvJ8�Yq1���?`��4�se�/0�˷зq��T��{6Ok��� �4���W�>�`�
+ܭ,ui8�f'�%�^�wTf���*�C}�U��n�o~�ǖ�򔖜��|�|_����l���D������A��A�h�k�g\m���{�~!��A��<��n�Fv�z�	� �!��[��2��̎�=�Y�>�̫C��ٙ�+Dx9��y�~x/�S��_��e��M _,�T�ǚ�։��;%|�_�j>c������g]���|�q������w3�i|�`���+i8$�+Pc����§/�,� ��!�wu��6zSW�������xf�.C7���(��0U�Wi��������K�K܂� ��p��h��w���Nq6|�ښb�o�Ţiֹ F�C[5�O��ywv
I~n>&~kN֌6�t�2D'x�Z�d� 7\��k�",������x��P�-��@l��l~,�y���K=<�&����F58���<�����u��3\���Z��Ot5�u&`n�(^Y�ӑ�S�#�)�q"�)�Hw,�2ž��w�m��V����R�E@!���}�{ۇ�]��O�H�
���(	����i�GP������n��b��Y?(������U�Hh�0i|m �ޕn5~$���Z�{��X���`����ً��b9�N[�F-��V�En��J8-��G�8���.���t+3�M�.6v�i��|�	�+6�X���T�Y�X_�X�G~������O�����[rS!ϯ6���`|�0�<kqY���o����+�ǉ��e���R[}K��}�5�p���R5B�?RA	�n�E�ۦ��E����O;b�U$��Id��*��_�i��Xy�H@�,�-����{�=5�8�
`]Wډԓny�p㋝�$�jwx�0/�=��%����K�d��$��\�bs$��K�� l�b����2�q�<���n�=�.�@�=��� ����	��9�,��&w]�-�;g��o�|��n��߶Z�]ä ~(!��
N=�����&�"J��;��B���N�D�R���n���V��Rxk�?���nyC7�
�3<	\ڋP�*�3�mB)��x�?&i���e��?0Ou���ƓkՉٷC���r����j�
�,l�H����
��5����+��f�ǅ�M���s@�����s��i��/q�^L��|�f���X���*�O��nm�d�JT\¢X^�s~KN3ө|Slfo�ù���j�����#�T���#H�&���h��ҟ"uE�ѥ:%�x�]3l.뱾�������/�n:�4����!$^�f�R,�f(;8oi�����9^x�y;���՞�YBJ� ���N�:�tf���H䡀 6d�R����Pk�������ȍ�V1ܣ�n��Z`�� z"{&1��ǰ��Vt���Z��f f9�l���s��/#z��48��pj�B���k�_hG���$�~^)= Ş)�
e�"_��<_�U ϼ��5�ksKm���|�;z��Q��ۢ���~�w\dR�.-V9��&�h���<�:M��0��e.0�����^��w���J�H_���Iw�=ިVx��瓡�Zf������R�8P;U"�/���E�^�+���m�uF�d Q�ոSzg����?�o~U�<��f�=��DUsF�g�e��q2�֗c�<��]
O�N��e
��MO�x��[�X�i�U�	h?�﹨&}t��V5V��';?�QP�ݽ����_��@*sW~�=�wlH�*�r����2�x��-i"����Y8&ϔg�>K�������P'(ey������<�z&����h��3c�C{^~�de���y�L�����O���doq�ά�ǜm���ʳѿ�s���A�4��N�|�e%
������A�:or�P<'���o7��g.�^�2W����x�lt��􃙗����:�]?�:������琪]��:�jT�����V����siq���9�Zi9 
�5a����b[{b�'KwxY_.�)�����(WI���8�U�k����n�,j�Y�jB!�������M�1 ݥ���g��g^(��`��������,f�j�W|u]����fL�ȶ�/n#'8�G@oWȐ��O�Th�_�LT�`�9N�i�\!�;"�Z��� Yޫ����!�͡��n��X_�Q�������l�К@D�;ҕ�7�5�����t	yA�8X6��*|�9J>I��=`��u���X먬؛�ǆ۫ݢHOM��:{��UV6��ʰ̽����Ҏ�S�����3����7Dx)! �Te��Gb��~�^7%���kv���_"�es/��6�L��(t���y��{Oل�O4�MB�_D�έ(;��+�c��0���&t�b�hѳP���4�2����8/Q脞�B���sN'B
z�� i��ᄏ �;�����E�Z���|b��c��{�����wV=wa95�{�Tj�Т`z�N_ގ4�Y��s�&��"=�q�%lW�i�� R�3
]�@���T���G�\LrnG��L�����1ԃqH���;Vuh�>8�5
UC�_r���2(\[!G���3��}&%o��6�`^}���U��w�ۣ�ikk�b+Y�{��������<e7�6��,!HT�tp�/-P�J	ـZE�}MLJo�B<q�Mx�����{6�o�cs��
wr����U���k���&#*����݋E����Î !{�ʘq��N.�}l��h�;0źl���^ޥ54EJ�g����h���z��fG9�gD(�u��1g ,o_|2��L����=�l��F9�S�^��~�RR�VR��Yir���*�n#��MF҈�p�����%��6LT�ih���/6CE���q���Pɓ(��A�Wqy�#��ZYP"���9)�J��m���ߐ`�e��[����y.�qǚl����{���j�LGƥv��.s�OcŬ�[|ad�C���F����Y�[1B��d=i�|����V٬�2`A
b=�6c�F���s�'fZ� ����.�֞�ӆs�;$���}V��Nhx��L��ޞ�ҵl٭
��ǃa1x j�����CON������������]Y�{ �3o�� ��+yKڒ��rc�n+�A�M�)*CH�/�@�}YKg#�&\�]5�����!K�����J�Kj���%w��j(ʯx�L쁾;h�`yA~��\����d�u��N�^�mV&
�_�*\��D1#҆V�������<M�5;�0�H�����a��*Y����A�[�}�= �iz^�zf������΅�t�O~s�Nfg��P�}��YC���������_NO,ʬ.����BK����k�&\�\S4���W���0��q�{���=&�ܬ�%[������m��a�=�U�.�q�U����Q=�{��	/t�z�����U�\�$
���M@�|�����p֎���rG\]�����1���S�üR+���Ʒa�D�J:<�F�H���Aijb�!����>�$�ml�:n��V�(^76���4;��L3+R�I�)��!De��
�X���=���#:g�~ٟ:�8_��_��,R��j^�]+�k�=�ѡ�Z�l���    m� �W��D[�S������r�-�
!��;�nQ��]&����j�[k���|X@��߱܆�j���ӧV>ݭ��U�'Q�w���������
�����b�s"尘��x��x���`Zy�5W�@��1�f���(�O�}���F��)f\`�u�ig��龂ٺoJo�o/��I|�6���(��+��[�8	�rվ����"�Yӿ7�ӆ�μ�O��C���U��0����Yv�
X5<0#G^|h�2bP�<�\��EJ	H��E��񺗢'}�SH+bg�@�#��;G'��v�`Wb9��Fl��a��27+o>���Շ����h���#��I#1T���~�-��S/�Fay��}�%ZE+��9g����o����uL�Q~�����8� �{�Va�m+1�=7:Ǽ�^&d����J?[>��f�9��_͓$�9J��P��X1�ҥ?!lR5��r/;�-jU�Ƿ���<�"� ��b&ĝ�W1g�w$:칵=Y�;��lD�}����L{��~�WK����ޥ�fz�m�o��j��L�V��ڜ��;[�A=�r$�ϕ�b�S�~�& h��(��'��|�G~��t
�E��/����J����fT��㒄�eq��=\F��#�bD9��Hi"V�n����1P���]�m���X�nwe��Zp§_�C��
�&���)��Z�V�\*���q���.[v^	���ʿ:1���
(L�R����r��]4�ߧg޸�/�x�z����Q���I�����6���'t�£]�ѷu�+j�w�������9փ^�I-��I�:�RH�9�f��W�F��0��:-M��ɨ��o�o�������Ю�ی����sZ�l�.���u>�͚%�Og��D����@��{s���cjC0��+��8�;����tY�%�⃱��!_��2�&S�aUy��.�D���æ�(42�g������Z�H��N]�2`\�.<*�z��[`��wx)�c��lX��ֺO-,��)���w��sq���Z��İ?�@��Vvb~<аQ|�CB�(���5��Z�,�+ym䧶k}�&�6LnD�aArΓ��8)s�*�֮[9�A��}7O��Y�)ߴplϷ��{�ZP�����f�gVo�ܻ1޹�3}w� �9��f��;�&�뵋;,J(��e����](�SsުQE�ɬ�X2�.0%)}_�\���k|*���IjAKt���jleA�r���=Xk�����ɱ)9R�e�2{��Ȋ��c{���� ZWL��MIچ�}�>�3������ŝ|.Q�yk��;�qv��q�\H����;7?���@�o��	_���7~y��x*q�pr: ���Z��Aj#D5��r�����ɂ�^m9�z����������X����x+Ǫ���|U��hD���"�j�5����O�ا��b�I@O��ƻ;����X/'��~'��O��o0N&L���}�����X^�LX����&~��<���K��2tA��',ͥX���үP��v]p	��Z��Zj�:�(��57Uﶫ(��mX�nT4i�`F���u_[�j�5z��.��3��ʗ@8Ў�;+Ͷ)��[�vϫyv!kU��o95�rmva�콷�S0޵U�a78�ė���,ބ������;O����r�������"_��y7p���3�����c5�&Y�����D~T.��V~����˯t Z?�y��o0@%6��M����PM��Iqdq�q_�m�G��:��sG���P��2��__]r�O_���"�o�d��o����yK��-#��������:������XR��R����o��#�, =�:�י�p`b�Ĳ�?_����n&�L)*,����o���=���ﻠ}񯦸�Ks�NM���뿶��8�����K��������x�������m�����������a~��s.L�?������U�1�D��J�����z��뿶G��=�f���_��x|4��s�	l�?���U2,����[��u��|0Kg�͇�'��<�����<��P��a��w�����F���������_�+�=�ݘ7���VQ���E��]�.7�i�[1�M q���<��l�����u�X����O���T�M�*}��~Z=n�梑Oe�3�n��N"kpUP��,�-<�]��)��U�O�}Ɛs#M����0d���.Mu��Jh�>#cP�Y#��ấ��(W��7}�j�NL���"K����� ����:k�m�Q�� ��ZS��YV۰IDv�]���� +��(���6�k��{����6�1N?ؙm�YTγ���|�DαI#�b���u�Ĺ,/LZ6 Z*���Y����&�\v�	��8�|��<���y��Yp߿7^޿������xv�tV���ͬ�n�7�h7G�8������A&���a�n�p��q��A�<�P�T����9X��+޷_��+�/d��qAg��������E�����&�Ș���uh��h�ٔ���^�����,��JR�b���ky%�9��s�>��^�d\n�ui�.����p.�J`�?���\��|_Y��"�埝*�{`������e'We����!eE1�d�X��M�z<�j*�����I��B3�٠�m������*h����g�������f.p}>�����'dE#	7����&��6*Y	�C5�N��5l���}�Μ}�����ܜ'~��bծ�Տ/�q���B�h��+��>������&Hcc]��������&�m��7*h\���㧿�­��}��>���?U]N;YDX�q�\������{�35���{*�u�מ�����d�UκE�0�Xa��溋O��$�VG�w�/�w��eà��'I�ו`������I~9#�W�����Q����u
|�-������d��L�Y���<�k7�/&�n�~y�_q��tVy���'z��|>�P�t��~Pп�]U������@�As���@��7DR%Vt�ҿe���MpE.��ޜ�����M$��?
}����E0'V�IW/0PA��؋��{�c���P�^�Y���d����Z�{��i�c���ހ�O�s?Z�b���������kA�4�?�
2��o4oA���?���aJ?l��fuy���{�m%e�����O�
0���q��'�u$�(���K~��O���mI�`Hyؤ��0�j/������O��Om��??q��Ox2^C��iFew�0���!�.Rz��'�ni��˧���z�}~��a��ڸ��N��7F��A�k�]\ ~/ܺ�?�%�qql
���&}���o�:Z�k���O��1H"��}���?߃_���.ƒ���A�oN�[�@<5 �x�uAd�Gͯ���~����_{��^��B��{�Uӿ�PTE��_\8vypQ�ߺ�f��Ξõ=��FK�5ph�9����I��x�bc���<������R����'��[]�˱�����D��_nfhﭺ����0*L�_޾-�ƿ� :6g9o�E;G\y�����;����sc�?|�L�/S\)�CM\����Ĕ8 <�|pu������@}����KD�g��6���R�������7�x�����݇^�Ā�-�j�^Qŋ�����o���U3Pe��y�O��5WG�f����\x>�m_�]b�1�ps�1��LC���Z(�Db���-�9k�ș�gZ�ș��A@�dTŔѿ��ӕ[��Р����
��V�J1�b�A�2O��rӰsm~��/3�f�8Ww����ӡ�����|�����-s�� �s�ڏˠ��6z.�!�f��ѥn��,�E��q]r�Q�Oݪ�v'����(�/zJ��U����[~L� ��T?����-��Rۡ��)�&���>�k��dĳ��.�P�L���>�Ϋz���I9N]�u��ȶjAv�( ��ފ��dƎ����q\����&i*˯2`E���cr/    0}|��U������l;ļ���|�A�Ϥ���d�Z^Y��?\q�5���"8�����tI����q���p�����<2z�i38� 0)���m�ێ��F{����a����G�4��s����ݣe�cX���ӵa��n3�r�3��R��f�ey`w�V��ߛ��^J�X�u��P!�D�'e��R�|��e�@�=iF�*����E9V����w^4�ʾ�Mi�|>V�b��"�,�P�f%i����`}]h���t;D�Km�M�N�$�w�  �����5�GLT�c?/��.��\�6.��ʲ���,w��2��\����;ԓu��/�-�H���2��pLά���\_׵�Q�Mб�C�����M(�o�'~�{�LU�QU}����h�oED�R}\��~����E?~ߋ��o��B����ܑ5����
����#�;����בjlfͱv��mq��^�r�=�*|/�U�{-^�7���=�8��%�n}r�Hі��.2eIR%^
�9q�կ�D�l���X0>,/�I^� ��,ĵե@�*U�̪`yB���$���';S���
k*�{�Hj'ث(����ox1�H��r��8��"
s��M���W�k{]sAe��5�OO�������
y�}!�N�0��L�{m*�}=Cs�*�>J-_�MP�T��	C6!����0v�8�����vN�~���䒋.�Fe+��K�[�4�8���Tw`)��~=}�L�a���R�(m�r�j�Wt�>���j��yuJF>%��1�TR�N�|q�R"p9J�9�/�α�`���E���*�m+r��C�ͻ�֕����RVK�-�����l6,;s�VgK{c���b�~_w���o�в�o4Q��Ȃ�����k>�>qH&�X��.�9�/WW��ۿQki��v�*-lĀ�/��Q#f��m�S�˽{ʷGs&� 
**��K�Y{&s8�Bu��⣮h9a�ܠ���i�[x��T��ҝ�N��:P'�'��|޺>�����"N����3S�_��oO.;��@YX�;t�E�@��uңɒ�b�r����!��/1�ݑ���;t��@�7v��MO�@�s���9�c�_��o�� _�D?tj���Y���Z�#zy�-��3�#�hc4ȺW�/����q)�	���xx��k�!����=����k_���C1�Muc��=	��J���u7����})��P���^K����]���?4�������A;8�ȋ)�,i /k}
W��)�����G�a�RJr�v����$>f���T�'�����x�eU>v��Kaч?�F�H�{"�3�(�^T-6�a&S���	�,m�BǬ�}³�=w�[n�x~�>�'�8�����vkє% �Z#+��9����߼�'(�"�6��2����\Z��QK�������hN ���g�SԆ��˿RX;������m~�N̑�լ������iOʼy�PM�h+E��1DQ"=j;}l���é��u��U]�b�z֔���W_��i�f�7����G��b
j4�J��r��Mo��c�zg�����_6��۴�^P��9�_5�Y��y���կ�)�;���{��|��������!O:���X[����c&_7�x~���m�V�1�d�:�:�0����߂v,�^������Gw�%�ä���D+�d���|�zN�s*kw���d=Q�c�X)��z��g~�����C�r!ϯ�o��kѴمyK�Y^��r~���A�,$�����������7o�����kyk�z�FY���?%��9�fkΗ�DU�������Tel���D�����ɠ
}�S���H'�1�|�G���h3A5}�ݹ����r�!���DKWӈ�达X���U~j�����J5Q'ݐO�3�OR��x,���AþNA
+�OK��=a�gYkv�ϸI������[l���Rr!s��^��6� |�����u ���疐<�੽�=��]��,��o�NǩFh4O��Dy����Ʃ��$/A��e>��y'|*D��z�S^*�_)���и����Hd,A�P��(kj��,8�cӼk���А��m���5��zmPe�W������ݲ�M�|�}���Y|�y�@�K�G3B���*Fnz�,��d���a3�&����T�`��A��	�h9ҳ�D,�5�u�hh�z���̣�oH���A�b���<@�&'��n����5�rx����R��U��t[[鐿}�v��n�k�c�1�e�2�&&�1ͱ��T�W�R��$�<���=pZ��w���Y=�W$�'bq�YH�lˡH�I)�Y�lB���{������a�$(}�`z�z�R��>������(�7 ZOۖ�m
�����!���:wC���2���C,A�<kޜG�.cM	�(O�Q��}�
9a�h>V�n8�EUɻ��>�O����GGD] �����@��+{��l�(�_S6�1,k���W&�i�i�� ��?����0I#�VQρA�9��7Wj��'<�b��"}�2�� ~N3�ĸ]���
c^���ѻ�@B��;Mzu������)}k�Z%O�g�*ROgn��Q�U/P�: ����z�R�g]�R�H��0�>�bۗ��zŻf3;�0f��1�H��"IjTM�|+����T���|=f���������o�;���bSU�Cxì�����ߙ�f�O���u~�b[��6K���������l7�hA�Ԏ`���!BYh�z@���L����Ё��i-�a�����#�ӧ_��XrZM	9���w�����A�#ĉ �ױ�����$N�OW;O�>��2uQ���-תDL<*%����+�	��.�w�X�]�5�;>97�
�#����g[���p���Er�s�r/G��/�oڀ��pUx�+b/yoXz�|��Ҕ�z���U8��p���FW�1�p����WBO#�{FK�Cq��XKF�yClUz&2��:����H4.��n��$�r� 0[7@��h���	A�#?�x���G%���b�!uK��g?�g�B>**�4:�=Bp���k#�+ꞹ�B�)�r���^׀V?ଳ�<��QR�7WI��:^�hU�<^���{oϼ�JUBgv7_���^��I5���@�k�m��+<�bN��aBV�z.l�
��/��+�n~c����re�[ق �y�\Ob��J��R2�mw�d�<u�N��0Y1 uX:	u1�#zh�܅{�����*(K���+(㊿e��œ��@��p�ͭP86b� �_�!��f�n �g�������x��黥	�5Id��r�ߝ�)���0�.�#�J��Փ<I��vG��3&4�*�}�J �뫉S��p��sʋ���%cb��AŮ���CZY���G�"X��\&Yy���q� >^}�,�!�6~�G7�����_m�?[��#t�'�%o@��W�P����QѸ�8��}�� qo� ���MᄕC�h�_o��n7�z9��N��T����(���C��p��=��!MRz���3l8o�5n�nm$i�ڣ��cɓ�vʙ��%"x�F�wx"AR�9���i|tP�e��]�2o��Ƈ+k��a��:�;�,��4>y2p���ID�#E�Z�/�7y?�Ԓ�/e��jhP-�A%�7�R��%����}��Y� �RW�{��r�y��
��X�gmb�Z�qpR�W@h�
u�(��d����#i���"%�^�v�+Kj�x$�/���l��D��q)�L��U}o�3<+�!�kҊP(A��"��z0~�)e�A=>����lHH�">�,I>~�[�h�*h$�A�	�&������nL�4��in�4�"ǔ���7�_U����T��k��%�OU�[�S�]��l��+L+�!RD�Ŧ�M�� �\�e��4}&3���5��ӡMS�[X���q�ByX���34�`��pRxƷ_ȔqL�e����pM�`Y�7�ڜs��    CY�1_��٣��k5ߤ<����#��o2��M�b���������&}�bP���&՜�ɟ��
S��&(��s�{A�;����G���Mzp��Yo�b�5�������T����\���E���5�3	э�#d�+"ܬNح8b��-�hHE��GE�~�y���YP���32Y�j�{��[�	k(� 兠 ��$7
�ixD��ۃ"g�wc��˞�?�
�@���1�)�3�R�頱`W�_�+��kǅr���S��qa����ٳћ�,ۘ����5.,�)�&��n�9���'��~`�6U�����]�}�D��s����)e�m�D��`mX1���H��XӋ��q���a��̟���������O�J��'&�Cw�][u�o��ok����	ǰ>H�����;NC8/��ŷr�za��sı{�^�^��8>��T����I̬����*�L��ˉ��m��ί��ɋJ�`���R^uHAǰ�����[��q,D�f�-�He�F	��-���jV2����(�IK_�~��E�;�p�µ�泯��:cH��"&�'�(����m���t����!`L��5�[#fQ0����jJ�Z�HNm;GjW�8Wڛj��<�~��t�|�,i.�S�v4���}�l����y5gMl��`^�V��Kh4m2��l$N�=��ˋ�S��7�h�bQ�F}������Q���8l�W1Rk�r%����K��tP��b�%O:��yA:�S���yׯ�P��C�M�F_�S�G)k�8b:��?����p �d�}ȵX�O}ؖЪz (�n'W�J�e�d} ��v!ɬ������ls���?s�7a#n��"�W!&eJ2�1o��H~�Ы��q/zB�	@����f�ӮI��\q�T��u}>Ү���:�snF-)��p���H�N%��Z>k�S��O��u�A����D'N�fd�����3B��q�a��]��ZM�곎��3J+ g�hܩPo:�V��|�h!hD'3��y2�ϸY��`�qa�*�6���I=�,�Zv�#�t�a����{��c�J����mQ?�=x2�E�o+�& �$p�!6���ȕ(c%y���-D�����g����$e�D�f���.�4�	��S%��zk%c�\A��ux��駭$�"=�ӊ~��� ��0��ݸPZ.0��I�]T^ՍT���D��MCl)r!Z �V���*��Aܧ�D4v)�e(N�����{u�A��('�>d��`!�Mz�H�X:�w�*���C1:��`�'��8�Cnv<���	ȱ�M%��G]���o����i�G�o.wQ�+z���]&gf�`>l�}� ��<T)D��o��v參�%-w)ІY�V#Y�/>��uYT��������>2ϭ�[�Y�&����C��q���ͤ�G�-\0��ξ�/�1{�x�����N#�A~1�=��˜�^�g���W��jY9C|=m��`��3*}$�^��M�����z�F�г����Cyh^h_��U��ᠳ�kY�����9��*�=�=�}�,�W�����5�֎�A��K��Έ���T�m}I���3����"Id�7@Zp���6��Z�׵���gт���Bt�uJV�/t�7�yR4ᘀxAy�N舴W�h��C;�~:�&����*RWȱa)G�Y���~({�Æj>T,�a� �GW�>���=!<��ԅ�_ȧ(���w�ʈ��*?s!aZnPr¥���� ������L�l����4�I�����0 M�����(����iU��C�C�:�\�Q��i�R�N�.L����d͵9���k�.m���1n҅��o�`�s	�h����T���߽�	��w	���L����*?�|g��l�1
�d#�&�{���4�C��Lf*[g05|ԁ���S?��|��v���ņa��n~����Ԇ8mv���j�Ʒ!)޶n��W�9{�7��u%�������$&Ol���!�ͬ��8�@=����
�i�8�~�+�_Kg#J�v�{k�k\j��+#���-��J�-��+�E�J�U��x���e��=~������!pú�:T��\C�9���Z�CDQuu߾s��k�s�f�$�5�R����-d�ԓm�n
��|���r��켾`w${�H��y5*RI](����fu���Q��Y��nb���[8N�����>�^�w�Oa�tu�P�P�7����6�X#� ���3c��*��?���лp���6����P+$1����i��wǐ���{�WCĜ�3����dH�#]�B<	�9�}�P�YY�L`u�&t�낳��@1���ba1�mʋjݬ��9Y���R����N�:��g��H���7�E�*k������W�u��G�b�1��yQt�15|L�C���N�X7�?Ъ��?ߢ���2���-j�h��	��)����~3� \؝v�qJö�����9PRRQ���Q���d��	�`����G����c�z��K���Ptv�$\�SEj�`���E��/�<��xI��Ͻ�i��y ��t(���)3~�[C�Tʶ�!ns�g+IS�#�"|2T�����>��͊�~f
��D�(��a:u<ے��5^x9���S�� ��AHQ<�a:(��l6��4^�RV:����H�����C���m�Y!:v�xV�Χ��m ���x.�l�4���c#��&Y��(/��|:f�"��]�Q��AG�0��I ��N[J?�?�)��3[�+j�4���z�t�s���W����Jԕ�Jk(k"��~�IY���8��� hf;�u#�[H�{j���#RB�_mV>�.��o<�lF.�D�]�g>þ�@� �="Mۑ�Fu��t��h�_�5�P�%�ax�v��@i��L�)p-�q�I�A<��W��u0*s�e�!��l�n����g�"[�:7A�Y$	�&����7Y\�������H~/cZ�L�^�Ȫ0��j������.��<W�=��y��I���!.�8�R�����?�E�9�lRХ�Ž�䕟����jꥪ�|*�Ng�4�ϼ<Z1r��|����R~�����c�ҎBcƯ�{�gZ����t�H�o�W���/����BWK�F�D�;I3�1�&Y���t��z]gB��I�7�� C
E�\��4�8�]ǧgTO88ո�D��g�	����+�/���֡���|@��D�͠��@��GR0�
=6�е!��x�z�EQ�5���-KZ*��~'��.��-�����V�O-E=���'�郒��c�OAٹ�2�c����J �� W���Q�y,=������g�����3���*(�A4�m	��k�4��Aֆ���**@���@^6t�UӀ��]΋I=Sn��M7I}�B�*��������� <Ǻ��n	q�|k-��@@RС�k	�{ݕ�b)����	���|Gied~7Q���D���o5���`�*1���1Fx�0�"o�Xި%�'U�(C�tf=%�`��7�d+�!,۵�W��U������J@�Ȟ��@�P�o��@���\��FA�*�E�nLI��M6=���!گ��:u���0 �"��w�w76ws�Ky+��[��j�a�\��줋���F�ܪtV4�×o�ڮ�ac�����M�1_P|�O�C��!y��K�}Ыv�?2�͎����0|1�*f���+>E�r�4��i�E)%y��UC�nZv�Z��U�^xF:`f|���N	�+YemO�����L�Xݓ"!,c�kǿ���oc6>��i��V6���	�؍Y�$~ū��Y��pu_�
�����tJJ�c�D�J�}��AT�/7s�h|Iiw�{ު�@K��b��:�\G�
OH��n|��͚�S�;ʟ����a2���V��#��_��)}���Ƞe튔i�ʤ���#�MMυ�#�6MGJiT-��L�	�������5<bn�ع�׫�J�:�A��Qk�w��D�v`;+� �-~���    ��1�Fo�sY�ᎈ߸EbH��.��BFp�oܐ�c���*��$�~R'�d��ex��#X��C���fig�G��P՘'�B~��Z��I����F��5OJXNmG������V����:j���ޯm��e9$�'�e(���{�.n���Z���[;���/K |����w������)�+���1cū�(5<˄�5�Jǂ�u1(#�e��js@��|�E���4��s�L�?}���}ˑʪ�T䃁�n���4}awjj�$���N��䯽�<�D�����!Ѹn��[F� `B	�iY-�~ ��)Hss�yg��Y�RC1�CZ�3q�::��>��c��Zs�� ��ˈ���� p�@���l����ǅM}A���9��n)��m\&��T�*�I0���z��Bh
�LA�Ӧ/E�v�$Fbi�V#	F�ueh?�SQY9��ls)^=<��M u�Ss���J�(=a��ZTj�˷J������γ3�֜S�8�����nT���O�B�����N%�/���S������l�6�#���F� &����nʠ��#�w��*��?T�/j��``G�6�t�ǣ��TF�.��2W��I�c ������>32��q	o�N�����UU:hZ!ޖ���@��M^2<�b���x�/��3�J����{-�����p_U��;�E|��y
z,6!#��=��$EVuH�<�c@E6�b�w�P�gL�1!���6��H��y"�(��tj5/l��O�/��T�p�L*��������{�3�F����T[���"�b�y���VG2L-�]�;���* ����n����ޡ�(���x"W�uПg�P
=[T��۶� �{d�,�38�_ԉ�9��n@��2�=�N�-s�d�	86)- yq� Hfc]5+$G͔8�^5��-��3}��}kB��������ժٕ�oƇ��8� iS����t��?�ݝ��m�γ�ƫM�z:���~�����,� ��42�8���W�Uo�ڻ2WK\��[�.M����Ϋ�[�P�٥��A��9t
�'*=}^g�"�ܟ��r���XB����YC
��ĵs�D��Cr�s�\���(W�U�O��g��ɇdQ��!�p]�_S�\~�~pW���f�0�2�T8�P�˚���3�ݭ�v�.��A�^%yVd[�p0Ӈ!>[#v�m퇃{Ҧ���suI�.�W��X����5���Uױ�6�?H��td�9�ƜŜ�����{���9@wu�(��T_�S��d=Z���Ш��!U-wE����;�5S�(m8� �'���n�b��'��<'���ϯV��н.1�]"����y�{�Sߴ=V�Ug�9.����f��X���2�F��=�=�<+-�o����Կ}��o�$�,������A|2���7N^��|%�?�6V�9i&/f�Ѱ���ra�Q�w7ͺz9��P�[W#����Ѽ",ʟX��0[+h�e?W~���'HT(e�9!>c�����v��|]QŦ_{�/o�2
6����0���g�?�8݂ڑݎ���6
h뜴 ߹�;x�X���ޕW�<��K2?:]]y"/	b����si��o��R���'���X�}!��}�lR�8*g���A��C����+�</ 
�/���9Kt��~��AA8s=3V~r��|7��55�$���[5��t�-C^�%�P�ƽU-fl,�JWd�՗wU��$��Y���O
	�8K��dXco>`T7NJ��v�o����搱t������W�y����'��	#�A��L`��� �oTa������W��\g ����97K�ն}���J���A[+qe�]���E�l��x"V1�W�J"��4D��oJ�~?�9a��R.*R��ĸ;y[�|冧�z�ukg�ū��,�vf�Iw�1�{���Y�S{��P#�"�'�xf�b@���a�3d����{�o{E>�� �/�%�`O�Y� ��כ\��NAD�"��͗�P������"��[����&m��E���;S��M+���<\rlR���Tir���S�o~���2�'��q 1Y�*j���dC���0V?.&x��2�a
��qv�k��ɖi%���fɭ%/qs���#���/;x��� ���NǕ�X2���+�^��J]���#��ቦ���lgv�|���U�K�͟�請��Y�(��<�����v.½r��'����<��|�Yw+q��k�NF%W��>�P�ز�ÜTȈ�Z�ܓ���\����gS�g�\�=��3H��TiiL�U�j��ݩǢ֥Hd�N�����ӻ�.i����&iF����%��a�=����P��~s�\kA�s{:!��Qн��Y��{��Q�k|�4�D5X�u>~]���/��S�����~2Y����ӉH�8;g��y��j�[�3�4�!jg����b�n9	ؔx�8�.��� ޚ�� t�nmʆ��̫�!�֔�<���H����Dl��jva�0��$zK�{���j����Z�zN��q=��~H�L��6�`�"�x�H�j��I�t����q]͞%�{��=�I}�VO-MH�j��+�2��xTF���D߶�5}�2,uR�2>E ��Vv2y��P���%xߑ�\JЕ����g����r;�x����������eO/�M���'�#1�QE�m[��΢���vIV��x��K�����D��,���S�k�s�}'=ۘ���ŵ}��N�2���-�h�<�o�
����j_�k�b=�/�Z�m���d��Xe
���N���OoB'7#�U�H�ߛ9��d��Bjϕ�"u��;Zζr9�|���u4=�k)M�)4�=@�bQ�+JB���g��ޡ~��6���ې��V0%��P���� n���ff�:r�����02b�	kf��$0����,9�va�Ĵ�k�/Q�b��l$.iQ���?(6�1݋�I���6܇km�y�_�S�h��������5��1V�A���kjb"c	rWc�Qd��+;cDe�l8��
��o�i:�=	�Xx��p�//=>/��Sc5ޖ+N��I��o_G ���-�߿8�&�ʞ>*���PW� �\�f�O���R��{�N�����)`� �
�fhש/�zˇG�T��&pRr@QZL�6�!�Źd��Q�ysx���h+h�^ϗ1��#�-�t6y�A9~[��9�O��ϩ���Z5��IQ��w�ry{�#/?���)�wm�'??=n���n�RA�]��P[m��!g���o��6c�Ƥ��_R�P�ae��k��Ti)��r��7��o��Ĭ�dy���~Դh���8�|Ƶ��C�"�-�lH��u��e�
�dX�3^a��z��Oj9�k�X����O`������!(MM�+�?Ƽ�y�\��D��f������yDBC��E�㩆��.HԽn�z����i��ې�S�U�P'���!8E� ��⼿�!G��a���Qj�$����E�g�-�Al$�r"/'cw��t�
d֛�FI�0e͹t�ڛ�Owo��6\fS�t*3"c�;W }O�:�'[�ꐠ,#�?o@}#�(;��j�#���(������us�%+�ҥ�ăf&�b$�d���~�2�������b��G�3��
3W2Ǜ� (~�H�j>Q\"Iqv���T�e&ֲ8P�.ݱ,.����{��Z��p�����(��sI��g^�_�CG:�n�LU͒m�<3�cʈ�K����-ĉF��%e P�x�sESt��sYhн<}ZRy�i�p���H{�1����|���Ԗ��=Z� ��Z�Y���[�yq�G�^��!ņO�c@-��-߶4 \8�H��wX��~��HU=6u�L��Enb�$�W޶�8Mj_D�v5閣9r�Cj�K�{�Y��=)�F �y�i�T���i%���I\��@��='z�KdD�YO�n���	=p�Y�GL���%ע��	�3+�k�^L|�Oh�J�B�I����П�
`t���e_�֭��Ӻ�ּH��VNd�V�G�Sr    ؕY7<P��fn��=oPY�����z��-~	`�)�b��J�V��E�cS÷�x"/>���(҇Ǽ�����Q��tL����C�F�H?&����5��~3�24.�եiz&�(l��U����gb�z��e�zU����Q��r�a�L�DL�רjA�k�V04���	r���E4��%�� g�r{&����2��I,ڲƬ_���YZz�]��j��K�G��]��x�ş�9�r�}t�aI*fȿ��v����D�f���ĩ�� 9�{B���	Y.F�s��u�s
e����%ݸH�����σ�c���=�`��:�'�=�xm�ڣ3���A�O8�i֓*�v���A�Yrb=�Ŝ��ɑ�u5��x�|Q�y�K��#	�z5�7�@	�ƯL.�F�p���i���H>�q�L���rb{��"N���kL�>��"WV��߮�n���/����������8��>?As�_O�i��+b���!i��d�����4�7�<O��Rm�5�۫Ī����f.~`gK�&�0-=4���O�nԩ���_e�3&Iƍ�����e^\Uk�P���x��@
�1wmU���7�Zs)Y�L�� ���e�p��Z�ξ����]I^V�ƍ�7x�z�����^n�i��/�n�#�鯶�~v
����0��~��>�׏+e��n�"[���y��'���N簔�e �r����'�:�*"�#b�ċ���m���R�������|g�/�$���8��Y��>a����D�b�&�xs̈,́$^~2I��>VIV֟��/��lߑ�a �P���:Ғ�~��p�4��#[���v����0� ;���cPJD'0�����$ϥ��6I@}93�XD^�a��ʟ��՜����&�'�PC\M,/�&A��tEE01�ʦ�C7^�9T�d�7����6�w�x~�w󽨚Y/ߙ�s�ź5�{��0Mxq	�2=��E����g5�����:�=� 	�����q>46)+ #=i�O2�>@���Ie����X T��|=a�fB�Y�h��ت�	Tf��7Vc�<�=��A�0�W^�}X�B^̔gB�Sb�t붮)D<�O��n���RV܂\���]Lfmh�,�疂���W;@�����ѻ"�7�X�3�:�-��v�m����W�'5�ؔ���菙3�g�����g��H�4��`��r�p% �0�̐���\r�������urEeyrQ��D˰I�ѭٚ�=+�f��&u\0����2��([)��Bf��6w	�˒OK�n�� 
�癇(�v_�)�f)�,ǉw��<�:"��<�u��|%��F��h4摿�g�[9�z�y���[�E��3�U9.�I��`60D�5�ßñ�/�lP�H,O ~5�2'�p���66����es�_�$�ǥ��ƣ|`�X�idE��q�|Jζ!(�ű[�Ecro+r��un�H M[Í�F��y��2?i�B�a����#�-�L7�|�|�PI,�ػ6��<m����}#,2B�9�j�<s��'�f��v��F��ᖤ����0��ЬF�%�5�s�+�6QI
NV�W�:ED<r�qH��!bAzMʴk�=U2�2m�UhV��!�w�*m
�9IL�ix�z��y���~><�!?�#E�Io��RL�����`��D��ւn���IS��K�]a&�phf>'U,����SW�+Xu0h�v'�`�+��h����Nh���I����؅|����5��A�^5��Y�X!�bq�oe�\�5v�i����-�#����ɷYt/)����(����L�aUz�e�-��S��[�G����y(Na��F_p��메�}"$�g�s��T>���τ���{=��v?F���/��e�9�z�6��oji�0s��+ �]�+���n���t;��� [�3��uO#E��K���rHg��#�7#/-��jK;w�hi�Hs�W4W1#���ɑj��ˊ��_�:In.°	�u<݊W���L�I@%�w1�h�(��O~-�6�G�����>r��5�R+S��{TC�4��|��e�i�Nfj���������庖Фl�a'�_/4�j�PdJN�D�{�a�a�yeD�� �R��>��ẕ)��L�X�����v2RI� ,�E7t+$�t�V��������Һ�[���Rh�_o��K���Ww$�اJ5�w]�ކ�de�b$M$��f\�2��1$����v~���%1+���Clv�'���c��ej���DE�~c��y�w��>���8�!l���r �B���A�h,�@�I�#0]��"�{A�ބx{{/��=����%J�Ўe����l�1�m9��A%�R��c�G	4�z�a�Y��cZ���}6D�=����)�P;^ix�yO�.Wl���ɔ���ZǊ�'�k�yG|d./a�o�'>5�<B����ښTb{����9���G�U�DOB��s4���9���0ٔ�_� ��5�Q,r{� X���p��[#Y�tN��&w���!�� �O9-UNtt�q*��������L��hr��0��{M��}��!� 7�a��r�iK�k��[��Wh���z? ��Ib�c6b��D�s��-�7��t�s���P�"p�A����b�+�2�%!Iq�g�=�a�cp���!�N���B��z.�?���g	��c�O���`�i�X��������l��C�$%����Tm&�G��X=�?�~?9�x�\��K=�g,��$(���X�ԁ���}�� W��9y�g�8���ʭ���Xi4.O���3)�E�����	�Ko������D��8��u�l�������i���ǓN)���>o}���^�*QP��m^�|-=5�|Vq�g�f��\^�E4�*}(�����6TWW��HO��sBU]�>4��Ľ�╿6���Z�
�祐l	�p�Ks��U��!%�{{?t"1�Ld�l��J�7e�9(ׯ�9q¿�%�օ��=���k*���@J�/)6�Ӡ[N���j������\��s>����p���W	ju= �
��K�'RD^_�(>�У���b.��8~�Y��h5॒��8�ܒ����O�^�2�O���^J�~VIT����"
���ɐ�����{b�ܮ,D`C����4�`�3S����Њ�ޗ��V�g�K^
�^[���g@����F�)U��|����������]a�A�c7��/D�ӳ��1�J��S�e�Dy��Tլ5��m�?�e,�R��Iq�K�V����Sy	�w��#_]'z�om�cl�ufM2#r��1��;�¬؅&;�DJ���+�+�۞o<~���|4Q��j�Y��5�����YC+�����N����f�9�@�Uf��H�>�S}Y���C�r��h�@< �@m�51�h O�����r"�^�Q�,O6Ĕ��G�x/�����G�Pˌ)]�{���J�mt�Fr���vI�^��HM7����C��F����P�}#��M�[vah�b`��Xv6y���8Cr��չ��jm^*�yr��ˍPE���֠0��ņ@����@x�z��u��/�R�;���g9�M!��w� �ǧ\�k�4�CEI�l �d�~���jt��_��+�>�,��d��k���:�=�������St��x/�m��i�?4���e6��>��A�Ψ�@n|��d��k�"�밼��Y�k~�������W�c'�tk�/�����̂I]�����`Y4���d쑃��7�@~l�!=zo|��מ��	��{����!w���C|S�44�]^��5���{G �)*Kg�W�T3)�
���9�t@
=��j��;���HO��H 	P� �%*o��p=�:��e"��(~NX��/�ǎGW��g��s�"�ی�`�}n��z ��x�
��*�ݳhr�g:�*�Co�E򓦔���>�>A���!�s5��HF�w�(��w]RL�-_�    
ꇏc�'w5���3x�����t����4{�m��!YveӞ�i�þ�8�M�{��T�A��{W��4�,�I:��i��>Ƹ�JY��cY�7��d8e����<�jZmsm�k�ç"ٿ�~�;ڂ���^qE�A$ԯ�P�#�
�x\�����<�L�����9�\�2+���Q�X��Ŏ?������h�L�I�K�~�s�E�kZ1�{���m�h9��F�qd�@��S�$��͕.8��� ve]�q
���������ʞ�����~e��ȗ�L%&:�_,����j�nb�� g��umeEB�왵o�郲xR����p�H�m���j�:	����4r"�0��m�,a]�60&[ ���O�'� }>�c�%�ۇ!y	�9�c'ܟ(�A�� ��n��[�� b;bn�X�V��b2%Fb�\ �.��V��"���'=&m�zzq����DWi��KZ}K��o�}o�BfJ�0�o��!�Nj��AhJ��X�i�@�Fǀb��AO��=Y�X����`&2�����E�} ���(�
�f�8�ɢ�	�HѰ+�䁉_QO�LH�%�)��Ԗ�w�?�-����j��Lud�Ⱥ��I��"�3�rZ�\�Re|�*���.ѽ����D�g����f-�{sk5�j�Ԇ\I+�=>��8�3����xH�ڈ	�QԧW~_Ӆէ���+��:���;�)	z	԰{o3����%��[�����K _�тb�����6�v�\td�K��Gm�]׽��Xt!	4֟{���q����#�I� �m,�c����j�+����ߜ�s��;Lt����:�6_�����J� 67�J[<��l3.�z�W�O�2!Y����J���U����L��� }�EB2?ǳ��>�a��A���o�^r+9�y_�h��։5.v�x�;�]��;�!�K�}��:����{!u����c�e�sź���FR�CEJ�&5g;�IY�CR�ql�]����O��e$�j���ۍ�$}�>����]|�Ӡ���/���{␱!/>x������#u�x]f��/��V��Χ��$*��@���'���au{@#V�+ Tn�o��ʼ-g1b��ؤ��t�C��*1�2�F�a���-�GB#�[�S;�Ř���%�I�,g��]�!PÆ29��{d�ʰQ������Y��o�/Q4V2�1K�iq���gv�T~��Ρ�w�ݩ[�(ׂ	�1H��$�UU[���|��AK��I�3�*8�����D�I��9<��0�Zx�g4�g�{����KP�t��$Ŏ��
?1f@<���]���0��5O��)�-J�$D���wv��^�q��C��}�����[u��j&/�Ě �d�P�X
�#������~(1��B��F���P^h(�$	�RU�[�dҎ�}�|�`�Rʖ���[Wǲ|���{����jk�)h��
�fged$� J���M����o#E����e�5β� x�,�|[rx����+VjUEP�$��I�ڌd�#%LF�ܑ�G�0�A 6jEډ��G��y��i^�&�X����P60������"3?��4��;�,�O��jR��0\��}.�Q���J�J�W/�]�]����-�V/��Aؖ�A��H���!Z���H�l�����/##�q9��v��7
X˴i�Y�k9{��_�'��� ��9J �X6�+6z�5D,��稖Y�0���)���%���f�w��<p��K�H@
7�B��P&N���Ĉ��K����dM-���/��N��#ag5�(��-'���ز�P��SA^��"=�-<������Y����G5Cm��/��]��h��k��/N��%���q�����������> n��N!���]��H�/JU�L�v��gJ��M�J^������*][�l����_����t�-٪� ��p�ZW�|Ȃ���]�G�0�hh���.
pi4:���p�Q����x�"��ށ�2���z����<7t6u�NOcO�d���4`����ҜQ#/���Y#Rd��K�����hr���W"�����|"4%FMi��w�s?0�)^g��P���I`4�S�%�T���{X�xN]:�^Grj-d�dA<�B[?Z�]ei+�2{�j�!$�:N���y�u���֞��V��8G�:>~�C$Y�;���]O'{�N�@Gx�#���-�+*[ �,;&�i�|���j4Tg@qB�ޣ'Y+'fN�
ڧ�B�4�{�8��.���8�)m�+���-e%��ZF�%G�*���e�ﵥ:ڤP��~k��O!�J�/��5���b�hg%���J"3R����\�,� +�3`����i��\n~C�I���[� *�{c�䥇�osBj΄$���'�,G�#�wNG��ˍ^�w	���EO�x�+@J�p5q݌Ŋї�)`�� �	œ�.�Z*�JJ��s���pM����AM
�rx�~MD�m�7r�y�*�x�&��"����;�\��Ȍbϝy��pY�r�us=�8ƭ��a	�l{RF\ɬY~a����ٲ:��e�$;_H���_�D��V5U��IQ�����������R"�ᄯ�j��e���tl#x�.H�2\����s�Qʚx��xI7�iS��=j�lP0�������z聱�:�x�kE�7���ˉ��6��nM��3!?���?��˿)sN*]��4P�T	��s�'>�7�����&QvoD���Sߛ��_=~�3$�Z4ٺQ�ص�w�hL�5�X�6y��ň8����ٗ��B|���'�/ޣ *O��3�?(k�� �/�ʷ� ���� �4���)�Z~��y�?���_kO��%����d���:���݂Q�v���id�g��<�˳��68RVlR,�kyd'�U�lg@���_���=-��sG��-|�}$�Ĉ���I3bp��c�`v)/	�ϽP�G�����,6eq��q�����0ř��2q4�z>@U}�Dr����U�
�L����=�y�:@�����=�1��#f$Ŋ�2Δm��ը���*@���E�a/=5�:�E� ��D�c5�k{
8�����qZ-���#M$�z�Y�W6���LO��%�2ٮ���\E�/�/U��J�Q�B��Pi���N>��Ll"?;mӂ1#�琢��zɄZ��C��(題���hP�5cUJ��q��z�{s'�=*ڔ/!P�)�0l;���l��wH+�����0Թd=��M$��>X���`��#���"�l�O�AI�,�O������=T��0���R�K�/�A��Z����[�˹���B���!�m�y߭'"��T���6G���gqn�>F�qU[��Cً�)W[lp�=��Ձm��}sVZ�@Oxq��&�A�V�����B��;^ϩNj�kŦ�ㅷ���� \���J�u��	����k#�`}��{l��ʤ|b@��v�i�V=��s�d,a��}^$Uq5�������pB��J��?_@���ė���#�L=���;ȩ��R���ٰi#��*@�H$��sR�+ͲB���~�:�FyB|���ҷO������c3O����[[us�r&����E��M�b�S��)�=L�E�����e����Y?�Oz��S��9)�쟘�Q��c�� �d�cTe��}���E�b��h���!�o�������:��g���&o,��x
���~��R+�-U�nB趠���p��&"U�͠x�aom����?��pԑ��y���_��a/�w�����w��>ϫ�# ��簴VT�%cI���i�� ��龋ͼNä�y=.{I%Q�M��"RU��!��w�O����\��TpC@u4��!b1���pN����Y�5����I��O�����z4ƈ�R�M�\/�e��7���y{�Շ{��x����Y�2��=`��J��{��eַdx��y�+̸p�4@�w�<����Nb��l/�!�@|��Œ����?=�����������:��{~��1��rS#�ߥ�ٕ�Y��|}�mfP#��2���#    Ԗ���o,�qWl�q������Z�yۨ���f=4%�C�uVZ?�&���~��:���==��_�q�-E��yB##N%�mM lN���k<=�YZ�D; S�
�ג��J�+����VL� /��关*a�����_�v"a�w�Svs��&���>}H$�2E�Uwm^��I{Ѷ�p�3�v��bw�������UIz���߄`����,��E�,L{���2.LI"��N��i��O�V�7�C��|��Z��t6[DQ��h߮��|�����w�������i���a#��a㞏��t.���$0��us�KI?H��1�LdX�9nP�na.�Qb�{5ER�_��@�G����	�T^�46�ά�$ ��i'��њ�$(Q�1��.f�lHDTkQ4��������<3c#wo��jhȇ��4�ӗ׽A{�T�󭾄���K9�-��)�>���v�4qf$H��

EM���L58���Z�	�&7��@e6	�����~撊/�"�e/r^��2��Fئ�ߊ�T�X]N��y2d��Eç��3�)�O�=� v	��LcP��r�
���QLo/O<�d����s/����i	-Q�Y��z5�@�ᒛ_)7�����ܽF.�ަ�[�����x��A��J��&�#�����}bFėI����F*W���7aLn��վ�u&�rZ�	��e��,���IZe��6[��F��������i ��{P��.|m��JnC�B�3g�n{�G��4ߟ�O��QV�$�*��G�>�߱������΃Ͼ�2���˞�'. @�,EA�����k|��k�ؔ�`���(�%.V����$[t
TUu�@��!r��F��)7��[��/�� w�s���>�-�9G�tK$�b�WKd5�7�@����P��m���X�S�i5L���RULT'�oB����n����@����w�AGO��/���~��̵� �/+��',-kڑ����0g�{���Cs�h�~��cy���|3g�����F������B�^��>eB�~iC�LX�<�M��hA���ъ�?��Y���[G?Yim�uY`sd�슬锈\Y�eP�k� �_G?��3S<P�%�j���"Aar���8���A�I>���/���b���v��T���� R��o_�����U�hQF'����pw��!�Z���w�b�dE�;�j��3��ʓ�^OD�?�n�t��?Ls88ջ�o_r��%v�ʵ��xY�$��G��%y�BM�M�U˫�A�	�����U2QN69�X���+
�v|�Ab|!��!�̵�-��N�J�]���O�$��;��l�!y͚Y��;�щ�8*�����_��d�R8>(ݒ��<y1 $��`�h#���y
&{�9��#���r�e�]���sb��?��d���ǚ���Ь� 5��d���}�mY�|�A��v�k��۲���8ᑵQo.,�J�g��%�Z��B�(NόK9Y2�h3e,��bO��Ϸ�p����ۨ�
�$��Ns�#E��ɡX�(��i�'�ko�6P��{ۉ)��V*iqCI��sS�KdJw�'�9qo�_��~�W�@.�n5����D.*���8�4��?�q�{��ϳ��
��iz�oo'N��$�oJ~��D,{w�JTC���6��.B�%�D��%����{@bmi��XW�>���x<=fV[C!�}�o�j+��骟9�Dz�q7Gh��@�Kۈ����L����FaJ�?�s��3Ψ��7� �2е�>>l��RV�]V��zE��56�c*�x�M��'���b� 	[0/|������X�t4��e��')a~��8��.��`/ͷEʬA�r�V��D_�D�T�W�wR��\GyՏ��;���Flu;{ �1��/z��jM��#�Q�UV��ł׻w�����m�6�s���HZX�J'��u�oV+��}�t�w�Z=U/zFj���l���O5](�p���߻�@T�� �.�8��/��T��"�d���$I��$��ܭ��|����@������}���{�l	�q�kO6��D�s>��0T�@mA�e�(SҦ9���1�^?��!&�P��
x����4	���g ��\Isdkc1����O��� �M6g��;m���tMO�gY�Z�8�']�A;G����D�̀�_b(�v=�WT��D�����f���@GR̋;'�bе�Ō1��$�{0
KO?E� H�u�W�a��p�y���5
�jk��)yY6V�� ��sE�m��t�i�؏T��,��]����M���& 4���D�.h'�5��0�>�щ�e�7��!�{��'vHb�u{Uv.�{	�R~(�+Z�%_V�n2��g�b0�����$ibW��6E�ަ�"?�wC��,�C.+h Z\�e���P���x/�'��^�T^��@�)���u~���ׅ=ԍ�u`����?ץj�h7���A���װ�e�H_�(��T�ʨ�ˌMB�(FC�9�m�Tl��[�Ϥhp<��f[gN��xk";����2.��#v����V�H�&����GA�wy���N����>�D;'Q��D��O�;���Ӟ��*-M�I�Kk,���v��	�Dj?�(�-�&X�h)���#"L�$����a�
����X�M�^�*�,��q/����=LU6�g���$Q$f��f�x:�eG�$�~a��7o����	�~J�g&:n��>��2w�]������!��A�^P�ԫ/��9��~��bn�=�-)���Kv��)#I���H$g���4d��jC}�����*@�D�Uz8zA̽�v�3���,�u��`p;�Ӽ����ϳ/,�5@��>�
�t%�[�\_t�V�������{�ݛd���\�3??�h0����@�,�^���oLsU��Ŝ�|�7�j_���Q�1�T���Im����Œ�^�|�U��:ī5|�����0�����K�
��b�5�܌��F���o?~O�}CDl$:�s��U���KddSވ�}ӱ\��C�ES*� ���~��Mb��<;�ԟ��L��rqX��Z�+:��	��"��<d�ʖ�o��b �TLrbY���MAA'����'�+hO���� ���K�L�+�}y2�A:��R��uކO>����*�d�h����\�[#�c���Y���P8����B����0OK�*��:sr��>���;'M�e-��e��.*G:�Hn~藟�7|/���{�����6b�Ǿ����I���U�+ �%�{R�+�o�g������<�
a���/K�_���ŋ��R+�4~�;å_R׵j�>D;�/ٯ���W.mr������ѩm�W��S5{4�9��X#.�fR��Dz�j�P��E]�2S0�,�P*0���`��XJS{[7����J���������+br�� ;�+E�fV̭��9�*yh{�+j����>k[��g�N�p!Q��Y��_��#� �"�'G���L���
S�?�%����25��|Co�Yv��j�fx� P�����>{�|�14\3ߩ�q� �Jt���)�pӄ˿�6��,��!a�5��]� ���`B���h�۷͏.�=���\3B;ۑ�8BW��'ᗇ��I5�ڟUa�e�L�=��OLr[���	�"m:g��$e���!��9�rF
��q%�%*2�ش�;{ݙ�a���ѱ�2_���(ã"=�B��/�g䏍D�?���'(Z�\������	J{��N�h}�!d+�~`�@G��������3��n�q�O�F��`f-����A��?��ᆁym����l�w�G�k /���ΗP6W#9u/ۼ��ڇ�	���@�'�+���Q��A���x^�'��S�n�KI���}�&�E���/�V�0���j��#�N�	�|����rxW��oю�3g�R����̴�DqTzA\h�5�	���c��jhp����l{�t������F/)�q��'�I����    �p_U�<�����[M��'ҍ��4J,~*�D��R���xO0B
D�k��۹����w�i���V�Cu=XCcԷ|ۛ��.��3�&�rxkMémM�&Wj�����gJ�bꚿ�O��$M��w�K}�r(�r;���$�Z�
��W��y\�X�+���^��n/�'��GO1��C]IY	7�9�q�P��"��p)n��8��0���,��l�]ʋ��WGQX��ؔ;���@���� Ǥ�p�=�� �?���y���Lٍ�,X�UF���V�2s�.��FP����y�~v����/���x�p�|
���Ŀ��	��e�1/V�#�f�8+<��(��ac`5��{	�}�/]��wd4��zt�P{H���v*�|8�_��#����
EE��Ԃ�t����6�(�>�p�	@���F�"<mJƲs+�_���Â�^*��!�"����O��ᨩ�zȆ%-V%�UhߘV��ʬP�t�����jթ>�w#��{j0q��lq�b�#�=6`1L��PATK~Q9�߂��#��}��GPl�P�#�����SuP��S2��AO�#��ǣ|=�J}ϝ�YN/R@O�r�ܬ��!����;���eHM*-�g���e<��n��f��[r���,��K�;��W�z�CO�Δs��Q�K�;��l�O'h�o�_>wH���}�U]�xd��T��x��ʋ����ث853�F�
�r�L�*S���F��Q�ym���i�߻3�\��ӷ�����W?-�sU5��B���\A����4��n���O>|::��$�Ư��8�]xa	�o�dm���ͤ�Z8�4�%�^�A|6�]'���Թw�R��qʔW%s�瀁r��F3��n�7�%ʄ.�Ӥ6_��<��tB�HMk��>��6���G�x麨˞�cFhވ��K8� F�
l>UU���y�=��Z�8�����qh84�  	��]�cx���b,��0��	�9_�,�?�U��М@msE�ݲpu���񖺣��+�0�"14�4_�*F�qf]Q�n'M�,0�ބD�;i�����J� ��v���I�:���!�������;s`�J��Tl�Y�����i2�^��S_���t��<fx
m���6�U��7k�}�7��i{�3/Fn(!~y���/���[���.�G�Ŕ�
K�sO`��$�r�b�	c�)��ۤ_SFp��ȵU}���u�_���O�f],��c1����i�v_5B�ل³�D�z<��A����	_�S�>/�TC?!��Z��6���4�^sUT=q�ܪYt]"E(��e��J�1�]�TA0�X��{���V�����F9-�Z�qI���ɓwy"u�6$R�&h[?���X~����Dm�/�+95~$(�D~�7�oNm�x]{k,�[U�:c�]P�Il��{]j>;�<b�|d�UR�E2��t�����R7����з���1����:��*;�#=����������xA���`F���{��E�9��D=��fТ���1C�����tۀ��|׍���EA�o$Ǳa�o5�a�l��t��F"�~�ہA�>&��x��u58X�����yk�x��	t�c��+�	o�٪������7`8m���i}�TS����B�ױ\�{�����p]χ�6j+�G��5�(���"�)����>��3��cP�6��ǧ�x�z<�]r�4���	�J�ШD1D�O���Y/�7��%j=�ݰ��v�������3�4T�^��(}k�jV~o�����F��Ùʀ˚�[,���پ� Q�=��p�k��)j�aؚ��ט�]_�$�d7L=D'�|f��*2�7c��;��a})
m%�U����fBtF�7�Ұ3��uS�0t����~=�)�if�{��S���-�0�շ�`��a{A<��S�Xr�k��'��Ox���{���-�U187 ���y���5��F��1�V }14�)Y#�)�6$�˳����<�:�l�(���G����VȲ�u:I��--2�2�����j�޻|n(f
݋�[�=�8��Ȥ�mė�KՓw۬�.r�ܲ,�����vd}����n��L���Bty���Ej(*���U_��Wʹ�z�H�}���[G����P�uh�� nW�Su��=�N��K��F�E�(�vkn�����k�-�V�T��ޚ�fU�U���'��m%�?ޱCy��
�E�xQ�d�M�8��M㹄UzM$�s{��0M��7���F
��`9��i�IK�0M|��󏠏F���42�,sd��@r��`{�hT���+*�> �+ 58�+�\�\�xh���l�t�[ճ��m��5����%@N���:w��tC�;4��|��B(tX`����U}�걢!���Z��za/�����[Ɯ��r���觫?��'�	^�_�ҁt%=�(I->��9�y�^�D�}���, �0�aH5XKr�I9j�/�,餭�]<d</5Q1�՘��ُ[ ޼�k��gm���}I��麩�J�����	�J�Yr�y�K1�o����#��B��㿖�|=6�!��[o(�F�c���~�ܒ)��Z�:���Bԧ�16:�`ƿ=Լ��<��_��Y,���pT�����|�<�x]�L�$
z�/���Ц^�#��tFj�a��� ���|��{/�@��6���J�G�X]����cV��Q�ؠFϹ��Ee�J�Q������[H�m����Rʣ���B>_UZ|��%�>{T�K$�=J(i��0GFB��5@[�;����&��k~�u?�?���¹5��$)��]i���Ƞ#��)]g��să90�w,��P��'��,�]Jܤ�������Mɤ\��3/�����6P�HJQ�U�h�m2Tu��4EtA�Z���|���=5��������1k���	�\�e�kHe�� &���;��x\ֈ�Pb�	x�^*���}��0U�`0��,�C�z���A�����f֒�dx"gv�dճႵ��\d��Z�I�9�l�*�Pf$����kk<Իk�w��Y��9KNi�}/�_����p@�sM\�h2?��ՙ�(�h/EqO��HJ��+�ս��-��_:��?8���<�A�fa���[IܢbzM�M�th�T\���|N�!�.��Z8��Xc�C���6�'��$�F'A��U�e �l
h����p�0��/Y��蠎�f:mÝg�7��5�������YTb���6oU�U`a$#5�i�O�ԨɵrZwE��T��N�������s���Ź�I���M�:Wd~ <����eتS]�+z|�!���MA}א8]EA�N�j�M�"�������A�9%�E�×T~�)�����f��\ɤM�L2H�0+������E ���bes��f]�d�Lۨ.��[[2��T��:`�F�b�3u7�/WOٯ�NJ�1'�v	;?��
�:����[�sj��;W�m,������O�K;��O������1M�IV�8i����\��I2�άZ��Z��z�Q�v�_�2���ZN1xЈ߶)u�����c ��(o��s�����@M��Ώ9���sL���*�1u{�&t���s��^~��E�a�*�*+<k�HC\}K����HV�@=�M�,^�Um�8����:���@�Ԫ	�Ѷ���t�A����_o���s*�0�1nL���A���t�q�6���Ɋ�t�4��r
 
0��� [�׿l~��û�E�3�S�Y��Hn�W��X9��΄�j���m$�d��O�lN R�R����i}��*�yt[��X�<!2�%�	��	�O׶����ͧ��~w���71:>LA�WJ��{p?Fw�H	�ld�s4F����	s�<�M[EjD	���U����g�Mh�I>3��8�����~!Z�!1~8]��}����a���t��CF�ע��C��?�שmȽ�Lޗ�9��~�v*����PM�U)?bN���u&�*���#R� ���ͺ���s&}M    _)F�0��/�z�e�Q�Y|��sl$l��F��f`�Vy��Gi�5
�-�vs�]0��q��(`>���+pѮ��{�3:�d�s��;��44a�i���4@r&��d/MgW�}}�\ ���򬚍�
��|���=��tH4��)�W�yƲ�h<&'뒘�k���o���lR�I;K@<�,/�U��Qw**ռ�v�����̃&�>H������9��)�KL:�-�C?Wz~D;��IҠ���gvǫ�R�j�h������"��o�����>,SF�$7���^��5`�pP�8�˫]����o�L%���l�Z���t����e�jF� �S�� O֘�]�W!	'�
�)+k�E �b��j�=m�ɀ?0u(���VΥ��rݾ	���E�զ���KB�[�DV��N��4f?-`��4U;8�]��i͈���4��b�����זF����K@}�6�y��GN"��W������d�u����%��&cЭ
b�J�x�9�:���GO�aל�q� {�O�d�ײ�ض��֤|}Ə6�p Y.Jg�&���?�$.�j~�&"���
�@HĿ��R���~���gdͯ�q�)/*�_�)�T�~d�՛C��Tݶzo˶p��B�o=�Q:�� �i��I"�����|X_hm0lD;b�ք8�ta=c�D=�J.m�QA���B�TvR��m,�մ�z�8��>�72�=�:(�8�Lvp�G,��:��`���"k��ya޳�������MٝX\U�q~�0�̌_流��`�S�N6{�*�F~@ǰ�x8#��	X���J�}�݈�d���z��	��-X�EM!�e�,�y�D�{�����U�ʲ�Ӆe�M7�w����{1uW=]P>��DRۢ����ī��RV<g`F$�Y��o��$β��8d��D�P��埻x�ߥ|
�`�$��zכC?U�r-�%��R�Xs�':��J���8Pn�f��X�+뻲�毆�}.��x�ˇ{�_RV7S���L}.�$a�Ɖ�S��"Y�h������>�%Nw/l6��W���YF�~e惱���?�Ah�r[���Q7tv��ʜ�:��P@�lp�8�z��[�T3!a���-�_G���3�T�
w�W�	���[�P*|���G%%�Lp���'���X
��c�*�{����Q��KV��`�{>���y�E��T| s��V��?S����\ɄNEOb6R�tW��%��ӛ3�j�	j��$���:Ɋ�v�_���	MJ�kk�	�����]�1P��F���^pg��͉����������Ѹ�W����JS|����˝2��&�3�Q@lў������-
���MZZ,x>�V���,���ۯy|�~E0��� �blo>��bkYVo6p����3��P�[>���R�F�QE�-��/돦��gl�XA������0[`J��`DTn�v<�o=��\�_O5y$X��B���>�y��#4��F�� ��|L��x\/2�m)�{�6!����T��iVP��m�L�����ypa�2��`6qA尙&g���q�J�R��$^��Ey�+��Q�g�03g��}��xO�P�g<3��s��),�X%�jSC�T���8�u��<qN��Xs-Tv�sQN8�9
g�O�g�o���n�s9͑�v�ô?G*	���Hr�.��[yj�V��4}�O�QG�BL��wպ4�"�r�+dx��u���ȿބ�α��>��� ק�i K%���cm��N3M�u�WnKI%�fOʁ��W��Z����{�aZ(�Q����l�s#˙�AX޵l{���m>Q͠�4�5U�]�n�BX!�h�4U������P�ռj�dM�^�M��|q��6��ٯ�Z��@O�$�X�FVg��˦&X��4�}ކ�]��i�H��1ɶL$�d�2�Հwyo���aSt��+����ji��4�`�JH�L������bX<��0ϔi�K���Ӷ�a���ܓ��*��
k�t���R�J+O��H$?{���U����LyUxo���U��6��p��"�������W��[��o���
 ��� �nj�xYM|�u#k�ϵ�A���Z�P�ZH5����HC��Z��E� D^3L���)&Y��X���ߎtu`��
���w�x��H���Wt�G�����q���X���
	N6�)��I�o{�J�#�i(�_���;A�\��w���䗐��J���A3�YǷ��>�YLT=��T8zg�䳜�!v��rj�f�)oc���~:Ҷ�
u�tN�"�Z h�����~��*��g�d�"eL`�n�8�Y��J2�QT�nf��+��J�2�k̴��[����������i����b��D����ŗ6�m�$�o��p�߾Z�Ҕ�V��zĽ����5�	�/.��3�/�
@���S��a}��υ-��[e�%u�;��9x�8h��#=-)/V]*�Mw ��C�ߚ!��'�T�^�|2i��__xk,�ܛGo�+1�X�NGNl»��7WDּ�o����'��G	&�~�k_0	�af���x�O�+�^�m��=���N#Ǎ3g�W�|�]g�{)�^K���h��rg:#vӌs��Z'u�u�_"ܴ���P���L:���%}-��{?�7��LN�O�V2S>h��0�]~�R���'�}6u6CyVD]֎N�����REm�H�b�K�d��x���o4�r�_������b����ό��5�y�Ǣ�=�O�o&ގ�z}�Fz�S��K��晢uǤ�Kib������jW�]��o"�X�Y&��l>�P��?f�;����I� �������Q����	K*�&� ���,o��g��G�G�Lw4ۭ��b����f�������N��2��S�R>��m��%�,H��KY��A~^��cu<���M��؅� �І˻K2V푪�'E�3�oZR���:y4�L�4�Zt`�;=�����ϑ��h}_�t�b]B~�ѕbص�mTP=~Ki�S����&�K��<�L(���	�pZ����}R�KU�9h���@�����L�}ٍ�j��Kzꄘ�;-�ʙ51g���q�wL��:X��ɼw��U�5������*)L�δ<d[�ć0\�|�������w��١>��߳�g�Ƨ��y���a;�?|.n�h�.����|�`8-�
�2�恞���z�wz!Ȇl������`:+m�{l��M�z��0x�y�!�K����	��łc4֓��=�J�ƪ�MpK- �ap�Ƶ�X1��l�!��Lc�#F���i/����L�Q���R��4e�+w��쟏���O�����=��q��
�p��Ȋw�H�ć����,6�|�uq��;m�3i>�1Õ������b&�l<���c�H�g�e/a�QOC|�~W��	�YJ��|�`�ބ\��rVC�0W*&���Fz��`��h�&��i������A�]�i�3e��bO@/2	12<zl���Ժ �)��X�zO^��H��>+w��j2���G+�'5��<�U����|G�N��>�f����?>��M�]��ʡ5�Nmې[��Ȧ	h�/�YZO|�.��C9�t�ja/�jp3��ޙ��/]����lcT�.�Y��Lu�j��I_z���s���	_}ٵ��&�
���L���G٫���%�<7տ��Q����˸�r6��e�[�\�z�g7�$l���~P2�1<Y�(�Kͺ5� ���mta���5�*,N8�*/ia�kM��	�Ns!QJ����ɨ�=���f(m��ځ�����a�[鲸/�AY�Gu���qg�!��u�_�1��䀩��X��F4O��W���a1�x�)L�W�e"}���%�H�'>���=�M�-�_~�Jv(��?�{��(��֡�[|\%u�"���_eE��������t5(x�6���G[���ŋ�R3��[�2�w�O��: iL5���L��N��k�3%��C�ѯ��O�5�f���|�.�G )�ຝ�E��3� ��u6����w�c�#��.Y�t��F    �����}���V�i|!v%:��r���x��\�]LL�(���� �>�C�q���Tȁ�M��g)�l�d^�T�Cxڧ�O�toF��ӄ|"�d��a���'�v~��C�d{ĉ{��!�wY�P=�|Xh�.1�	�N(��4�d�k9��?Sp�љ]=���ܼ���|\���-�&a�j���1��1�Z���BU���Y����/�1�J���3 �XE�/o��9�&^O��D�<$}T�~�-!��K���/?���gZ1�,%J��q��5�g49A�uNH�n�^��+)����<{���� �@�[C���F��
����g �v�ᔿA�n����h��!���&�iM�M+!�����V�oO�<  W�p+n�G�B����f|`t-�q�W��*�Ut�uZ�oq����ɛ^j��&�q���Ͷ�xWz�!~�HC9�\��0���&�e�Dǆ��dٞ~���' �ӤfŒ^(~���^���|��wbjɿ��r>�"A�2��FlQ�.�z�y�S�,i����e��mԶ�7r���`n�u�cI[��,o�����2M��Dj���q����[����Yq�I1�qcO�f��T�{{jh�:�R�";� 8*L��~��/�E=+b��Շ�8���[�h�k����o��!5h�������W�c����O���(�����0]��:�|Ž�G(�2ܿ�e�W_5��oZݷ��J��;����q�դƦ���Jk��~�nõ����F���6{�����4g�ħʱ�������I3_%�.:��7��"�@�+�L�$�wUbe�ٳ
]�#�������P��.-b�ǝ�C��PB��m�Sk��뷇���������z��f���8WJt[���Sn�o��2CkS�!5pUq<F��1~U]	�c�paTf��]�m�Fy���|*��T�o^��Ԃ<q���2Wd6����\�����%�Ky������Pɗu�� Er�[���'�����A��FW��`ũ�]}nW�T����f���SI��`i����)5ק!y�_�1Mɕ�i�/杓$ŤG��")�Hz�0C����� Z���q���������{��o�#uK�:(��z+J��rb��X}cX�B*�8z���!�Ì>�ZdTੁ��{���r� )��b,�2�j'�  ̡��UD�X.��S7sP#X���d�lආ؀Mz�S����z����`���v��(G�����6b���ׄ�>��&L�9�VM�],05�9ʢ�_�~�S�W�������~����D	�)$�S���r�<���ے��{�z-B�V�:���:�s�$�1=���_���,�a.��O�R�ֵlq�$1ʫ�r��za�B����.��![��5�g�n�/�T���z>`#F�K����*���
��^kW鋙l�Ǡ���]h�t0n�����v���<�w#E��hK��W<��_��\�ՠ���ڄY�3 e�)��Qj�xQyF�"�pZ�$S��'�F��<��L��YFx�&|����-%�3A՝bX,�;Y3���ש���H/��֠�\K�W�b{�� *�mx�_=�Z4^���WP�����?�t��\#j��k%��|�:1j+e�b�'�;O�s�<d�S%���/%_�%%����U����N�]9�?!	+���p�o�{���fʡ�<M>�}��$.��_}�W�]�O����!E���dqK�*֖����mْ!�k�6�<3�)*����%��/��b�CSc;�EY���34�N^�=�}�QҺP+$�4�E����󸰑(����ةL��p���X�$�fxU�] ��:nz�F>`��2O
�y�%O��UX��w��*]�y�	x>���ZԢ�<�n�7'
�쏅#k(��l*�\Z��*x�"�.�������
�=�e{7��O]4H�;��!���D�zAj����.3o�p����Un�bi�jbU�%N5���t�g�) �g����{��� �S���5nP:��uQe�Ezgj�nL��>��
�c̛@�dX橜��x�Ӗ�V�`�����:�9��@)���u'� >�;�����>���ݗt�T�9����,{�|�	O�64l��ǻ|��l���I�QF�z���J^�:���a(LITk�E��8�Ӻ���Z���u��G�.E��+������-�={�F��c��1� Wjq#^��z����c:J��οz��se��ŎW�
aD�͎�?��dv��Y�>2G�.�9Pq|�h�v��:��KF�a~k:���x�_���i'��\3=��˼j��H���<��&�����Qޒ"|�N1e�/��r�9�I@�~�v�[ߥ4:�cK�+�x�a2}v9� G ���F�;|<60�����D�HV�v�p�NulVgO�U��L��t�~�0�qv���<�{5�Ñ����t��<%?�kt�����~�E�x�ȉ���j|POP�:��k^�J,/g��5�J%���4�^/�������7�ֽoǾ���������om�?��j���>Xr&�yI�s�^����_;���,GU���l����7���g�i�x]j�����K�fh�CQ��|Q�x>�?��Y ����.T�Tn0/[\�w����s��J}^�����=���s8/>Y�Q[�?kvR+��A(��;���
�L�Jz��.^��ь��e����~�+a�<�j���]�ٚ;y�k������`�_�w���cҢ
�jSA��ol��IȎ^u�4�仲z�����H���|�Db<�5�z�H1$7�S��P˺�K��ޑa�����3!/��"�4`�?���òn������T0{A]E�V�����5f#�7q����G#o��4]�G�+̓�5����B�٧L�n0=�5YmX+��W�cZ�p��G ��������ra��'�p[�F�!�`ݢ;@+8
��Y��c�Ro��s��3#�W��!ڪo� @Zqxo�źr�_OM�O�DQ�W�'{�#����JUŴ�X0T|�]�U��1dE�~-w�S��D��و���>��f�9��s�¼�8#>�5_6S��/��Y[gR���6$���Gf���(���N9�w��Ω&T�Nm:"ۺiap�Y��͋�'h�|ܔ_��� �y�4�z^�q�o���H�ǯA���^�4�S*4�04�z4%�����r�9�u4���~
]ϧ,�tYͅ6�%+?���Iә�/����9mD0{F��mmk�e��?v`OQ��tZ�BM9��-q�Go֏E��cq��t6��g�6��)�l�!ɇ�n�+ۗ�u���x�ź�u��&�o��^K���>����]\Z4���g���B�E��$����"ܣ�H���P��=-�7���y�|�^�z~ �%ʍt}�
jA�*�{/���@��x��л3p*>���'�M�r���;-�����T�$�%�Zk�v��kFP�_ޠ����fkm�[���Z�/�_��H/�3b���I������~h����nk�'6���̚�������I׏�@�3�I*��V�!]I��2cw'�.`�E�ͮ�G[��U%���r�Z���hj�D�TĩA\������[�*E�����K�|�0�pŝ��w5���Zr��\"���\�=��k���7>>�E���O��T�$�@}����P	H�n��ed�"6`�P�D�U=u��8��#�4v�*z�<+c٨ i1�Xk�?r�{23���n���ְG���^c�@�����+��X-S��4��z(���o �������^�3��iN�r�gJ?��6��O>u\��*װ�q�U�Y0Q�Xi�z��Pw@�o��EK���Wc�}�p�#�}:�9�<>�f$�a{����f���-���rd@:`2jdT]�j��2zkI����C�@H=SWGʓL�w�-P[g�r�P���C��{�V_^H��u�Pey.t�N:P�Z_��E    �v�KJC. ��>��K��xG�(����#���F�Q�Q&��8ư���Z�f[��~{��ʯ<o�����j�r%ezT�.r�0���uo�ĸ�d��۟�wz����c��}'E޸�H�ԧ�����q�D����.U(	@&2_�GB�L)ݸ�g�	Z��m�Jh�!Qgy�^��'��J\(�9HS�bF�c�n
R;G<4�@�.ĻՇ�O٭��@��*���"r��A���[�ɡVz�QQ9�u���;�A6�%�_3����-�w�O�t��j!����+\X,�;aړ�BO��Xt�I\��#W�o�����(��$�Ԏ3��L��n�5m$���!�Ϟ���]�*�U,�B<��:��)h����b���.��4�A�\?r�]�'������~�"[�{j�vs9�X�+XO�"���J�A�'|C�i����M�#w�!x���k,��w���T�ķi�j�˔@�x�\D��X�)�1�$!e�� -�[R�v7 �jG���M�l'y�s�5^k�x�d쁄:V��j�a��J�~�W�N�|���
-�vT���t�{��_|�����b���U��=���%��ǌι�'A뤬�Q�{��9(CB�YΩ���9��g|�<g�qE�'�̭�0��3�F+��\�N������3|ao�C�g��uG}������^���k�·��Z�Z�vy���~1�AJ�b��Ilt�]���C��<30��	�>i������9�A�{���xQ|�,�	PU�7��eY�a[P��ͷ�I@��zN�&VNC������33 .b�;�D�*eH;EC�����"�/<��ي�Cm`�����h}������y��������n5�����w�r` �)�P[K)j�R ǒ<�O�z�s�{4���Wb���}4m,�/\�?K$V
i��ϲ	ʌ���%pH�U��B���\ �by�2$U��5��(E|)���Ʌn=���d�md���;C0�G/�Fb�s�u����ہ���-_C��hd�}���l���$-Pz"qd��58������U`��*>������X�&���QOLZ�,H
�f����[���F�����!�Xh��Q�D��L��@dC��O}2�h�S ���l{01��'����N�u!ep[[��> �Y�g�C�)�������.̭i���<	�f OB��X#�P�2��|��x��N�u[>:>�����9�ט(�GJe��+d����V�效�j�\;�̸%�'��x�"Wq����끱�$�!�Q��=�if�����d�d�C��(�9�Ňo}����ՙ�*�l�`W�].�o�y*���KԴ!֢ҖQ��<��=�ny�D�v�6��~i�{W9S>�P[3e7#��n8!q��x��(�F�y��i%	K}�AD7������ܛV�Y�w��O2��5��(g�]�M���5���57J��!�Un�u�Tл�6x�Tѯ/�PcN�ץ��ME��N�o� ��z�}�&�q_W�qЙM҄ȂW-{�D�rQ��u�~]�yW#q8i{��S[�	��輪��+�4O�ÏQ����+�\kp�|zy�=d�k`mn*��^��S������(`��gQ$��RZ~ 52.\g^=h��� ΠX}��Q9��;�ސ�S��	�V0�(x@-&��gY�&�9�L�/"<��|��y�bV|�j�U�(Wy�z���G��1���F�/�ҟh�=�O�D� �k��=H�3�A��z�u�� �@`�;�:��V9�M�'Q�:�A;h-!�G��ق6i�Z`@��G4�����aP"z�1|��7:���$��0׀��Cco ����-�$��Cj�������Ʉ������4��a�<̓��z��gԽY�R�%�Ͼ\���*����(4޻�s������%���9u9�Qʇ�a: ��?�3Un(�Ɲ~h���wo��^�M���̄�X����*iٮ��|�}��eb����@Ƶ�YQ^o�����<�����vt��1c��uَZ�-8���`����A����~�����{�d��d�MmF4������Uy龹_wn�7�����&����P���V�����k��/�l�����2~_=�����:���[�ZU�u����#R�jZ֠����ŋ�"��y���K>�X��O�7�#�-.
"u��u����B�B��#R�8�/|a���B-�U|��[ۈ��j���	Q�[����;���|���)fiBߕR�b����qz�iߔ/�L�6������*��$=�Ez���r<�1�MKf_/qZL�ܷ&������2���v/w�M����ɹ�/����1�L������Fv�:M������dt�����e|J\Hh�HMe�ގ�8-s�7��Oӣv=��p��g(�J�K�2V����ѧW��g4md�������ֺ�#�GuZ�+��Q�NSS���F{���K"�fzkq\s]���=T��h��4��=%�Gʙ��W��}��o���-�Y�߸s�n(~%F=(�&�9vm��{v����cPڏ�s��+|��a��.�2߾ѧ��>h~�SG�:�t��4L�����J��~�]/i�@Q������{x)���Q������A��rNnk��$�e1�}.~�Zt�*O��]��E��}�"�*��Z��bލ���x:��h�~)5Zk��o(��1�U9�v��n^h��,�М�) ������^�r�
��=%Q4-�ͬ�_�8�C�}�SR�T��%:�,9����8M�ڹ⦞�`�$U�'�����H��_<.�Z�8)�����͐�`~��)8<x$������D�uC�Yr#%��̌��+� g�;�eKSȴXkk�>�vY6��6{�E��s4ȯ��=�(X���F�e��+j�|$��`�cl��-?֓�붽k��Ҽ���R	O;L�Ͷ0-2���c���ؙ8.��M���$��e�<����(?���
F��HĹ�[�	�+���f�Zb�flN�P*t�SM֌��>s����:���W�s�6��w�hc�ʥ����o�FQ��e��W�6n� �]��'���Q��,"��}Ew-w��Ki�)Z��2����K�JG��x�'�D��lS���ȆB���������f*���¯���fa?����~��|үH,�A<ZLq�M�R�9��\X���	׼�Y]xp3@�(�'6�ڃ�]�S��X�&Ȭ��9����&���E��A��y�Sx� �iZY��#m������% 0Q��σN|��������$�V+���6C�l�"�E(�r��4�cg5Nt�@\�������(=ʱ
]#�l;���p���~�D����^IKc�^G������]��#�d�t<-��(��uRS�߻�p��Z{�&� �X(��0�qg7�`�O�{����l���ف��x.���`�sAF2I�X�来��^��U���r7�;R���=�=?m��GA�1j/�tZ�`��<*>��$�v�.���"e�5 :���+���/��X�����#���ig}~�f�bP�~�W�5��IR�b��d������ب,�@��K����@m���L�Wk~�P�����Pe��EΒ�ih���7��
9O���v���ˉ�hH��U����&�n�K��@
Tr q�i0'JL6������'��#��Zd���W����C���F��돕���<k�Ϡ�W�}��t�/�X.��F����ӰH�Fk<�:��+��5}�4�[2*������Ϸ��^���&����
)�FJ�@�Yw���om�g��Wb��8�#��Sz��;r߁;:<�����{9�>`��=_= &l�� ���4W�48�K�u?�eX�[�N�=���"9�WL��k:/5�0�*Ф>���1�J���`�ɽZ�ãA�t�o�;�y
��S�n�(��:�憩Rhћ�qf*��pk��gW���(�X�`����    ��2��1���g��FT��Z�V�B�]R=Q���k���[r���<����gͧ���b8#N��'���]��K�A��`MVx�R�@�/�A�b�K<_M�����O���k���9q_�c.�v���
��>!���* 4��0�+%s�q�_������l��"����`��=�r~<FV�wwt���_��ǉ*���Ҳ�9J}�!( �sH��7�X��x���ۤo+y�y�,�\?j�`F�t����eh\��×{�nC�wf�� �)s���D���/~j7*�7��}�{�`j�a�Fr�>���NU��v@G����C��Ǩ?}�������L�G��������/�ߝ�	����0��F�JL0������iVIf�s��������{ۖ�e����7W��� ����¿��hx��cWa_��/������U������<��J��텓&�_�}�m	�
����y���ֹ;�6�i������|���e�V,������'�����]!n�
T�����b��!��P쿡������ �������E��H����1�K����wI>��6�,��hr��9kzA#`�,���l������� 
��(��~���nQJ�{r&�D!����h�ۂ6E|;��ߜ�&�����9�����8_l�唸o =9Db	PH��Cc)4�i�F�e�4 ��_pQ�Q�EX`0<}�yeE��=0��c�����+����51˥���M1g܉!��2�<�rA�ݜf
����A��˱�-!�Oi��b_���fYIbW��Z���m�O;�ϩά�,�C�N>Ҭ�����n���Ct�>����f�|�}ʬĊ6J�r�J$c��>�"�7����J�*�yF��s���	�9�'V�����;d������#���a�tH��}H��R��:�o#�����|�=����k����N<���?}�01F�%H?&��A�b�t�y06�:��c�b |$��΍�@���ceya͎ϕ���g{��&+IGZT�����[C�
XQ��ZG����4��o��#���h�Ed��<�o�~>~K )eg�R�`E�g����Zϳ�qM�׵
|�=~6�C��N������H���w-1p�*� �8��,�pn� �A{��N���Ү��s=A���O�i4��|���S��:���*���X�b�~7q{��<䎯�>]>S��|���)�Q��?Wo�R�~��?�44��O|ǿ�RU�������7�h��Zk�:�����@��+���b�'e��=p@�D�c��X0~�{��Ng�}��7����+E���@__l��/��/g4�c����������?�?�]��������/��dc������?�ُ�M�����t��D�h'��e(`?���*�Ă�g� �;�zF�1>��d�����R�y��}9G���>��6 If
�c�CpqF$�w'�.x����>GY )���%�6o}����r��:T�Y��8'��Pwh��O��k���xʦ&�O1�3���P@��>>�]�����?�5�XMP���;G�ԓb�O��i~<��?}n��N�C����� ��;`����?��s+q��8G��� |�&�?L�A��� <��¤J6��5@�;��~�j�� ������t��Ʒt b �l�G�ӧ��|߳�_���z-�t�c�sƑ�柚#ο�����}����p��RZ^���g��;y{�����϶KAC}Bh���?�5������I¾?şy���w���,G��o*��8m��|��#���_,������s�������Ӎ����zq����/���U9�c��')��@waF����11��-���߬c��o}/�</gx�7�-ֱ倚 ��~y;�u�`��MΥqV�h��ݽ�n����������x�7��'F]E�j��&u�Af�O�N5&�'����C���,X�t7�9��󭀳���V\m�a�'�0�����Z9�:l2��W����4i�5A3nQ��+fdc�Td	�Ag�/��KϘT��([x��� ��b\��<8�X���I����Y��G��#���Δ�;hf:�Z_3�jr>��S����K��6� �����0�A�ρ��*�eVS�[�R]f��'�K�[/P��g�wE�y���83d7aY������]-I;Q���]���Q���e��H�,T8bol��
4��؅�	��m!YR�Y�VV�R��.�hܼ %�����2�]s[���l�j�@����o*�ާ#G�սϝ|�}��k��p��e{�c�3�.li��vߧ����B��-���Am��c5cu\���C�
��>�<v���G�bbsQ�}W��={�w���ãX�ô_+T[Fu����@�oOU ����J��F��Z�c9���ǟX��T������ �KӨr=�iMZG$?�U��9�*O^�l/ZU��Oٹ��4�_����q�����<��y<��P2^���@3 ��c�i�4�(`���|W�{�S�����d���[��@ڍ��:�,i��C>����:o�����H�<{��/��.ξ�����S�E�(i�A��\"6���{wW��U��do��j�,���	~�e��k�}��ڿ�=g	��h-Bg����ӧ�?�g�9w��,����vA҇<�٩�-^��{4n��؊^q)Zu��}�~I�1Wy�+m�H[���.�x���y��͟O�����|��A�u��J�s�~Q�Є�%�G#H��1��=���M�!j��0��K�yΣ�+Η�09UV��d��������P1�Vq���<n�=`�ⷳ1r ��~	���_�c�h�㚐����][s������6u�LN�����LP��ϱwU����M<d-��D�!�����T���h%��w��bG*m	�טH�]�Z�9�I��@�?���/�r�_P'<���ƍ1u�|bw^Pf9�,�76�W��uٶ9r>���e;�ĸ��4�nĬ�v��10��;��-�����E����it2|>IEDQ�-�}�+���&9�O��/}��ّ$$����ZN�V�������.�QF���s��N`̨��)ϼ��Q���*��ϧ}�*F�����"ޟ�[�2qz���@�2hIKB����X��>Q�N�dL��f$*��[f���nqi�<�!(ܜ*���I���6�N����d>�|�o�PG}Z��H��E�bM�d+#��
n��t�d���V�q�5�T/��F�Pd�ۗ"x��9�����F�,���}�ao�����أ�ɻ=+�=#�$K�	R��
��rZ�ې�1� ]Q�6�%��'Vtu<����YW]3"���9��[4����<�%s��6�d'�=s��]��s����@���LG�GJS][��{��r��T�����K����.��~_(�?8�3����iSjc�Y�v@;cݢ�/K�٩��m����
,B?����ߟTF �����߯�/�,��,S���%	��X$��ߩ� `�w�i�w��r���i��h,8Vt��JD�t�a��<+���꼼�����R�0l��G��2��#nLw�j{E������ڂ��d4�HN��S�E��a�a"��HX���{�`�`�yR0��>���C�"&��y�U~���hf]�d�)���8E+ł!��n�G:۽K�1��}$A79���3�����=�ŚۂjΑ��D���:g�	nn���lU	tg��s�z$� ���*59
�M&�|4��[	s]p�����ub	��SoNY��:�p���ȉ>5w���¼���9er:���s���EԉZ1&�c��xJ��J� ^*Y��rכ8��l�y�Z�	��:�X�km�b���>�.�̓�#v.�� �@�\;_֐��<Ǎח�;	�hii���8?��.�df.�2�-�/��g���>���W�fY.Oh�(َ{��    ͳ\��mTO�y�LV�������2
�3��{C�X�P�U��a�&LA1x�����fn��3��p=ٚ�����n�4�b�"���9V�!������E]Z�潣��%/�&��D�r�M���=���~⮐�:��8sȕ�X|��$�G�Y(�ã�Pt�*���;s��<�Ū
B��+�؋cb&�#�/�^���Pw�7��(�_(��+t�����*L9*����h�%��KH� �K}?Z�v��J%'h��$�E�`t�y�W�6��Hm�����JkF`G�����4��~>_#n� `�{�0b�]P@�]��A�Dnk���]��[��o9��09Ic��ru�r��&�	I(l
9`g�B�A��T�*_�[�p�d �e�|�va�Vy���3����m�R���+0(=@*+%\&2��e:��Yb����P���K_&PX��P{�������~(��F=�:*���骋.��&$�+��l'z�D4y�K���ן 1��%�2>�zE^Pǚ�.e6�a:�3[��4e,�4Y�����h���	������.Iwcz|L�a�SmЛ�n�

Z�jq���E��RgUF�e�m��u�0Q�<}�� �>Vys�3Z{�+^�fʱ��~���d�<��[L��|fRD�y��q�w�ý�� ��!������Đ����m��$�{u�;�c��[�{�W���������i[�I��x�IC\H8�^�!H2^�Y������ӝ��rf�_�s���E���v}��Ĉ:�co:�g��Vk>䋤��ى/z�2"�=>K��=��JÕf��Z�R�]�9s9�@]�������Y�O�� �����OL}�����컁 ��,�ܵC#72q$)�Z�h���_@E@oʗ���-X������Y��h%N����/�âQ�@�'������hL#Nw��w��k?�j3WVSr��֕�$��+�"j?ݦ����B���U+��ޙ��E���Hݙ����y�W���Hʐ��^k�__"�[��}YU��t;�-����I���*w%%�hx)ju۪�4�\}*��*��� �D�F^/U��!�]��`��#�͡��QE��@1���u�Q�W]
rPy�w�a���?F 4vf�,;ĕ��- ����6gx�B���E�����<�^k
,��2D?|��8ӬE�8N$c�ݲ���vJ�/�a��`H5_�r�kI��窴uL M��`C�IKs�k�GHҴ9��m@d7�WEB�{�ՆR~9R�Z���\��٨��!�u�����u�0��WZ��G:���PIƖ��Q�(��L�+�ȸ��K9;�����Q �^E�-I��y4����J�?�o�fg����W��Y&%�����^fSk�\�<\��v{��0W�n�-���Ȍ@V����D���?�"¬����Fd�[p�����6���/Ε,lS��L�c@���e����յzhk��׹Ǔ�A,u�n�:2�{�o�z!hrjO��m�-�&âo�튎�_��m�H5���oR�o�>H��j����6���I2IV[�՘+��IQ�}74��Dv�K��6S:�+(��(є�u��hs]M�������5!���P�b��'Ea�cv�*�e��mN}a���wQ`�|�-��'/�~��4�g�j���ě_�L���߷P:������Ȋ��)��|K�#�0RrD�S��Aٟ /�WݖE?�r�ʓ.����s�
����9�.w�iA���d��Lu�i2�$�/Y�_2�b]_՗%q��X��k�?YZ�&D��CN@�MmXV�c�S6Q��͂�U����*�ً���[��<^�T0.�c�t���ڱ�]K��'��wu�v�A n\em%�o�}MA�����>'�M5toC���"`B.ll)&$�^��c��-�P�c�6u�9�����u�s�2f��������:$�����O�6K����,�
���1G�D�fz�]�#�(�-��f�Rel�k�-#��F����.)�x��5K�����ٟ �e.gz��{�������zJ͍{?��M��?d0��������>��ir��h�B��;��/��̵M>���������8t��~��_DV��# ޻n|;����3u�N�\,]�3>�;�}&�qb��@y��aV�p��}�!~���<ƲLZE�� ��H���}���FO���G��\ӕ�d`�O�����>��f	c�
��U��gw?�A��2v-�ǀ�����Z�vy�MXlj�~6�*�A6s����a���pN?�v[�Z��|���k�ja��ѵ]�ȝ���m2)���a�(�@R�|2�\+�� ;��C(�\ia�/�r�z�핁1<c՟�]���� ����H�?Ts_6�#�G+R��av��L�#�V� 0��`O�C�[�d6��%��֚���%j_�ˀcW���\�s�w�����h��QW�a����B������Zʼ`�#�����=���X��˳��Q'4�5D�AP��%h?�§ݦ'�2�����^��²+
A�	҇f�'�T��:��D������%�H���y�G"�������9��2OO�+>F)(�X�˛�>�����1EvD�� �6��0�$��	��h2}?��r��9�����W��J�NwBGu��\��lV~�6Q�W�+I~��'���E<�p���b51,��,�8���qw����W��q���5Ŭf@�9N�u+� |l3�u!�sS���Gs@C�^U��ft�a��Z�IV�Vl�
��bds"�Mj]}�/���r��L�V��M�����5du��d���A���Iw��Bh\�9Ĺ6�-\��w��J����[����y��{>^,g�ڛʢ�k��tݩ�<��x�j��	���a J�H�h�7��g�.(NE߾@�)�r��Y��G��I/I�0��N���/
����|az�k�G���R��&�ƥ��x2I45[u�>}��N��A�����qULc^u�q���c����&2��$D|��>�qW�a�t��eVL�B����j+�wKh(R��j�߽闵5iX'���7Fx'�$ad�6u,{��BK�?�{I&�Eo�*�� 艵R~R|��#�V��\��Y�����ɤEZy�?���SM!i����ൽ��A�� Sl���q��4���@:��J;Dd����lA�k��([P2cXY=��x37�_w�;g��ߊ��,�*�$��Fzm�l~��V]H��O�D ��"o�9Vb@~O�b�M����)�k��c����֥k�*�>.I~2�~�Xߵ�D�0�9-�va=c���!~�1�uN�m�v�G�8s�~ey�}Hr�w9n�]�E����IC���n��<��&[�Kz�~5>��IJ�b����2�:pFbt�'2���� �v���a�_]O9M	8��G,�B��K����)[e�	_�C�Nvy($�k�7��ߐ�Q��;Z�qB�A���M���������N%0MG�dG�I��x�[~���;${���>`eZ�}0V�IK'��(���3�f�������ޠ=��Z���J:�ÖW��_�̀��<{�n��3���ȱ��ܖ�H�[��Ƴ=oNkc{h��S��Isq6R���__]ٶ�&�x@��2�biWT#�}�W���&X�k�n/��Q������b]��^�J�I~�����1��j���,�i��<5�	��od�a�)I�h�0x2�j"�<w���` ���{|��v"rV^�ֳ'^�	ēOc`���Ⱥ;�B����te��D�s3��q�O~���s����t��=�s�a�4��6rx�ف�� ņ�����`/u��An��W����0Lw�.�Uu�.�|(�f~h:ڤyLF�� �)SZ�4a"i� U�V��Mp���'��<zi4���F��@򀭺��ӺDM� �]�s��E|r�����Y���,_��ۓ����b.=�9η�W_�P�*鷧A�&pi�D��|�lP��P�O_@���'�c�GU����e�r���p�O��-��CoF$��:k��    �s�(����>;�@�ʧ��ۃP�ȱ�`m��f-��DVF�m)N�kO`�`�	!|^P+�Ń[�(�u+����j���)���A����fXhR����Z��ck96�d=���N��W��t�R�?m�]���_����hk&0W<W`y���ʰ_�nէkQhW#^fQ��nH����¬�@����w�l�xۏQ1q�9�p�7}��բ?�j�Yl�hl�}��8�	�j#�+���(o�c�fۢJ�5�#��N�
�cb�1=�}n;³������(l�_�(2V�H��`CI�̮��e��s <Kgb�4��dj��A`l��I��"�B���׃���v'w$����e=~5/@�Û[f^���t����X{�Q�Yq������/eC£X��T�O�q.a��l�YW`���|oc�#~�.p'��P�Y${'�i�#:�{(�\����۵��<���e�� Q`T��{�O6����C~�\�}���`�r0Ԩ���s��׽�W޻h�q�-�7�G#�t�GJ��{�u���<so�ΨU>}vL��	:���~�謈�B��=�&�R}��W��怍O�]re����+[r͐��i~LO�X���|��^���0L*gG�!ؘ��w|�\n����������0{�[D8wD��y�RdnL�o�b3�9^�,�o��cCh/^O_�8M��-fY��F���j7}�%��3��=B��<�W�QXȈ}��aS0�_�>��Hӷ��r�y�z�Ί�y+�ޣ�\����}����
�ZlՕW�G��9�����/�9��r)h���w�빉:�|A�9z�W�t��T#4$wa}���6���|;��������	���~��[^�*֜�Pj�(�F��t8� �:�ځXC!���3a�'�ލ�Ƽz���
�,%S'F�.���Z�R��f��%V[�gt�C����M��( ��)�!XO�)D1�B�u��m���>�&.셂�'q�QH��̮s�2�������5k��'Ǧ�9Wl�Wܪw���w�vTP���j1��9�!�An���0m?ћ���{4���r9M�t�L�juK�]�qr��n7=���r����١�1O��(�)���N��:T15;	�o��Cmʣ,P�[��ڪ�(M�o��Dם���A�Y�?Z1�ؿ�G81�O���w'8p�9 ����"'��Ϋ��Կ�����Yч�Lﯺ�a���X�L�#$���s$��a�%�^���_�H~���[�4-�����a[��:�#�n(҇ȸP�f2��g0�^.�>/������$�g�>�Vc�����%Pb���Amu,"���;P���e?
Vx@_a0�x	x
� ��z2W&�U
�������3�������q�h@�������I%q)�QI��\ۚ��wC���<p>M~���爩6"3�L�0A.3�dA��q�Y���LTO~�������(j�l����/#R����XsV��y@�fH�`�aF����}��θ�6��U�R�X!f��*R���W������|䑅�0�5����k�GQe����;���՝E�z�c��``�Zl}D�q)2Y��P���qD��6߰�'O��$Y�}����ʁ/g?��	7!I2l'�/%ݗ6i�ԔϢ��ĉ+�0?�"M��ր��=ۈ�"��`��ڏj^��!]����,�Z�%8j�o�a�7#y\?��8_�rE�
�7�[���j��"�m����2B�?s!�]���m,�+Z		!��F�9@�m�f-�!'�i�>iÛ�����qej��O�*�,pcO���},,1Ϣx�2�Y��^�r�z6揱
���Ђ�MH�Ӈ*��3Q�c+"����������K�͇v������V��ԫCP^.Y����Y9Kz��ph��;��D�4���2��}��n2pvx�,Wa"�a��&��P�iEJ�l�>�s��I"Dte�榈١��:b����k���Z׉���>�����[�������U�Lk���|�SY���H�i
gjf�ޙWenQҪB�d�18r�*n�������cL0|����E�J{N�}��	g����Z���~��xg� ��;Qnf�}Q~G�90^��/��1��<Ҷ���XxЪl2ٶ΀�t&a0��߬bdo�ǆ�p��/#���<^��"�վ�n��"��	4��vQ��{���PE�_5�Ӷ���}�VZ�B��<~n7��Ŋ�T�3��9>	�}��^]�;$�vߕ.�黺K"(��aW?6��>�Qj`gI`��ǯc�#��Y�O����M������$$��IA��P��X�,����[��M�G�萹�F�E��h��4��W�Kq'��畛�(�14Nbs�V)DFu��<�N����ql�f�����წ8=.���B�W�j�Y��>�^�5�S;Л����o&,����^j�WN�z��X��
�Qβt0n�G�,3��v�R����%��-չ��JkPW����膊��銟�<4�#τ���WX�{�N���Vs,��edy��9RNHNwq���z�[r~��K���5�§"̯UiF�x5�W$V~Gcl1�7f��+"*�u�������T(q�~��̔[I�j?�k����`�~�c*9�Fz	�MR�������}.��4�L�e���:~���b	�%[k�vZ^�����-��#nT����Kd��]ීC�نB�Lϰǀ�T�?_�����	'g�r6j�������������Ѐ���2"d^o�^�RzK��0@�&��	4d|�<A�x�_�ijz��a\���Pg݅�g�Ǝ��~~���W��Ƨ�41�p�����EB�����_���Y!E��mLx�������M�-gӅ�mU�`��n!
A�I��O��}'�tS�m{( ��0��P��,_��cGSo�����uO��Uo �d�V+��
�3��y�v'�Z'YT0��8���Z�sͬ<h/�+������a`��jlc��nH38}A:J�_��b�n*�/�	���s�V[㫠����w�ӄ���H�z���v��}'nt��55����w���`vRAkB�eS��^ss�����Ш�ƂiG���N������-F���g�fF����,)9�vÜ�v��G�r�T����lXZ~r1g�A!��<�����]�8��!+�;��dwV'Q����u'@��5P%6������񦅏ԗ��|y���� x�	_uO���3'��m}��Ě_e��b�ОCߵ�y�A���8�_EZ�<A�B����q����ꦉ� !ct�Yؼ�/����~�cxX���Q^�Ul�z�
�W���[�b�dw�V��k���1~_�3N*@�`�H�aL�7���␳����uv�{^�{MqXW(�D��b>��N�:v�0/qq��^�W
v��3�9X(��S�a{�XEOö�,���oj��s�N7,�J�}GqEv$}�
����m���?��}H��\��EeCPKurH��I�U,RS���D�U�&`&z�t'Q���K�y�L��Z�*���&�Ιڮy�`ӛA�Pt�/��wI|r��L�,Z��p=���Lc�[]fҟyK��:��J�/����G�ʨ��*��	|�<q��w!��"'�#<�s?��n�c;z�����I�g�K��D)G�~�x༆�O�I�>Di��_��C�z8�#����Bq�SӞ��p3�7���	r1;�����k�y�?�>��9��d�؃��$���v�C�>��/�t�X9�OJ����5�h��ӷ>~}gK�l�>������5��J���F��&��
k��z�*�C�"/�ܪv@G �X<S�X�M��l�C�D�{��Ȉ<?��a���ф"xDFq�m�U�,�=�*�}��#ެ��3�ѳ5�j�N,�zaXcj)א�����s����� ��bM�fjN5?3SdEV�)7��B�K�AbF��	�^������|+C;�����ov�DȆ
��²@�����f���zq@7�1S8���{�b�    ~#ѲX�獠V�"}���(�>�ۮ�\�W5W��ϝ>;��%��h;0�N�G*eUSɆ+1�<�*�揣��q�r�,Q�K-�:ok�������H=۳R�3���^��:$
(�L`����}L��TZa������v*ݺ'�"�=�߾���ѻ�d	����Ї?�Jz����T�^�N�d�X�U�Ki^���R,`�w2��K�s��ʖ�z��SSPr�x�r��y��+�Ud�>1�6��1��V�8l�c��d�r��J�J�� �>?�}�җx=�B�mT1`~9���I��
xR
��>4H��`"}��C���Y�Տ��)3�w�:n���1�k@A�
lג�;��`̏`*M���#׬}k�]J�S:��[ϴZsq�&��*����X��	x��WK랓E�i�Q1G��ъ�n*��lj].�[�ȶ�iV��� h�4G�A:�- �:$ �G�S^b�P��u���]+>;�����V�6c�a}K;5i%�\�(�``e1��诫|�/�o��Qz�J��w�#;��$~��{#���q`K{�h��hp���0t!F�e�+�_Vθ/�:��+*����O�I�~�|!F�t����r�+֘c���������V���!��	%�8�by����z�;4��0��;[�4�)�� ���,�M����qn��KU�ԍ���$b���^����lM���ʶ&@�_�n�����
�5D�Y����顅�7g�8Q{����m���z}�V�TFN��|B�#"ؙ�6{���zP]}�o��X*?��ؒ�>CƧ����&�g:z��4��r�Cĸ M�ǌK����� )mή8G�ن�P\K*?v�7���Ȝ4�4�=g��LVn;�9�%�gB�]�k���>z��C�������s��^�-��Y4�Ycu���4���o��,��=G���YK���]��l4���$\k�l�ѥdi!�ݤ�%��Pރ]z���8OW{����jŃ����i�U��ܻ�>hڳ^�L ��{UGT/IXl�M|��T��)���g���e-�
���}T~܎ٮ���Llf.���*��� �2��z�rq��dd~lc�����w�B��r^w�&Pǁ�R�<�)�&˩���_F��S�hQ{��<�n#�/Y���X�Cϟh��xH^�k&�ӲYD���y�A_��8.��Zg�>�[�k�6��u�Z%�Rw|	rr2;B.�~<-�#�ǗfE
|A5,���],twĝ|�/�����@�a�!꫃/%��|��{M�����~d<�VtLd�f��x`��y}��8d�����O��o��C��?&�y-(<U�JX<�r���CF�H���ԙ#Gg<�[�kU������*�Q^�:�Z�j�|�jb�0]}r��!�w�����L�F�c����3�d!���k=����FY�Y��K�k��d�w3�(��Z�"���wၘk`q�*�4�5��x�A�m��%+
F��~��b6S��g�Ӟu�aX�L%=�� <������DV���>�
�W$�����=�U�:�̩&������x�S�2���,���c������W왲ݧ��=��^'����A^n͓ �ܛ�,)�PBe��铎������t�=���� �h�a���}*�>�%1`=����*��X>����h })g�Z��ha^S��'�$�iqf�}l��{|<y��g���I�-�E��k�ަ鼍���;����y�EՆ����N^a@�s��Q���B�jX/u�šz�d�<���S��,8��?���aAƁ�B�G��"؛��DO�HL��9ZU��-R��u1�σ+`�+��t������8 �L�ŧU��^c�k隺
^[3լ��.��_ľO|0�,�o�D4T`�-����kb�<P���dy�ZM��&3m~X���@�@b2���Q���kG3�z#�G��@�m�3�?�����ԣ��i��$��R�ԁ/�Zڳn��ə^���iQ�N:۠�5��R~���f����\�}6�&�����>9Tq�����<C������S͒��<�w^�5���ٿ��R����������ףe����>��;M��L��!@��k�K�N "��3�t辖r%/e Υw���w�`�l���(jt�8N˼��G�:�n�WN�gAS���;�3����a�cW�ve�-z�q�u�i�e�q����niY��$HW��,fY��z�r�X�z9�eP{�O!�	Ƥ�^S]�+�l���X��>�GZ<#�ŧ��D~e�{t��!�2֏�
~c�S7�t���3pnə"^��T��|�s%�Z�;M�׻�-}����o>f^ާ���E>��Y��^d�g�S��1I~B�)����ˬaUDZ��h�yd��n�~�8�8�e��Z/�\h���̰3ѧā�޽��*�Vd>��ȍ�T�o��6�������w�&N�[�4���l`��{�5F*X\['R�쥥��s��,�	~i+�r�pXA�%\1=3�J���{��8I��4�at��v��|�Oe�m�V���˼��?p�Z^��B��P\$傅[N÷g5g�,Ъ�ד�m��X9i���Np[J�Ӫ���7�Z.i�������q3
��4[ʬ�7q�����B�����8�N
�r��I*b	��@���B\�	�O_nF}q�������A�dli9&n�:� �"�z�[��Z[	 .����uҢ�n�]�}��M����g�{,�r�$9dSۧ+��&�~LR����y�F�n��r��/�m;/N.ylZ�ֻ�99ąm��_�,MƝǻWL	KR��dZ�AO�[{�� �wJ��D^I��K��&X!�����L�1̓Bͮ����E��Zw�.P�[�cCazKf,�{�0�k����g\Kw�jƝ�m�:�p��s���u4#��ؒ'�Q�y�$%��%k��~�	j�x�!M�2�E�s��_|'"x�K����ǎ.p�<Ӷ5�GPJ�������\ZAn�3`#�Ɋ���G{��&<4�j�穘�[����U�>L��l��˄!�=&8�xڋ�yvܽ�{fX�=U���������|�ЛS2�����&a*��,�$�������~��w����kVK��lhv*n�Îc:��8���r�>	t���u?�dػ� �]���<���.s�f�z�.��+��ˬ�)����4\���IQ/�x@�[�ڕ�MN��*�F��k��~��%� �9�K�Z�4{�!Ļ�΍7#�ޯ�$�Q�mWiu�������=����f]]�#+�|
��
�*��)L��ebH:���=��kZ��w��wL����V�`�yr�}��~jTm.��LX��[p�j ��;��=S� (���xJ7����P�8
r�"���:��U���K{�}���"E�k�S7�m�a>�G��%��ս��i��b!�i����߽v��~%t{��m:$<�'�*�Zs�+Px�]��P3Bt��9xe����{-�ጯ��Qn8�'aų�b-<�z��ͧ#,�@3��s�+?:q���Q_�g-�
�ɐ� Q�٣�O�uj~�tI�w+��7�V��M��̢���U��#�>�w(�o�cX4=�*P����q���*�I�'I3i�L�g�u����>��'0���u;��h����/�Ż�����:>S������+`!�L �EǢ�]PK�|FX�:��7>�Z��vP��:jU{o��k���'yo�a ��wi�ԑW}W�ռRK�X���~������c=��!}�4,>��,����6����۟S�Й@�꠫���&s�W��(x�eX+�o��q�Z�ˀ~S9.��W@6��'���f�D#P�_��0�I#i���W&��.|�����x:��g�RHhDѠ.���"M�U�0�(�A�w-c�o�����:�I��ww���V2��g|�Z���@�X�e�z�m�4���W�����V�e�f�P�u���Wün<���Ob���߹�}'    ��Z��\~5�`�<0�	p,]�Y�x�+<�D]�3k�҇�>��5�������JU0 �zeV�6T�*�oMLBK�)%��2k�)���b�;����ה��@��|d��7���mh
�v[#hEz���B��S�Te\�UUK����>���~#Qm��-�!�
?��v�[<��9nt;e��%.ɣL˼靴�c�*�m���E-;�|�媀��[�xZ��K���ư)b�];QG�����8��kU?x	��^��;��8������RB��:�?�R��5���$����8ook�ZT�e!�H���8�'��C���� �-{g����y )��cs�XUp=�j�E�,-���P�wlk�2_���q�[B�m/�����F׋�/P���-L:�B��}}��T �*��\d����Qv�0���U��}
����Zt}��ʹ�٫T�J5�1�B�֒T_�?�VpOGSRĖ��I]V�t��	�9�f�N�L� x�9�-IC��c��no�@��zun��a[�6=Ù5~djeeߧŐ���L����Pm���)�ʫhg΅��̅w=�f���+�������9���k,��>�M2E[�d����.̴S�W��It�ͩ|Ͷ�Q���\K����&�hX���#W�w�,oy\������N�����T=nU��)M+�=�BE����4�7��nVH���i��{~Xϥ��o�+�ݬ�ڠ2�
<����Ѱ�_�M�޺��<�]'�W"M3�Cڎ��jj������uԮt�p�`����_}��rQ&��hSD�$G�ԝ�#���n��Lrׇ�Z� !:�w�5U~߂d��������ɝ����?	�5�1W�^�]�صO3Q�F�.Q��Tp��R��絮���u�8��j�F��#�#�x�%U���:YR�o��^�;���v��L��i��Z���i��D�Mi�A}R+�f�!X$ �9��LN�+Y�BC�kS�+M�@Az�	�U�X(
����[c?H�����B����t�N�ye����GF�J���S(DZ��B�q��v�@��3��ZU�uu�{�R�vi�y�f�=��љ`A�>��	YNn���U�>���:������1��O'�M�YO�}!c����+���X�Gj���/�C�ϴNk���M�=V&>Z����qQC��Q,��������8����������hUt��qN\���1N���K'����M��D�&iNl���G�,����fXyh��C\U��6d��A�%a��O?�?�~����ȅ�[$���Hͻ6�c�\k~{N�{��6���~�ϲ���R.@q�
Hi�Z~*Z�q|�qjrZ���D q>9��'�Z�ע� m��5̷ռ�A�X����� i����ʚ��o������d��y��]_{�,�z�  8�tbyx���K�[�+4��Ǫmѓ��hO�˵���^w�	�0�g-*�@5������6%[������8�|��r���6�]�.�b��c�i[�>��i��{H�U	�њ�z1�Fɖ=��,�G:��+�<�����ހ;ys�TANX	�G�=�/lw1��a�5w[���~�h�b	+҇���Nײ?��ll���^����O֦��Q�I�|1��s�ru��<���|��9���;�0�7o�V&��s:�N����"�ֻp�!tqc	j�~���`��n5��T�-=�O�P�|���L^�}���;Ym6��hAژ��#�S�]^u����D4/(�o��٦Y�a��}Jo����V"o��c>��z@��"J,�uHdD>���c��I/ ��JP�(9�p02�b�:B��������O��Fp�5Qͪ�{N��EoԤ�&<����|)�3��y[��D�8i�����_#ș��[`E����7���I�=qT�~���Ѵ휢��'4��~Y6�ڐQ!*�9"�v>��k���=*<�>�g�|�����f�kz]��i��ֺ\5�J�����.ظ�����͗�QŪWƥ^֡h�T^r!iߗv�Yo��L��2K8�#�:��Z�Ev�o��!�@�9��,�۠�N�6+�'��o#:�	�w����j��.�t+wq�/��FS[�
�J�Th�N�-�����S[ U��ʅ&�����@~pm��´�b��Mш$_���>�7Ld���I���J(���xgP2S=[��S��4j��w�w���q��T�^��k�q��ZR�@�Q:%Q����w\}h�g{�YȪ�ε��䓝B�!��DJ����?ۼ����
p�?���k��Z�i{	�bP��0���d.�Ԩ2gk�d`�� �F��v/!���\�d����K�ź����F��NɆ���J��L��`r�q{�Ҳ� �7:������%wgXe�����+р'��#Ԋ�ѩ�K]5��%���^|L��(�����A����sKi`S���~��
�c�j@�O2�F�����m8H������/}��s� {��� �l;�4��ܽ.�����t%��0y���3����A:/�/yyBݱ�?"���C����~ڵ���m	�ֿ���Zy5�_��$Kv��D�B�-x*��8�O��pA��`�:��"��pKWk�o���aǛ-�g�_
���;~�"�����^|�2
=�^�������  VQdR��lJ�G�EQ�|"�ӻJ�:������t�D���vKwH�F��ƈ���n[W<Т�<:�3�}F����s�Ƕ@Y|˒j���s�/M2�^��B�
��s��$).<#����`/SP����N۷l)�0_fk%�y4<{�m�Av��q�r���
�S~Iip��1g�ڲ,x�#�!;.�1�g"�1���9�#taP�T�V��C�G���ז�+���u<C+b������A�r��\�� ?���	�����xD��W��[�4�R�x�[u*��*G�ܫ���qƙ�O��l��Zx(�ҳ���J�j:Uȯ8�ol������͙#�ͿEx�}�-�M���č�[��];7���?��ZH���p�ܝ��8r��{]��tE�%4��Q�=��{6H�r)��>����"�W������Xt)�d�'�ԧi˴ʠR2���8?,���m���>���_�f���
2�9�A�a�Ș���!���L�i���������l��i�����6[����S[YX�=�v�|a.J�k�4kbo~�{�k��X �9��KJ��i�{������~m�z�(������/�^�d&If&>�E��׈Ç㥯Օ��{}ڽޗ��T��R�lq0�=��>'�h����B~�c���yz�l4+����r����\��+="�2�^�df���cya��'�t��߾
Ç�<!s�<�h��#e�J�i0.�~j����9������k#xuuX/&'r�dk� ��|ցT��5(���g�\���:�	#GJ�q�F�
v96����mW����s�.�>H�߰Iu�[�����-9<�?�q&u-]C��]U�,/JP��8����4�w�-��2�qV4%wM�@�G����]/
&�@h��{�{�������l�/��C�@PuDc�f������7�K;��qD���F�����=}�@o���tB�ZL��q�K��"xe��oQ?h��L�-_��u��P�Xbp������mʩ%�R��A�}l�Bw3j˥/%o�lI�u9V-?�Tߣ�=���!�c;�mb|�ҤG���()����������V�s��r�Ҳ�D��ǒL�y��-/FxO�x�h�b��bܜ��m�� /x\�gܗ�'�AŻ@�-� �3q�a�d��L�x�^k$�����J_�B�Օ�b]9�z8��?���!ãŲ^�f>�e����=I(�Z~�;��ri��.��<k��f�Qo� �ksR��bfx�����ϩ���`�khy��F��c1���p~\>�샅A�e���N��ff�*b�nL�I¶yU���x��{̺��s͏���<F��(�s�7�    �dm/FS��kՑ�Q2|��J5�x�º�P6�<������WT~%�g���'�yBWH����9�o�v�T�QK֬ޯq��l-�Ҏ�H�Ҫ�~����޿����3~�d#����S"��nbX�8�!pw�2˫R����ĆZ�~G䞙�'S���K~����h&4djXO��3��f[�~�y�o�mjd)@
����b]:T �iݢ��;��v,:K�񪝬]*�ܤ���!�ʧ����C?������c�<P���qZ�zB`���(�4~�EN����V
�l\�ɒ��67�#�G`�6���>�L�4�U��h�E��:����S�
f�>�\�9q���E�J{�!���!&/[����I�$,���(_�?V�bs�=7�C��Sx���C?CY�����J���ߛ��ʢ�c�r� �� ��i'������Z��dJ	�i�=�aˋ��g�J��
WEz��u���U���7U>�G{��a�;KGMdQ~��%	��ekfX�@��:�\o4�a,٨C�Ȳ�{���~.~h!��Qݘܧ���6?�Yɯ����s]��ޢ�$��0o�|Uq�����H�����x�<^�+:^��ou��V���\«��H�W��ݬ��?�'�@w� �t�F�Bi��9y>�-��G���f;�6G�D�y��]~/`Amc�b�`h�=Z(Y|��V�}z�Gg:�~E�T��m��}��C�!�nuB0� ���.iU^Tݍ���<���~��"�L�Ԥ�
{����Ŵ�<� ��?4u�g�,+�MK��-������:Ԓ��qv����νնT��yD��:��j}\f@� YԞ�߼O��a���彼���ь b$��g�U����QtԬ��"�v��~4-�Ta���lYX�C��&w�y���ǻF����ƌʦ�S:��z��E��,r8���T������8�`"(�U�����H�hͅ%��d�5���l9=_��I�����|�ˀ�s!]�����X��(KR��IQ�pN�-�*ད�iA
y����1]�S;����7_(}�V7��[����c�+p���	�L{a-#������`�����[j�>���5�?�kQhx�=�}^o�J �aI;�|�<���V�����zZЧMq1�B�<��ҸT�37�g���j~~Wg�Aa,kw���z��
�x�_���v���d�2A]^'�ܾR�|)��-��S,���{���V��0�{FG��r���ZG�## �	t �9�ϭ��)��������届7���B��ǜ�st����]`<�0r��>�hS[�����E�����3�c�>�\ZF�^�c�0���d`zm`�~�8{<��p� W�
�mu����?�x���鷺�c�������l������r�x~R���R���W�J �YZ<�6&O��5����A�|�4�!h9^�c<�4��A��.�;����S���:�r��_���T����MU$�
����R-i�{��8T��Gto^�5�S���r��"�͎�`U��Z����*_�"6߫�ү���ԉW��a�Urdyc�ȍ;=]��8���'q�.~�k���_��	]K�*��-�B��<+d���Ynj4�ɏ3��8�$��<qf�,fa�R�fcP�.���H�v%Ta���V��>Jo�� �6F����:2s	[/'�`]�㬒�[���@�@>�qR�,�=���(|rn4�ǢY���L��̾З����%F'a�jNA� �I�Lγ�T�k������E�a����.�.�ݲߨ�$�i�G�x!]40/�S����V���<O��~��#����w�ı�#��y�����kM����C�5�[����9H ۼ^ٰ̥Ef�Q�WӖ��/��ޚ�'�L���v���kL�frCD9���}���r}%��#D�~�p��2��Cy<���2�fCzd�u���+C!�@1x��u�]r}����Ԟ�8�9�mn|����5��?gG6~�|�T;)�Ara�|��ńeA��6��]��^�a���6Z�ĺ��#��K�l9M�2 ��m���a�=˨�[m�k�S+`��/)�R���[n�i���0���1�e�HB��?([f�:0��c�r�:�n�.�4�E��3r�{���dN�7'����%�c��ח������.�uT��eu~ ]��>h�	����I<ن�>�(��BA��-�%��%h�ס���e�$����Tb��R��@�6�.ſ���u���V
5�iX܁��Py�O�j����-�?�O2O�����=]Q�2#h#�p��9�U9|����[�-���e����J;���d/0��bL;f�������e��He^�k����DV�r$����(��S�\�� �HԵ:��RD4^�ȳQ�\���h����b�ZͶ|�&�KE��Il��om�ϭ���ؕR}����DK����T�ϞW���[��<z���s��]{� ������o�!G��.f�3�����,�Wu���htɕu
��W-���[��z���i8=vpݑA�Z����\Q2���2M�_��ZW?���7��O
����i��ZY���ً�1�W������NFm�Ѡ�UV;و�)E$�D�>�SMސ���1�`�u�	��T��;aN��]%��Y\����x.���mz�y� �'���n�ݞ��m�7�q����4�.bl�g���aA�Za!��Շ�	ۏ"��!�y+ݯ��1��ss����A-�4�yu>��$On:L����oPtv�=J�������#�`0���i�N�ޛ�<qH�\��B�������k=PZ�D�Q�a%��T�@�C�/�J�z9��P<�ɽ�Wy4����|��{q\�B�h�3�;�l�@��NA?i�pp�
�mF�?<��@1Bwt�h���JU�ɐj�6aH4��)_�=^���"򅪃����^z
8��������������˨�Sp顷b���tK��@��8�1���s�F09gx��TmM��-���!u3A�bݖ���n6T�e�^G1�}��w�Fb�F�'�6���1s+�

�.T/��h.�Q��g�/�g��mR@��%X�y��D\�`��}f��Y�r/ȕX�~������M�Nhy�v�GʷO��{=-X�U<���M��ڈY�7ZF4���	Ɨ�	)���,���D1 ���I�!�%r˒��:�)u���Ǧ�5@k�j���y
)ctN���O�,�FB/��¸�����l%�%�a�9�(�:��.c�,k`L�e-�?`yGa���{Ss�|���KGh<����$�J�.v��׻n5ñ;�Z7O5�����zu�/;�#辌�o��?H�Z��.�k"} ��uq��!�	@*�)�����*3!%k��X3���N2�uV�}���0{�0%!+�C7_H��$=��������s$����L�'G��c�K |QD ��
�B��l�K����Q>�i��*���W�='<l���8D���Xm�_~��1u�_6��Ԥ@�u� �-�p���*!�?����#���~��-�T�����,�(x�aI���]�6�7�.�(g!Α����ϊ�.���ֈ/�`�^0� ���Ԃ>?F��ȟ�ʵ�^�pg�Ra�n��ʐ�����.�c{�G(S�<�����v���$�F+��f�|�3��7�3me�r\Vv��4 ��B��+��n�6�q�$f����H��C&*� `�Ƨ���Q@zj	�z�GE|?��6�N4����N'n��h?��V����f�9ʀN�~y=�ǁ
~�� pv���V�\,�@w�,i���LY.��EM�E��R���YY
K��=_�94A�
�tmģP>��3\v4X���>	Trr�D*Օdዹ(i)������
����j�b��U�z3�t���;<�l�4#2��&uK���s%K��S���5\`�z�T_����O���g��;�l��R�`�X.I��6�J=8�yb����~�OX� âۿ(<    # mB����,K�d�i�&i�b֧�w�Ä���E�'��\�P��	65�ʎK>�B����!��I�6����]��*7��*��$��ĉ��[<o{�K�����V	?�Ru�ƕ��/��
���չ�ʀe](,�B3�[���s�@/�e�0��X��	
q0��}���q\�pUE3G`��U�n�o�&K ���9:�Tk�}�EAit9��3���?�������ur���s�5�+
��|�4�eh _z��H�-(���-J�,���e�5,#�|��;�e�.��>�@(�������;�ӑ=�OD����2c�v_W�HX
eD�J3�O��͟7͉a��$���u��| ��"��|f7�;ZQ,>ږǽf��;�(�.��D����S[��Y`|ߵ6��[�*�ߩ�I�T����Ξ�����'�!$ 3�ik�-��G�r��Ĩ'&�!
�|����{j7x��#��q/*���I�:e?>�:�Ğ���W�k�*G)�r��t��ެOH®M1I�Q4I�<4�.U��e�am��4�KRY<�`5(�m�9@����p�7f�U� ���i���U9�8T��[�7��o�b��j��R��&�tl��s��.���r��d��2��l:�P5��z��)�c����8&��` �q�O`�C����s�9ҚHւ�UK{r�<89k��T��2��g�}A�{oHZ1�Շ�S���{ӯ�5��_@5[�c�F��3�UK�[c����ƻjC��E��[1�w�4��f���}(�Z����ԬW�Jr��ٹ��K/�6`��&c`�'�/hm;y��G
4a�� }�9��շ�`��*��^'d�yrg���!���O��BC���>��_�2L;��#"�(<���N��,�uW7_xF���Y{j��t��$~��@����
g��N�+G�j��Aa|��x�F�z���'w-�w�}�z�J���wN�C�l�ߓt���c�l���K���$6���;+�e��V��(�0�N�~s^�}b»(��p��.R�������ķ8���Y3U�{n��FH$ݵE����_%
�fND(�W�A!Ђ?��]�0�F�;�Bs��,`w�?N䁟:���L���_�t�E;��u~�oS뱤�{�� $�4�:����)u�}����5䓝B��|���h�RK<�����Z�S�%s(��o��%�ʀ�d����b�^�T�2�-��߷��Y��P�}��C3���O�i���|�m�F�".�j�9�@d�Լ�u��J�����z��x�é=U!iO�^�v�R�W�>:��p8a�,^Ј;O{l�\�<��/+7�m�包��:[{@���=�
f�;���#�zT�5��������7r(�&߽R���~�xn'�������^��>P�t�&�������g�i>C�`��]�"��h�u����8`� 5��z`��ȰaC=Q���z�ܘ$>��/��(w��кK�-ێ�P�'eM��`uXçyǬ44K�BԻ��!k�c6�hR�s��v���A)[�ȏG|�3!��plў��N%Ԥ����}m O�#�_��4Q�&���-��-�ȑ�m��њ��C5X�7�j虞%M���j��=l�
'�Z�P+�N�]����k�Q9VKaA'��x
�kf+�%_�-�v�:�̣r^8�%Dcd�Bbι6�;�7	^�̝�Z�a��L2��X���D'�\8��} �q!��������k�9�or��X��{R�Z/��}�]�Rr������P�+�N��b��'�
wpgp��n��h�S|Ic~�6C���}^/kn�`+R�|X�
;0O1��O`s���Զ�Χ�Wz�myq���#'����N�"�?KH)���7)dj�i��I*�³=5���]� �8
��M��&����/�����~� F�d�~����b�s�N4��kO'Wd�����@�������g�,?S��" Y㨲d�,ӱb3�`)�UQ�!0O�������AF�C�p�`ざ�ei��C�d�~=�>�������Z Aq�`���.��Aq�>�/��{�k2��:�ۮ��{z/�*1W����
%�O��p��#	.�����¾�(�eC���$N ����I��z����fj���[��+%�5Y�[�.�V��Q�w�盨9=��z�'-�81N�"P��������X/p� 8cz�3G�f��CC�ڜ��/m�ص9��kK	�W_�.�'Ogt"_�}R�Ƒ/l<���x�N�8A'�&����8iTu�MA�Җ`�yD�hF���.b	A�!(6���E����
���(\ێ�
\���I���Ǫ�4R�k�!B����,ݔwW2RkH>�;���ŷ�	W0J7p��O
<ȑ�Th��0�\��'���s~#���*���(�P,���\�D��C� ��Ai�ZI�,~#
��$	* JI��=UtE����8�KF�Ȝ�Q��ki5���.��y�Է�X������Xz� ���#�����)Fuq���*A��D�u��EH�C)E[�	����J��C
�p�9�䉑��ď����]�x�V�B�a����ָ���S46<�ix,��UD�(q;Oq�kp�%�%)��sV�5�K�DՓQO<�,��[�#���a����gB,��7Z؍/z�8Y�� 4�-�c�!���v �P���ft9.8��֋�"�z;f
�0r%�@c`��v�2�6�Z[ƞ�׉��w�s�ˇ�̙dh����,'��� ���a����/N���o���p��~��:�+����rS�P�2?'ǋ��F.a���*��:Ȯ��Be82`���=�߿I�ᯝ-���+1Ϯ*���m2b�RPm,�%�h@o����<Y���$���7��n��^�`4���{o��d���4���I/������ɔ�q��ͅ���h�|�B�˺Y�47��E���n�R���i�����L�!{y �|�X�Taݳ,���_�<֋�C���NS�Wq!im��7�o9iXc�SB]�/�_	ͨ��c���3{3��:�%3��%�+�?n��}��WT�!�u��`����`���i�E�����c�ټ�;�_�V�Ԕ?��]#��)x'�&@98�I�,;��jX ��T*Ҫk�|7ɑ�{�i
��(n_X�IX�8��l�B�P�k|��i:�w%
���5�F��t_Q-{����Z�$��fVռ�Q�#T����i�oU�G%d���1��w�Űc�X�yM��1�Q�����o6�j�~Ҝ�c�!�$�Yk`�!zf�8�C�d�������Lw��k�=���W��\��	y[��6~M���V��{�I�e���f/�yॿ~�Q��3K�t�{
mBy^G�5Q9!��n�$"jw_�([O-�*ִ�.w��}��?�?Gt��(c9Sw���P,�.��XU��@W�J)&�{i��?�m,Ip'����PI5�c�>�-j�r.�5F(� DeϨ�����œ�p9��0~p磕�(q�&u��>��b������7+,[%��^�Mk'���t/��7V,�z7]�V(7E��H~h�?�?G}Gx9vc^z��>â��tr&��x��p�AX%U���fs�����Jc����K��u.�a�E}�I���k۞K�7��+���7����K���So"�C���0�O7mQO7nc��J{�~9�w�\cŖ��(L޴��o��������Uk�IW�Irv�%�>	����P<մ.�}.(��D_�$K/&zɥb�����B�F�ǖoɘ�]8(���q q�=f�|��K5�`��$0�B�3�uB�U=G�h�^���5�H�y�B(�bm�	��)��.|污���ҟ=!n���}za-�fH:�ݨ��7���Ue�􃿳8<)I���w+��W�>�M�����#�7��&h=sl�U(�c����J]T�����U8�������}� ih&�/    R"�I`�K����$e�m=��Tb�ν2�R�H����E |~� ��\�D?�f�K��y��.#�4����v
�U�s�F;A=�Y���'nQ6�0:=��xBI!���QZ��^�his������e�V�f1N�B�S�_�-�pb�<ְ�w2`C���F�z��Ɯ(���<���Ă�	��@��q���qKļw$k��@���sh#7:_P����Z�{ߏu�kj�sa��]�vk�p��II�q�n�~��vzY��%:X����H��w
�$���x��t�wD^�aT�W?��q'}�[*���i�!*�A�����]*�Qo��^e�L�g8�a;ϭ��'i=�U���;��}�[2�)��� �e���Y���O�'�U��$Q�;�n���0�1�DR�-G�q�*�XQvx4���[�}%���F�� /�<Z�lI�K���$>#ys�VM��}���e��w�˒;�;1��c���OhR"���	���N}��sx��/I��QUպ>�q�+fѢ�R�d>�gՖ����d��'5� }lU�]�U�c	�9A����\��I,�dH��(wŹ� F��_Rf��xZN�r?�_S���h!�ה�R�,-\>���q0p�G<P=#Ȩ���>`�^�׽�׈L+t;�؅�wF��>^k4}��Y��E�ۀ�o����n���^�|߾�w�Li�3Ba[�xkN�9�NYOz
v �t梙�����'δF+\v��M*h�|u(ڌDA����]�Z��|z����{݃�-F�Ub��h�~�"('×��%Rf@1k5��w,��#qA�#���*~r�#4@쌑qI����*��h3���9�q1z�W?=58����K�A\�~TuMP,J5OMi��鎪��Z�z��%2�R�Z���"!��pB&���H�A4rLJVq(�
��[P�a�X�}������$t�r��yC����`�g�<��%�;�4 �ꓨ�%�{���g
9����7N��]o�~\F�Gx�,��h���Ol}�X�줌��R�(�GO��[w�+���}�aP@|c���*���\ ���/H��(�n�a\��{?�90ƍ��q�UE�Ɣ,���� Fs� �w�6�W����Z�[?p^}kA��h!�KX�k��J�S��^�i	(+�'�r3�&L�*}N��j�I��5>�rv��t������<����Y�������M��&��]R�5,�+L��W��ڪ��2%a	N{x�!Q���݇yK�6��� ����{m����Dm����+����R[T6NA���j��NU
�QI�&QSu�z��9��[�6��[�����') ;��8j�-�8F������z�U�0Ȣ?W�E6�"Go��^��Z�Ҕpv+G�N�Z �)eL�[�e�8_���̮�8�v�޽WTb���E�F��a{=�*f#(�9���p�a�S�̍Ծ?��2�������J��o�t�"�7^�t��UK���%�&I�����}�=�'qP�;���В{I��@(��@�e��,�ӻ�o�=�w�j.���W-�T�nےÕ�D=.���$LkF�BzN�b������(�e(K��`����5�.��n��<��a����c�s�E����j_p����G`t扢_�>�
*}�,F�LN�ӏ��E�q�n�I����$���$%L���)�o_�Ii��B�b��"eQ��dz	e<(1�9`��;F�� ��L�ؑ��ڹ"�@�a�69���R��H0T�.��μ�lO�_Q��~n�Ӱ܄/9��鈚G~R�K�v��km�64�㰯�{9wru��Cat��r�6���;9'��:�i��#�+��BA��%?��oI����+�K���<�M�7����9��8N��H�ˤ_n_	97?���*����>
n-0�?��	0�%�m���{�X�j@��@�a��+k�b(�:l�0�;7�n�:4��M�82z���$����D-�~�� ��ۃ19k�WR;���/�W�J3�$Lф�l���Ր�}�&XƬ�Y��9���##��X���-��UH��]�Ą=�7s�Y�@߇��mz]�(Q�4Dix�u͚;U
����ZP�Q�`'-�ĠGR 0��#	�;�]Q����
 ��>�2 �f�B���1��\���W�I�dą��nV��B�0鐎�L3�
���׃3Z7⓱6�L�O]R:�8KshϦ�b�U�@����>���׳ǡ6ȏ�b�#.�_�7{��� O�L�tzg��uR�&��y��nE<9qޚ�#��&�ϵˡyq�ߧ*v�ŧ�{̝�0��~�;q�'�(�.}�%���g1XBFi�K�[�f���p��,��}@�û!=sKw4 )֞�"y�
N��%ΧN������Z���<⋺�����\�K^��p�;0�B������hd�b���s�~� �N���s���pï���l~�z[�߂	$�2j��?���0�z }GC_�e�{k����?��
f�nJQ�h���E���7�3|�5�k2��p�,{�l��~��9�����9��@��t
u�q4Væ��)�m� f�(9���)���T4v(r���%`MWr�cg��]p	�@(���F/�=/�+e���a?��n���OҚ�E��4\c4Y<�gW�z��������E���	|�S��c"sv����)(�D87w�����0w�R� �좧	"b�_�ĉ�����#��_��Lᑥ��X�a�О�CO ��^�G�X��D�Y3��x��H�/��ֲR� ;��������"p�&m�ݓ2e��ς��Z\߽��ނ@��U��,�[�\P������6q�낧�3���N��# J�M���$�Ig�oQ����,R�B�"�������̥5�����K�i���D��Vl#i��UG5{#�s�L!��ׅ.
Yƺu?�I^��G���b����$��#ň�x�BM�Oȶ��Ba��'��+�^L8�}��[_GMP�{���i�C�WI�V2x+��~�cn,f߬�IT��*���2*��(�M�F+ͮ `�n��/� ૣP6�W����%�y������Dx��R=�x(gh��f�Y�@��mײN���HcCִ�G�3PF��FʧgA�c'���0X3XS��1/(}Ǽ�50�������\
�>���p�U+��3��=b�(�!�zRx��`K�p�ށ�ijO�ﷴ{���+�M_��_l$ �.�DmM�0�"=#ʨ��$1�t���詵�W����n3�j�U��iIŬ2�l�a/�2�fm��I�\{�g�P_�]$uZ��ɋ)����O����J8v!r�W�.�0�������,|�h��go�h�C}>2.�$���"���/5��+�u�Q�
-�'��1�%%8�'��;ǈ��'��_�"A�)��,G��(��*)�ޛ���t����0	���-���q�O�ښ5�N�?i&�/�"�Hm�E�ᙹ����G�f ����I���-�cS�gk6P�NC�������	k��?�Zd���쐬z,�2�x�e�����_Ƽ�bG�f� ���#!^e6]�p�y`��W\�98�l�D�½�C�F��%Z(�=��|��"J�R:+�&[ @𩓤H$C`�jI����Fy��h�u�z�Z�dYd&!\yzR�1k<��E���T�-�����!hjʑL[Llj�E ��#z�C��D�C[+�8 ͑�]������?�ّ� ��6ZE6���Q�B�w/����u�7���^K���@�f��E�B���۽B���dN��%���ީ|L�bAUՁ���n��������L�<F9�	�ҩ�+x�!�7bt�]��%J���1+TAD ��
�J9�!h��^w%$���Y�A��5�u;C�Q"Q� 8tx?�c%5=AӾ����W�����p1�#9���bd�����"�{[� E�sB@�*"���Q|Bd���S߻O���颅�fQjY�    ��hk�b	ƃ��`H�� �T�ɛ�^ɹR��l:+��Q}�ca�90��EJa�H����bP$�E��b�T��f��*�%��������e��?C�˴�?�Y\�8��79~l�����L�1ϓ�gԳ�Հ}~�r�3Տa�ݠ7^[ӄ�`��g���fx�u	f��JSKNտ"���km���S��U�@󀉻��$wƒ @LQΔ|n����R���&�eRN#j��dT#I)��!PX�H�f��_��8�o�q�o��`.��h$,u�����Ԯ�,��Uo�P�xdj	KMrN:0s�O �xw�Ɂ2'X� F��	�U����L��y��<FO%�l�@�.T):$v�;\�kh��*�_kܵ��W�r����g��8}�[L��&H�������v�HN�������2n 3����k�4�kp��.NQE�e���1\cg	��s�0ZC����U"�,���ÿگ����Ȉ���V����}@9v(�Yj����1$�%[�F�����{ρ��*�0#��}�,�X0�Δ�H;�F� pv���(��fJÂy �y]���+xC�%v��䬭����) ;�T��Z���L� 1�bxU�<dL��(�y\o����A*kE\�f��qJ���f��M��	@��q�H��Vj�<>��Lӑ?�w��8�6'g �|��BqN�������w
��n[�ƛK��J�����	����ϋd&���'��Ϲ�㡽׳w����O��/�7�'�D�#�H��L�XK����,%��ޘ��d�y|����b �l����!8�,Q�>�A���ƽ�"�<Ģ�n��E���'yZ}`�pJ�}�ޤ�X����~�%8 A�B�T���=0�C�g���5�z���r�ߋ>�$����p6�X��IYLc�E�\�g��b���f��q���6f��0ŴRG�K6k>��n�m�������I����qyq�l��_j����|*�e*�c�}[X��Apg��rkgȐ�X�3�ܸ��U8�ht��"]e��j��2I`�}�=߿�@�|j���cZ+����W{~��S�y@Oh}�#�Ȟ!I����ر�7�N�AR��4��:d:r �n���I�ʤ���x hD��~FII8wD[L�� o���S`e����Z̓���zEr�-�#@.1��a,^o�����ɋdE�m�$x~�V@�������N��I³�jI]�
.�*�I���\�3d�Jd��
��ԓ��ޢW6��Xs�l����x�	L��/�ud���e_���~�Bղ�BJ��,Ŷĉ�1���$�Ӛ�B��nh<¦pG�fV��|��A�q]7�B�\	B0��fF�] Stj����|7���svmf)��ц,2@�E2�H�#=����yo�y[}�'���I���W�v�����X[&�<.�����O �,�=�̈́��k�?}Ԥ�*�U�i�����Z�v�`�E�}]~N�%oM�@�v���5��R"�!Bq��^��V���q���4j)YV*)�*H�� ����~�"9a��1�e��g���c8�<]��e�(�`�Ծ�ԍ6�dQ��p��7ڂ5�/��5�v8������=]Hl~���4�L�r�S���Q�.��4��x�\����>��3�=MJ�4[��C.~F~��\Bn���{
v�u��K�#	it^���{���w끵��P0��s��rLx���Im����@{�v#n��gC	ϦJ�*���1���>q�9��=ږ�n��7�k�|��'��W�b�Q���c<��<�����N�}��'K����M�����*��RU�S�����X�aXa[
e;J�I�$K�B��~��~�'E������ѽ ��n��DX%�C*ؾ\	�_4F�m�I�$�t·5)�W��S�bk>�h<l����{�+2 &R����"��.9q��*�jU���*���eI��;p��?a�^�O~Vo��b�.��Ra�'���/�1�9��-w�g� b���D��b�}��}??���I�͢�G�x>~�~yol�ǆ�����(�R��j?>(�x��&#v��M�|�r�`�����E��x}��,��^A����{^�d�Sf�8�D�%�J�^��E���_�7aP�Ah��?��dYL~PpE.�O��aYa�[�PDp�4�b�)m�qZ3�p�r�4,�)�q��SV��_�y����  �p�N�t�N5<vK(?��^�gS���f�z�ı�Q�L�f���Dn�ʙі�[��ڷM{Lj�Aj����~���ߏg1��d��.�!n�N?��
a�&�'ª%��B�ۜd[7�(+�k��q��,׬�{�Pl��W�x�ʈ��x-�U� ���a����1	P�����o��;���>�+���©��:���Dd���aN��B�2Q 4%��i��J�z-Zdq��͸�Pe_JZ����2iܯ��]��^����ׄ����"��L>��l�7@���t*}1+��ݸ5����)+�BX���(��'��l����eG���)Ya4�C)����yUO���_C�T���I�V�;�D�OӋ�����|!>�K�(
dwZ2�	���od�����_Ӯ���!Fiz7*ΒX�߰�T"S !F��1ɱ���;H�d��\U�P�x]#{����������� /q�rY���{(؇�~��3��δ!�V��B��{���i�����AJx.�y8z(�ҟ#��y5�f��$�[k(P�W�|�$��!�X�ycj\-�L�|��'��CXR]fupS�}���h�W��`­��-�ުo�6�� =uDO�
�`ݙ���#�ϻ��U(\��(��4�
���8'Hh��ٖ2p`��P�fO[y1��:�H�dƇ���9�$�6e k"
��4-V�ԛ7�E�z��ŽP(,�d^��~c�8@�� �C���0�"3�u�@ �a�-G퓉����'Y"��ܷLz����$�c������Ӊz�eM0�
�6���AL������Lϲ�;�Ϭa��5@�-It�1̑��Nc�_<	p���nҏ�0�6��󛴬d4R�P�{1 ������ �`�`Axpe���Ww� E*�@�l�
e#f��Q�i�e��c�i�8��B#"ā�w�����$�~���T�7�¤]?�=T�{O�=unJ�x}s��j������'W�Ӥ0�R�Z��ާ��v��mӽd=�i�,r�'L������hb�y��*M�=�Ll=O�ښ��a�F%���~
�ݪ'ˤ����1@~֥q�Ɂ-A�@���i	`��#_8Jx/�J��Z�QA����2V�v"ƝБd*v��`��4�-���$�
�ї����26��ӭE�1����k��-�4�Ͷ�)���ENR؜�?��+��b���veP�lۃ����*���l�y������)��YR�y�	]�����!�~�yy�k�Wc� ��7�"��C1���[ºa�ZʃB�̳ب�w=0�L6��v�l�3$�c�q?1�����h� ���v<�MPրQ3����	^InLwh���u�~�؇��3��7dk�����ף���2�E�}�Պ.�� �?�ӯ:��Bw�5��d�^rF�#�'�t*����a=�,g2Zs|�n_�bn����g
0ܘ�py9K9�voyT,Q*f���g��0�gmC��z��#��4y�l�U7����nm6L&��)2�����PL&V�	N%�'���<�2�����D��5X�Q�۔]�1_�Q�[�",�!��@����4��"�X�|0#�D�����
�*�m?�0��E���u0��d��W;�?������l���6���T�-��4\E[d�QH�����'_8pU�ɲ�5}�q0ש�=3Ƥa�_Ż����[r�.�j�u=d�g�+5��VL8E">XIx*�X?�z�@4K%�nQ]�;��z�UB�}��Ĵb���Y70��׭,�b�Bʃ��D��D,ThB    �T�֖�G�ю���>&5�����1�����ѐ��P|��%���=��,�=0{f��DSǨ��E\���e�Hs�_�=!����=y~���c�o�L��o	>�	���ZJ0��H�nU�^�y�\HA�����{���^���x��v�t�
�F`W����nۻ��^�~��Հց6������_��b��$&��$�'���~�U߿O�F�^�h0�gM�R�&fM�TV��ʸ0	�����F�,^�⠀����D�mE�j����5ơ��7H1ա�dB�x@�[���j���q����R*�����n�D�|b��(凅�}�� %S��\�u�園f��e6�P^.a�`YB�؜~�ԏ�P���v�/}�����*�:��JP�$��a��%�c��DHQ���=���J�R�Qr�"}���@����`?��W���
���c�~��Λ�Y�=���_�^c���q���a� ��9��zϱ�+׮�g���;\ׂ�8]��T^wh�3��ua#��$��2�t��*��=�e���??�mWh��Bi��>;�i敍T\����O�z0Lo9�T
���9�,׶&~�ks�qD�a@�?�b��kF� �ggE�u��a�p��#}��.��#��z	�+8��ی��]T�~�.�^��d��>�,7�NI;x�y��z�P�xɓ�c�M�#}�����ؾ߲N�{
#~�B��i�;�dq�A���<��_\���S@�>�E�����E���a�	������V�SL>/>*�'F�r��D���7��XY��Qg��Bb.^���u�����i����r�ad��#����b��6'ϥ-!���Q�q�م��_u��j�:B ���Oz�A�dہ����� ������$�������y4l��Xd4q@��F��������I��I�sI��3�&֔g�U4Wr�]��*
r�7c���j1����ZQ˟��nP�G��ն~D2j��l��^��TϠ#���df<8R����g���1̛p炌�w�c�`���Ж(%(z�]�|u�f^���Iw˴�f[���{�6����i�������3'S��0a�n����K���'�� �eޞ;z�[|X��z�s��YG�M�g�Y8�ٔ?��*��ΕAFۆo��]�����K/�-��l�w��LN��,�Ԃ��y�ޗ��EV��������%���5r;�l�.�m��(��r���yB�C��>�w):�l^T=mB ��ñ�X�W�{�F���J�)���l�J[�J4�����S���wM�4<�8j��S���\�:}Sৌ6���I�aT��;�f�,�Ú
t+�YՒ�V@�������A�]�K�����u�����:�i�m��B�K�>������;/r�Z�{40/w�}���ٛ�g��'���z����I,oJ݊!�u�p�F���:пq���6]�S44�I��t���j
��k�G�E0gp��[������z���i'��5�[f�|�8�[�8��MHH�"����5ƖK6���Ewn�֥e?;��X�Mqa*��Ipj����z�� �_6 ������mv���sq�_m���	��"D�4r`-�Q�q�3w�I�
�m�1u^v�����\�(�.�Wx?G���+�x��޴��iT"Rx�v��-�a���^_�< E&˼5�yd~ *j���������Y؃GT��,�S��Ƴ�Dq��x�c��:�9�Z�a͊��4�؃��}�W�A����i^#V�|)��/h����e��� ȉ����ح(K�b�<�@�i0��W[�;&&�^Յ}5�TX�H}�֟]q��\�Γ�F2���R(Z��s�^��9}��KAs��]�g����@+�_�G�@��
�a�z�N?�W�*�>_ߏ/؏�'Rl��]��]�P⛗�������e�>$Od���%}�>�~���k �2�@/�)�4A���*�W2	
w=.�#�*�Y����N}H��]����
���R�D��p��?�_
c�}���"^֘�F^�/	e%��ٕ�Cq�F,���O��S~��mi8gAQ�D�6x�^��0w���t�֛]͓`��S���N���WjŋI�9��OT�h��j;]���E�QNB�@����7�U+�g��%LEq��EWvd*V}�c�Y�C�P����2��}���8x�s����r詢p�4���_��b��g`<�����h��R�I���{.t�`�JpO?ede*�&寲�J�%߱0`<�M�������ߩ�J�p�1Oa�<�^����Q�6�hg!�����E���Ә�(�#�W��Ȱ?|�z�<�H���ߟێ�F㫰�N�g�Ö���˷��zzo�8$���ߚ����gO���4I�a�p���D,n9�׹e�5���qJ���0Z���.f�|�>�����u�jHJև�hT�3��yx� �s[�-���F�d�pgb��s׷Ի�lu�yС���b��vX�7��,���v�������륡Z ��4�CR`͜K񫞽���4{K�c��}�r��F��H��-E�Ӝ�Q}V�Dk�O��p���s�<�����k��y�Y��������ӏ����ue<���b8%�_��1����H�������Ba��k�İ ���C�?��v��V5E)��[��9}��d������5�~!�\�hy0����6���s�U��� J!x�m���SB6��u�/[�O��yXrl�?��~�����Pƒ|�]9}��cɨoF�w�u����� �X V�g��e���i�0}��[�^o��n�w����4�BӖAQa8w	����Q�����!�F�JC��=m8?�`'3�pIѕ��sf�M�ٻ��-uo�?�1�9���2`^�"�.I���{�;�¦��.�l�a���;K�F�����0�OCE��v:oZ�ezwiÔ|�qSN���\Zѓ�,L_+��o�u�{�X-��Y��;D�_,ƽF����1%��1R�}i �~�Ep��K?q|�\uQ�9��i#�4pz������(�{ ���'�z���(W�o]-Q�I�`�?Iv��ZL|�_���������˃�ŤW�>ɟ\�;�V�3��c��ݞ2�f��<���0�ɿ�L�T���3Z-�2QJ}Ak��ޚ�<.4SGףt�%�U}�;=ؖ��jvv�_E��95����	�a^�{O7(�S���V�Ut��(�DEޚ\VsP�zsؓ����2��}�A3�9�,f8�����GN�ܾ�͐t��X�
���S6�)�R:�wf��M���jT5M����<�u����f6�х]]��
z�Pjy�T�]7
J�[�l!�9T�jk��hg)10���������x2,�C�U^�9�-���+Y�M%�F���H�_��Լ����Έ���G���{�9�]o���Vc�N��5�Y��{�.�����A��s�0Op�T�Z4ޣ4���+����QR���]�ˊW�J9O�k����H5M�5ɨ���9�=�D���P�'�h�J6]���}˂�6sB/]Dƨ��g���j񣨖�!��	6��]��Z]v*#A���*?�$�;4��r�����a#=�~��H��'��k��.�}�x�����'7�7����p�ij�~#;�o0�=�lڵrk9��S��If�TLi�@O�t�����S�H��M�Ȇ��nw�$���l^@h�\�\9�b�����,�����n�^��~�mN�ow�j�Fl%ΑH�<��!�J�-1A5�.�05F��+4�d,LrL�Fw�lg�!͸8���76��W�����y*�s�u6'��}lŦ '��(V^]�*
�י!����P`�%�{ʨW�}��>�pL��b���q����y"�`��g𔌉���`��ǀ8�)�y���dr��9�Zd���`5��͏�j��h[�s_A��?e��R�ah�T�l���:��u��t
��*F@�������Ɠ��Ƶ��\)��dW3Ϲ�?�ݹv��    ܚ
�w�L����(�����`�����W��7���#w�b���!�T9{�sLZ���'�}1��	$\mp�!�ł����<���Y��M���y�8�1݊�K��r�]�����M�>�<�u������s��$ɍ�"GFz�]o�J?��#�p���ٔjS�t�(jn�F8�
q؋h~;�"����&k���F�p-3S��������H�R�!��@�3�H�KO*!k���{{Vn�,��:����I�g|��4��0�	qb�dB`����`��~^��O���5������0�~;q�m�sy�@�0�GY�+���yo��II0���~kT��)�_�%M�%v�JE����,�f
<��=<�}y�I{0��c�s�Y��FE�Z�y�/�r{��$`�?g��GqG^7gMo�,�L<��^�F�.������9�`�#�
�����[���E��W�ԁ�BĐ]����k�.�N�<��P_S��:�7�Xp��֞x����鍞@0܊�� E������Cw�h�|	�lv<W��&=���g�Q�������̙,C`�@���l�WO_]nSG y~pz.�ay!RL�"T/�ە�I�r�i�yΓOR;�?
861K�١&�\ͦm�*؅�@���o瘹@^ �����'�L���v"��xи>��O�����U���^~������8j)��������Dﶼz�����y�n���}Lȇ�e�%����>�u����S�+C�yf���xK>�i�-|��V&AF\{9{�M��䬻�9�l�uӜ�T>v4�9�z��[Ǔ��K�m�j��:���*���՝��s��P[�<k��E:]�~<xo�g�,I����Ld:lG� k��?�9��8�e���_�ȀpW��p��c.r��ko/�V�W�9�M
�ژ��R�m�9CsX��f�;w��O9�l?}(��ݶm����L��~>i�*��GCx����Fy�戞i���z�cJܾ���;��U����u�'}�9%���cto�S~�w[Z�1��1x���b9FW�����1劥oٷf�
W��_�2t��T�ZWc��U-s�D}&k����:�}�a�Z�a�7�RfͳW��b4��%�.�bM��*��N^����hdo/q�ޏ5t��%f{�ZD�N�\���Qg�Y�De�``���Sg�"_���od��6br��^�;+��.
=ZP�L�����@e%_�Ӏ���FI=_Ew������^��үȝ�K�ف�X���+��&u��Y˳y��dfK}���xZ�ݕ�������xc��e4=k2c�C�m�k�E�"�^ڐ�z���%f�ܗPp���41�Y�a{�����k����l�	GJ��B�� �_w|�l,�9B���VF"�~���v~�lCF�0��o����ܲ��nw�/�g1�'����<�j�:�;G.��d�]�{hfly0�@`�����܅+,o�c�E�{���X��d�V;h�hp��ɓ��т̿!%��Ci(�EHwuUO=47c�/�~
��hːiF��>8��M���N��sH�t�=J��M���}Q&�����'�0iM�η�G��h1��L��_������` (�)ߠ�$!�G�mz����)\�6�x�K���sNlh�Mq^¤ٟ�2,c��m����ۦ��z��~VI3~�O�y���k��Ǵ�Fɐ_�c��O���Bu�^�c�N�H���T-d�x��0N�K�d\��Ə��B�vi�,��V��}�ln�T���h��L��Ol�c���Xl��_�u�jƴ��h;Sk�t�&�_ė�R-	g0X^fh�r��v��1�o�g���b�C:*�X���~#�K
.����:�.�]�ׯm�v?��$��s�Z��l9Ί
����]E'��&T��˯?��N����ﭭ�&���]��i���[���2r9eI�I둌�,���l0ph�G��r*�5�6wQq����!Q�a���d�Z�GK�ߏ��P����8��!�p�3z)�I���Dx9�E�a�k*B��� ��>�~&�T�o`8����F9�DD����Z9L
.|ƣ�o�C��������#�n��׵<��ΰ���Z�Cֽ
�<R�,M$��_/vG"�)����������R��m�b��:���K��Gl�{#���P1CYMDSn@��W����F�fr\�N��0�!v��-��ǰ"�Fq3P, ��s[�^ǘ,����Z��
�'���]�6O�\|��{~P(���2|d%���1`
yY ��ġp�LʤmX�Н�S�]��yw�=��
��M�.[*�r_�b��r��y�Ď۵lB�lw�J�g!B��2q�z�aQ<)na�Қ�6+�a�`!)�-����1^�Z�=P�C̕� =0�w�[:�?0�ŗ����V�_8&���G���H�H�>�(2w	�&Lj_q;C���e�L�ݢ��	�kt�y�q����ޟy������]c����̵�V]��.��s�2��-��g��̺���,5t�~�:�dM`̴��-{�*�x��gg�+\r����
�h�B�0�s]*����.�:[���a��Z�IVP'F��2�.����"��0��(���j,�T���/#�V ���[�a!<@�~�F/��!�1,���2s�;{ZU�p���σ�I��u��k �yG�/x0/[�e����f��O�): �oZ^�]���������7m�
\�P�܃�������������d0y��D�|T����Gc�R�m4��g�^�z�?2N�����z��!�T���=�u~���χ@��,+����Ͷ:T��K��:�,뗓�ߵ����/>
�W�T�̥Gݿ�+�]sm�|��;���;���ώj�X	��i�	�� y\O��?�l����}����~:3�p�7��g;�|A2~ ��i���_��[�$��{�zƦ�?������>w=�I�f(%N�+$\�7m�d#Y�������_P�_P�1���ǿ����?��_���'}+��      x   �  x���Mn9���S�n�~XU�]��fc�l'A&,g���<Z�$���Vm����U�iС����z� Ï������z��}}��2�����ߧ��������T�Ded�Кx(�/�jՅ�)�D2�IC�9��o�/��<	��)S$��P0�:%�2��"�-����S�9�M"#Y�d�{�w�ܯo>=��|~���������ꩇ*Ě|���;�����b"U�x����Ej6�͜�y�.^ G�fD���ۺ �)�$e��W�IS.tR���'�'q>?~�s �o4W/�H��m}ù�У���l�:fX⒨�<�e�O�3E� .%��dt�8�K���!d�9�H��u��u�pu�:��"�U;u� �����_�]���pgt�d�]$�+�����cuw�l�&�?�3V\�xB)���A�Y��
��2<�z����$��g���c�[{D�c�Hl��@���p˯vk�$
�>�9�z�,�k�Y]@5*IΗ���x�^qM�[�=ĪT=5ϫ}�(a(%���zOԊ�A��5��vE�tӛ])W���Ԝ��bs��gTB*'���zGT�(-�;fjx;�E_9N�QHlPL��1���iм���֬����g&�/�L9��VǐT���l�ŒΎ���m�&��0���i��0<tbٙT���V�!�f�Z�
[��׷X�TG,q�m}���ǈ����"]�U����6�#�ڭ���E5_ZVcg�A5��P�[d��/gם�qdu�;]�b���,�5y��׸��z��6s����J挠J���c���M���L���>�NcFQ(�E<R��W�7�aH[v�=�F�#�u�o��授�wr�k�[��LR�T�a�-TՈ��� ;L�nU%�RL���᪻P�E����(�:e�뇭(X
�-��tm�U�<�a�͑%��8�᲻\�d-�C?
�Yo�.�#�v4����!#��rGs�)��&���w@m��G�Um��#�G<�$J��>[��lj�_z�dqT����
UB�4��K�GO*m<�R�2Kq4���zCZ��bA��$�9����#�X�N��Ge*���O�WB�R��w6$C�;��ɼ��+/a��Tt�Lŧ,����=ѣ���&5E��ۢa�=�}��JE[漃���� �MP��7��ILVR]R�;FU��^_�["3c��kL)�u�2�      |   e   x�34�4�t�K)J-�,�/.I12�S�J8���u�t�M��ͬ�M�L�M�͸�ڼsS��JJ��|sR��S��bnnhd`����� �"      �   �   x���=�0Fg�=�㶴#k%$���!�M���SP(,�*���l#�bV�ƾڞZ N������c�����Ri#@���:ȉ�W][�+�l�S�l����j_{�۴+����љ�,�4���=f�D���V_�3�v��O��K���c�	?͇�      z   P  x���;n�0@g��@R$EY[��A��I���+'�S��4��'�D��6mzC�>�}?��4�V�Vj�A� >��ݘ�C��Pgƶk�A"�e^P2|F����Gd+�!�3�F.�8�'�9@@i6�}�{�Mc�6�C_��M��ڮ��cPЋ��|��YH�$� D�Xs�w�!Uz�E\D�/!j�
&�a
V(�\���K;N��fB�0�b9�xӥM�X,�G��F"-���/�.�<^K��6�lc��+�7lq�d� a1��3sP�L�$o�i-u��-���R���4��f�u,��"��=�N��Y�a�����@o      ~   �  x����n�J���S�"��\�3�,R4��i��٨�PH"ח<��,[�+�e7+#���C�'gB�	$ ɼ^�~/�e������Ow��������������	���L�S��:�!��,��*�I����2�.V�E��Oe�R��yp�!0�p0�:����E:_��_E���^�Z���x\�^�=$�rpY.FE�-q ܳ�ђ�Z I�Y 	Z�h��J̍ ��V	�$\3ǌ}�V���ȫ���J�%qt�L���9z�
���c�
8����4n9�Z�����1BG�	����y좷=[ؘ,ڜ�P3F;��K�<�g��i Lh?�R�N�T�C��׮^V��,��X�U�<������x�D��sf�G��Ad��Ad<�DC]B���A*����4��r{���âZ�1d�h�`���IP�j<���9��97��GVC�hG�`��8��v����^Ҧz��iY�՟�l���X?�׫�
rN>'̐�"��s���\kP	{`t�e��R�-�-�.��oo�JM��x��+~��w���/PC2��>S�Y萱I���	�)��9�o�|�X��;�yY<�ڜ�n�d�W]V�e<��xVbc�aP��	��B� >����)��@���F��
L,����eh���pg��C�ѩ�<�ɃS'�Еo�a�Z����I6�γ!�����^��^�Õڸ�Oj���}��Uc��}��ov�w���ǰ���>��� ��u�&�0�Ӽ�":R:��z
QC��x���Ԕ=d��������"8�x�Yk-���=L`]ۿ�֔�F�'j���H�8j��8�:�;����q���x�����ќ1Q9Cޥ�[��Sfs{>�@��yU��$[�)z�!Xu�/�L&�� )      v      x������ � �      �   t   x�u�A
� E��S��3���Y���%�$8�\������Xq�QaVW���n@�8����nmLpd�Ği!-��jHJ��������6+z����#�(qI��9h���=�s�-T'      X   .   x�3��IT�M,JN�4202�54�5�P04�21�2��&����� `D      A   o  x�m��n�0E���T? �K%kb��U��v�߯�? ��s��\o���l���qƕ6�0�^��6��2Qx���4�5{\����&2|�]��AY�Ѐ+�����=�EQwex��9���-8i4�BR�7-�����[{�K)���j)����}�K�+U�7�ѥl?�����vuz$M?��T���D"�
��ʍ���P8�9�>��m�A�U��EeW�2n��n���]���kX`^�/�c��t:�n�}�9ͯ��`�{q����TB�!�;���>���m���e*`2/M���m�Td_��!��_�w�(�ӿ>M����@�t4p~��cE���N��y����~:�� ��`      F      x������ � �      G   (   x�3�t,(����OI�)��	-N-�4�2�"j����� ���      M      x������ � �      C   H  x����r� �5>�/���KvS�,f�M��Q�XeK�vg���:�$��s�!b�%�m����E��t/��p��ί�?u�O� �o��&��(��01�y� +F�@#�M?0�|+��=���+�Pj�'B����95�Tjj�R����Ѓ�� 6��H��b���L� ,���0�*�տ�Ot��&nyn��օ,%��Y��m�a���\�zU�K�
�Z	7-R��nX��]!�=0/Am�3e���hૢ=	$��-og8���Rwv󍻋���x����h�����R�ץ+�A\hܔ-�{�e�6/
5m_�Nd��ǹy7%��D�G`r,e��<���?L}01�����8h��L��"f�C��-��s)�ՙ[��+⬡SHԴ0.�,���?�8@/t���V�'�ÙRٵ�����l�[aR<Kzdp$A'�*l(��ݢ�6/NME67�G^2[HS�M]0/_<=7��Z���Hg�N�Ύ؋��+�z>i���`5�*�1
�y'ን��"��;�B,7 ���+�����|S��~�ʥ�'Ƌ�/M]0/ޜ��4=��к���ɳp���K
��O�D?�������0>٦�c!��1�@�Zb��"������5��N;���Y|�O������bW�	l�d;�5���Ķ)ݎdz׵A�c���2J�E_�����3f���)z`b�Ds�nl�XS̢df�2W�~<����e!"�t����z|���`|$�9՟�+?^���E����Q�CO����r�����bV�DZi�a��q>ƯvDL̕h݅�Bѻ��M,������}�y�?n@�      N      x������ � �      P   5   x�3�L��-(��ILBbr��Z(�Z�Y��`����� Ȫ�      R   :   x�3�,(�/KM�/�4626�����Ș����X��H��B���������W� �,      �   �  x��Mo�@���@�kgv��{�Z��ҪI{�T��AF$�؉TU��]CJb�W�@�����Ȭy�3���9<:?����srz��x޹8�����*z�k��U�������b�{.pU��xx;Ձ2��ɸ���ԑ<�Rfi�B0�ݸk�wW�t��ow =d�n�I���e�����<��?��Y���1?qP\W��q��ϯ��Y�L�ى?;�w8��r��@V�UđK"�R��w��~���7�HŖL�c���X������AJ�'�d�ӛa�e:tk	�؈.�ZZQ�uQI�F�b���(~l���
�\GkP��g�00���isg@!��d8�h�Ԑ��voH	�Hh�ڽ��P4H��DuT�eڤ���n=���_E�\��#۔�c�k�>�mN1d�F
��U$��ں��J^�O�"3o����T�!���+�[�-�.U:��;�"F�X8[�A�n#�\��E���J� �nF F� ��Ⱦyd4�Vpߍ컑�VAK�;K�1pV�NSɩK��
�Ȁ��o���$,�z=�&�i��9�0K���J�K�QIe�)���3b�Ӗo�DK^��>��rI���z&���
/VZ�,)+)��.xF���+���^��Dݨy&��t-6�~s@L:fc��Gn      J      x������ � �      H   �  x�%�˕�0��(�}���Ǣ8��.�%��O����~v��s�ڽv���zf��yv���;�w~������g��Ο��;w����9^_�&��C|�B�P!t�!=Ć�CT�:2��#�\����|��#h��i��(�<�G�{��G�{��)7_Oi�'5HvI˾�%���e�}w?�B��.�N��*��eߩ���j�LR��/K:��45MG��&uN����I��wD錊�8��8��8��8��8��8���?��8���8��8��8��8��8��8��8��8��8��8��8��8��9��9��9��9��9��9��9��9����h���ސ{E8��9��9��9��9��9��9��9��9�c8�c8�c8�c8�c8�c8�c8�c8�c8�c8�c8�c�]�����{�9�c8�c8�c8�c8�c8�c8~�=����}      E   [   x�3��M,.I-rI-K���M�+�,OM�4202�54�50S02�20�24�&�e�阒��G�cΐ����|�t�pf楧�e���/F��� pp3P      h   �   x���Aj�0E��)r�v2Z����x��8$S��u:Ci!�b��C�I��2�D}�����&x���~*W��}��رX����ԉ�;b��m������������:E0 -��ey��̅��ߒ�IC���H�C��mM�mi�{��Q�j�}�D����|I���[�q�C�uO���I�V}�ᐙ�1�6�X�      T   /   x�3�t���MM�L��4202�54�5�P04�21�20�&����� ��      j   B   x�3�t�+)JLI�4202�54�50S02�20�24�&�e����I�cΐ���Ĕ|����qqq ��      L   =  x���;��0��:�
[3I��w��7����р�.����ܱ�;�T�h'q��KQ^T}2Rg�:�1<�#9A*q�N��mzW��EzS��5)k�v���z�@V5(it��p\k�>r�GI��{���9�'s�?�GN��}W �̜�_�}s����4�fcY��UU�m�J?Sy��oS��Qke��c~�����]J�K����o�fң�;l�ܘ�q��᪥��҃�R�*f��Q�0��=��(8{	�����K���oޗ+�<m1;�Sw�	�9��� Z�эw&|G�.�ƵZ�'��     