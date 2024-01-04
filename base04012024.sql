PGDMP     )        
             |            cp-activos2    14.4    14.4 "   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
    equipo character varying(30) NOT NULL,
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
    nombre_propietario character varying(50) NOT NULL,
    razon_social character varying(50) NOT NULL,
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
    public          postgres    false    255   �      \          0    43636    cargos 
   TABLE DATA           I   COPY public.cargos (id_cargo, cargo, created_at, updated_at) FROM stdin;
    public          postgres    false    237   ��      f          0    43681    ciudades 
   TABLE DATA           o   COPY public.ciudades (id_ciudad, cod_dane, nombre_ciudad, id_departamento, created_at, updated_at) FROM stdin;
    public          postgres    false    247   3�      `          0    43655    clientes 
   TABLE DATA           r   COPY public.clientes (id_cliente, nombre_cliente, nit, razon_social, detalle, created_at, updated_at) FROM stdin;
    public          postgres    false    241   ��      r          0    43815    colaborador_sedes 
   TABLE DATA           q   COPY public.colaborador_sedes (id_colaborador_sede, id_colaborador, id_sede, created_at, updated_at) FROM stdin;
    public          postgres    false    259   *�      ^          0    43643    colaboradores 
   TABLE DATA           �   COPY public.colaboradores (id_colaborador, nombre_colaborador, identificacion, telefono, id_cargo, created_at, updated_at) FROM stdin;
    public          postgres    false    239   c�      b          0    43662 	   contratos 
   TABLE DATA           �   COPY public.contratos (id_contrato, tipo_de_contrato, codigo, inicio, fin, estado, id_cliente, created_at, updated_at) FROM stdin;
    public          postgres    false    243   �      d          0    43674    departamentos 
   TABLE DATA           f   COPY public.departamentos (id_departamento, "nombreDepartamento", created_at, updated_at) FROM stdin;
    public          postgres    false    245   �      p          0    43798    detalle_movimientos 
   TABLE DATA           r   COPY public.detalle_movimientos (id_detalle, id_activo, id_cabecera, detalle, created_at, updated_at) FROM stdin;
    public          postgres    false    257   R�      Z          0    43629    equipos 
   TABLE DATA           L   COPY public.equipos (id_equipo, equipo, created_at, updated_at) FROM stdin;
    public          postgres    false    235   ڕ      V          0    43615    estados 
   TABLE DATA           L   COPY public.estados (id_estado, estado, created_at, updated_at) FROM stdin;
    public          postgres    false    231   r�      t          0    43832    fotos 
   TABLE DATA           Q   COPY public.fotos (id_foto, foto, id_activo, created_at, updated_at) FROM stdin;
    public          postgres    false    261   �      x          0    47977 
   logactivos 
   TABLE DATA           o   COPY public.logactivos (id_loga, id_activo, activo, serial, usuario, accion, tablaafectada, fecha) FROM stdin;
    public          postgres    false    265   J�      |          0    48016    logclientes 
   TABLE DATA           a   COPY public.logclientes (id_log, id_cliente, nombre_cliente, usuario, accion, fecha) FROM stdin;
    public          postgres    false    269   7�      �          0    48035    logcolaboradores 
   TABLE DATA           �   COPY public.logcolaboradores (id_log, id_colaborador, nombre_colaborador, identificacion, telefono, id_cargo, usuario, accion) FROM stdin;
    public          postgres    false    273   ��      z          0    47996    logcontratos 
   TABLE DATA           y   COPY public.logcontratos (id_log, id_contrato, tipo_de_contrato, codigo, id_cliente, usuario, fecha, accion) FROM stdin;
    public          postgres    false    267   ��      ~          0    48024    logmovimientos 
   TABLE DATA           �   COPY public.logmovimientos (id_log, id_cabecera, id_cliente, id_sede, usuario, detalle, fecha, accion, id_tmovimiento) FROM stdin;
    public          postgres    false    271   1�      v          0    47965    logs 
   TABLE DATA           U   COPY public.logs (id, tabla_afectada, id_equipo, accion, usuario, fecha) FROM stdin;
    public          postgres    false    263   �      �          0    48051    logsedes 
   TABLE DATA           �   COPY public.logsedes (id_log, nombre_sede, direccion, contacto, telefono, ciudad_id, cliente_id, usuario, accion, fecha) FROM stdin;
    public          postgres    false    275   S�      X          0    43622    marcas 
   TABLE DATA           I   COPY public.marcas (id_marca, marca, created_at, updated_at) FROM stdin;
    public          postgres    false    233   |�      A          0    43500 
   migrations 
   TABLE DATA           :   COPY public.migrations (id, migration, batch) FROM stdin;
    public          postgres    false    210   �      F          0    43528    model_has_permissions 
   TABLE DATA           T   COPY public.model_has_permissions (permission_id, model_type, model_id) FROM stdin;
    public          postgres    false    215   ��      G          0    43537    model_has_roles 
   TABLE DATA           H   COPY public.model_has_roles (role_id, model_type, model_id) FROM stdin;
    public          postgres    false    216   ��      M          0    43579    password_resets 
   TABLE DATA           C   COPY public.password_resets (email, token, created_at) FROM stdin;
    public          postgres    false    222   ��      C          0    43507    permissions 
   TABLE DATA           `   COPY public.permissions (id, name, descripcion, guard_name, created_at, updated_at) FROM stdin;
    public          postgres    false    212   ��      N          0    43585    personal_access_tokens 
   TABLE DATA           �   COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
    public          postgres    false    223   U�      P          0    43594    propietarios 
   TABLE DATA           �   COPY public.propietarios (id_propietario, nombre_propietario, razon_social, numero_telefono, created_at, updated_at) FROM stdin;
    public          postgres    false    225   r�      R          0    43601    proveedores 
   TABLE DATA           �   COPY public.proveedores (id_proveedor, nombre_proveedor, nit, direccion, razon_social, numero_telefono, created_at, updated_at) FROM stdin;
    public          postgres    false    227    �      �          0    64331    registrocambios 
   TABLE DATA           �   COPY public.registrocambios (idregistro, tabla_afectada, accion_realizada, valor_anterior, varlor_actual, usuario, fecha_hora) FROM stdin;
    public          postgres    false    277   |�      J          0    43560    rol 
   TABLE DATA           B   COPY public.rol (id_rol, rol, created_at, updated_at) FROM stdin;
    public          postgres    false    219   K�      H          0    43546    role_has_permissions 
   TABLE DATA           F   COPY public.role_has_permissions (permission_id, role_id) FROM stdin;
    public          postgres    false    217   h�      E          0    43518    roles 
   TABLE DATA           M   COPY public.roles (id, name, guard_name, created_at, updated_at) FROM stdin;
    public          postgres    false    214   0�      h          0    43693    sedes 
   TABLE DATA           �   COPY public.sedes (id_sede, nombre_sede, direccion, contacto, zona, telefono, ciudad_id, cliente_id, created_at, updated_at) FROM stdin;
    public          postgres    false    249   ��      T          0    43608    tipo_de_equipos 
   TABLE DATA           \   COPY public.tipo_de_equipos (id_equipo, tipo_de_equipo, created_at, updated_at) FROM stdin;
    public          postgres    false    229   I�      j          0    43712    tipo_movimientos 
   TABLE DATA           ^   COPY public.tipo_movimientos (id_tmovimiento, movimiento, created_at, updated_at) FROM stdin;
    public          postgres    false    251   ��      L          0    43567    users 
   TABLE DATA           �   COPY public.users (id_user, name, email, identificacion, estado, email_verified_at, password, remember_token, created_at, updated_at) FROM stdin;
    public          postgres    false    221   �      �           0    0    activos_id_activo_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.activos_id_activo_seq', 19, true);
          public          postgres    false    252            �           0    0 $   cabecera_movimientos_id_cabecera_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.cabecera_movimientos_id_cabecera_seq', 24, true);
          public          postgres    false    254            �           0    0    cargos_id_cargo_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.cargos_id_cargo_seq', 3, true);
          public          postgres    false    236            �           0    0    ciudades_id_ciudad_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.ciudades_id_ciudad_seq', 2, true);
          public          postgres    false    246            �           0    0    clientes_id_cliente_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.clientes_id_cliente_seq', 7, true);
          public          postgres    false    240            �           0    0 (   colaborador_sede_id_colaborador_sede_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.colaborador_sede_id_colaborador_sede_seq', 1, true);
          public          postgres    false    258            �           0    0     colaboradores_id_colaborador_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.colaboradores_id_colaborador_seq', 5, true);
          public          postgres    false    238            �           0    0    contratos_id_contrato_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.contratos_id_contrato_seq', 5, true);
          public          postgres    false    242            �           0    0 !   departamentos_id_departamento_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.departamentos_id_departamento_seq', 7, true);
          public          postgres    false    244            �           0    0 "   detalle_movimientos_id_detalle_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.detalle_movimientos_id_detalle_seq', 51, true);
          public          postgres    false    256            �           0    0    equipos_id_equipo_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.equipos_id_equipo_seq', 19, true);
          public          postgres    false    234            �           0    0    estados_id_estado_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.estados_id_estado_seq', 3, true);
          public          postgres    false    230            �           0    0    fotos_id_foto_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.fotos_id_foto_seq', 13, true);
          public          postgres    false    260            �           0    0    logactivos_id_loga_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.logactivos_id_loga_seq', 120, true);
          public          postgres    false    264            �           0    0    logclientes_id_log_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.logclientes_id_log_seq', 16, true);
          public          postgres    false    268            �           0    0    logcolaboradores8_id_log_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.logcolaboradores8_id_log_seq', 12, true);
          public          postgres    false    272            �           0    0    logcontratos_id_log_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.logcontratos_id_log_seq', 18, true);
          public          postgres    false    266            �           0    0    logmovimientos_id_log_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.logmovimientos_id_log_seq', 81, true);
          public          postgres    false    270            �           0    0    logs_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.logs_id_seq', 51, true);
          public          postgres    false    262            �           0    0    logsedes_id_log_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.logsedes_id_log_seq', 31, true);
          public          postgres    false    274            �           0    0    marcas_id_marca_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.marcas_id_marca_seq', 8, true);
          public          postgres    false    232            �           0    0    migrations_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.migrations_id_seq', 24, true);
          public          postgres    false    209            �           0    0    permissions_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.permissions_id_seq', 69, true);
          public          postgres    false    211            �           0    0    propietarios_id_propietario_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.propietarios_id_propietario_seq', 2, true);
          public          postgres    false    224            �           0    0    proveedores_id_proveedor_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.proveedores_id_proveedor_seq', 2, true);
          public          postgres    false    226            �           0    0    registrocambios_idregistro_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.registrocambios_idregistro_seq', 31, true);
          public          postgres    false    276            �           0    0    rol_id_rol_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.rol_id_rol_seq', 1, false);
          public          postgres    false    218            �           0    0    roles_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.roles_id_seq', 4, true);
          public          postgres    false    213            �           0    0    sedes_id_sede_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.sedes_id_sede_seq', 15, true);
          public          postgres    false    248            �           0    0    tipo_de_equipos_id_equipo_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.tipo_de_equipos_id_equipo_seq', 3, true);
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
       public          postgres    false    241    249    3693            l   O   x�U���0Ck�,���)3��@$@[~ų�p:�	5��[{��ƙ�F�B-(l��w,=�[�\휎r�"r@�      n   �   x�m�1�0��9�/P��	��܂�""5N�BNOK���}}�G3\� p@��d�d=���bd�%�9Վ�;�,���&u�G磿�9u��v�ˎ�������[Ŷ!�u��E���9�=���d�� �1D      \   w   x�m�1�0@�9>�/d;U�`�X"�*K���"q|�Ē����حy]�R�ڭ��$E�HRJ*42�P�_����Ϛ�f�0o�mn��Ӱ{��U��͑8RF�G�<��' ��*�      f   A   x�3�(*MMJ,�t�O�/I�4�4202�54�50S02�20�24��*�XZ�p��qqq �e�      `   �   x�mM��0��)n�;��;�&=m�8�%����Z!��ԡx������y-9���oum�/�N(�()n2�"0������׶hِ5؂E��-�i�S���q��,P�R�fgٲ������Y`S�,\W�A2耜w�ɝi��h���?�      r   )   x�3�4�4�4202�54�5�P04�24�20�&����� ���      ^   �   x�m̻�0 ��T�s?yd�@$�Mfq�l
��& "��K0y{t_�
��|Yq�!2V���3#i�9d8[�������-��m�8ٺ���@HE�\$�g�"e�7MH	�{*�?�S�9M&�      b      x������ � �      d   2   x�3�t.�K��K�M,JN�4202�54�50S02�20�24�&����� ��      p   x   x�m�1�  �^��2*����bH���v��v���p�[���C>E!3��Vv�ڡQ'�V��i���Än� .���9^��c�2�^~�KSh�[IK���Ƅ������f��r�,�      Z   �   x�34�����,�/�4202�50�50Q04�26�25�&�eh��_T��������[PZ��E�961.Cs�Ђbt)s+#lb\���y�9�U�)����&�eh��Y\���qbJfz>���XT���rSSlb\1z\\\ �n@u      V   _   x�3�t,(�/KL��4202�54�5�P04�21�26�&�e��\�X��W���R`�k`�k`�`hbelled�M�˘3(59#�
j��961�=... r�"�      t      x�̺Ǯ�\�%6ֳP �S��=����ɠg�?�x���U�A� ��������欽Vƅ���H���j��.��������O�����n��NͰ�-0.�*ÃX�v�o�̺����3����dn�i��n���~Wp��$a��x��cX���ib�<�����������'����E���U����%��}X�m�o.�П���2����٬�M%��{Z�l�C�O�l�_����Ŀ���m�_��*��R�g=;�v�?��TV���<�-����s�fI���7���9#�_�2#(�°*��������~ƌn37�a���3/8>����?���=���Fd��0�����gΰ8#+Lj�##�L�0?�ba�#����~C'�L���{�\��s��r$~��߆��/"z� u�5Ŕ�;��,A�o�;���a0��J&�:��K߉���n|���Y=��r�����Eo�������#���C�����=���Գ�_j!bN� �����D����d<������o=cE�1��wG�����?{������_w�B���V��ڴ^�e�b���m������2���9�1���;������$N[fmCfO_c�w]m����oGe}���H�Ir�L>9ǿ�B��]�����Y�T����AMلv��@p�B�?�z���)���;��?;�h˽�:����?���~�ǣ׆�ڱ�1�߹��g�9�x'�{����w��(��N�P�XWc�T�Ί�Mn�Nu)�i�:Ls��L?%T�3E���"b��H���{�=�K`���AAp9���v���bDjNJ���N�pj�PnD�_�N�"�&{g��P�fg�b�m����
�hˬ顪-��/�y����m��;Y�%��W�����(x9�������#:�|1�!�
���aQy�\#ϝ��������UE�(;'tم6���
�~"Z�f��u��^5�h�h��麊�k���nbb���3,��s��\��-�D)��u��VQuݷ��qz��<HH	���^FT�,l�v?ŭ�g'��ZK�j×!/��P�_��B���Cc�����P-,@�g��+�.��F^��sb�J8�����0Zя�x� �u��Ɏp��f��(e�Wc	 ��|���CE�T���
P=B��<�.�?�诇�|������pM K}q7���`.t�Bm�1����=V�m�(�z����	ҩ�a<�c�Y�B�3&Їd���,"��p�T�F߰S�5`Z�d$`\գrA�8���	-�ע�	��o�mu� X�U�P��l�*-��v���+���Y/z�(Ҍ%j��8'�:��1`�����JY�d�g���F��I�L@)�3�KԤD�ö�Z�t�Bz��H����GzupM��6ұ8��������;����0b�f��?��0���L���nw�܆�f����=�5}�w������Pws���/����@��[�!�>���2�D��E���������	��/��.�=�<9]oؼWl���<��2w~�'C�����юPAv��W������*�?�ql��#*!o`��(�܅�a�9�W��5g	�F�;Ga՚�S>._�R�x[���H@S��N����f>E�g�����ށ=��bPT8��O�b�.+1�,�I� �;KڴU�-M��e��7��I��ݓc����j�A��a���E)���5���boy���v%bq�X�͝=U��;�k(�i��a��o��E?�������a�[F] w�h�������R�%������cUԃAZ�kC�^#R��23�gPb� M�.�� �"�R|�8%d8x��{�-��X�k#`� _kY�#	2��,G�>��:F����*�8n��<��� �<:��m:�4qW���^�?�xc�S�^A��/�r��BX�4rdцz�=�v!}�:�SY�cq ����YC��Z�O��; 4��9A��
��p`>�1�h�[m�O�c���Ο����:皌�G�U� ��<G����~r��5ـ��}����H�=�f�?�D`2��;ྭW���,�](�πW��@v�KDe8��[]9ؚ�_�C�$�d%�*��"�AbBA�R���d<���%;��e��^��R���޺� �չ򇲦��q� y�I{��-�7?<��0.��4��Cᛄi ��˳.�� ���>?_53���a4f���JF/��Êtǂ�f½�V�{�J�{c�/�2Ve�|�����x�xЅ�B�@#�}AS��[s�!��/�4���Q�lN�ɭ�z��Lc�c./����Z@��^���Q�s_:�'�ߪL�%�e'ӰB��].��^��z��>�����z�k�{:�T�n|Ӻ̻*�<����\�ec̩��,c}x!{��)���I{�0)����a�sp�d|�)�Y�T�޿<�L�S-{�s��H�)�[Q`�e��I)�vt׍7;�ׅM_$i��O����A�}]�&�y0}ܤi�k�5/�2�GE�W60�iuϷ�)U���uv�E�4'n�@wZ2i��Ri'�uJ����e8�Y2����N_� ԇ�^jc��:�^��~PK����c(,!��n[��U13�,��Oぽ^1v��K�Y#���%��\����]3��iRo�l�H�"�1�/�w���$W	?A���B�J�K �K�O昲sv��Kg�=v����}V��ͬ�"?��0��(�[:&�)S(�����]E����!͵�ǥ�-z'�5��RȤa7�:��{��*����[d8�;=O|��2D���m# y�}��9���������bWI��k���n�&f�R�Ei/�gw^]3W	� ��0RU%�"�Y��$M�r�mJ�y���
0���Mo�x�C��:Dl��T &���2�x���-��}��
�Π�����x��p Mr��(���AV�ԉJ�N 6RE{��0��ɣ
[|������-;d%����py8<�so.��s�["��]Ts	��Y})f8x��r19���.O͝&�vZ4$���`5Ȅ�C�&����M��������1��g:9��S�i�f[HNvVF�v��}P�a�%[�l����}Ć��+�Ѝ� 2�a�<�V�$�k3�{�H2�$��.w�]�?��G?B�W�>j�|���.04/�N%t �A�6w�|m�"=zX�wMe-7�m���p�R��?b_��:�K?�0Hp��֧��T�wq�������>�����6�c��1 �I�x�T�^���YI�]�OzU�$+�c��"Ϻە�`���(�ǉDp`L���z��w�`��J�h�1�?$��������V���{C-��K�2��5 �d�a����M��d?t=�H7��l��J:fH���&���G�ȶ�#!����Ҩw�v� �����Y�C�k�)������i�K��o,��xd�ݷB泿�+s�Ws;i�Q�6�w���w��Z.�j'�.M�>ݻ-�!�7*,�E���iE�_?�g�o����B�Q0�z�=mT2BP�%0�L�� 8��O�V�^F��n�����Cowꏜ��sC�k	���	�X-��6��W�
�m8QA[+����>~��_�M�ˈش~�)�A�lx�F,�@��p6�����1�m3�-]
3 �HP�Ɵ�U���l|��g�a@a�O�v�f����]�Β���xjvE�7ȖF�7���\�a���-k��HA��I��v�c|7�
3��A���绖��vzk[A>�)��d㊏#n��<l���0�Ӱ�j)8���mi�q��=GWAb]��P��M�SjwO��Z�״�o���?���*��'B��2 Gn4o��e�+��֙q��b9T�������U�I�2d7�~�;����^�w��ͼ�����(6F���h0�o}=]v��8|�m盠1��Qk�+��9�)��Y��41���j���������F��QS�g�i��_N�G���2��+~��NڇB�    �.��I��m��'�/��L��qx������Q���E?٥������Ɲz�V��ʄ��;��!�;2#G��k�}��q_a�f|�]�BXW���na̬@xڳdd��Y�������6�B��|0�и�܍���2���=���z.�Y�]6^�~N���Dܿ+=aɁ�4T��plŌr@i�<zw7V�C|�?�2If�~���%z���S�Է#'���J�)�������6�L�Q�qY��/Uo��s�=z�"D��[�<�����M��q�g[��	tު����z��!r-��vn9�L���bf��33s�܎̝�]�o�o ��Ϋ�R�h���ܬ�����~����f�
6���hQ�a�����^��R����s�#��GG&�V��ê��~�d칀9km�c;��<ef�=�Уo���(�����;Ќ��#���i��._�d&c*����{"?&��hK`�i_R�E�_��?~��ǔH��2�7]���B�n�V���������q�G=Dy�`_Ҋ�z��z�x2�k2�]����A���ܦ��R���oKuF�.����i�ܻ��������w�!��a6i�N���*�it�Y����5>N���7�1�����GA�9w=�Z���3�L�o��+�6$E�ē@�Hfs(iU�_ʊ�i��&�9�z��2A`�#g˔yծ�x���*�S�3u_�<�I�T=
�u?�0"p�(".6��3dY�2��gkDj��v1��)�����d�RAE���s8{Z$u�����3��~���ܮo�zח4 �eP60o�m�!I9>�����]��D�(�[�f��O�W�v-7甂�OGø����;(����3���#���K�=�D�nX9J���=��p������Lka?g.��^zv"�Z�ӆ�VxO�g���o������9�-����*�˃���<j�^:cg��WUkti[1b�/sR?�^�Ģys9��|hd��*`�.�xM�q��.h� "n�#�!9Ձ�u&D�b�o����FS�'hD��T�� �|z�WN
����)�[�e����?"�O�X���H:�x�WA�~�'���"�ԑ���2��0M�1
�B`����5�X�#ڨt�g�6���۶�K�nߢ%��P��EQ��vm]���[E/���v�e��	��(�m����a-�8��D(��!�pB~���t���r�`�Z���|�Ehf���|�wq�C-kdw��.���Y������W]e�UH�F�}�<Hm����B[f@�
"���6Y��g�TTp�}���qK�Pl�Bf+qf7�/D���r7�6`�J�.�JQ��>)?�i��PF����w��A��@�ҏ�b�Mgm�P�ǽ�����;����WIx�xƮ�Z���{�]���ʅ���=@���6"�ubT�i�%��,�n|?D����|�#�3韷w�K?k�!`8�j��@N��e���ԣ#lU�H�S�K������c�g�о`��|�z��7��'-ӓ�^����e��+Mm��ɾ�,�f*�&�H�C!]e�O�r܀<b:�摒x�%����/VQ�^�5��U��m6۬\H�6�>��8Y�����]���˪���|]/ �b�N�<O@+�EE�\}]�h��Mto���^E1��uY���PAӚ���o�s���ޕ�Dd�(����K\��μ��S%Hj{��5�|/���z,.ȋ�	��'���=�����'�l��l�rM��m%�q��A�"��ꀰ�����^�d$2�e^	 r�HξN�� �^
!��	��v	��UL��=�0�W�.��a�Q�\��x^�ߖ�q���.������&�v�Z�&LĮ�^/%Q�G �L?ŖP�?(�:"x���&���LN|p�qEܙ��ﺎ P�Jf�4ʝg��26(��R5j_>�����e-�����'+�<1����{�9�����܉�#�#ذ0�{^]4�G�x�Ӽ��6��B�K'�%�3���\v#�ҽ=������8�(Ř��qn�4&+@���f����:R�N�b��@��@p��[���P�a�%b�R�b�:d�in�#�<��:냊����L|ÐhM� 5�+����v!,�F�Ƣ�We5��0��"y��T[�w��U�m�#l�ץ�(I���Ox$�2���2R�afc��`�TaiOy�S�F�ɊDG �}o�bۺ[�c$�Kx���{�M�=u���_$�R�:B��!�V�4;-/���!��k��+݃ú�6)�36��D
�������W��s��K��?|��_C���FC�J�H/q`ۯ)�R��g���OR�{�!;������o,���Q"Y5���^�_�q�A]�q�z�c�7���&v;u�0�w�1���S�~�R8�Bo���M�F��◮���Y1w��=�GC�GX��?�������߁����I<ޒ�7o7����>��%�>"P�ڠ�B��l��4�H��e�e���Q�z�G�NV�Ym~i�����)�l�T��o"R��y��՛�\�|G��G� +�-zk���6��cF\���Q���e��f��j�O�O�G	sS�	#�����g�U{��|�f��6�[~XҝX�n��S:窩�g���5Ǐ"��OdY�E��ꉋ1-�c����snV�pv�����KԬ<m���z-uI9�:�/Z��Y�'��):�y
�~ �=����K�����1V������<֞:ێ9M��Y�K�J)^� �a���N���� �,����d�ŀf��Q�X�����Y�y�^������$L�Uh��,V.��]$k&2���.������:�M��M�1x�(�%���J��ֿ_��~�����kb����5���{r�vf�/ݰ�&�"��@̒}l�2� �������v	�Rߤ��j+{�LV잳ԟ�t&\��N��G &D��
�Ԭ����5㿦�0e�EQo�Īm���-p������BG�Pob
���|{��q��:�������#e�˴�S��|��%��r���j �y�{�W@@݀r=Wt��}�S�͘��^���|e�8
�<��)�T?q\�x�A5>��q]��P۰�$Oj[w�������bL��E��5#z�dq�ozY8�TS�}���|~��Tv�Y��}mU��a�0Mn��
4u%P�$���%���P�}t0����s|f�5�^�ɡ8!Z���E8T̔��(QbY� �l��UA6NG×��ߔ5v���nf�7l�ե�����l������ј5��l>��/��#��zj%FS[:NJH��c�P:L��r.|�O���;��P;^�=f��+��	�\�jKb��;+QWX���6�e>���-9�	����W��t ��E�l��Y�?�/��!�\"
�"�i�t.���7���Y7w��'����ȁ�P��fqa�_�I'���Y9총Y����oe�6;f:n�㮹�A�5�|]�8.�m�g9��I6H� �ȷ�o:�������09~胟�{&7A�ū��ɣ�+�gS/�`_Z�B{ }�d��^�����,�V��i�٫)��!ч�8Em�	�R.<�p�z��G����CF2#M�N��T4 �
d��������)��j���r
�_��N;�6�G����2o|��/���%��p߰	�����BH�\����� ��eC:I���&x{�����[g8�1�L~�� ���%�p��_p�����[�/�&����*ˍTW��8�$�}����X�L ������'"|��~�;b=?-y���0nG��s�sy�*Z��/�0T#��hSŊ�����<��]��p��V���u}�	���L��g�R��d~	���5X�A$P��=g���~�����v�
����Y+s�p^Ysi3�`�1&::��a��:�|�Ni�s痮�%�	�{���n~_Qip���kܯ+z7��R���e��}3�NGhdދ-�6�"�%�2MW��,Цr���t9ݲ��G��w���,�    Z��| �c�\[8\�rʢ-�Bq�)��:!͵ ���I<�rn�F$Y�tC!�RF�pj�Bx6�}�2������d��(�{�޼��ۑ�`�Q`3����A�6TU#U��|���F,q^���g�2�\��!�����ɍ�ɗg�aZ�tM[�W�MUV��*����s������i��{Efp[]G&����_/�w^���%귾�G��ˠ2c�!�]	wc-��m�s.rK���J!Q&�dm��֣�⬃̗֬��vE٦��b�|��PK��#�ד6�ȧ��F�� �b�//��;���K�.�Φ��=�i��2)�P9G��E�s�g�#g�~����;>����݇{@J�VD�8����i�N54�܇�ѷ8I�4^�ry�t�c��?�S���K��1Y����������� ��"��_|�5���Z9��}��:���ݥl�&����r�9|�]�>	 ��n-K0���2������Yb2���7.�W��.�B��A^����:�55���V��⦧Bn9g��ժx-�g�D��1T��eؐ{F݋�Qg��Wh�]��8>�0'�a2S�v]��OvW��1D�h�$tl4���z�����H2�7	�?��S�H�z���	�y�iP5l/���A��P��!���nK/BQ�����f/�D5��V�S���A�*��y�O��xUX�R�3܁�5��_����7��m`}��Pc��偖��fx[l��r6ȡ�M��+mTr�?qR��Æ�b�'�{lpC�L�^^F]�#o�[B	ܳ����?$�K���U���0Q�d[�����GI�[�&A��iO��D���c{{jr��(:��������"S�l)��*��9�~H�O̟�Re	]�V���L��]V�oC���_>��h70��<���X���`�KpzQO�z �����d���Ә��?���3�+"���T{�6x�ж��A�q~7N̒1�gk��wԣ���b)�-U��^�>�8��ZH ��O�Ac�ٍأ�ڪ�ݵ���p�7z�)(RM'V�3x�ķ�������砪�)�9�ʣc�� �$��{��^�'A�Ȗ�[�9CĘ�3�J�eL��z��i���RX��r�Tu���
���A ;�Vp�a��c�t�E�t)%es &'�8&���6�u�B�ț˺ �;�$�\��o:@z�4��l"�X��Gʫ̔<�⪌��A�1¼��A�R�F3�bD4���3-�j	([U�#�Q/OO��<
M}��3R�O���Z5��^OH8�z&��&m�_�*5[�;��9�~ԫ�R��GN�ֹ��7�i؉�b��A��aI�)Xy��
+s�vxm�� +A���W��$��܈`�%�3CJ�TE�k���Xk_[��l�m�Q��$5������x�h��x��UC�z+��@I�"�p��V�wQ�[��V����C8�t���}X���ᜊ�������y��X�H��6P\I�����f���3�� A�O�Բ(t��]��['�Hb8*qZ���LU҄�����Opک;�.�x�M���C�0�d\E3���6'�!���ؑ:;.Ƣ���R�|��*H-N%�i+��~W�/��#�Y�/��,5aHןӿ���݉����Z�d��:R}�`�j��Q��*iɺ�P=Q&1�ㄍ�2��(�B*_/V-[^"���<�L@V<z��|��A������,	A]*���S��6�z��\^����n���d�"|~.���̂@��4K3���H��n�k���Է����ӻ ��Y؀�T��_u5i�:a�[U=^}��Y�i�-�-��l6�����^#��Ӱ�֢��ܬ��\���T	$� c���t����.�)�gG�3��WLyG���&�w(l~��@[,�v}��D��=%�-�(77��b_���)�X�KN���spt�Z{��QH@_�c/i��nQ8�7���)n�I6��:����Q#aBUհ_����ٹH0���t>G��~���!��ڡ�� ���p.����[H�����%UNAJ���X~�P��^���G�������84O��y��q{}\>(��v��a�"��w�Eb[f�e>6�@��˘�'���;@\ߺ���!xwa`fe-b��O爎c��-7p��H�y��=��E�G���șԠ�Z�%�f��"���p��Z�%i|yr;ݫ���X�_bR[�5�]�Kd^H���Vq ڤJ_�m���<������
����"|�����2\q��R"���Gha�I�Y�U��6쑵�-���\��I�K���He!u�f|Sdl#�Cp��3������O�����-k���A$_��,�-]�i��1䲁F!ޝ��0�JIs�U5��LN]{�9�i{�-���w������a���N�]U��*��wUl���@[t2'�OS�R�����'�PȦ��L��X�T�nj�ُ4�b�t��x�C�ƃH���-�ƕ!�F�_�{��T/��D�HtsS����B�U4�k	��غ���R�	;���^,��b;]�+�0��ex���3�E�e������_~�e؁K��������T\{�[-PA�{���V����o˯!�>�SL�'��
Y�I}k[���Uţ��ˌ�-
O�Ǿ\u��<�=��	$xl���Y3\�������E9��Y�6!�I�`��hXb�����ն���#ڰf�j����/�r�ľ��m&V��~�����5ɾ��˼.{v�U�im�����2���*㹀���ɿ�+����}�Rg?f�d��06�	�`^d��x���\y$>�F���(đ���=/V�bWz)���v���##�^�sjX�f��8/�vɦ���0�\��������X]�:�T<�Xur`�öB|\.�a�g����FF@����8G<�%>E�	E�r�B�6��9�4�͋>��Ŕ���m�^��^D�:SӾo��'|�K�!8�u��

�(��JM[5��30�^;N��z\|gŴ2(l��V���ƛ���Ƒq���D����FD·�����g"0n}y��ǉ,i~S�ׯoN���a֎EZЎ����E�Q�b��\%r�R״����u�Jܓ� B� �F~��̼�ߍ�6��
��9�4\��k��v[�A&�ؗ���Q����pG>V��d��� ����t0p�����o��ZT��U�R�LX\��6�m`>E�A-˞��Oa��IPC�l4��}��!�4�_l�y6?{�������0��ɰ�`���ƗA.|��/��[�:�Z���E�ؖ��l5�Iv���F���K��R�至Yx���AE����D@L�οw��Ř~��8ڲw�Gߟ ��G��p�oR�ҽ5�ss��]R�����ge�F9�m�	�f�4�v��Ts��NNs�ټY��m����"�W�ޮ��U��?�sm�ߤ����b�TUy���L6b{Ddؠ�����y	LrC�L��Ihwrr��K�{�'�G�o������oav��l!� ٶ�����t��0TC8V=T�����*��N�0Й�蝡��*^>\�/`�}}��8{O�2?kjF�ϛ����eo�g����NʪnЄ���K�w�笭��I����%5�%�<�^��D>:xW���SDf�2̼�İkpL�z'�<��_Y3O�~u3+��E�e���f�!4 Ɩ������K�߰q<���;��q�͗!w��5��y��ўzG�:G��i��j^d[�9�'u�X'����|�{yB~C��0���~�o�c�I:�Ir;�D5t��&��uj�������>��sRC�}Zag�����ΰgE,���I�|M�k2ԧ{�/��,�T��>a�Wl��^�	]��j/��a�O��о��
D�v<l+��G+�my�A����zs4���¬j�w9��n�Z�^*�;ٌ<�(�N�8��Ū�k^j��Ԯ����Fzԥ�`0~������_}B|��t����Y�٭:0�ɐ��I\�)B�    �L�#�޹�>���o���bb[��������W���͟p�K`!{L.����H�\.됫� :��EL;�e�`!W�z�f#��Fw'&O��obn��73#���Ap�z_1�����@��m����K�r7'��#��]����`�e���_���O9��x�����uQwTA��/3@��=w��@����酥����F�+LtW�1�`!�LN�s3�~�!1o�v�"�)x�sj+���DAR�N��\�€/����}Ź��q����?kϵ�
�������)���T��.\�O��	�i�K�B�y� r�n��H���������7�*�l��M�e�!U��q3�e��Bd>�|�Rozf�j���k�$_��|�f���y�K�����YDgLa9ɰ9;U�dnkTj���A�8��e0Thj��mָ@@��1Af�Ërb�J!7_���?���^�H�����|��R����I��KS��lv�Rd�E��ؖ�>j	Q��aڙzl�}����A�@�I�����L�됁UH]�g��m�D_x_��gw�5��"�>FD�㦈pBW#Jb��	�v���[&�0�Uw"�ZGQ����s'�c������V$���d|�*��d�c6}"���޺�'mF������ɥ�v�A0��fKeVC�$��p�.�-��	[�H
1<,뮈�x~�ۭ�r&�#u^?�[��o^E��W�Sx��|�s�:��
!|\�Ίt���3�W�K��Ù.��=7�����y�8��̝Gr�JE� S����0��V����W�?BI��$�{�TBs���ãM��v��l���`�@L�.i8���,�Aug9��Y����r��X�au��� ��i�,��P�R���Qj���yDv��=����h�F�!�.�9ܕ��$foFB��֯�ܫ]e�HVOH��*Y�Z����\�?�"���jF��=d8�m�?�W�,�`������{�E�<�z���$ϯ�N�����UtAR�C�~u/��*PCI�1��UJlLlW����q侪ڱ���?պ��������^�Y��Q3� 7{_��ܛs����K��Rn^xqY���2yfÄ�� ��f��I����Vk�V��5����׊Z[�+[�̜[q
������o��n�����S��� N|�/S�ݔ���Taq�	`ZȉzdHvIܥM�O��A���vGS�h2/�ֲ�$�R)�$�;K7-�f5�x䗬�����!��P��{
s��y%dZ��}R��?B�%�	����X��	n�I�F&�^5�=z�p�S�}��*5�Iώ��T`$�P9�b� dv��	��g�Ԉ���{J�*7��?։PhSŰ�%V6���BKiM�0����֗E7'����������F_o�;�H�ά [������`�#��������]jH����)��I01bUr��Z`�ҙ��,�[�61��L�������~�L�TZ��dYB\7S>!9��Ր8f!+N�.�Y��e�z������a��¦����t�fӜ'����»n/�01S_Rf=�{(�״&FqbDU��x����S!��e-�,p��kc� n�_��{��s�yB �0\U_]#���|#�7ya0@�N��&�!�n��}�)�D�����z1��&C�0�j-Qo]����$�4 �¼��N��2�0����f6���Qn��T���vq�������%⃃��j��������|~fE����v��@$F�w��N�eK�̛-_r5X����n[ߢK�m�bb,��$Jl�ѷG[q�n��z�)�@�$�Z�_Ct)���U7�ن{sdŲ�j�e����l�fv�{|��%��s�0��|W�������wУ���f]x8<o�;�S��7����!q�H�����1}��4{������%����T�Y���3�A\����)�����-J��g��(}�ՍwM���K��*��a�bH�q?)�
����[���䕖��exo�ݑ��_n�@!��ӗ���E�AǶ�(<�x�@L��]y�^Ĕ������U���gL{ԧJ�>΂�8�A����k�n*;
UNd��YKƕv�6��c���r�cq�+MVN,@6*u����FU��^$��H);L�ؒ��e\�xf��ףT_V��Ԡx��g1a��/�"۲�y���!����al!3�'�؟����ls�,��������\jO�w�T�e�X��>)��E�+"I���lX������4d0�W3L���׳��v~�HU쫹�����$`q�r��7��)-\��Ԧ�=�4�z�q�w�A@G`����R-����s\������RH�ԩW�-�I(��"}h�P���_!�V�r� ���_�`�M#$��X��u�Q���X'R6*�]�]'2���Dv���3�A�xD�WK�����/S�^���3����O�ZB+^L�]���7~g:~���������n��xـ�r���VA7�|	�s���c���q ��l^���� �K� �Mo��I���Ωcj����;�4Q1�3[���u��[A�F�>Ǒ!z��R���u C�Q��N�����tMޫ��o�1�h��i?�����:���3��(h�f�i~�~�^"��@� ������
��h�z>0�O��
$�YO]�K/w����Qzn�5��ǒ�l��U"����t�SRmԦ��)cͷ5������Fw����A�{K$0��2�xlᩚf:m��}���,o��O�|��)����}Y^8���į�����
�����.��4��=	\���)
���[ _}�S���<�~�������w�P�%�|Ç���X~FWV����y�c�ǁ��M��uƗ`S�m?��r�FsG���yv��=����|�)��Ų�_�@>Ч��i��T�'��-�}0`P#w�gũ�w|p��0�.���D$L�!n,S�������ysB%���|"����|g���}F?F��FO�����_~ԉo��l�r����,�%1��ưA�lh6�y^!,~_�j�܄x*����I��#Q!>8p+{���
��6�����d��/A{����A�?[��?�������vږ��J��3�����N�;��	����)�z�/X]~E��ۇ�
3��d�\D�EH�b��s��ws��U �X�Dr�����#k���?Z��z�"O}~�V��y1k��C��y�؀]�]X�ۍ��/���>^V���Ѥ.��oB�`x=��;�=�=�Kx��^6���!�a��aO�ޮ�w�o�1Ƨ:�x-�҂z?�	.k{��p��`I�t��m�G�O;3����iC�P���g��<�KoXrb�{]�a^�\��~��o�M������NQOB/��{���%!��u`Uv`W�PAۥl���AIw'3������d��u����Py�V{h���'�t�����r���2�=��m�ܱu���F�.F��`(��)�/�ܻ�z��Y�A��h�9Pr���o4�J��jbO_m��aq�ە��� '�~�0N��S�܁MN���`�|���Xہ:p ��Rd�ʐ�Q��,�{Y�]��M���2�v�	5�@�f�����Q=�z����:��jؙ
�B��g�����J���z4O���%�)�{!)�GՆk]�;D����{�IB�-�&�.I���XK[���nJd�n����~"����cbo^��ߢ�J���M�e�	�99�7
N�x��-2�1���5�j7�s�j�'�]BsA|gk9�M@�iDA��u�f����/@�.��R��X֌����ݷ��E��I�@�Q�s}��:�1���i��M=n��QzI$�.�f#t�GΊ��n�U�$��� ���LO�.������(=E.Z��gU�.3�=�D|�vPs4WWb�s��ʸ����Jy��x^*t����@�~c�����Q7�٨{-�5���^ �gi��iw�    |AN�[&�Ǥ~W����_Yv_��7�`��İ��P���B���xޡ���{���esg����|�K<�:���D�_�	B�|����m��0]{�ԴK���R�.*���d��o��#e��nZiP7h��xF�iyFD���,wN7Rā����T�H��*r�Z/�Ny��)m�0����77��?V�T7��d�~��_���d��o>k|<��v�ưi5J_�\#���oT2+mV��c<1��D�[��ݷ�E��hQ	���+c����C�$�_�:�!�Au�J�ʉ�$fSū&UuR=�8G}�=crg��R&뱦k5PR5EΤ���:�H?VP���j�k���щuX���dd�n	���PA�$�s�~s�[�6FҨ{���v
�ӟ�/���Ű�U�C3DȾ#D{�T}�k����ߞu\ƽA�Tqg�j�j(�0,��v��P�8ٙP4+
VD�<�D��r�U���N�;g��z�;�_���t��+u�v9�ʤ��,5P�:�Gq�c�S�RN��8�V�5�`�')v��o��lN�k�H/��pO�-C�.�i,���~j�i�E����[�0���|$	ڣ^�b|g{�����g�:�ۃ���$�~�=S�����~�.}�_Y8O��V-	�j��鶙�AyįXq��S�l����W����҂0<�p�5q��zI|��D�u��U�,��˹A�[�]qP�b#����K��Mk>ℋ�|ڰ��C<Bs�'�/T�=�] B����:�?��T����2q 7�<dX�x	�TO���O�L��0��1d"���ԦD���F��;@�4�ش�W<��O�*�S} ���7K�������y|��:�8"5���G�gNZF~��Z>t�c�������!U�/Q�~��\��H�!�7�!*|L��8�4��z\�_(�2��/���� 77��K��R�"om�2g��M�Fd�� ��ir��z6"{X�*�<)_��d^��Qq0D|�|��=?�p)�@��vr"Qh�.ʸ�%_ T�l�zGq��Ĝ���Io�[�7aIxن�$�/������kI���3��$��{�(C����������
�H9��ʦ�ӦB���_�D�Q�*��,]�J��=�
ih���O
m������DT-N��2�L��e�q�7R�t�Ek��{�Ț52W!���2e"����z��� Z�\�YV3L�<���*u��s8�͈<R��>���_�B�Oջ��t�������-y�\��q{�y3��u�LB<�L���]��_�����x�ѻ6I���_�A4��o'��%Zoej�(hC�K���,�ۿ�P��0���
�_đu�tn�"jȬ�~S]
�����y�F�t�J���S^�FD��trL�_�H��d����n$X��6Ȅ������P��e�z2�������:�/�L�9�Q�G�2������0Ͽ-j�C$��w^d�G�V�u̠���C�3��K����ޙTK� >:[;�o,�˚�%�����6{SPoW������Q�����A�Ԅ��b4A�촗��]R�^��m�����^-��n���=��˔�W=1֨�%���ŀ�b#���cܜ!�Հ!�����Y-g�h7�e>������r�%��	�ji��a��]ޠ��5Doɯ��*1��O8�-���qK��BR6/���*W�A��M���ߖ�N��K��-e���y�	!"
��,D�⺜�+�)�c���m��L~wE�ܘ���Vo�Ѿ��f���������}صO��e�`��۶Z��*l������׫��	#�TT'����%���s�WUL���R"Yד��������{�vg��ӆ��ܙ|��d��~�B���x'9]��q���(�����$U�R�T��4�X�d%ƒo���NP+N2H�B]�[��R�=�o`�qE�~����޼�h�h��X݀%+loon0�^?o裇]�dA�u�������>�&i_�Vf9I��~	ò����-~�II(u~���oV�ߺ���7-�W�׫��3����.��#���*��8�^ ��~~�4����nrz�Q�F��̱U7�1J#�׬�Ƹ��:,�Yf�XhKF~���Fw]<J�u]���Vr�n4Q���'Q��p��w�;�_���ҧ�ua-Ta��}�s�4�'���gj��5\r~e{pns��G�y1��V�b2~����o�t����[o� 8+/�����3ދ:�z�G�ɕ�}:�����>��.�C��q��ޣ��|������J�Tϵ�����V��
]�cz�8Stj��o�W�e�R��'`�ӯ��b %E�p�}�aRY��ܠ$񽘑�OA�a��wzGޯ�`��xJc�g�۲.��\m��F�Ф�v��t[|�.k���&��n	6�^�[�^�D�l�^Ҿ���\`f�-�b"��[3A݇�Ӣ̕�9���<n]�䳆t��úlC4وت�����R�ٯ'��ť1�,�:L�t �	�Ϭ�=����SN����z	x�g�yf�Xضm��j��뙿q��5�_���&טy�ϔ�m|��3�)ܣ�:����&�A�����F���`d|๝�j����4�;y(����?�aD���˜X�%I��?��ȁ?̌t�20�J���=9_�ڤ;�p�{3����/n}�o�slt���Ń@�򙮢��x�2/�@���>e���:[J캸e�Q�K�-�MYP�kh��ǜCk*����U�9�M��PsW���Q�y�� T�wu�y��e�*��A�\W�C���4\�op���>��@U�hv��J�j�PB?�(�Q}۟y�)�� jψf'�D�8/�N�ˏ���U/�y����21E�v�oy�B���CZ�+���9�%<��w��)����2��=����78.|f+��r���Շ����ǆ<+K�HƉ���J<�d�VI����Z�V�,��#�}I�=�]�y�fP]���3�j렬�Y���Q�f{��|W'^��S����g���D�PG��bk�;^�z��39�����AoaKEK5��e��U�h�C����j�|p'X�%�uqs�cٙ:�\KQ�(�x IxRt�8��\B|�c�<�J��8��*	Z��d�7ڛ��'ꛫ����dy<-V-��gO)���b0 

�k�[�TA���Ʀҝ{��j ������j�D�Z)��~96�(����? ��+G=�|Ɉ��A��G�Rr,�=~N����1�Q���[�~`ȗ���{j�i�ʾE�T�&헡�@G�q	��ee��*5/rG�6������uW�ϙ�� :��{��\�/;�(Y��������V2u㌶�w�j���s��d�vw���&BhW�yG��W�U�*A�{6a�%�@�`��;NW��	�AO;d|s	0D� 䥞~�N^�{`jų���BX=�#�&�Z5|=qM�R�4&g@Wl0�����NxX��@_2� L�Y��۞i �ގ$��0�,z�
�u�|�J�G��q�X@�����2�?�����Ʌ̈́#��6�3n\jS�}A�6Ղ���M��^�������To2Mw#���6�u	!��*�i^���>{RI������ye	�Qwi>C�BA�%?I�I������T��^	���L7����FM�0�(z�I�P1F�rI��+��11{�����Y؏)��hh����݈!��k�I���B�E�.�	���"��O���Nz�Ok�O"/�W�h �98�������L$ �`ŊqO;A�l�uF@��H�������w��~�!�q�9��.�I�G�8|�"�L�b:�O�v�uw�4'k/7	�	C~37_�a�S��xr���>����sB�nJ¼�x��j�`Ǜ']V��bry�L� �&�˛��R��PZ7h/��CR�ʶy�Uw���!����_�o5	:TQI�(�D9��X֠��/��Lo�� �7=��[��
����`�q���A3����    z��&����9�(�L�5���T,���-�f��V������i��!d�X�r��l��8��0����[_������ǝC�����!���<M�4W��I�O/��~�r@䘝�e�ہ���)��T�bY+g��O���^�Vdu��I��m4�FIj	'G���V���5Vc��F��1=�u�G�� ��7/]hQaU��~*�����:
Y5,Kl�Ļ=��0�y����j�?��������_'�NT�,�VM�Ԋ<�~W4n��ͧZ����[Q"��xı�f�6�1���5��@���A�$u�ȸw�O;��:ؽd���#6��\_(��3%���#��vds��w��A��Ǟ�l/5�uЮ����~q���ھ_E/����4EC׻Y��Kl;��&�Qi1�$u��p��;���c�W�`��睭lO�9r��uü.s�*��IY�o�+-��kvd�!\v���)�,���Ȩ�;��%�$ޢ�:j��~·P��O��|��d�	�>_��������.OC���y���n��u���Ȼ؇T�::�L�Z*��"�f��+�Ԍ�ݜYW��HF9�ަj����m�CD�wg��ͩG�[�ggx@2s��r�H����m/��#{1=���S:�##QN�AK��^6�Ql1�Pi��G��{z�v�U!|��bCQ.Pw9��$����w��5\!I��v�~�Wk��i�:��N�7X5$(��Z��઎� ���a%?>���`����V�Z2M�30;�F$�6�h˝dw�öV�S�iC��oF#a ����C![ৃOV��'�O�
�x��1my_ !��zߨ���GYԹ�y��ʷ��l�Ũ�.DR�s܀�m=�7��)�F�j�"9���*��M�D��)�u�tl�4���)�$q����j���5�x�Mx�g��S�n|��;����bXkݲ�"
w�jR��.�`��Au�6jH6�"}hjL�'{Jq&v������&���T@���o@�7�Cd{f����N�%�,HN'p;w��q�)�b0�u�ǎs���Ɏ���(h�.>t>t���X�KVa��~W�I��a��h�<"�H$���g O�Ыȸ��.QW�DS�Ueϫ=I���g�h�y�.��WQ���j��6Wo%H}Gw>(1�nc^�1�|��B���
V8�*
� ^d��� /�O\:�X��! �,�6�v�4:~���|���%Υ��"��䡃󫉼���{]�x7�+�.�����Gx&1�#�,	���e�S䟘V�/�b=Nb�р��2�5`��
N�kY� �9#I���%�D���W�u�r�*�~"�H��NL��^0���B�|O_�R�]w�F�Jv/Cʰg�SL]���UKe���3$�&ɈZ�_����Z;�.���nEBDzx} ?�YSafqy��`�9l��xvZ�t4���|Q_��6]r?Wח�3�83��1"3'5��%��U�c�C��ym�rEJ�U(�9�����.
�/2&,G�K=Cd���w����� ��}�c���ťv��C�ࠥa�߁��,I&��_w~pd~��6�e�j��[$}�]�<���2����i�iAh���߽FA�X�ށ�n4`���T����^����ۓ}|E� ��vUY_oO��K����dz��C���x�X([n��湾H�/��U@�"�f#�x�v��+=��̽��x�h�?[���,g�ne�`��9�as�ŉ*���]��pIə�;��
|T�t�v�_y�z��Qf[8��9����BK�7G��(�J:� .#C����'ߺc�I�1HU��2�z���h6��>�nm��d�֫Qe��*��;�v��<+�y���!�0_(��E�=\W|��?=��h��d ���]2�E9�n2 k3�~`��~1&��z�U7�I<��N��o�t��o0���g0���ν9q)����c �f�L���JKv�����7��*������Co��WЛ��Y�!���T��y#�Ou�.���,�08��I�/lS��P��f�>0+H���iw<h�)k�@����֮c��V�@?���f
���6�^��]�&�.}l�8���Cz!�U���og2lqY�0}ټ6/`��ی�o'�����'-�&��%z_�2�����˥DT-(���uC�҃�0��%�x�j��4`?����E�D�� )F12+��h�O�̮c#E��qi0��	��l>D�uTr23�A��<�W�6�%N���_�q��7bBf��*�V�[8�8��t���������hB=E������l��v@1+��� f|q��3�����bH3���J�����K��>�빳ڮ���S�~�I�n������#"�To�ܥ��)��8��Hi7@�t�d�2�]���q�������5�!�Wb�q5�=��rS�uȌ�'F2�-]�OX`��kw/���wsm9��R�se0���O۹�x����̺ڶ|	9Tg/��b肮��,�.��.�X7�H��t�3��SR-���J"86=��$:��h���b!?���Y����i��5M5�*z�Pq��������\%�;_��a�m8A2t5��
aB=,-NRnh����ǍF���4��^�ى�޲��x3n}@A~7�~7cΜ��0��{D���W�`Յ�k��		���j��Aت)[�b4"��*��Fp��H2���k���V!k��ŵ6��y�/L�ޛ�<I�ѓ�md���i7����C��pxgZ�����>�?]������f�񣤕m�'5-Q��_��ҐnD�T(a�����j1o�����y��/�d�w�-�$�*$�䪠���}�����ƃ/G�Ι����y3���3���I����T�(=G�P��z}ߎP�"�d�D�%��Yne�w�%@]fB�}/�/#뵩��hH^"����y���_of�gc[�+?.4x'L�����va��������(w�\�T~�<���Z=��#����8~t�r�������]�KJ�f�̀� !����f�g��Ǆz��,�g�B|ڳ�5Y4�y�m��އ�Ν�z_�`,�4�z��xp�v�e>w���]G��;]�u���6]�M�m�� �J˘�*���N�x�WW3��oX��َ��9jW���_]<D�����*
>���[U�o���*�ㄶ#Q����S<q,�ޏ�oS�.r�Ft���iЬ�k�Ώ�d�d�����q�.
'j<l��#؏����C_���Y\��w[����S���nv)t��f.5��!�Q�1Y�~�4>ͥ|�L����:�2��V�o�f��O�ԁ��+X�һ�/�wE��M��qoU8�f
�[q�n�l䪎���n����"oӷ�]�n�GVwS�y*y�ӣ�לpA���3��l��������^������k�w�:Jv�'���
R��R�Ĳ4�O7I��� ��V���.��n��['w7"p�HS�=�Q�۞�X����揙�ǣ΀:͛����k[T�r��9�:���򩝩]U����>�i{�6M����h�cW�J(�c�k�&���礅�5Eq�f��H�9�m�E�\��%fO�d4� "�/N�i��+�N92��5��n��rØ�>���3�L��#�qe�/�O���=)Hj+�r�{ª�6s;�((�ė��!��ϡ��Y6\:�v }]��Nt����ݣ,�kJZ;���ΧuB ջ>v����D�����Z��SEWǗ�K�*�X6�_k�k�y�g��*��/�%eUeQ�\�����PGlX��q	:�1����@� �o� ��qy����Kb���%�|BEkuZ&.�V�sʔ�d��}��k��Zh���_.g�5�K����\��?�̎�G����E��o��t�ǣ �}�|b��)z�k�����?�������S�X����2#�G�>>��M9Mv@�rl�kO�s �#�Wi��$�E�%��3��a�B�(稤Q.��p�ݛj    f���b\L�m~�����A�����+���Q&$�0AL���Y$/>c1�) �O$)���8c�R(����A�ҡ�2�k������#L����b��bZܫK�#j�I�}K�R�O4(@\��p ��db��>d������o��o2B��>Ӡ:|������.߄������{A����=4��7A�v�I��^��렩!
OX��"3�٠��_�7ʌ�F�[*E��W|ʺw&Q<�^D�ܒ6z
�ӑk'u�8^�~�s ����
�5Kk��}�[v��7Z�)Z.�{}� \��]q�:7���J�����W�z����m�����j�T�Ȏ���K U`1��#ÁS�L؎�|���R��$����8����|��y�mHe�j��_YK �X�ط)��f*�dF�.�rH��� %�/m`�E�=M�ĥ*�!d�\¼�**j� ��\��A��[�?����*V��納/[l�U�{g��_k���yش���o����)�cկK̳A@�b����	��ݿ�ٺ�]���2A"�s�#�7�Y+n9���׃�A�fwIǐ���<�7Z�tYJg�c8�����Q�@�5��`a��X:	�3�S6�I��!�׃ٚZ����k���W���va����^臌G�n�"�_OYjzw��OF֥� Mbj�8{��#z�{M�A����F�z�s��u@Ҹ��d����] :ԥ,��$��Q0e_��%�'UG@�/l�ڟ4,��hj��sRX���"j��vY��zy��h �~�b���M��>)˽w�ݤ/���"y�K�7H)�vI2����Wl�dp��?7��H���{��(�P���a>�Pĝ~��#��g��U����)\o_��5x�����{F�+K�z�(΢�9�T!��z>�z��a:��3���X|�9��OgP��P8�~5Q!1�|׮�������U���Q����L�_����^Խ�����U@@���쨛��p/��ϧC��A��-�90e3\�X�K�wVg��x$1#[�S���e�-����}W6����_)����Y{���4����v+��2�':������A)��46�.��j��ۂÑ;^�-%�$f_��}�1�]I��T�C=��!�Šq��A�藞�M��ײ�Kjn�0����}��\_8�������6y�t�7��T���[臚�B��[���9�Kh��:�ӷ7��v�s0S��9Ԧ�����8�N�����Kn�GC	�����b�R�O�J��H⨸�Gd��\��9n��f�QU#�6�W�puy&�.�m�e� 1u�}�a�c/ha&�N��ԨTt����v�a.��w��(2�:�7v�V�VX�Z��T/䔌#4��d��XG�;�~�Q1yqԏ!2�8��*�p��yJ6=S:g]w*/v؄�2+F��s4k�����7�.���;Y��of��Z�O�k�1���"ϠXYf�Aa��Ԋ��zW��e���Ce��l�苐�3:�H�h4Bv�8��6"br���["/s���%1?���:蝳Pt�Ը��H���#%���u�8�a�<�#D�-� x7��{�f��ޭ�����A���$3���0������%����InI'�q��
��K~��r�`�Y�x��i���_�l��"���)j�>���V$��M�:$�V}�q)���=M�;} e�mո�����R ���ş��3��2����!o3�=�����=����k�����]��:��i�)��t�+V�f`�ŪW�C�v�S��Y��s:���}z/s��.5J��EP*�������M���s��mt ��\�QuM�<ɺq�dO#����89��r�Q�n*�Q6i������"-e)�\�kx�i:^V�%�̍�%�lV.�51Ӝ&���w��)\��mu/��Z�`ӏ��K�j��h���R&4�R�>�a5NQu�p�j�[79�!����?ك�b�׮g�:@L\�ߍ�Kt���듍��{u*�.�l������������ä6qqne�%u��8"5C�b��m-�>����z�R���g��dꇤ"-m��e�쥕��bp=ڬr�iV1.���#��O���7����;�r��j~V�̑���{�lUs�����d�d����M)0���ў5I[��2�t⑰Y��CǊa⋡*�ը5o|�	=�/�VS�~.�/�>E�Q,�R�\�}��7�Ӆ����t��$������a��{D��P�̫T��Y�׾���x-����QV2�{�R�_�/�̉�P��R����I��CFPُpW���RL�nl��.�=k��)�Q�j���;�x��F)W�8��܏�>��l|�yԬ�j* 0x-�gkg��g�x���<���h��P)R9L_�*%��%dؠ�e�T%SF��{���l�*���ńϨ�c��Sfp��%�����O�b�<VVn׬<��ym���h�a=��[��J}�b9�,;J��fl�<(S��.i9 g�729<$x
�UzFc%g�D*9�ٱ�*P��j�MU����(�%:��0��#P��<@pƟ��7M��������td�ߞ����ݠU�S= [�f?�UK���)�Qd,�c��{Mb��kW�\{�:Ov�kk��m-�����0��9��p�u�&O-����і���t3w��QA<����"�'4��MK5����G
�Ć��FuDIi]�)@ ���C����ǻ��_F��㨚c�6?�d�L�m6�ڭ�Uː����|�,Qd����a��2W���Ӂl�i��t/�6oU��/M�3u)`x��5wh 3Ux��WAb�J�9�FNW�����-0�k�l�q���ͭ�n�VU��R�?cj`����K�[�noj���.Kq�r8HR�{V,!��-�~7Au�zh�o�(ՙⱺ`��x��01�E4�����y��D�h5�I��]U+�naHV��������T5o �s��D		zUI^~-aGU�Q���R�:��j�"	�	�`�W����)l䧥F�c�mBV��|��N��������_V{�9�5��������h��=����[.�3�fM�j�}��ǧYa�페�C>��3�n����;Cfڒ���X�]�A[�1����#�+�q���A��B�e��y���l]|��R�:�����9�U#�]C9�z���=��g?�4h�z`߿��a�VI������;'z���o)ɲ���k����gs#���=�A\�>�sD���(�$ӛx�@4�id�ː�5o��{x����$�6M��Ϭ�{\�1���lt�h��l�MM�u��/�����$�S�bB����ܼ=�Ą�[�
���\�#���dU뾃�����L�M$���U#�u��F���<�6�s�|v9np?G\U�Ǿ�_��8�ν�X�EJ������ʪ+M�G��>J~��S]��E��^Fq�LF�m@�>�K��]�j�8j�:��=Ѱw{��|%�N@zs�����܎kH)�x���u;�Q-&�_3�v�-�k�p�'J���8��D2��> <�?E
�ee�f��7o�	�GdX���s��f̳�ຎ��_Wɘ�.!��ë�(�u�bs�NA�KD��Hm��O��cn��;ɀ���}�J�9�,�1׻��J@�L6WVY���92�?���镭X6�d<��"R&���"(6߇<~��Aq�/����K����DP��M�#�gN��[s��ҝ��ߪ����)�P�U��[QϾ�3���PU�O��`�>��rsv�a�=j
������\���^��=�?���yS�!q������F�z>��v��;?���>,/~�TLr��a���!&��)�}"�N4�>�r�G:���4��Ǉe�Yq��:hè$�Q<�����>"�[�1P?EE�8�g㶗ک�}~�>B�.v?�������ٱ~�t|$ݹ	ߝ�A=��#a��p��DOw�ǈ�뽍�s%Zh.f�7��U��G1oT<ꛪ蓦:+�    �dI�D'����_�?]�����t��P^�������5 ~}E_�Q2�1��0a>�d�mE�/���[}�텾�:������M]b㲴��k�E�4;Z��L-LF|��\�����N���{�i��I�.�V}���Y'<�a�Dk�m��tÅ��'��@���פ�ƌ�J![}��v��<(n�Q+2�d����>Y��L���#*+s���]�ct*�d���n��b�����([��H5'�)_j�g��m|߼��������r��ɠ1Nc<��Z@�$g���U�މ1�S�=)���)������H$�Z��/�Ny�"�!��9/���E�|���w��8���@��a�&�����������+�E2��Ms���@��Z#�j��E��g)T&�	��"J���[�_S���Y����H�4(��s�8�f��/?Hdhm����0&�^޹+��l,f����3�z�ͣ���3��	����z��S����<ݢށ�'�PX\w�C�s��ī_{����j=mq������4�a���~��Po*u��x@��)��k1�~��|�=��I���T�RT_+h~쾹�j������C�`��YO܀�Vʺ����RA�lk����.}�i��ǟo�����lI�6>�)?	����D�kWEa�2�y�|�����{Cy�O�q#�]�4�|7�"�₻�������t!�r�[�r1��î��~�3b�D�w3hŻ��O�2�� �Eq�3װl�^��7���}e�L���P�f(S�>�_��W['o�Җ���T�$LO�;l蓂��gA�^�M�Ś{�ܷ�d��^iō�'K�c���
	a���(����;5�'�[�����}?��1ofI����~��3������|��P��Wb�Pm�����+��m!��m�kd�]@6���A@v���9) 4��4���\)E��u<���p�O��~ޑ8��+�UI*���/�v�l���EKm٭o�zHN�A�3bEV�4��Xۅ�����q����cC��jVe�'&t��"�j�yc���0�1D�ٔ�7P�Ш�cq[5����� �8�����?��^�׌��+�ȷ?��:�Y�C�a�  =0���l? '_QC�ia"_�|;.� e��;F�Eߘ�H&l��>W�����lK�;H���]����NynY����
E"{����Z��][(��h&��]���,?őF*���9ؕ��`���Sc3<�Cw�a�4��Gv�|�\�1	A�\Y-<��
�������<ȦY�_2����S���
"���![��C�`�d��U����O3��xxPY	��;�cW��L3��&l)?l��- ��~T��K��g�ј���ɟ<-��#P#(�N�h���'��9�m���w���AP<@�BdM;Wm]�O��!`�ر����xG��Kq�����@M���I=?'n��Y��1	�͐��屼����bÄS�1c:!p��c/ʯ��/S-ʸ���p����حc%dأ��C��X�`hëe�
����vV���P���%�a��3�KL7_g!�ߠ}�GL���1���H-#�r6��G���PA�|�����Ǘ��s&)|DX��B�f������G>��i߄�;�g��_��,�@�:�|B�q��v�$F1���@�4s�{�̓�7�\��<������pg���9�`���D���1����!]�/��fP�ػc7kd][J�?ыL�ϔ��;,�Ґ��a�IkuEJDr���{r�`W$�(;���Lw�)ܒ��ul:ύ�jc���}��:���v�]lR�_�~>�|]z��3�@�t���#���3���N�z�5�k�ƕ�}��=@x�#�nY�C���*w����g'�t��(�OtU��b�?�9	dc~C�ٜ�1����̩\A
'�1y�g��k�;jnn"Æ��mXtO���7i?f�U14rs�������I~É��h~�8G����~ڧq>S��V�׶��Xr�Sgj�QP�5�u������Ar~>.�y&o'��(���/� ]�ګ�ɝ�5�����t���s��{��j�n@��N�V}�M1wx�o����9�9q�(��D �����F�ĸ�޸�y���5��w�x�C�\��@�b���ً/�N�n�	�&5�����X�����,|���w���J�O�R���<�52x�.`���Y�¦��j���Gg�n��ȟiH#�g��eq��E� ��旕��A"��p߲�N�|����g隗۷�Y/�ր�!��0 Z'@���PJ�,��Pu��uV_&�ߏv�ە����~w��͐*Lή'_���O2��pL{�0��A�x�J=q��0$�Me��?qK�8\�-�(?�y5l�6�/DւH�i��:���Q#m��M���_������.�Ay{�|Z�s�b�% �O��.���c)S{	ỗ��W�+�(F`��M���~��+����-w{V����93����w�PK@���5O��V�4`re�c20�	�@�2��oқ2���s������%������䄦I�k��J�61���'�F��1�_P�p�nt�/�Yya���0�8e�"�!7�K�檭$䣛XZ�0�a�~�\���TEL#E�&m���4�j�$n0�ba�Q?�����UIrl}�J����� �U7����1]��)��~"��J�)!cA�D�@�[Κ;��`���]��"����K`ؘm���1,��|�lb,��owź.ַ������1��a��	�-�h@�
�ɳ��� S���N	UM����ѩo�} :Z�=h>Zs��Ҟ�i!^���C����F�V�U쇯�߬���*^�f焬T|��o�dY�8�i��J#�y]M�t�4�[��t��iH�G5��w7�:0 F�ۖ��ú�*\u�V&jq`���mKz�%�|t(��$Ax���{�2��e���,�FS�E&��U��k�S�nT��<���oɐ6�>:`��(r��(~��P4"�W��mP����~�WG��!�}d�3��g;��������<8LDY�T�A>��Z�Ho�i�h�������*̇�A9��������0����ҋ����c�c�:Q�yYȻqg��g�T�T�*�UP�+����f�-���G�_/�����7���	������<E�3�E�{Ҕ�}٠�b�v�"x����>'yt}9�=*"�T�c�HC#1ұ���@��ٸ�%���z���{Rb�@�gY���-Д�Ԯ|���vf�t��{Ƚ��HJ��灣R��ɖ�}�)��p�9V.k>�jhA�2�ͨ��W����6��u�j'Z�L�+����9����g�Z��Ʃ�`�q�~"wl��U�T<�!fU�^]���k���gy*YK� y���&�M.1���M��(��������>��GkL%�_��-'�����.���*Q����}��[�B��K<i�^T�Cj��׽�^.5^50eJ'
���/8���"�ם��mF�HM=Q�Bj������<Р73�U&�J��`,�m�4��#<���Cq�߉�ug��8��Y=O�H�$��>�d���q�w 4e�R�I��*�z���}ʊV:�R	�nF ��Y���S�*:^je�y+�"��(d�u-���!�E9�U����g}�|U���x;���~�p=�ho�/@�2�|!���nL#��.��J��3d�&@
����B�o^T��U#}(�I������y�A�i!@�MgZ�l����������P6p�U?H��ѠG�Ր�:���ɴ��`=6D���fJY�b�����d�������a�|c�y�ȸ�^�Qme�3sH�>�'�S�/���s�ֿl�^f}�p��_ױ�I���-�j��8AS˪�A]�?�89�`.I�!��;�o����0Pp7oU��k���H���ܠDǺ������?9S���wtm�#��8O��g�*�4�8�p]�g�̓����9    ��RI��:��洵�����j�÷�/"��:��)�%s�c�s��etG��U8��D�g�S~��0��a�cs�B���W���'Ԥ'E7�6,�1*�z�Ѡ�*���ڨ���0%���q��O��"I����Ƃ�mq9�Fҍ�W�M<Jt�ú�S�	�����v����E��p����R��-�J\.��!�zS�x],۝�io��LL���NH��.A��S��$��l`��d�j�iX���]��Yl�#kd��׃�9TeZ��j�ȋ��G�bQ�Iu[�g�xe��4�=.z	�{�Au��.=7���d�yI�����h����1w�VKM�&�Ԑm�
+�ǘ�y'���S@���E{�<m��K���+s/�us�-�$��������a�~=:�?K�ģ�秃D��`����P4�t���9���awcE��j}��}��|���<q~f�����_���%C�2� ����wWRC�i�G-"U0ܮ6�x�ޑ�Q8�|bخ�w�����e3>�D;��ÿ���X�R�՚��V��x1�/$�bj��N8q�s�3���kd����D� ���:��:%M�^�}�V���ac�+�*�Ӝ>�P1����	�n��]�y+��K��H
��\����|=v�aϘQ����쌢ՀUWW�Ї���6X��ܬ��q$�rXv� ��3����nT�R���ÝE�ږ3�<��ɉ0�:>�m��	t����1��=ߞ��wJ��:p'zԅ���c���z����/��L��L�3�2��B�odj:Z����.�:T��=Pkxٯ��7��V>�3w�z���xL��3-����tx
�3;�'1�;��]#~g��D�w?��r��V�N	S���LR����v��v��7Aa]���^�͙��`������oU��,
���6��s�=����f2's���6
yL�_��� >���ax�8?R^U�pӓ��=�?���X�?]Fe�%ފ�({I��7g��E]:��%(�L�`IX=z� �-�eأ�(@'�Y�Ő?2�$)�xN���I�I��1R��]F@�@��
�@��0fW�ܺ�Τ��c]4B�*ʯ���D�A
(�s%�'���('b���>8�u�&�s<�,A)��Xw�?7������m�Y����; C�	r?��,q<N���Kv��7E�0�Z�;�Ya��6zXXO�~v�Hjt��ϸ�ii�_�>�R>G+��!I��הB@�Twv��<(^k@��?�4q{�F|}5t7�2;�p�X�W�'�ǃҘ����G�°)�U����k�R�n)�����b���&U�^�Ml��=7�_�Xcp�C�w�z>Q��+|���t⸶}n)
*D��=8pc@�����t��EP�m1��]����c/�Áv�?~Fค���!�G�X5
�Sۏ��H���.Bf,�I# � �X���y4f�"*����Du�СƎ�$�5�y*�J��RM��ɰ>�Q�v�S����py�8�@ǰMV���Bj��"M���г��qI��>�q�ꕼ�+�W���>Gߗm.g~FU�.G�
���8�X��y/�-�{�F}+��pib;V�0
z?����lƥW8�7P����*��!:J�}�θgsg��7�,g���2�Ϳ�R��\�	}���W�(�f0��@/oP�t)���d&���	�蔼�0j[u+@�za���֍���4ťG�5�ʍ�"�7�sj�1
v�yZ� F<T3G���py?�v��,��`�:��|�[�_�H|s�|�6��_1����	� �=��@/a�<C�����G�q��uC�y�aA����קSj�� �q�I�C��n$\��.H*�ޅ�&!�Ӫx��:v�Y��f�<wK��6�m���|������K�մ�G�^��ch����� �-�ȾxO��f�L<�:���;8�ه�9�<�8[���0�X��*��U�4���!�&� 
*�a�����,��jb�<�{m�[��JլP�M�S�ҟ
��(Pe�d�m��$O�mr���0�������oͻH�*�ܶ1?�=y]��8D3�q��a��BUm~^�����j��.x�[5-E�5�h��|V<�`�)��8�a1�St��3H�T ��;�A=lq��`;��얢u��en/s	e�op�Sv�� ]`gk����_����>JD�GP�<}�Ć�e#��6梱Z�v����7�bo��$8�K��2 �����A������:��B�n��7	ƺ<_���J���l���>X����]e7N�J�y���6_|lk��S����g;��NI�TjC���45�,5����6��Ƶ�Pmݫi���Ȓ�'��\-G �o����7w`��7��^�$Q����6X(�t�@P�2����8�gjϥM����46�l����w�/��C�3�2�wP��׬@,F%�&~���W*z�,�����_���o��1�����$�8��?�0`e��g��ՓQt(*Z�N.Ê������m(�fN�yE�!:w^�M@<R��{������f��@�����ú.��'�_l��D�_K�3�v�������=��5�r?�zx�.	�J�A���oϷ���a���W�>�GD�1w�[C~�(�qw3�ч5���Ŕx���[XSFmZ��C�F�n����_���y��k��od�^՟�.qgh_j����o
}~l�};�����PXחjK�?&O)��+�9.�̀�a�|6��-��?WC48��">#]���x�­8�B��}��|�	��tͨ�'L��$Y�mʎ�]՝{o���5+r�%�?&[�f���M���f��ކB8m�V���s�!�Vr;�V������p�ɰR��~��<>�C�#��j_>��f��=��Ϯ�5=�����&�A�Яyߌ�_L�U���=M$E��]�2� �3�NӠ�:��Ϛ4�KӦE��3�>7I��a���*I;fc}T�x��1���" ���` ��xf���ÊΣr7��R�:�D5D�܋�o�!t�!L/�&��s�A���?)c΍�;�a�fT-���j���
���Bd�6Wn����c����� ͕5_}���O��)j�ޛ�ݫ��Gڽ����8է��޲,���_�a��re��{*�v�2(]ם�왽����)���ܫ{�/����̕��e��}�����D���[Q�!]!
5�GJ��q^�E2��RPm6L:��yx�?����/b哸�TE7V��=BF��E�\_�����\�t	��`Ѵ>���H֊Lp����τ�?#ĩ�c� ��xc1�M��W��qi�!M2I�X�<�"4cI����t�-������s�#��-sQ�%�qnÐG_ M��n���~~oY̍�m��������ǧ�n�&b����^�P(�ySS� r=l�@�p̧��HHA&��i@�μ:3�{�FPN���h�ג��wR��!
�]Md�/n	�BD�r�EHO�Y]TAFCZ�o�Ss��e����b'������eT�����t�{�w�v'm"׼�1�ð��E�T�A�yOF�3j��>�1z�фi"ʔ3�}�]_E�b���O`��ia(]¿R{�{��5.WM����`r�!U*,�}��6bng��*uu�[e#��&���,�9�$޴Q�Y����(�ɲ<K������D#�G����S� �1���=7�0 DJ�]��������at���fQP%z$�Xj�7"��'�3�TS�f�{}�C�7��'@7��8�d>�E*���B8D@x����9����ɹ}yhd��Klk�&�X�df��p.s|�kK�*�d�`E�,�43��-��c�Xi5ֹ�R���2��7����ԔE�A{K����<���3_"��}�o1�d���Q�(�ۗ`��?$� -�ܩ���^[�a����I��sYT!�?�y���oK��Ǻ^K�UD��a��H��("c�V�՚H����\m�V��f2(�-Vꤐ��y���v��w��B�N�    �#\��ld�#g�5����{��ʞ�WM�����#��w�I�H�[��:��c�=��㦉⻃e�M�<!�'��_��Ǜ�W^<峘��@��Y�D[.�T���6Ii{�H0<��I�r�ne�IC�Z��	�݂�C����Wrp9�K����=�B�9dӚG"�;��"����'ji�4ce�)� ߭���x�%X><��H]���$?
�42*�~B�ͨ3���Em�w��T�#7���OCe��Gy�]#�d�6�ٴ9�۞�s?���̫j�m��#���b�İ�q������&� �ks�Vk���x`Yw<oS���'�Eu8w��9*��.!I�sO���72�Qm�ڗ���oGJ9�
J"�}#/�8&��'�YK	�h���U� ���;r�7>�����*q4hQt�{�qRG]QQy��R���c�n)q��j��!������J:uJ&>XNk���J�]��ʴ��z��ƈa�F�:���X:��	���ܗ79[�M2�P��|�3G�n[���B^e�l�tI'����f��}���!�-�[ؠ��X�,��?gE�
`N��N�.�\�(�v���*S_N� b'�]�K�=��C�d���+>����`s����&^ऴ������E��	&���B�B
�'ޒ�$���>E[�Eȁ����?3f�Np3Ñ���5aU��k>9	3�>�8x~��v���M��J	dMBm���Y��c�`B�����ؖ&�sh@ǂ4��k��nb��F��0�%���?��×?i�d#z�}���u���rq�i�p�$��J���Z��[m�O��fZD�i`��`{��i��7)&^�a��7�X��)s��Ԙ���J<?���C������R�B� �k��i�ю[4�R��	�q��w�� =�Wn�ё��������FA^V��3�e�N�</u�V!j�G�O���ۉ��SO��;z%��L���?hZ�3�S�������7'JY��ݰ�f��G�2�z����y��м�i���-Y�T���z9��|"$>z�J�J�Z�1�B�+�a���o�0`�2��$�����S��"��K�i�������dzn��g�I�w{:����ZJQ�m���D��J��cVEtC���Y�O�]�kߣ�E9+%���%�ֿ��ң�~r�DNC>],����K��1&ȹ�M=�}��?'�]�K5<R��0L�-�G��]I���x� �ok����LXoF����"�~���W�
x�x���26��3��e���0*�x������Yw�S"<4���~E=��}F�j������k[���'��
U�ը}XF�ya��+�C��3[��q��Q5?�}�o��.η�)s!q���Z�¢�V��[���/�k�D�3K�dXлP��
���n�sl��������S�ё<F�S�����7΀��9���Ň�V���'�Nx¯��Q��y�1|��\/��G�p�g}2���/��9�v���r5k\M�k.?��'�ہ��ߨ���2�;��8���ջ�#H ��v�%�����.�6g��o���>Ţ",����m*۔�I1D7Rk���$ܵ֎�8M�
15�1K�������]�s�h�5�v-�8�u�:#	�#)4����9���~Eۉ� �lI�����[o�2����F��\�E�%G�n��
ч�4����O��ui��u��z&1ɛ;�����o�pҊ���Ҳ����]�kVӞ��y�?c�;����܅�����U ��ý-��\�� ����s@쫛�(����9O����ֿ�l��T�d���_z�#��H������a��s}��=~���|JK��e�ٺ]!�T~�tK^L�I�_'cb3��[��?���sQ���;\�=�X��p;O��f�]��Ξ��6CıP�L|�#����"��he���|�x���uG���㤘�h��2�v�-ϒX����;�;��-v��w�n��1i�<e_=�>�<�
[r�YU�+n�p��q	[�j�R�d�0��]0��6�0��tO	�tz�Ѧ7�uPduK�i/ʥ�&0W���o &��w�f���=��Cg?Zk�O��\n;vuC�FPe��;��w?o#+J�N�cZ��p���~��c �{ғ���� �۽��\�n��Nr�&��yK�������O\�Й�$S$P�����J��s�����Q��D�fQ���t6�bq5pE�;�P��b�tP�$���K�̯���(�X�F��P1�4�v!r��l~V��h�����U���ﾗk[��@\�̖[}��c�r��E�x~�硫�+�ݦJ��c�<�$��l; h�GkM�q��'�U��^Y�e�����瞽WaW?+�`Xn'������4ֿ�ⴡ[�O}2��#�v}L;����nX�����q��;�|x��2^�d����3���E�K�%�@��ĝ,�<X@F�'��\%l���W;��;� ��%?��˭|u���h�윎��|��"r���+%s���W~��W�h3��+�`��%�k�+�;�,����Y�d	Q�S���E{'���8U��|FiZ�f3+_����,3��57�1+s��2�O�q×��$�����P�e
ʣG��x��g��Ƴ=[J���A�}0)v�΄�-2�P�p�(EHd�H[�dB�-��+�r3��X�|�t|ZD<8˘�Ph���-��q��o������H�u�I֢0�%�
������^w6��T����S��	Y���~�]�{�Z�@!kk�C����yJ�\j��G�ǜ�ET)A^AVw����mC�����걪�%<7��/e��L�җy�x���C��6�)��$w'��$,����ك��u�F�Vпf��`��� �� b3~@�q7����k���ذ�J��5���XEK��A�"��زc$�΢��F����0�Υ��ꁩ���x��b��ϲ:�K�$�W���4����#��0�+i4�h�K|i��$uK���$M��)/��U�]<M��՗T`�;sz��vs
<K� _V1����Q�W�E�mO�n��+�2��8�t�s�2 �n��#�X���`� �4Z�g��,Vrκ�C���Q�����r�: yǗ(,T/H��H�qB.����%E8
[�'y�����X�ڐ����¾tJ��P8b����4�������W���C��[RL�����Y�2��o�����h"3�3��dv�z{�۳�5b'��C&��^���u��P��2��ˋ+XE_�A�mO�g�Y{+J�]l�M�)m6���v�8j� ;�f���c`�y(�f���6�y�k����D�\��@1	{W�Rʤ�C��m)�A���4!5H[v--ڍw0(�,T���/ܩh-v�Z�O��&��"����d�`R��Ї�-��eh^���$n���7+r���,ۧ�����[�ݮy��=�Y��[����49�o�1y}� 6h�����`o3�9��0>�<i��+
��6E��#n���s�8QƉr�D]��W��tզa���6KF1 �b�2�z����N���;x�l��<콣�{�i���[�S�d���Ť���Y���}#�����5�$��L�Z��l�*�}�0t�|4�xkLs�e�����m�B����z���q僿��sB���|��2��� ̊7��]�����*e���D�N�߿�OA����@wJ����Լ���p��b1=6d�Lw$ҫQ�m�@a�v�~���O���%C �d�kp/"���e�V�����6��΃��CR��6agW�{7� 闞�z�n<�g@~��4~����ی��a�Q#�q� ����E�Z��eے_�TKC�7�������⒂���:jE�%!O�ɼ��Q�v4��noL���bC�����jB����S�$dۣ1�f�b�Ԁ��#W�Hk�m�����q1�:�#�S:1�k��A��Ug�J��h>�Mr    HH�����Ȯsۭ����A�p����c�#�d�:�E��3�2*���p�s�H����F���0��,�&�;#Cy6¾�AÎ��hW�CTc��~���V��=	U�����"�2"�q]Ո
��%XZW��EsO*Y�Əix��hʹeO 11|Eu���gm��w����<QH�9^f�Cwofo�3����7�3��`�:�v���|SU'��6`U�$%��(h4&W�O��n,+���T�dik��C�j���hץ�M�ա�H�8�E�D����i���u�ۈ"�2�'�~Bb�o���j��iɛ�����Y>s-R�Q�����~{���{s O��G�x�t�
2e��R_�Q!5ęP���gP�&$S+F��OTW��嚿.�4�e���P��4�:�Y`�ߏ��)�C�p�&a"�rpC�<����8� �`����A�C������U��[A��`�vG3�" ��G'C�C bns@'�[�M�ۓrTzJO#����	���{T�����ǩ�qz��Nn��Lr�;G���̎�U&���S;���U<[c��＿�\�F��-����\3�pF�*�ը�j[��O�8w��w'��l����M��^�Y��)*@8K��&'�� �&�Y ��_�.߼c���!�OT���3�T̥�?1��n8>!���Y���|?4s���aU�ŒV�O�[�=Z�ߟ�P_�l���:o����9�����]��� �9�|�N�6��F�iX�b<V~��~<V��|0vbR{��x�B_x6�{p������-ǸG�tZ}4C����Z�M߲�;�W'-ku��p������il�:��>��~(���)�Q���H����E���a���A��so�"00��v$&TeE~A^8m�*�z�l��F3���Ý�!�:9k��Q��Vu�1�_��]
y�JNq"?�\��$�ڽS�X����rϠ��Έ�V%E+6�ҟ�y� �:~�o���'����@|��<X},(%�m�����ߌ�.]���[ �|�F=\4Q�i��Ɍ�{q�������U�����W`}/��G&�1Q�Ы>�O�uɁ9�N/��o�RH��Y��a����-� |1�l\7�H�4�21�?�����*;d|k)��7���)w�נ�^m,]Hn:����y�я����!��"�P��0���:��D���v�*L8�-^,��w��7i���Z�Տ��R'��8�~�Vm��v�E����:���O����Ԣ�ή�S��qr�"%�_0���E�&E�������k���uլ�j�F�z�+�**폙�?�+<�sE�xT���`�`�ĝ��M@����^ҁ�{hi���� ^x��C6�cโW?k���O�Hx������Y�?4��k����q��а�����e�� ��v��n�AE��Z�ť��d?��O&���76�A�Rln���Uvm��{5��X*Zo4Y���9T���:xF�������:�)?�v����;$��H<9_�}|~/h|}_��P��>(�|����Xϴ�\���$���<��|�_Q�Eqhg� �X�'p�J�Y��+a�^a�\a��[oδ�3��d.�����/	}����_I�D�IE0DlK$�蜉�o���&<-E�k���w"�,����,I:��G��H:��l�0�U`���?�Qu�/c:=��Fj�R2`lG�
r
~R��ʾ�G�����w�,2<�[�]�$�������y�i���r�|�kO3�' �������w��|�np����ς#=�Vt��2�oR�^��`�7�;M���y����H��Ӭ���A��I�/y� �����˧�5 Pg&(�5 i�Q�;e<�K*�_��a��s�;�I�R���-%JU�3�D|2�4��MU�������oJ9v:K�K�����f��,p�GFnq۾}�1e��I��B�ǯGa����K�?�{�Z����7y�
�6+gـ�>z��u�N�+���^}}�r�v"�+L��C$F&tDP|�n=;cl�B��A��O��%�b���H�d\�,y;vW�d��C\��,To:o�ze�V�۾�g�Q�²_qo�����Q�T�QW���_��d�l2#Be>�+�`�w<d�=��L�c��2�d�[ IF�3%u�4�Cw��ח�8�R�>i�1 �O�>���m�7�?«:�n)!��5??(X�|��F˞tU�Oj(L�x��Uha���MV
������3X�gg���{�Y�����{D�\
l�Eڒ�7W���h+�,.����f���d1 �-���N��r��[u��F�g��fD�9E�kNMOP4��<
]�}���ߚM#£H�)��[��m^7��8���Ywz9j˸�R���0ӕ�P7�W5�q'S_�Ƚ�N�$LBО���L�|k�tǸ2^�sj��ī��1z2)^���|k���%�!��#,T����Wˁga��[�x��t�^~8�;�K)'����t�}3X�ޖ�S�?eMWNY�>�_������Z�����13K����ޯ�r�ɰ�_��kX}8�N>dE��͔�����,����n:l�����)�c�����n�"��V�������N�=�n��hښ�+�����c�wN�0���֓��~sG�	>.�o��۶;�9�̖�`^�k���83Eq��>+���x�sO��Z�R��5���H۴C`�qfag��A�+?�
;F�O��?�UD�	vx���:��#����O�=Ѐ-b�BP=�}����C�D�����O7��(UyYP�	�jEt�:�%�<�n"���ՎEn�dM�~�\=��%+�P`� cT.��\Dߗi��y�qh݅MQ�>�>G3?�z/���a(�޾�8H�x�3� o+�����Ȇ����[��8�O1�� ��Z�b�pKg��OҢP=j���ʸ5�]	5�d��4������j��7�]�y�#����9��J��O(�֥l��m���R��P��O�>h7�ި��::s�פ��(�ۯ�0�S���G�!��K��{��(���zN�`�tB/a�w�����<���S�%#�&��/d��L����c�����pr����G���Ar\�&^�`�]2� U����a^�g�̡��&}���ȧ�ph6��e���m�4Vó�vYj�
qg����d.�/wK��S��v}@%���y��U�9,���U�OP�U��эߊS֯��H[W�%1��O���$�P#.�����ֽ[�i��p��l9Nt�I��K�h�ӻI�.�>�A��г�k�]Tdºv�z�#L���^���1m����L�F�`��*{ ֙ܭ�3!I��^j+��	B�)�]��}A��{�����%���!�Tу�O(<�|�!f��e]��EPE�"������s)���R1�z��x�:JRa��3ݬ��~`�0m���K��9�]��P��9�ޠ��x�9�\����:� u��# ��3���x�hr_������*�����Ue�0���(�9��D8EG)��U`VQv�Q�x�q�Z��ԁˠ`u��h�m�iӄ 
UR,�$B���.�b�f�L&h=��  ։?ԐQ���5@>�d�����P���7�t��4m�n����~>�g>:N�;b�<%��*�y�۪譕�0bŴ��e0�>i�����֞=%���(S�E�/��`rG6��,)���~7Ա��>��7�n���ڤ����܀&)2!@�y�+��?�%�_B��C����Q`�>����*i���Fw)@��3��$^��"|!o\}�v|v+*��{�c���!��R-���uE�xb�[s/�F�,�p���E$��~ݲl��瞾5W�ު�6@��Q���ƛ����)��]S2��y@��M�K�a��F�6�}	!K{NЇ�b�G��k8��&($���B���	@�ɬ������z�����~�K�ň,��g���=��ԡ`��\I]�I��/�������5    =�7C3�/�w��Z�q� �^r2�%	��X1��䚵Li 2L��L~�D��p�B�8
�o"�����kD��Y���$M�՛dx-d��@Č#.>w�pg������G���̓�fE0��� _����I�Y~�;��Ώ�y�uo�:V�L1�/�����M��?�����w�[�Q�ih�'��۳�3%/)�Ќ�-����1Y��� l#��������p����`d�9���w�_��M
[#��U��1���pc�M=3V���7:��h�~d���� ��l�1�@�Wb���u����G����䊩������I���K��K��H��ۋ����&Es`���
	gH�֐�sn�nD�r�)��]���c#bľ^�/l��V:�W�O�����Ϡ0竰`�UX�	+\�OQJ��2�FN�V~:���tD�	�UIVԯ�.�����U{(��T(�rKD�#o��d�4���<q�k�#5�w�ƒU	ëI �~�S�#��*�̟&ece`���K���ӧl�U��np�T�Ke �h):O��v��ϟ�5)�%�j~�k f�BE}�f������NC��Q�-��w�W2��*�x���C{��rTZ@|�����Щ�At��%��T���*�τ傈SU�-�����eg�{����v��/���V�Ѫ
�0��o����};]�݊A������L�X���O�m��e�o�
�H�gt�����p�������Ȝj�n����},�������&����/
�����zJ.�4���k��/Q�N��Mqٷ�`�X�4-�& )�;O�(:"6PΊ��>w���AAjX����W�:��^��[����'/�-9iN�ˌ��SFh����qj�L����
��Ҳ�����K�J�ȋA`��v��q�=aӎ��[�!'ȡ�g��'��y���ke7Qha�A�l$t���y��>?K�(#�+*\e�'a;��m�������@f��K��XdP!��]�l{X㐿���,��P�\���f]�P;�aEG8.f�T@�'\'M͚��AàU@�����@筒�om{�RS@�-M�"t��;������W2�ᫎ"�[KŒ|��O^�xh�V\V�������},Ξ�2:��?�⒣���p��ʽQI�S �D�Fk��l�C�o����?	߿A��C,J �
|Lt)�s�k�6��،7�`����wK�T�%����f�x���B	�A��{$@_7|�2��P��C5Dz>}v������7�'8��T9�O{�����Pxw�.�� �ʘ�-#�2:�M����+���S��M��R�_g��( %(x��lce�_y��&�y��׏�����V�B��b�1@��R��!�	N�0����i)�>^��/�'N�(#����IE��v��3���I�Z���5�����8v��<��;��]��i��JE"���߬���h�F�Op��L%Xk�k*v��,��,9{��#t�'*���ׂM���.;aHC���E3�nz�t������;��t.:���fB��\+DR�ZZ���"]%3�5#�����'��u��	:6�.<Fb��Hc�	�)���C}o�m���C��nK�V�(��cpi5�xci�=��`�CiUyє��{L<���Y����HMR{��u��9�t��,��$:��A������]@c0���k���"��n�KKc�Aά���x�$giWXP�@�q�&|��wʐ=o'��X��M��$�`W��]�8F�fş�r����^q8�5�mfow�q�?��6����N�4s�7�w���]x����y�E���K�G/��M���6Ε���R�D8��!�V�N&�b2�r#WQ����V�E�¥ƙHmT�����z���%��S��t�EAy�u$��C���ԏI]��$��]^����y�����yV]�
ł���Zw�L����Gi�B5�5�e��!�r�/�j�V2�}۾�����B�l�����R��9���G�Y2��t��LU�sD���'���&�K.{���8��`��0�Ҷ�5��)�/'�{�1�ʾVa�\���l|YIi��!j��/��a��B�Դ�0�4{�9�I����G��+ϵd.J�*��[�#�^/#�ܥ��aA�i�>~��fjS�2������h<�ʾ��%AP�E�����WU(cF��1<���[a�r'+c�Lx^h�۞�q�1zR�'"�K:�]�Z�������H8ؕGoV�#��HvjX7��D��&��H�Q���6��&߷i����N�9�-V��y�{]�p�|Ĭ�e3����Po�"8�5�(��+Mښ=<�j�_÷�w8U j��j6@���*�$��֩�\�����{���r�ݻ�������y�a�P}�d���[-W�=�����g�M_<�w��@��p��}�yg+3��+��s���5:^0"r��<�uT%��Y�ቐaEr�p��*Z��!�[�9���+�L�mR=�WW8��*�zْ�Lm�S�3���/s#2���רc�psN�s֒��� 8�ݿ�h�D�u�+��I5���3�tZx�=�"2�,>ޭ�(��IU�b�Q�����ӌ%Q��z@:C��M`z�<]BӦݨz?a���̓Ra��a(�+ap�M�XO�� ��vi��Q��4��lkཪ�~��m�x;^��j��V�#��6��e�v���?M{��p��"�#�Ǉ�E=������04��ɢKڰ'ZؓܞK88���$y^�l�����|s�a[~O��W[�p7>QM�ӸU�(�O1k潹���h�:�ǂ�B���1�O�p�Rf��=��xQ��4�s`q�QG"�s�e�%/%SY�Ju�$�O?VQBS���T.H(���F�=��7�lo_��z�����˼���w��¬ �
�&.\��G��{��$��7�B�3���^�Μ��e�5��R	�x����v=~K-Z�T���-P{['c������xc��e۠�&4*���єZ��3 N�Z	tDR�4v�h`Z��A0�}>�0s\�3V4م�@4Z���4��s͞�[��u}^�����\�A�i�8i(,��n����-��=P��Ç���� ��?���P��5w�������GC��g����p��W���s�+k��C�*��"N�c�h랣�!|����?#ͷ͸�,��~u��+�B/rK�l�:� ~yv@Y�ꃪ~�w}�b��İ:�pd�c���x�2M�
�O��m����,&�[N�ۄw-ƴ�����S_U�I��Iely�j����aDlɢsyl���Ó�\܇[� U�^_	e�L�s���~2F���[���p]�ee���!���ġ����y��A�y����.��w�G&N�((Y�+ޛ��M�'�8���~_E����8m�F��}�L�|_a!�Wc�-�_ǽ�Cf�H��w���kL�(/VS0%F�r���<� �a"9|� �"� ��TD\� �-��Z�蓜�+`���PB�}��uސ��/:�G��]ax 0A8�|G-������U|��SC�Ӛ�g�3K�mŅ@�p����������^�{$T�Fw�`k�fz��RoTմ`*,�9�\"_	��=�4Z�$K��.�h��t�S�Gb�,����(\�:�U���J�E��=��T6l3�T��Ch���a���C�6(-&>���z@Q���6�T*�z�\z�|^��
k3W���O��ja؀ڵ����`N+n�r�������ڂ����5����߳��I�<��u�T����=�G|?N�a��b�D1�174�O\��#��8�����k���{чF��"1�{Uw�^VeRbg����U��j�yӵr� %��pR_S��E9xۜ���w���ķ�	Fi]��;a4u�Qxy�j�K�����`	�X ��I)���F��T1����? �v�"����]"�MyYeF�d�]��~�@{��H�    *��Z=[�+ jO�A�.5=^��S������O�c��?���w�-�{�z3 W\d�7��P�a;�$U�,����9�ۂHR�Vd�"ֺk��`:Ҳe�k��oi#<Q#��Ri~Rr4E�����{�9L�������lwo�r�͊���E]��f�i-,��d�����N��&���_�ȟY*D(���k�� ~$3�x`��������t��6+'�ƺm���Z��P�&��a#%�n�T��a}�g ��u*�J[5�1�ۮ���Td���K�gs�/�%"
eFg,�� /я�'���7͛={�5��-���x2�C{��{�dn��*ʜ�I1�&�H	?V�/�P>�4�\�uX*Vf�ͫ��hN��p$t,{7Z�/��O):�
�HSeb���S�ě�jR��N�+��M�Էf󧻞H������k�|��42Ç�lyH�#�Z�S|0��:Gz-�gJS��ƀ�
��h����/�.�US�v�����#�JЇ�J��N	�t&����;80P4P�ĺ��@��T�}��1�ocF�{M6\�P�Kq_!;���׫�j�M0�R�9hwhk�q��8ɳ�H�բ�ڧ�cC˘���ګ����^�F�T�1�&�loƺ�g�����O)��a�(!۠��B�$k�'qU�6vm��$�����O�89l���K�%����\1�3q���vɑ�|~�c}��W�o��j��Q�����(Li_1�0���l�3E�gE4�)��g�tO�j��O�LS���-�\�j}��O���(����f�E��Ӂ(?:���%�"��d�Pm^-�қ�w	)�y9��+�$�����Y�d�aMF�K���jY�;)bRM�Z��SY��5,b-��ޯ�*�I��LyA�x�Et/�Â����d۳�'B~���d��m���GDE�:�ܵMN�T�G��J�N���E��Ͳ%���a���~���	�J�Eu.7��cvK/��11�b��% �d����pS�EL���u�0��2D�Fx�r̵q�� Q�xB�-�7�Ѧ���g�?Zp,p�0c6	{�����H�pxߓ���.0����-�
�=�m������������wW��c��<��E؝�록I)��]Q�򒾅Of����:r�^�o1͸��/v�!a_��^������'�� � s�	�?x9��N�O$�ߧ��;�.�ĝ��
G���m�����kl�D*�l#M��vVս;��f[Dg�s��pH���6�6��|0'A��f�SaWۚ��Ӏh�����-s�\��Gc_H� ����B�
��rh�&~C����ǝ��`����l.�ؕ����[w�u9y�s5.(�^�E_[|�|ʓR%?'�2N	��'�3YIR¬�_���DlS�2�nМdlRND�i�}�x�k����Y���"�e��)��{��]��P`Eɻ�	aiY����$?bt���)���M%7��Fa�Ϲ�k�I��4r�W6��#��r���e�]"����1�R��0d��5�2*P*L�z��rk�U�J��p�-]|"�����dyR��fT�L�l�f�n�}*��r��uAFu��K�Ν��f�W���r��>�;���^��)�#�ُ*&%��h�O@�ym�u���O+l���L�IiZ��C��k�}`�RG9�	`7$Ԭ%��{LtL	@+n��C�T��c�$�����ޫ-6�؀,����O��pO癔6Āt�i��)d§] �2�D/Qs����Onl;I�ԃ�I��q��5Ro��W0��b� �:���d��ל�����yǍ&�*&�0�="�O��d���"�x�|�n^˯��	��)
>�$�PY1%o�AI��|V�j>ɇ��D�j�G�����F����Pq�i����Yk8�o���O��
[��׭���y�ꊵ���Ȓ`�S�&c�؀U��0o�,p�y�G��ʂ����`~~V��2��/��-?9�nV�'4�8�+G��a3�%�w׺*m�C7����|v�#Qwd�V1aD�ax��ˏ�7��JL���1������O��j`�f�#�͝;��B��~;���D�ϷP�6������zv,fx�/���{\�v��洨7�s�x����"�r���6�ũm߷Ђ>:����̢N��Wr���d�i�����0�����ˌ��M����p�J�������6<lK���ձ�Ȣ��$ydsX�&�_hFhV�E!��y
0h���F�n��F��O��L����ٶ�YK&P�(vkA���@T�B��n�`��E��۸�$p1�3#,ř��E:�j��ݑVo��V�#�CˍF��At/���"#�����c�c�q��`��hF�k�z.�&60Ej_s$E� ������N6�)���v�4�;4�[����ַ	������+
���=c���]H��е�4Ѻp��(�hNN���=�rm�A����f��]�e��x#(4��>OmZE1<�7^o����@l`����o/���j��WFck�4-��gA�O�"�&�3葎{��]���cʤ��
�/?6C[��c�^�\��b�Ws���}��n&�ݖ��I�EZ�}J�R�X��DN�xGV��og�[����uI,k�����ɖY��K	ُ��-�k�.@dB)�x~���Бe3��7	�->�	_�����T�Jh�. *^����X�oZQ�+�j.A���3��<�=�����ԩ('�:���[��1�\xڴj�K�&@D����zk��r�T#�-���<M-�m��5�d���@o�y��v�w�A.��h��q����Պ�?i.�%H\m)³��ހ�ӕ|3_9�I����}��K��!U�3��i��������Ǉa�η��A��u^�K�Xŋ0��n	pQ�m%���[�Q�h�q�h��l�[��56���D�HuȑIB�8�T�H~�`�C�V��9����I:�P���V�_H����1��V�)�6 Q�?n��7���C<�:I��$'������+q'����dR�]e�.�/��ݎ/3(k�ڜ�� f�O�7����\gߨK>4q��Qվ��q�8i���iS��Tq�4�R�'ߢss�̈|d��=ed�쨇�{��X���y�Z֛LH��6#;��΁qDc��oh�sÝ\�ï�L��o���?�鄈�S"�d��i����y�9�l[z@4𮉷�[��Nx��<�V���}��/%%
v��� ���ڇ��JT�n���S=$��M���%��~]��d���o��?|��#i@�`��N�2\S�->�<��
�����'!"���x���<��k���s�^����\����_���HX('�����{�<�/U�-S�a_���������ï���x�,������?���	ؿp��ʢ��H�^����Cc�j[a���q���L7��c��+ZI2N�sGV���KH	�is�@��4|�"�(�z�)߻�#o��6�Ke	�XՂ^N�	�Q�DiA������*tg��i0���^�0>��!0`�E������ʞc�b��!CO��+1`\(TZȝN�T�����Z��� � x���z r�}	%%��:q��7�~ץ����XiQ�����(vЈ�6�[zS	~E��9��%�ɋ�$Յ�{P�0��G���%ş���k�d?5f7BY`�?i��x��#&W�g1�sڢ ��V��'��VW̐%%�h����� ���H`�t�\v��#�n��5���4���9�c4H�(�x'o=GsV������C��_p׬k�K�I�sw�F��T�� ���4�j�.ieE�e!IRY*tnPS��'f��Ƶ��/�<q��y�H�obJ�T�?����+&2Y��ԥ1]��,d�G�O�s��U������	��{L�Q�`v��J,R��@�������*tK	��e�l�ZZ,��h�Zb�gyK0��|����%i�G"��%@��_�岯�<��6e���oL�ǋ�|��s�    Ta��6��_�/�i'Db�y�500+ѦKU+ٟ�1�#_��LTF�5�Ɯ� t�)�n�[�1�����/�� y������o7c��#�`-�.�_�(��L%�oMJ<�w\�.f�D�m�k�d-Rzl�G�����<�2G�/u	6�����"͢�ni �__����k}��-Y^U3Q��q�.��#����ȼ���k��N�M����V&��t(�S��5/CY�`��w��]�Q�]p�=8G���ҥm���}�`�/���#5Լ�2)��� �Q�f�'=��uWvN#=j\]N��3;�h�5E� &	�yZ�c�P�6�'���&~e��1�:��(9 Ym�ix�T�������C�v�T��)OY:.K���d���*k u'���]5듌�<��Ёź�Z-��h�F3�>z����rp-�Wm"�U�>��c˾3wz3�
P��P���'ñ�r�B�Z���jX96��Ǭ����$�RE7j<1����!X[��d�u��V��V���7E�9��ۡrI�Tlx���;?E6�gV��%p�����h�.�\�Z�Ҝ�O��4j}��4� �<�]��J��o�+�n��n|wMU��C���I��	}��_�H����Qz4�RbД(�D�R�> ���L~�0zk I�K�z9�E?�����R�Iʴf������=z53���U��ڤ�#�G�Ȳc� �ǅ@�x�� ӟ��>���%^��y;�u������2�R|ײW�]iP�cY���n0%��@��PR�ā�5K\����k�����ۏ*�8 �U���o(���wNZ�/��n��=0�D�t���B��>�OdI��'L��ս�g���L�����$�@R�>�/�h�1��G�s�"o��f_h�#�^�/�iq;���Yp��v��tФD�L�=��E�x['{���5Y	 ���yT��![W Ȩ^�(�@չX��['\~Fв憓�W���E�By�UVS��Ȉy{���s�M��;'4���M(A�p����f�?u�$�tR���1:�bSn�T������6��@���խtȃ�>K��li|w�L/��,bt�m�je���u9ď?-{��~_C��K����-Z�܃Z��0�c������.X�~�Py��&�*s�;ן����l�B1U�D�h��c�:
�1w2��w6�)+g�$��R����rʳ� 4Z�vIH�6uj)�h�K������]�Ͷ���&�7 ���J
N��:�;86L�!��8b��Mi���w���%F_׸hr���L�����
3��R�k���;l���x��@p]��׊5~��p��p�u]�,Q$��^��$E�4��I~�1E'Ѧ1b}�2�(N� 6�.��i𮼏ϴ��0K��at6q�PDc�1�1�.
;=�n/K���Bv	~D��ndh�짭���i�ml�9�]d�u�qʿ���<T:
-K�1��D2��U�t�����}��>dTc�S��,���������~�%a�5�"9����9�${3 �#�R�
~�^C�X�6�d����h����Z��Z,�p�O}ۻ��R�<i����a�����y+���{b[�������[�+v<�o +�x��	[�=w�/2���Q�: ���9�4�*�n�E����ՀU� a셼F��#( ܋�As�D�k��;���ѢO	�[WDa��
f��$���a-�XH@�SOA�����ւ Cd���/��;��ΆV�{� ��xV&�����Cc����3����kIŝ���k�m�S���09+(b�0veU?. �PJ�"���kq�,�r~<��<P ^��/�����%��<�;���T������&�ߢ9��F�Th@�����Ix��Ob['�9`��2��x�C�i,���uWe��S�Cw'Q�π�+=�A�?j� �(�=������ ��/C��q�����F���%#�!)��L!��:x"��f�0p�7���˄b-M�G��KQ�Ӳ��,6�Ƹ��Vh��6�̂'Ft�f�V1�����2]���$�.�#{�Buah��s���a��(L�m��/{���(���.A��\��)�^��kxk�~k����EO &KG��\�P��[�СJڞ[��S�����?��	����D@N�o�P��1���LC�һ~Zg�xۯ[P ]�;-���A�8H���J�	��]���/��43 >�e�d��.�{d1��м&D������?�+Q�~��I�誓�N�t������x
g�eֺkPȰx�r-w����a�%�e�%�P��Ê"����nD��vIѱ�t���;V��X�����g<܉�`3�ћ�CzP�3�־�I�s3i^�I�Q`�kB�� 9���	��B�m�_�2��;�}��aV�M��E��]����07O�TҼ�v�fn�
ߍ�� ;��8rl��qI�c�vY��R8`���aDm�x����l��C�?8���lN]�jcN��7�����N��[2�$�b��P���	����h�m���&�|S6���&�h7�M3��� Em�75b^}$�k�M
���������y��`�Z9%���&�����r�㏵�`Z!���Ƭ"�͵ŉ��h�=P���/��I}�gF��bc�H�$���IȹiB�N��3W�;�=Go�t� _(�9yI2/�k��S&���q��X��z ��?�Y���|5�+���PI�[;��(�po�#6��R�y����_R��6�zúp�8�Ш@��h�&�z��u-b0wK��K����4K�eh�.h� S9���&
�7�J�����F �.NT��f�vl�I�Ȫ�%0x���枿����<bq��w�y�Գ�P��M�o�"/��m~�P1��V�M��j?C�b��^��g��<�ե�ܳ���%��%s���Wgq��A���&�@�����f�4��j���G�.��~����*��',��w�zȯX�C&��&����-�|a��ʼ$�5Fq���xU�f��9$(�%���b�r�W)*�X��+�K����c��s�]�I�m'��6J�6~y�`� Ȍȿ��d@���~�!�ʙ�u�Y*i���t�D~�<y����5r����Bϱ��\f�5UK���٬�P*ۯד� ������p��lg����tN-�bg���؂����}�Z^��:oq�� ��4A �j��fӱ��U��Y@XQ�o�=�����[�O�H��hluXJ^j� H���$��?��V�x� �ŷ��N%�hp�T���1�l�/������pG�1ܔ�#D�����36�������b�
s�q��&��@P�4�W_�²>Uz a7X�Ѐc�`hHk&�����J(0������V�ҥ��8�.�pa������ǿ�m._���/5��jQO���� 3T(װR�j�8�?�k]���D�'����F���"�/�p�Ph�S�5Nze3���Q�K	������=�fEx@����R�iĨ����c�� �K����Oϊ�1������+�(�~F��.��c�-mv琭Mx���uhS�ظ��G��/�	��}�]�qؘ�ޡGyh��{����L0V��h7��,�ڐ)�4W)���+�y9��PW������a1o6�B��-_.��.�<��B���*��׼ ���o(�Z���T���wU{��.�3������K�#~һ��zQ��g�X�Jx�<�n;� N�1��� �688�I�Yj�&+7�[�����<I���6���^����v���׵z>�"B��modl9Qе���r�杏���C���G�΍�
3y��q|6��3�����!�W0}+��*kX����F����ҦÂ9zi�guF�h��O
��<3y�g�{�����t���X����z��j�*�˯]L���6j5�.�+�t�n-��0%�%b�CҼ��hE�    ,]��\nwC��˓���kYo�>Q��8.s��i��j��������ȟa6��1L_�E�<m&K�'B�Ը'p̓Ȏ�X�U["h����sE�w*2�hJOjiA*.=#Hm�:��%�U ��L6�Q��,�8q��:P���b�:���$�c���<��^Ŀ��Sff�����%�)ރ�˝��.����c0E���6ex�}~U�ź�{9�3<�wy	apM�E�H]��$d�_�2�Օ�N�$I�1SY��u�\ۉ��j��gE�slTҢ��'�Y9�&Yb<���=8r��5�@�:����*��>���5@-�Jλ
��1'�����۶���
3����,U�_�t���ln�K7&�P �<�X�N��B�5D=o���zD�&|^�ű�mLw&X�@9
a�w�I�E2�|_��7;.�l�L���a9���l��w�5�$�j
�X��m"�s؈��vx��#+?�X.7��N���HY�ِ��K���>�;���)X���F{�ϛ�"X�rc�7�N����q
h�[���x��M�������~�e�60@��,������#*�{����|��f.>���ݗ(Lμg�U��d�\f�~]�ZJ��|�a�#�_�yv!7���º����X\g�l�� �
���O7��}��0A=���ۢ`����A1�7:��o1O���&"�����̖���.��|�2}ZΊ����O� ��l�FI�A�cH��4����P5����m<�`��/��ȉk�]��K_�� �7�_��;�=�v�2j;�tش�����PͪЫ������7�<mxh[Gz+�=o�� ��3e��Y�[���
~��~�;�:�9�:@E)#��U�?�4-�= #������_C�.�3��}.�P���)LT�\zyaj#�2fK���#�Ж��	�8EL
B��&4�r�&��]OUc��F�nr(� �&2-5�#N��=�	ۉ�����b����-=��ab�y�:����Vu�ڢf|��(KB�킑����Yf7�Q�4���=��b@��= �0�#4Ϸ�%u_.���i�	�����/��3���a<eJ/��E?�9Bx�s}�i���D��( b3��3���צȀ�vyhf��b�o9�0X�~����;��@��"~֘ɪ˿����۞X�� A���eX�{�.$)Xo��g�]a5�m�J�xb�4�l��h���N�._��8��C����H@�sU:V���2� ��޿g3�c!|iNU�6cP�z�_�y�@�\se�ʑ4�Z}�Aj�R�!�I�h[���mo��O�qvB۵~�m5/���!Z��2����~n>��5 i�)�dZ���WY�<�g�"�w�x=�~�4��LR��s6��9�<3#�A��e�G�"RǇG�|T�Ħ7�F?sN/���a�
F�_|��̡q�����}�տ5?����TQF��V`�.S��8o��j�w1����4x�0�'wk�fN2���4�O�G0+���!��3�,?ӷo+ZP�L�n֗�0�jXxOX�Gi���h�K����
�Lo�^�����& �PY�a��"K-�9[A1�Cԛ��_7mN�1��GWPC��˖�����mC;0IEóQ{&��{��p�H���8Q��Nу�!�P�֧o�����-�a��X�X���R->�s�R�7J���2廧c
,I1��v��Ic���L���R��J=�g�ĳ����vn¦/䧹WFS�)��O���y>��l�C�l�$�C��ր�L�!�T�ho�:�o���BI�xJ3���1���ԯ���$�^�/������.���v�ܦoE����+��_����|�Fĩ{��B�@}Қ�r,�}՛[����R ��Zg7%��8�����d�n�}cR�V��TZ4�����"�hf!a<C~E�9�Q��u�d�{g�� ��#���x��XC����]� �
���{��;t]NR�c�������TSPp���47�8W�|)�L�����"� �2=���m�?��b"�`X��o5*͸���V7d"�Ϯ��k}�Qz5��n�V���y%���ƽ_Z����ޯ�G9[��Ɗo�y����w�,P'���|^��H=�'��?�׷ұ�R�c��`|�;(��b�ؤ�<LY�Z�$���1�B�!�>*2�)�¡���ܦ���1[j�G�(A$�`%gv���/r�+&�xN��*R��*��>N�����ŗڣ>/k����W>n�1�]=��kuc�0~`���'�m���]��3D��>�j��Q'ѫ���o�!=�L*3W�z���α��Q�ʟ�:�(��H9��EQ�c��äC}�n�`n �=}�0�t&#�d���O����*�4_^�I�n#��y�q+�'���|�Ô5*�ނ��5[�6�a��||�������d=�yc������q���=�l��ǯ�ȿL��m����<�?2��R����+ha�C6'03J��2�]X͋�:�Y���	u��sJ���?@��(���N�ϫyZz苪�E�\$ɢ�ί5�XVD�=��+*���۸�/x�o =9y}�;Xx���G��g�4ȍ��+і�,�����$S�':�^��w,XD�Cy�3��#Q�/��˔"�\'0ծ���V�n�즡re{t�NԾ6)rd�����(!���P"� �8Z����o�[���q��0K~Q회@>�f�х��=&��q�k�/�u`�4��������]i!��\�~���}��Ye8���e����}�=�n�བp���U��oe7�����p]M�m�K��R \H���h��>΢���X��S��q�^���%#����,�@B%�Rq{��h�)�Y�e�wR_:�c�;Q�*���>��O�H�Rm������.C�8В�~�L-=��ɸӪ}o��\�o�@���^8�6��>D��Dj׽(�2�Ż�"1Rb><�E�F
�t��<�b��L��%�U��9���7�9��7 X�@��gg�Jv_cW��-��#�>��G;�;\9	M�!Њn�wE���KY�����X�������Δ	��=�v}�k�ԻK6ꭚ�>��[��}ۭ�Hn�r�Д��K�d��zY�J��:�_W�7�{�N���@�$�.�\�ې���P���^KgaT���Jg�X�*~�2��3��n�����.���n������P�1��(�['��g[ F��];�	���^�g�����-5��Y�Ҋ�m!��	��Sɍ�I���%��@uA��H�|ާ�R�:D���7�pb���Ig��뷠~�]y���Τ�F<��o��[�ݼ-]؇�5�Y{{o�°�.�|�K���������9N�\Lh{�ʔ'�M�@n��H
��̕J�I6�D;pd^��&��ӻ�]H�q�`'d:,t��=~�D9c�+ڽ4M]�(�t}0���2���V��yE�7��9qoʿ��V����a���$��挤QM<�a�f�N ��}�o{��о�oV�Dÿ�M8(0�;L��Л�kJ�M�(sI���׻�w�j�d���4�B*�j�o�����5�	��E0��'L�H���0�=�<�j�D�	˾�.���#�quD(�߽�>��I�y���n:��;@�h�毚�ǆU�O�m �*@���&B_�Qdl�.Ƿ�^�B�a��;���|�>�X���������$3h�љKy*p�����4 �2J�tôO�S��i5,�[��~�PޯB�uo���#�Wi7��p#�����#b�����LےNC�,�8����o�wm�;�T�N�p���#濩�U�(�|��0� X�@-���\��ͽ�"o�oa?��`Z�f���*Y}�(������Ud�7�?��Py��tT�R�Ȇ)c�?�)��ūV�cЍ�σRzs�s])����'=�Jy)v9���6�u4�ǥ�;�3���~��x88/����{s�_����nڔFL[�u% "A�s    ��-T��������,е����Oğ��nd��ћ��@�3���z���f�����L-w����J�p|��jY�M�t5��ۗ<y ��X2{.�q"F���sSl�-�)Ȩ�Y5��"���{�B����c��~��|���Y�@�%�be��S��3���6@�"c��B9��ൄy�ϷSAH��nT˂y��Y�C
|��7��oc�2I���+��ϠE3���yK,��F��#/��� ��"�+D����.v�̺o�"Ӗ�ajǿO#y͔S�Z���bp�Q�[e�8���v��G�K��͎]�͡˛�alu���v�2'����XQh�H�e��+g����l<���yN�fw��
��^8�֊ˢ�(���z i�2��r�7�}V�"�C���B�+�9-�� o�7lv��5��t��-`��(��g��Q� �Y�l�k�'p0�|���.Mο��g�_��	����c�Xэby��K��r�oCVv�4��Od��L|�y�hq���������߿Ρ�c�To�9~�z��]���1�.�"������7sP��k�}��۩tyd�Z�'��d�5E�u��>������\���Ͼ��V07$�|/T8��b�1����x�!�_ҰM���Ye��Dv�+����@?��<�I���J�͵e�ӓ|7Wi(T9��ҿz��·�d%+�=����$uy�]^���,���
6*��c_��� ������y�T��߼��9aLѩ��to�^m���;51�	S�Èa�r�v�Q�<H��n��D��2�~m� �=�:
�"+���Fv�#�8�{oɜ�+��$��3X�߁��8�(!�J�M�t;�!"s6��T b~��w�;ߎ�B�1T9I(x��X��;G�Xޞ}��Tcx\�q��/����k���S�R^��)��� ,$�UJ-i�=�'����E������iਅ�߽0�F{����Aɲhe/����=+�270��Ql�y�Abl� �L6բ�h����S�K����\	�̤��
P��/����)A��s�hv� �'M^$�;UETz�Ā{Z�1'U����X覀c���b��'���rqC{�^FG��*]0j�?V�Bo��#�UY�H��$�?�!�ظ���dNꀌ$�=�~VT���=��Vi�x�_��y���N?���b���Ñ������z�7'L��D4�G�G�����R�
>(}�X܊�{^�?�����8P;E%yt�7ָ%����0�1n�7�W�4Ǵ�wV�D/�������z��%B����8mN`_��i���x�b[�A��y�z}�K��D��cJ{��^=�P~�y�7q}ڹ��Wu�%,�/�_	|l�U���{q�~c@���s�=�����sV˗?�r�U�����[�Γ��шܮ��!KCsD+GNT_�z5 RPP_�J��5x�\�LO0������)����6ig��|�8�[�L�ȧ���j�;��l�2���n�dt�?�'�Ŀ���1I��"��:,>�W�Pz��o0�	�0�P��z�P�H��x��S�H�|��a�>Bp�N��I?����Mz��u j�6*=��R��jͳnkA�(�^K�������3j�?v��f��� �<X���l1��ޏ��@��Y!�ô�9ƙ�-߾�vX��om�PE�m#��KY�K;�� Nꝫ��N��ҕ����Jၓ��+Ҩ҇�&y��c�k� ����n!0nl��^͢�eù`��W���؋J��XC�)f��^����7/����ǅ��$ �����}��_:H]�O�tX��Ep�)t���n�R��5X�?џ:�<B��
b�4ׁ�����ұQ��A*�ֹ��G�|c×�QbQ:�ޠ�2�>���3dS�
|1�t@Ӝ�ɖ��o���`0�.���Un��
?��{�,�兤�u2��&�d+�)����R�h(0ɸ_�h��[���N�Q�~_��}�eS	�D��lTeIF���8H7'�P�����iq�P7�t����	�u^]̯���!B�`a߉�������ޚ�}���B��V��k��pu��^��������4Ӟk�nKG�'fBqi��Nh���������t9�_I9��z`��8j��66�A�^�����NS���-�{>`:���F��=�Ĩ�*Ls�F��t*����(��K����wJ��>�B�)�},�Ұ����6S� |Ȓ�]�/c᭑3�U"QE((���]3	��I���( T��!���������I�țJ�mHz,N;g�'ޟ3P�T@��Й���ঁ��С(�9z=�������ZZ?X�~ݿ�D�?�.ۊa77���&*u��1x8�=��(�f�q��˪��~8�Ⱦ/'��a� M�S/���[1��~0��EŶ@���~{qG�	�+.`S����*N�ʢ��QgX:d�]���r��f\�8�.�$��j������/���А�1���UN=��@�����9ߊm��3�S�h�çY�L�����y�B�f�Wu>���~%-e��)A�x�[�p��WŸ�qؑ�>���bB@���#���,1����_JY bľ�"����l@�A��~&�&�w5|XF5T@ ������W��p�	�z������R ���2?���"��*��l��"]xĆ�����ǫ��g���AmXt�I_nV�9T����hO�>�X���߼�PR�.'xX{1��)�c(�
x�C��wk5DY������+ń��TVzI�ν	#&u��5tdn��3d=迥�06
�G7��R �J,9��Q��Vf�/�ʺ���ڿ��VlW#H�e���;�K�o%z�o��<����	�/�^{���Gx	E.�p�!%,�'
�=ܘ��V��:�e�� Sw�����vvN�N��{W�������̭Q�:7C!`�2b�Z�7�DwQ�̄��f\F�F��*sK����[�!u��U�(<���By�ǂ"�T� ެ9�%�x_�@Ff���QB���E����܌��ĳ#�f��K�0�km��y�0�����+ҹ��@@,(�I�HA6�+r����*~��3T��>���р%x#��O����D�-E[;A�픻� GEu�pUB�-ݠ���h���5Ra�o0/�lV��Gr6#&;>%�p��A'� �{Lqf&D�nti��`iD��|�@��;�b�xF�9ꚗG���(�s,�ߴlm�t^���_���Y�p�9*(?i�ը��.lxd@�ZZ������
ݓ,�c�~�J��Ȉ���"��,ԫ�/�H�'�O�w}�c"S�#���S�s>�J�كi^�P��ado�����`�G�S�Y�,�M 9D�O����e\�$�j��0臭����DU� ��С"M������sQ��� ��^t_"\[�,����2ֳ�r���b̳9.trgtHk$}G�!��mY|(Ƕ���sx�?Ĩs�m�c ъ@Cp��S�̮^��I�;�����nj��O�R�VD;$�k���C���	aFZ����)���:[����O ���"Я0aZ�6���o���"�E���j=���ݖ�<�V^9=������К���o㑴Y�6P��B���v��*�WD�`u��S�XB�rb6���>5��
�����|cJ| ��>h_Hd?��p�	v����zWdu�?��9c�aT�[�H�e4;�݄�o'�!���P8����DK�P ��D9����	;~dy�6D^X/��s�uN�N�1��)AiW� �Ioj|�^���$	#)�w6p	O2!J�L��*Q�7r�r���u��
��ML0�丱o�S��s��������+8S3�L���i5'F*�I�f�#}�@@j��ɒ#@��S�u���w�<-t^�F-W��l�e�֛���x]���7|�$��CPK���u:��p�/�	?    �sO�@N��2�n� ��:�fr2<l��<��/�Rb߰1��j�2X�X}`2��O�����L+��SNM4�*#�;�ҽB���U�%�V5��o4G�Y��!?i��x&�K��.�_��Ie�Ċ���,ѐH��*�Q���O�3�of���q�Y�(�a��ހ[�!�Ȑ��� D��5�s�䠒-�1N�!�
�gx�=�����kx=���
��2��{��rӠT�J�쁒����4j�,��[�.�a�/�.!	[����"KJh��b�;m�-[���_��	�m?������~_�~���B%9U���_�=�n3Ƿ�(G=��mN�����]���m�_l;�ҭZ�A2��E�����~��0,���F����p�J���sm�8+��U<�e������pI��Q'�?S�S;�z� �g����߂@Ǳ�a��3�$�_���自	��e��g�hN�P�!���hN�`w�R�Wl��帍�w~����O�ڳ�-��u����I+����n�M�J0A��:�(u�F� ��TLi}�ƽ6���!�j����-|�0�>_�ī�[L6�"�rb�!(h�[H_��%��N�y���	���q��Y��O��=�wO?o��?�����d�a9~�c�a�AQDl�� "N9rI0}��7c����� \���W���ڥ�Ayi���u����IPS[��:��܃o�����\�Nԩ�ER�����9���؟�W��N����u�(��p�n�7&b���_�n˵c_#g��Y�y~'�̗7z�|xű��م��$�� 74>;�!�g�o+����_<�3(��o�uAp�li�/��V_��ke��UC�H����J��7F��X�	�$3�N,��l����J${p��T�~.A����x*>
�R�fE�bR��4�Qi�p�Ch{$@I��&t��p����`�E/I��ܬ��%o}�!�3�mBB�6?6�>�����:6�h�;�{ܧ\�Q$F_^m�/jN�c�+�@=6ދ��SK��U^n�Q|MQc'�L���pDa���R.���E��k�u�*��>7)1Q�Zi�#;�w�䋂py�M�i�,����t!�y-�jÈ+�4����8��-�/H ʭ�虩o����|�ZjޡKxh��f��ؗV�=6���;�T j*�fғu��|�e��Eb�8��cg��<*���՗�N �@�e*�:u�Q�91�=?�%�	��[����d��;U�� we�xL����V��آ=�wbfo����#L�%�Z���0�׷]�5��;!��D"U�����;��K��� 6Ä�"��,%�%�i�%��ސy�nJs�%>� ���(MI�%�*v����(`���:w{%1�jZi.��Bȏ��!ua�>ᎇ����|ߚe��L��Ab^�a}>�*,~*��?��+��������g�k�ހ��$%�[������u�8�iޠʙv�摾/#�P�~6/&��������dA<N�)�"�X���B��_��+�or�vg��k*|ףҷ����
I��� F�\�˗��l�ư� ���#�E,�:y6�C����-M��[�Kn#�A��9�SP�_�I	^����{���s��o�uf����1���F'J�q\ 4^�m���%�j���!�tDA��dݑ;d���6Lɀ��R�o�yN�t���s�}��I�w�Ra�0o�t�̟q0�A0,�4	�������Z�G�=�BG�`�䙁��H�A6qR>AU0Y~�=n,�³S cha���v�o��9៑�����2s����>b�J	=�������p1�uOBw��Iދ��s�N��;h��>q޷�0�F��4�I�͎�~�o.ڊj�RI ���4�,��Υ��%���q vx�I ۃc$���߻��b=�Jm���L?�"�Sk���^�F}��教j���~'f�-�����Kހ�(�q���=Ҕ|?�2���
�ٶ�����@ʻ;�<2ё�2��;�L2'=����>6��@���iHH������Xq��݌�<2��`k���}߶x���>.F��~S��A��n�E�7
�|\AԴ⠛̓�>mv):co�t=$ٳ$ux�{u�ՠ3�;�̝ZN��ݴո�/�޶	���-|Z�1��0I�+w�s>q�F���LSę��[�,k��{�@�v�J�B}�Q-'vAA���iDn�p(�>4��E���%���9)5�)M�� �p�/�9�a��>��<}���$[�{�4���g�������3���fL�l���v�$�Ak�6����䰇B]�I[�>?'JA�z�]�ד����<�-����#٣{֚ĩ9��_ƶ��f�ʍ�u���pZd�.�k+���!�������dE���䟃%�_�7o��OL�igэk9Q���a�1ʽN�o��+��Z��#F��Ek��d�xs}�:�,�|�b�v�\Q�T$�jK������W���� �\�پpp��bz!j!WFaP���=�	g�:����j��,~�jp
D����5)8a�om=�"�'�v@����0���ބ.,�es�Q"�Oai���}�����C}�Q�`G��j�S��
]�;�%�'��s0e�2�,U*�eV�?e'������"s�2����w�n��O冨�/��5��P2����`�4��,�����dx_�#��߸��\vd4���E3�y{L�m�]��T)�#�Q3�H�d��T�a�x�?K8�N��K|�Ja�$��g�g(t�i�d\�)J����Ci]��#7ű� 3;>|���Vf�X��n��n�v��ߔ�1�}��-�,Q>�؅��F�Tx��Wz�P�/E���������2��	p��懈��w��(T�����-Hw�á����4s99R�8��p��2��J�B>있P^��v@�g\�@�J�x#f��
՟P�*<[s�Fa�s��(�W�ȵ�
��?{�H]��E�2^ԡO�g�E�J��R���r}��jM6%�H�eYs��4�3*��]�-��f��n1B�-�K�	
�QT�Ƚnᗌ�-#e��0nҷr���D9��꤉��+���	�0�ǽ�"뇦������#���%��,x�q�'�����΂N.[L���vK(ӷ}�}G|����U��������W§b sL�n�i>��ςΫ��`ŏ�q�ָ�X��d.�u�,�`��<���梅���ue���7ȋ���>:q����=��P�-v{'k��8���(�^!Ǵ�;x�%qT1"L�5y}1�j�)J3�0X�U����2��p��Γ����/���Ͼْ���
n3$�lh��z�d���m�^�x��$��^��Or��A�K�wv���X�2���CB����m[:fш�%�w]���wg�|BD��`����N��\�,	��&*;{E�8N~�����!	��Y����@�k"r��'���E��]�lqbA�%=�*XW��/��e�����q�	�ї}(п���J)�0L*^Z2�ڪkA ����x�f6<4˶��5~�A��2p�`<Eav����|7��2�v
S`��������\��!9i�t�ru���TŠ�@�+(�Wjn��'|�퉒h��Rb#�Z0�7��'Ŕ{�ueDB�,��]M��J��ֹ&'Ś��3V�����
��6��{�&@%�o��G��NI��$�l��Yj:E���Ls��>���}�MG1���8�/U����7���T�u���p-��_}c!���&� /^�(x�]S���$&�/�z���)���A|�y�0;�߭,�2�A�.Q�K�2Ix��x,i���hY��]��<�:��5�&�P�/a&YA�)� ��k� � �І�Q�W���ඵ�`g7P����h-B����y��v>�+�vL�D�7���,s�����_�v�v�il����Ǩbz�(jy;d��y�np�t�"���������M^�O�    ���d�'�H\jE��!XvT����n�[>��h��'�)Hk~YU]�稅'T+v2k�i��_���:��mr��6��v���ܜ�uG+vQ@U���I�6n �IcI�tHF��A��A����C@��꓅'k8ݪ�k���=�i�e�w�:N�ERƳ�р��AKTkR��&w�k��\�M�H�R���l�q��>�Ÿo�N����Od�
J	�1f�ṁ�j�����M$t��E�"�[?�#y)��Cr�5��o�3<�"�v�����N+��<j��2n�"M>'�$����s��Y�_���}_k��X�:T��r��/[���F��c�$֊o����w׽ǘ�)��ʦ�Ke'�$B��V*Gٚӷ���y���!5+vĝ�M�O���������Й��Bߥ�y����_`eS�?~e��3I(VU}���Z�򫧥�C�8w�>�՝� �� �I�� ��?Ş/9�+�����c�F����n\ǹ��.O�{��g�F3�7����<��âi�lF���^���2�;"SI*Mka�ž_�X�@�O����@ EʑK�k{��g�v�����GoO�t�����~O˅b�2T��[�W�յ�~�`�#�*��� sPi
���r*��r!��&sqEI�Ԯ5:�5/݄x;K�ze����t-�ٗ�O����������ۏA��p�YkW�xݹ�P�?�^���A��1�t/�!<��SF����mP�}�j�F���Ѳ��,'_��"g�,��.�J��igw��{�UbG�$��	+ɀ������0�C7c���l��8V���s�6��Ū:Pq	U���ej��.S����,*�2���m. ��-@�0m��3�8�VJ��7O��i�X��q-3=�s^�R?-�ۖ��`d�_�M�m+m'��Ϳ�~��4^��Ҁ������T+�.�~i�W+,��Ucߦ��v�Y?������SDK�B&>��t�#��_Kr�Q0��LH������%�H3�I@��ʒ��cr�3c�Ь@-���o�q��H�o�ߵWY X��輪�d��C�%��1��i��}��T9�!�f���w����D@e�Xss��Op+�d-D��<�ul�/���Z�5f�-�b�ë�:Ʒ�O��p LQ����J�=4��h8K�	�H\��J��@�ݗ�x���1�*;�Y85Tx���������`�ɵ݉2��Y���ɦ��?�A[�
�P�K-	A0}KWO��]��N_Y;{��6A�#ͱQ�5	�Z  y�w8f��D�!���7�/""����)�vɵ�?�z���ɝ`�K-	'�E��g�2C@0ˋ�^��Jq��(�"�ɴ���I��jZUx{@��R��Z�Lhj���)��g :���H~}�EQ��%�am�A-Ϸ"������GÕ��fni;S����Y�7'Z��$�'#a�|��G��xȫ~T򯯲��v��-R��$)��|Qj�SMD��Z���ㅶ�zu�V�d%>����5vܔ,c��g�C��<�h3G<�T_C�wp�m�P�mBm�\�T	���S�o�%X�(��U�is'�q�Lߔp���n�v�{q�ǝ~��sX�����E�xF�G�`SN���������]|e]�Nw����
��H�v��ݱW�����'7�g�UX�.6#H���u�.k6.�����c��q��Q}(�K��b�:U���M�"��Ӂ�}By$H�ȏ,GY5��J'�M+��8���v2y��:�T����i�W~�;A(d�(�{�:�Tf��j�����{r��J����BU�|&L4�K4 �h9MM:���X�I�H|��k�������m�(��Di�N[��S��P�"�{�N�w|%Fݷ�>0/��U���Ĭi��.�Ҥ. ^Ӂ�tsĽYߊ����F���?e�"!�F��Z�o]\�]�-�6����٧<;cS%�lPH�^ (N_Pk}���3�����,<��!%��e�*0q�#L��f4zSw�%W�m����{W1\�)�@��ދ)|�3j	i���L�F T�K�g�l������N��)A�%+O��M/`DA�ē̫�Pg6�0T�r���8�u�Wb߫��A��F���뚳�J|����u���I%��+R�I~�S(������
��4���ye�!g�P��W�.m>��=Y�DѤ����k2�h��:�#i�&$�u}��'��|�S�ؘȇ�� ��� "܃�vZ��n�n{T@4$�b�s�d�v���}�(��y�oo�	�5]ҶZ&w����d��OXx�K"�f�ү�KԻ�Y)$�D㣕��V}'�Sj؍��\"*��P�|�1U��	�c�W=axL���C��S%�M_V�Dܷ��O�c��M�9YN�S�	/��:��S�&�G̰��s8��\O�+I:���C�|v����>F{���jN��D��
�[��|�����2�.�W�|ݵ������VP/��e���*�-�&�G��@�\�i0^`�:Mh [~�<�HuP��r�?7/Ǘ��p {���o��Fޕæ���n����@��ctN]M1�y{�r�')��.�ݹ�s��;�����/�8���w�Gq7i:m��ww=�c����\�J~ª��Q��@δ~�iw�(���M�AQDg�)���eP�Iux����"�+�������r���ɩ�S�>^%ȡ�R�9,ą����;s�9���'U�:���e
�o����0,�3? }N�?�P����,�o����S�gqߍ��}@����D�K�1��'�e�%C��E-kwy4�q)X�N H�����^����6��r�3����o6.��?��=)�?,B�T�h�|'5%#�L���V�K� V[�?�t�+���@I�֨H
J�L�ݤ��ʐ�E�F�pv*4 �$i	wsO�!F�'��'wܜ���e�;��z��<�~Y��j��v�\x��+ O�o�'.�׽Y �WPc����x(+�;�@��\�]����s��2�Q���*��;��ꔢ��@u���G��h��hþ�>���%��������2�V�4	Ά��V�Ĉ����Pα��<�u"�:h�0�\S|���D(c�����X�M@������dn�sDc��a�\�L�ȡ�]S%�75��R|1�^��ٳ55ѤC+��֒�-���KDRK=� j��cH�ȴ[Q�&���c��i�v�赍l8�|؅\��A�"��B-̣9.'�Lp�X�����ڛ!�wJ��#<������>N������􋳶��|~�������9�@j�٦�pb<krm�!���}]�,�4m���츭�Ц�u����'��3e�m�,]� �^0�~���:N��j�b%�N�!�X�����5�;3>��M���S�qx�����4����x�g��5p'5�:^U�9G�����m:�o�{���˾�e���Ϳ}�q���rw�3+D�ڜL�ɿ A�M�cY�M��n�q}������30�rj��>� \�x; 8yz�q�����+�m"��d�4W# �H�����	0	�]o[����H�4�W5/��3����	�z���� q�Ԍ"���t�Gm�H' q��z�ĉ�\J�r"�Z�:'��{������
7{s�9�Ք-M��L�Q}ՠ��`b^D�����QJ����ŪC�܌t.��q��\� ��%-`}��Y�(-d��E�jWH0��]j@��.}��A�IMO)�I�"��#Y?��/U�}l/p�O�L
�[�J���F I0���b�e:�
��m��P�Rk��5;�������l����D�(��*�4��l��'��,�G�ϻ�<�ϳ��o�>49Λ��Ƈ��<���	>��B��l��C�E� \�/(��Wt\b�k*�0�^p\Y����+��~zYw|�r�JUaD��F��{g�î�y��>x�h���0H,� ����u�=�ۙ�B��*✂��>�����{otOq�	���̷���t�`��*�9�K��    1+�t�tK��x�_8�����_8I�I��Mc3��&�c���9o�X�T�!���eP�ef���
�Lg���С6<�p2�BP�}ZWcO2��"��9���3 E6�R�9������� �'=U�sk��mիѡb�M����%�E�N�F��a�ɠ�]^$��j%U����(OR����ڝj[�۹kM���[������oYo�@������G�4M��\��6U9�0�֝d{K��Zmnr�yq|5�t�ђᐐԹ�:��I0w��Ŏ���#����p�����H��w;��lS���3�`D��4��k��9��k�����L/�[Xե�PSN:l�o�����>���ʅ�c4ǇsK�`���HT.�g�@�k��b�s�n^�������D���A�F�$i�߱�">b�❔��t�����R�ѳo�~طQ��}�v�DI�{C �����zdߚ���Y?�$،�sTg6H#3Ԟ��"fȽ��Y7#]�����~4��i�dԎ^��Yh�-�9h�T-�ڕƨ�ݽb&�=u�Z{��1+�GU������́�AwXX�����!��(w�����AwzM=�1Q}����3l#3�#�Xe���F�����F?�����.lZ����6p?��J[/�N�r-��܁�8b��'�AJ��H���#��D�����΁��w���$b6��'�P_L}�u���HM��hs�t]q�uꦗ�`	Ժ�V_]o���;n���6���&�U��^�bs·{����#���*��M͸���a��m�9��m?+B��&tv���V����L���V�c�q,MT��1�q��~;�{�`�Iߛ]��a��jS��M+E�l�D��y�`jPE��1��%$�"	X��_�g��� 4�_�[Kmۗ���O����-D��_B9�\7A�EA%�o{�l�A25��qG��ua&�����Qh������ns:�ړR����	�M�0A�t���������ogy�͉SHMaf x���	}{��i��^�bʓ
��_&������^s���u�`�+�j絝�2\�!��~�[�^/ȣ�@DH�
��m�_�͖�e[�������i�H���ا6(���ir�b����z�`]��2��w��P�e�Xx���KV<���yմfل2�ٳ��w&9m���<C�Q� �������,���
���l^{M.�4��՞X|[�
�.�IS{RC�ѿA������5㽩\&��{,�(�i�*:ړP2V.N5���n�V����q6s���HP�Q�	��3���=���Ŵ+��r߱ �=J3�la���X�c��+���	RBF�7�;b�*�VS3|Jk��s�*�_|��X���]94��Yeo璵n���̶�}���SП�0 ��%���K=��0�U�ĜO�P%[[	��,b�m)@����/N3a
0��~��@'G O��x�{d��F��F�gߒu�0�A�c��p���{y0�w{�O6��
^{j. ~��`������e=�|tϤy8ϟ��,k�w$[ �L����^`D�>�
��gֆ"�+��+"���C���Q��z~\��g���ʿ�C3nT��ٛ9걤��Y ��
�s���k�����~t���g�m� ���![����"���@��C�>�?��B�F{K�=�S��9�U<\h�:7�?/�ɸ��E�]ށ������ڝ'3��g���P�9�'8��v�ޅ�!��­�T�}�4u;&���E�)��Z9Qj��?�\7���j������`������eQVm�������G}K�Q#�酦lcc�����+iJ�:��/m~̌a�a?���9�m��>j���8L�9�Gj�֎=���a,槠�)���O�8��l/��䑉c��� �?���gD~x$Q/E8m�w��g]�!*�rw݀��Zț�^��b
&�;��[('u������L,�h*�aխ9K��ct}xEa!��@���*ꃒ������7�ԙ��~���Q!7��Ki�^<GUρfWW˺��'AB͟�W��'+�qx����u_>h�'E�T��PqF[q2�%	ę�:ǵ�H$���x��a��i������8e�	n�'^��r�:tV�6м)t�chQ�AO�^�J�܄:��")%���?�)��S'�T�ue���H�ȏ5|5�/�i�é�w���oþ�U.�~����AwWwNL/.�����/���Q9p���Ѻ+��_;���Ҟ�t>%��g���Qelo�#� &oR�a��\�T�:\��9���@�8U�$�@V��(I{��5뗀�����+�XD�Bf�}b�q��ρ��`�Gve� +WH�Ϳ'I��2��xN����I�p�v�q��� �2�W���_-�E��ds�h1���ȪrMV�տ��+�R�ZT���v�T%�?��Q0���6N�
��hL��ܮ!LV��SXb��\^�'�O��B곿���!z�] �燫�yJ�� P���~����|pE�^,�ax��bV�v߬��E/��;0z1-�k�~pn��`ų��h$���-��=*Q�7��H��H1ʄ��������SG��
����:��m��i�P�%�����Ϣ�����:�2o|8l���,��U*�N����/�r�:o���[~<,�n5.;c��q�\�퀏0�0�"�v���vV�6'����{���i�As	�KZB��8�M@�Jl<I��S�Q�c��:Q�����]��PZ��P���P��4�ڣ�|�+ġH�o�%����tq���k�[��i6��N�)�Gq�~R&h�����ݛ�7_�<�`f`Ր".}Xx����'�Bg�P��I�U����$t�����.*cb�����$���G��as4L|�h�:�M�mf�T��$���q��\�A��̓ s���r ǫ��s#�@������qn4/�{9����f�|��t�n��'�R�	ܶ�������%GT"`N�B�k�#�?���eS,�cd��7y*f~�>,X�9bT�ӵ�T5H�e5��� �b�;��5�n�:Y��)������CL����kpEyw�����u?���4^O��W1�V��8U"31p�v1�����7߬�O�~�'�3HO ����Mo�h�%���"JpG�߯m�����E��\�D�;�
+���&-�h3~[���Y�=����̗=up�N}6�%�*>���Y����	xJ���Qm��x�7����Q�C�*ӱ�~�^���d�f����O��p��$)�ը���F�{��YM��o��Sp���Υ��X���o����������̂��R��a
\IQ%Ak�D�Fs�4�*�s��=j�N�{�Fb/1F���2l�痵L��rpo��2Qg�{��ڀB����ja9����m�՜��@4��ǉ�����˩��7���2k�id�Ĩ��{:��b��0<��G����,<��34��iۻ;qx��4eO&�Xf����0��B� ��c� �ҰK%��������Xa�����_����2A&W�!t�!��W�{4��b�^���������>�U�+����RL9����PIyH~�c{��,�e�ߛn��������e⯾�b	lpj�|��N4-��8�"&c]��9������
מ����l�O��}�r��Z��#���@�Gn��&�	����T��݄�z�bD�_IӋ��:���/?HX��+�߉Fj�D�0\Cz*����'|���ֹ%�(�����D��[�jϑ#URk�@$5�4ȗD���	���xAoZ�Ļhq��N�E���#��{�������0Ƈ���/Q����v���fezw믈�B�����L-V��P��G��o�5���ѓEe���Q���[d���k,
�r٭��b3��"1�&�}�ZӶr�L��>�d�骩W.���D���nԢI�a�T+X��#��N4�m7��<�K�e��T���j��    �9��`����α�$��Z��]�J&-B]�ېޛH��p�o��c�>�1�@�?ꕃm���閑������!r��>�e)5�t��������3�yo�}I2tǡb�V.�V�a�ٛ�)�*��\�=!u?��B�:��]�*7�4�,��"+u�����@��_��L�c������^���Q!u���mϛ�$/�Z�b�e=�vZ;v%v+%���),R�������z�x�4��^�<�	RruPp
S/2֔�#V���su��u%=+��f��+������=r �	K �CTSr��'�p`\jD����Y�1��om
���f<P3
��!�mA�j��=��eu7/���+Mw����@<CD_y�0��-nv����w'3����h�-iՓ�Bl�0w�MK���YsV07�kY ^����H�]-�iL���`�n�m��}����-ShK�K}�P�]%�@�$��c_�o������y����|4�޼ƴ^�\@��0��h��S-�ߌ�PMJ� H�I���K�'�����--07�n���X� �唤�TɠDfM��jH������%��ɟ���Ph.�-��������߀�~g��������#	�-�0���@���ƏO*Ԛ�4n7��4���F��A��L��ݑ>��_q>ӻ1(��������6lw��bA�㵭L��Q:
��V���ObE�]Mp+�"�Ga#�S:�2�D|��[�;t$���  �v�W%]7���;K�ƿ���/X]?w��ZF���H�m��GtM%� B��GY;j#�Z�eF��`���}���4�/��z�R�U����07�y�7X���	ɒ~����(��23K���֊��ͣ�2�������(,8�c���go���z�xJ"#9m�c��1P~��P�'l��Q�D�3L���~K��,�Gմ\�K�0e�l�7h�:Cǘ/���Ne���bV��<�HD*]'d�BB���T�Z9�N�<+�τ���G�P�����8�YJ2DJ����#�<�$Ձ z�Z�,��{vx�0�����LDGWwL���|��KM��V�^���mޓW!6�~�~j�p�8�{�%W�Kp]7�]��]]K��X^<~�P����kS�.�`���|���]��C����t7D�I�*��OOt���U���
JաUө<��+���@��G����͓��f��fP�7�w������&cE�Nђ*#!
����z}�j7�a��~��:2��c�Ҟ����j&P6�V���r��Y��,S<��9�n�`i=,�Vb��ƣ�`�=c'.����O�g}Jփ���OAx��mY�H��4;��y��)Y���N�$�E���N��̤
�%���\*���t�-��o�5���c��]�F��O�Xo��\����yj�K���G�:t�}�PX�Uɩw:�zys�o�b������~��!�5��u�{�~GRBGbpҕW8U4P )�&��&�|����A$t<z�Z3ge�rg^.5Sعkvkea3��7ϼ.V�>ytz���IFS����K#*�6�,�/x�L(�ץ8�۟���QH}y@+���ww:BW�����m,��=�N`�vVh��#\�@l�Ȭ���<{e�� ��m"��_]��/�+�0�n�����
��\��_�2���q%��&tf cEt^�;��0S�1�R�!�d+gc�����^]G@Ν�f�2�͛��J��x�0e�C�.�bl�;���wD�N�ɒB�%���,˰1є��鿣��v��xH����;QG���é���QZP�#C�3�u���\�� D��g@��6�5��r��0be�t���/C/��X���GKp� #ǎ���z���-E�<�����qkP�Qz�ߑ��B�=�f�^��nU�u�@ev��O�p�W='�LFy�|�1ih���\\�ʏ	��	?gD]'�n[o��P��З�Y�
�u�K+��� �2}f��/�h��hMAI����/ESP8���/��/Z��g2�c�q�%lu�'�U��Q�qT�ꌢє̹�iY���C�����A:��.V	y<3jmϩ��"J�N��v8���?~����5�煥�h�g#@?��䏰t;��e�-bk���B��U��xLص!��^�y	N�G�X<��ۍ�F��g��|��ooW��H�F�N����V���O%D[e�--���KwX��͵I%o+�����Evo��gՐՎ��=d�,OG]�	>ξ�ē��)���J���������c�U1(d��C��7G�b��	J��>lS�d��i�lHzQ)���b����]h��ֺm:q���;՛�>�X�=5�f�����'���4�B�Y��N���`��ـ�_��b���O���2���N��X��E��,��,n�4\�؇���IΩ#a����ډW�o`�;[���������n��a��_�����ώ���p�[%�e�l�x�=�	�Jއ%f7圫�b����k�x�S�\)�e�T��������О��J| ���d�"�e������}�("
���׌#}�wu����5�M�]Rr�E���Ն��{r��o��x��t��f�y�����D^�U?ŷo��l��t'6-E9��p��eLS%���AZ�/'�+Ir�J�^'I�<��sQ��'T�L���cftn#�m���J��w��^:|y�C�ˋEfj�ٺ���:�.	��űt;)�~mM�m����q�$ѭM͙d�UNE-�A�u�y�d�SR��׷A�1�
�D��Sπ�G�y�</�e
E� ��i�%,7�O�zYR`�t���=]�l�7�g���0+䫬�*�ê'|* D�ׇ/���}M����cv�����f|�l�����7/��o�K��9�M�Px�5~*�a�1!�p��|�WK\����P������(�c��o�Cn3���۸Sj���%���Ê�EB��r�cBq��j'�ݢS�Ȧǆ~ǩ+2%�[/{�&A�e!����`!^*G��5��Wp>�O�(�;�|��dޅE#��ʔ u��&,,Ȣ%J6Y^�2t���8i�z�A]���=��Ɛ+F�@$E��l��e�(����J�fU����0��A`~,��l�]z��0���F�eOД��D&{���7@�ł��6Ғ�;�0���m��B�������?��'���n�ߵ�^V�U0`lT�g����Uv�st�z�w�3d'����C?ַZq@PQĦho��~|Z!15�y|&JE�;8#��ʒ^a�����/YʗE�aS��@�,7�R��A��p���Qlv�(7�9��s��ﱉ�2��x@�R/�T[��n3z:}����5��,&���P��WF�	��J�F'oaϲ]��]��>gY�����Do�q�T	8��XF{2��\�I�j%�"4���A��D�{�77ΐ3�yG������O;��$C �*�V�7z������%`��GP<�}c�Ѯ9�Wh��q;����钤�>���@�����l�<�jUG�.��W���>�=�p��ʃ���J�'	����s�s���S���V_}ږ4v�g�}<x疧�pG�'����.�[��麴$�M��F��G$��F�	He�j(�	���i�ڞW���U/:�� ����_��t d��&+�(�@�D�HD��t��8�n/x�����W�1���OՑs�@E|��tӆ���q#_�f]�O�.����@N���$,f��y�1M����їk��;�#�����׭�K���"b�T|�|>��c��=Ht�U��U�5�C�O�ӓ���x;M�yU���5:qՁ{A+�r9o.ߕ0�_������L`��f%�>�	�%���X����vo�mvR�c��X���T>�?�:����_�M��/M��x�J@�_����l���v�������u�,;�.��T�,����L5&�=�"�mN�s�5�g��@K��<Eᦍ���/Û��
�ƉJ[�FM�Z    �.����嶘�
9���}�e�t�2}~� �d=>�Ԅyf��9��b�*)�K8J����s�N�+S�F���a,; KLh�.�췪����� ��*@Zh����g��M�L�3�/5laK���ۢ^z���}���H����xc[|�7�f0�y��'��̓$7I�.;�p�����8��1	>�i�y�ͥ}�4�%l�R
����u��^��7w�y�b�����:.?*�=]������[[�Y�xi����PL�4y;�
�^~Q��ܥ���\��w����Lx��eF�7�Od�o��,Ot�4�Ф'��6n���G�~��f���^|��d������FԄ%�׹j<�2'��I���;p�x���q���wG��p�,��E����O�ٱÖ��;�e������.-GW��S�|��O@����vs��X��7O�Q+Oǁ}-V����Q5�.ݺ��(��v���k��\��l�
����3����3^�/����7�v��c�����O.~64i��n�������S7�(]=�%oU��7�����ؕT��)���C�j����� �^���ç�w��`��mWmŤ����K���q�g�4�P�u Ws�<������f?m-�?�8C�v��ts'8�;���ѥP�^��z^�r>�$�7+YA3t���(�x�H)����K|���xx�*��\��J�P3s�Ռ�Ҵ��M�9��β�߭ϣV]���m��.I�� X��	�3^ �����[�E��d���M/��1�����L:����̤�a�r��;q��V)ۚ#Z�����.(�l\�8�:�_kj\akc�&�.�����Ă&�ꨕ�= ޷U��n���eօ��Y�54<�5㻺����N`�^2�wW�L�Uڀ�M�M�pz��@'cj�-���#����W뫽�e���fP{�`�=��G����l��~��j�k\�#n�+�'�qf�q���s���σ�.#�q�8��N�s��o���r�?�
�nHK9�p��nV!=�x�<$]�F��ѿ	[�6P����_"��H!�I� ��"s]�a�2�jR#%x�����~6��3ɗ�,�(�k�E�}�����J�y;�wg�v�4�+;��"I�����=��*�/D�_}(�Pw���t���Jf�S�"9�L���I���|&"��m�rF�	ݿZ���I_�+���NX��7�C�	���vH/��%��l� ��,�{}]>�FNQߘb���_�k|!��!�}�R���@̪/W:�Iо~	H�,��rz����
������_$�������L���.��^Z�� v�Ps�H	�w��'�"�?��G�V��H�Ч���x��!z��S�����ǀC�L�$�g4nhh7��C�}�)+���KYbӜgv���S�c�g����JB��f�S"q�P7y��֠��g�Q(k5�'���DR��~�Yo�3%�Xܝ���/�=EK�9 ��:��%���rU%(1�Ggu� %���W����C`�A��\H>.d�"+-Q�y�
���Pc; 2h���G�v2�3J���;�I4�B��Z��3!�r��f�ʚ4�Ǹ���`�0~W��߆�0�b�m��Of׆?sS/,7ue�R�-sH+t�$O@���\O4k���s�}<#���o�8K=�-y�#�;�f�)�� ���?-%r�C�a޵�ўZ��� �(Lz�#�߲�E��×��.q˜X�gI���%��E }��z��;�z(�"��֛E*�eA,��l}�{�+'|��3GVVx�D�C���]��d)�=,;)�"K�u:�K��PC��Q(E���<����~H����i�Z��6��ѐh}��@�O������^�Wy��İ�.�˓���)��!ds�,eߠ�#�;�)���z�2��׆�d��ˡvА�9I��Ū���=?P�Z�q��
��w,���ӘM/�^@�a!�H��A5<���K�˃�V}�����̻��X��B����ު:s��������o��������tt:Ǭ���IyA��o�_��&%rVh���1�"Q4&�C8q��F�Nz����$���|���h~8ݜ��x�vh�%iҿ�I
�M�}���g������zIDB��hʀx��j���X����nY�ul\���������W�5,	_k w2M����Z@��}�ⸯ��=ăe��}�g�`��	s�����r�jZF2�mh-�@��2�n�:���M�ُ�<�f�k�b���N���pG�4�6:����$>
/.z���x��ߓ��Bd�	�H@�ӟ��)�׬��9�D�È?8�x5I:agس:f�߈:�=����s6�^6̊��
�}}�3��
9�¥�`�R˹��(\w�:�Ѕ����׌71kO�F���������O��^5�X����5+�q(��ܶe]Wy���`�ĵD����&���k2�*Q>�>s@����TT�>�oO?|5w��f9Q*qD�c��ñ��G�[����\��P�Kɗaᗨ}m�%��`��f�5���6��0�w���������bѼ������'�R�w?��u>�.o�\��A���ʽr�M��g�W,�j��pu��$Ɏ��1 �<���A�*N��U���)@ hH�l��uL��s��B@6.`/{�;�mCC����r
;/;k�8��=��i�N�_F�ū�3�����?�0�CY���
8�OYu��(L��0x�)g�h%ô��szU�1���)lֆ+�!�VY4�Ȼ�A5�(�eI�p�Q�k5C_��3���1��s  ���=Z}ju�O�������/��t�D�ӡ����~�7 dg��4���}Y��
�wV����_>��FVj��/:+O��� �@�f�?���vQ����*]<o�&e֫��wÌ�foW�T�f,��yK;u����RRr��!���Lߎ��Ԃ��j���e��C�Zq{xp���sc�l���݉�C^)�܀?�|^9P0۱�&�
�ۿ��
��N���'Ë�2�����;�,o��� ��d����}��BA{�~KRnȕ�OÄ��S�J���骞�z�cL�"�cp�	G@�Թ]PW�:t��5����������Ͼي;/��@��$�����g�>��{ 8����/vގ#�KQ��eS��>�E)�"o�6�^�v髙Xg�����,�>����۠Z�h����U�Mj(IML�5-�O����!�ȑ7�F9�F3��a���.�m����!��K�ia��@82��h���~D�e \�B��|� d(��$(���_�K`F �s@���k�� �+4m�F9�75g���	��:x�Z��Qt�Ƣ=��_m#���*��A�ltni^�����`R��|p��㙷��[~ܢ�� ��5��7X҄��_��t���5�n��)D�L�~�*_FB�D�����
AE� I�(��d.�Ok�p�]7�;���,=u)n�����������Q���E��SNЕYq�{C�Af�l��Rw�E&Smz�E^�E��T̎}�t}u�zw�Tҭ�ټ=�#�>O�jzkoW���۸�ʠ89�����T�-��`�X�|�������	���
�ˍ�P�VF���uS7CY�3����Vm�--��5�p�5[�z(���tvP�v2^'.Խ�Ai�$5�ڑ�9o �s�02guFr��H����H��x	l"����^����2�32:�[��>:p俴NUP@��'���KM����y����C#�{��tC�l��_�'N�e*^V�U�u���y�\��L[澟U�ٲ��l87s�ɹ�#��dL�V
z�_�[�T͌��'��ױ�2���6�A���Z�~�Tlpq/�&��A�w��J�K+���`������7X�����x���緖Q\���Fܓ��!0 �"L�a��#�
4}��?'�٤�����I>ŗ�"��ɤ�~E3
w��ZE�0��o'    qp�HY0���P.C�SH�8�Aז79�Ru��"�F�=3�P���gv��=�9mƽ>�e���\i`EN�Ӧ��2���n%Q'�⮐��Ebk�e�����c2e>������K�pdw]ޜGC���"���C�aT]�v�_vd�4lbMU1����g�3��!�it�q)��-�.|L}B��6zB��Fc�=)�DZ��`�w��\�V%SA��Oj�J�]��0b�aTr���9ػ�W-�0~s�vqǯ`a`�R�շ
#�x�/� ��,ҶTHH��uc��6�bjP*���;I"bH�lƄ���㣩���V���iX�$1nh��"I=T�V���{l�j!^>�4ǆ�CR�,K�,��#���B�ra9� ��r�t7����h*s~
�h������/��P�=�>�^�U�D��6(jz�Q@�6�{��</`��C�Y��!�
��7A
�n3O���c���"�^
,{BEue��������3Q�~����!x��$�I��j32P����
@-ė���_�Fn���MW����JL��"
b��d�T�j���������th��I*��=ݝ�`rvz]<��TH���M{�)�jf� 7����O����W��÷<��b�T���@�C�.Ck��t*i�.��ck���N�M�=�8���v��Q/�� �Y��p�h>����F����٪;�@��v(~�2�����#B�T��^��B�~�����������������=��Z񣝛��SXω��r�
c [L})Uy������p������H��\���A��P���U�'zX�9�ڝ&��l�oL�J��~�������k�[����gk��c�����;��D?P�"pmmJ�%5D~|�5��_q$>���r��;���H9Y�Rb��IJj+񾥱�:�Y��Plp�K>QoJ���.!J7o�NB��� M�t9a��W�>em�fB���&�G[oƓ�{ ���IO�yZ"��&5f���
��AWSg��nd�.Fzkz<�w���h	$���.�I�,��%�1E=�־.Y�lǪzá�'��j �^1W�[Gط#��Mj�p�G!eܣ�Mh+�o�7�>NR��� 𷜶����+ �xRlŸ4�H����;ͱ0~ܙ+��&s�1����st3����<�w�x����Ֆ&�P�=+E�w�d$}	��������������A����E�?�m�������!a�x��}�H=
�q<���2��S��m�8��k��g�whY�,z�	�O����-���X������Z��v�a堞,�϶��� s]̠�"��'�s0�B"�bzV	\��?k��e�;��a@^QAq�'e�zJ������)qd��]�t��u��5�'�I�A�l�ۖģ)�G��7���ۿv�aP��=K�R�����Z>�2 ��M�<e}MX�1혥1��^��i!~�3�꫱��~�[�r~8Y{�Ш'bK�rg�V������l�)�a#�0�^�*�٧�Z�G�jG���w���׮ZV��4pB�9v�(Ty���9s��P����ʮ��c���у�n�gT`dQ�6����VJ^��ϴGS������0x�8M�I|0?�[�5oؐ,�foM�df^Azm������F����'6���g�&����dz�i&�3@��L��/���~�%݁U��_���n�#��ͺ�@��b�v��Wj���i\Ws�4N�J��:w��m:yޠ����
�2q��rYXJpt�ā�| ]��쭀����Zᎆ/�/`+J4���P� �\���[��违A�^��\�>�).~�S�!���3/Nk����[L �0'N�뺨��a��U�FR�e{,�UH����[��,�3<n�S�{���?|�]�o�&��=?�y@�����~�σ��ˇO����RL��rk}�����z?s�_8~/E���3ۍ��]������"��W5/!^1�'��P����q�t�<�a"��-���f�ݒ$>�����!��1y�=�����G�B
����Ђ����w�~R�����-��p�f�1�``�\����m��4q;��mX_j�Dx kqP�Oۻ�L���ele�s����Z�z�����Ȋ�Eݹ�J\{��~�/H����H>1	�@(ډۜ��'��Z1�������Z��_m}X�*��(,0�7��>�C�}_��+�G������ʄ� ���R�|�諼��68-k����f � Sx��K�<�m��b��D�b�b����]�q�n��KϾN/��f��a��� �]&�NK�۳�J�,��)`�:��HpBP2����k�"��yea��q��Í���Xε�	SՐ�]�Q�p�=�҄��Eҏ�Ҭ r4˸l���HMC�PC��z�Ҋ�*�;���c�c�����b�8�D:�]^U��������2>L�ُ��o!
�u^P���6�HH�ĸ̫h5*�����!ׯ�"����E�k��K1���ۄ���!���k&e\_�1���ȯg�m�H}�0v,��n�ҭRq5�V�K��Ɏ����o��P��4_(��1��	�s�IyaS��̈�+ P�
���z��A؁��G������5<����~[rU��%\�$�u�M2�:a�~�#�u���7���$�#�RZЉ��7�&Ow�A7��P�4K�K�eԓ��)�C�'� ��I#��X��!��W'�=�+�n/�<.��4}��fW+u(	�UM�k���}Ƣ�vA��I3�_���=_���B���p��Ñ��Y5��@"J����ԏ�O��վ��h��V��c]�˭t-?ȗR��[d���W�&0[{���1�G<�N�7_Զ|��i��d�.�_�Rۼ9H�_pA~snj�%�G�kM��>/~���Ѕm�[�ɴ���\Gx��ݘ��b,^�m�(G����#��UG	c[l��]z�%K�Y$"�?=�,}˰�7bjG�����U�ZK.Y�{�״�]�G�w���^p^$�o�WV��3�>��� o���Y�A�N��w��T���e�}X��b�=��|�>�g �ܨ8t豚�c����uK��0��^0��Sí;X��?�TipT�D��VG�M4n��7v�ro�l����d�:Tܿi��g�T[Jǽ�9��;�^�������;� S:^�K�:�qw� �&T��\#���.��)*wp��̹���t �rǖ|�I��O	��%/G��uJ�3n���#����/n0AR[�PW_&�v�����l����[~��9|�	��d��b��4 �詴U�Y��g9�����Oq3v����k$}+!ZT}��(�(��U�G�kۣ� ��P����ET��:W�\5��Q@ne���$B̼�/g��(��!�!#>Ow�&I����tI�k�OS��~~j��d�d�&^�.��R�A���I�dSI E\A�G/�Ȧ9a4鈗�64h��7��ǭONjE:@��kgi8W�Ͻ�uv �6;��!1�s�Vx42�y����ީ'��B�X}�=�5$%��ߓ
D.��$�U��;I0�����E�i���2c�f	���'M(�Ŭ���eY�A�-�k����`1�>o�߮f��I�Ju���F��#h�U8��ŭ^Q����u�K��bH.��lj�'�+�4�5����r#>7jrL�B�Q�d�ˋ_���oa��ۚ��tJ������Q���t�z�PM�A��:%����	|�ӳ�}���[��"b�xA�`����=0m�jN
�d�T\�'}*��862�В�����1�bkt�n�vZڔ����r�o�f���Y���'�Y����`��Л���Kl(�n*ּ=ؖS˧D�8ԢRh<x�9N�G����ط;$�����k���Պ8�a�չ_34K���(��	��X��Ω}R�ËA��qO��2[��	�O7<^��rEvuz^�1d"����J��
�&}��.TQt
K����n�v���Y�,�qwӋ¹��
�S�[� pW    ��Ԭ���x¦�SDF��Y}^�n8z�,(�+�*u�YL�@�����i� ��V�9>�U��Umz�C!Ϫ'm�T���r��fJ��W��7��Gn�Kc���i	{*C��>��0��lSC�&v����'6_�5)���Cv_�Oy������	)��v�\�n����⸶���'��3��튵'~���+:]�N>&�x^�{>k���P"6Wwz��R�΍��2�u����'����%�a���g��y��;�ٽ�)���Vc	�Yh=����_4��7|�6̥�=]N��o�����ڷ����=R���5��6� 7�Neb�?���8;�NϽy~�I��	�&�O3r9���G�r�ׁ�$�q T4�]6�2q�����vʛ �޴��%�񼫇�G��9�|���GX&�ؙU��m�&Q݃'*t�o�+s��H4�m�F���!�� P�����
ā�he:�H�(�efa��xx20ft�RWG'��o�pRR�v�t�f~���cV��"޹��s��-p�}uz�d�7�9%���os<Gv�۠'�.P��P�,}f�;�R����A+��_�4m��HE�� �ް�E�'��u�U���+���u/�ys@�Ԗ��O9<���b[k�F�u�A;[���@��ݦ����S�^��h!=���I�b8_���z7T�����f����l<*GJAi|5��j�}�]xa9v8�L�(��G)���+���U����eh����*D (�r�Z� XԚ��9��Y�ŧ�ļ�+�<͘�Ίd��c��6�;�J����v����/����_�u30׿�c�~*�ѬS�{p )�����X
GJ�k@�D�E.�O�����Զ���=���{(�A�~:�cIfyK��3�/꣥%fWV�\���C�W{��i��QTC�:hI��h��Ձ�nE��ӆ���[�B>���\��r���i7K;ߺY��;�(��Tގ�Az�!}�	�٢��^�S�'��ʕ�C�繮�Y�"x��9л����+�e�g��~0�8�D}!�w�!�c��(�c8���>!"p���z�˕vzѠ��Nصb`��s�!x3���F3 ˜W�hf���C�+G�������5s|�v�.I0�s7%���� �f����E�OnonԜ�O�+ҫ�肇��9�Y?�GN��|��f�k�����;2�-~��@0�����;:WO�����o	H�zt?(���Z�g��d�K��r1 ����Vp���ޜ���e�o��:��oC�V5�����	��%�ä1���� ����a"��H|(َ���Bޢ,�Cw�0�~��J�Έ?f*�Π{�:��=����[B���	��$pPk�c�Z��`���EW\R���	/�jQa�($[=�H���o�*������tz�p�M߄���~1-�~N��*a���}����H6t�k<��3ѭGu7��~�0  ��}5�����ƨ�ʡmyZ��w�����ޒ�,���ŝN I�r����K92/�����P/P��')�"����y�!�+{�Grg���X�$�pnh0����7�F�M5�7j�4�	�';*��OI�~GpJ���zʵ j�/[��x��3��(��3��o�|[c���E�T-���w8�ٳ���� /�쾽zg�<Ȅ���>v։#�.=x���U��~k�����0�Ʀ�i@�y�P�g��⧆�����j5[����»����B����s�Ї�@'��>��]rd/�$sze����ĝE���D���3�z"��5������U�V�e�Ɉ�i��M��~Q�����]'gY�  ���X�-ӫ�j���o\c��tu'Iy�x�F�#�����g^H�"�)�ͱU�Z� �t5�]X� Tف�7㾏7�,M,���Z��2�B��+mː˺��Z~��7�o���V^�#�~�\�i�P��%�X�R�-B��T�Nϝ��%k�{�U����u�T���N)1�w[Eo z&$^�y��x���=Y����(=�-�_�o����D}��f{�¼w}N�AR�q�d-�Wx���h�k��<k&(gg� ����&q��uP�%�����%�}�¯��W�A4��c��=<���u2F���ܫ.�<��5�9�^;	�8���q��Dh�7������*m�)��"��G$M�Wд,' e��DK}�����'�5
Cl\����V�[w�=u�4����J��������E����SEI?�w���̺G]�OߖM�涨28���;vZ��>�a$�w�mH2;����'����j�ŏͰx~��������a"yn��|��g�֭a�.�
��=�=�[t��p@���i֝�h{e�e���tV{E��g���Wm��3`쌺�:�>�7޺#����x���W.bflA��χ�������0�s����1�m�L�Z�IzǼo�sg�����\�b5ÓM��w,:����^�G͌�����\"������c�	���q�4�݆���>U{��Ob����H�o.`܅��Fa4�`uO���S ��W�������rw�D�����3�U�"P>�bT-����2�v�-�����着6���:0Aݐ���q��?��/��=m��|'&,{^��x�����8ax��*74J?&�!�Y����a^(�I����e�\�p��'����?*A�j�O�Uڔ�۠�M�&!׀b���:hQ)R/ԟ&�}������vq?NO�S1����&�?�uV0zs�tf?�E��k������� ��k�� Λ���z���TDf��t���y����nJS6+�_a_M��G���-n<M,Y%;TOg�������+�sp �������L��;P|%,��[^h�hcD-�DFK���C+4ﯻPA��9T(�M�4!�.p��c�f3!vg��uˤ)����ק~EZ�N�%��J B�t������I3�P��y��n�������q�(J�zT Jf�f]]�m7�*�CS�G��O���J�ݴU���Z[��Bh(։*u�-�5����䈂�nZ˗��I�x��\?�J�=%���� QP�����c���mpi(�.R��{�������]2����q��
fw�61����%�_&A�(���Sx rT~_kƂy/�_���v;B�������χ�c2����x.�O�-2?��3��4;%`�WX��Gpܓ��/�C�����S�&�OQ�@�5�l�~w��l�dع����Q�T�ES�.G������Wo�!Ȥ�HK�����r��EBB��h��r(���,w�waq�&�\`�苛$�n�A��G�L�#�̿���X4	�H��~(ޘ�4���=R>�v�ѮVz#?l#�z{T�{�p��_�aA��T��G�š�N��Lk�D�N��ŀ�~{�� ��%�\���x��Y�0�d��b�:�$ꈒ�9�.���c�Tt7��S�$�b��s����q�y�(��p-8|M��?"����o
����tf�j\��#���+���+����ܚN�c{�=�1��F0���K{���ӊ��B_Nⷨ ��ֿia�,5�4x��.���Q�k	��G�^KFl0�q�M%��+����^lǆ���4k�:�2Z���{8����`��L��r��p�6��5ZF�c�ܶ����r�4H	g����4�;�gM�@
�+s�������U�gj�s�g��a�J�/�7]M�P7�_#���D�Z�&N��.xl/�?䞪F�^-���'<T��oxi���Y1���|E�U��j�՜'%�@֢��p��>��ub�]��HO+�o�dA~�]���\������Fץ�rJo�=^vc�-�pi�G�k�F*B���%ޕ&]��/h�p爳��H±���@z'�h�4e�)�՗��\�2���l\+Q;Ѡ��	��"y�)ö�+�NhCt����F���q��'��3    
�<`����g%L"ɕ\���H "UӢ)��KCS�3�M��m�+��z!G��� \��]:��܇��m�Q�������o�Y���� ����;����q��9_H�9�Bq����f_�{2�ޒ�{ߒ,�NȄ����/7�^�v�cx��M���9�\���C���h7��L�\����p�(n����_7U��2��\��ov�lh�d���o�O&[�Ҍ�������n�R6f@���Ymd�͞.�S|����#���N)�	���P����@)HQ>ߏTr�r
�0���� ��5q��ɗ��&5�ؕF��5̕������ �|rٝ'h�7�d��W��#˅�N���'�]D-�
H�����̗���|M��	�)T�����
Q_��5M�T��T�/(ӚW��`�,���M�m�(6�n"2aD!?��]���gyvUc�}4�	���h�,�w� .9��v�U��E��L��m
���� ϝ���ߺ�K��@m�E[�<p���
��k���x�hU���+���gJ�ʍ���R�v��aKѐb	�!	_Nb�Z���x�"fb�o? �b2��+�!Jc�t6�Z�uf&�W�1��Ƀ�� �*'���)����u��R�}q�K��Θ��a�i�����Q3_��z�{�S3T����\�����.�LWQ{#�{��J�ri��y�4�笻B��a��T���o�R�<�-�tN؝!��|dQ��2�߸bl�����+�2*��^�D�7$�x/�c�|��s�ў��h���n�t���*�T�-H@AR��c�R"!�4n����X���p�|�0�
��1�֩�|�V�a��4.�� ��,�,�d��Fէ6�#����07�@_����w��ԼO�v�]���Y�,ҽ6X��չ�_@_�S���hU弱�Y����N�!RR�� �U^��<C��Z� HV+��5�	k� ���{�AA�`=5{�kn�@aͰ���7�Đ[��b��K�H>�w���M����4��X��j���	���.��8!bDs�W��z��4Ll�7P������o��cd�/�뗨gA��:�z'��<���~�d"'��'_N >����R��U�;�r~�*aΰQ,R+���i��i�;�=�RL�ȯ��y�����g�ݕ���!�nM󫇿�sY(��W��K�qy�L����qȸ��Z�0�7)+9Bp��t����lo�#�;+4�t$�l�ւ{�ejMZ<�mP�UH��=���!�s:���Q�Ȧ��jR�7���N9{ST�,50�@%p�7���'ɞ�]�P9��ud�O���?�J���z�WR���2/�e�n��r��i �r��Hnz��>ܵ??ˢb"*��U��ʴ���
����K
��b6����ڎ����-Y.'L�P���
_c���(JY��󤞐�+�<\�6�K_���(V��[����h��˴V��84P�*B����+͛�m״�NT�v]¡�ס�:'o�ww�c�[� =� +������	mȹ���ʗ�e5�/�\b�A�D6��(]�z��;�(A��p�/)��3����eJ=�22�o6k�6�K��qXQ�2::�����%��ѝf�.�o��m�?�#R�*��*s�C����k��!Û_�7�P.F��{g?R�C���ml	����6J�!븎�K�z& *nމo��"���I)�h�{D~�0� �0<��hP�7܋�일a3��\l�
��v]���?�oo�.��.o��(�@��� ��@� ��)���?��DV�x_Mn����ҔV˴�&�+ˢF'��YCw�m��ht2.{��s23{�#��`_�|19�tD��i��C�_:�c�n�0�$Q|*�F���Z1���iB����5A�����K��bX�8K��.w��29������eQ��kd���kt�5�;��T�6v��;Y�k;YI���֠��I�1 'YP���4I�\�o�0��}^h�,Qa�>���� p��;���2y��L>UϚ��u^�}U�ag�b���e�f�g`��ҷ���aխxK�L[$O���I)��0�/8=�72f�>�2��g�)�mO�Vy	
��#��ÃQu���e0�[��M�h��SP.��R]�f)yP� U��S]��E����mOs=�x���@w��k}E>7&�g�a�Y�1��'��ˀ�o@�+i���Pg����O? ��T��]��v\�K���r��[���ڣ%6�R��#�\ �ZN���0d>�D'�GUW"5`��F�Q��M�Dz�ƚ�	`rA{�-���|�";�NR/N�h���+��<�==Ĺ'��'���q} ��p�\C��m����3�V9�M��O�^��-�3ZsXn+[B�E����Ƕz��y=����Td����_J��Sw���]topxM���v�h{y���XT�#R=���=���DZ�	� �W��f.�kJ���b&�Jf �pYL�k���Քp؟�mU>�e!xá�^��&̥\t�-�pQ�ݥ����mQ�\ߏ[�c���?�W���P���؏��iod�E��zIiсP�+�V[�;�d��鬘.LU�N���ﬠ8�q]	񟽇�7�b���f�C���6,g�I�}�����Xr��0�̼>�ֆ�D�3��}e^d�����c��8+�����_/�(	6�I�%��?AE��!��F�#<�Œ�#�I�������@_.��xP�[�Wy���r���̦�;���}r>R�l�H��ĵ~]�֊`�i���زk��3�AOl���> �����x�� N6�}?�:q|��P�ѿ�;
2��(��q������v���0^Ȏ�@�K�2�8az�g[���qh7K	5��	v�<n}��/�
ud긖�7��6���)O�.t@-`�ߔ�*O�r�*c5�h�Df��D�	V$�(�MA�}0�����H&�p?Q����K��
���c��t��~G-/ε-�*�.B�����*�>��e��`��9ɦ�C�y�x��iÊv���gP�Y�l}P�vg3;��H�%��^��~8u�b�6���g�r����wP�F��)��Ƭ���G@�⎟�m�`�x5�\ �1Џ����7�� �z������q���{`��^�;��x�쒏���0���S۞���`�~?.�"�̀F���=���A��&���W	�u�9U�j���p��=soh�PqӴ�O�e���X7ҋV���x@O��ɦ�����6W��2�m*�+h�NL��]��@���Uhhg[��΃o;������6�|��6&'H���!u�����!��H�w��MV��??�`d7�Է�r?E�@I�5B������CF©uU� ���������a�cD]p-u�sF��GF�<��+�k{w�sm��t��~����~���!t���+����~+>��D���Aq>�d���C���}�3'�l2�)9�f�����Lb������/�B�6��:k5j��� keP�p�U���ƿ��,���2�����'�p�#��Rl[2�S�
�K�I	������,�A�u��)��E#��L9N��^����K�G��'E�3��]��Vf�c���wu��U��`����kTٖ��\:�#�@t|�yga���}?��_k�b�T������H�=f�^`�p�yF|��lu��Qg���[8��E�*P����˜�|TN��Hf��phX8��9�;�-y6oI�w4g��3Q0V����Xړw(�m�����m(��_���]�� `����0"��e�K֏��MD�ߓj�@�"A���F#������BǖN�+S�h^�3��"�a�/{�W�qb�W��4onR�A.�[%mP꿍���BCV��3[� �ߒ~l/��Z�7��\�2�dF�ߗ�k8H�Kv���(SxM ��������"�)���ֳ��p���EM"[��&%�Պ�Xۺdl��4�9W������E�S�[�5����4&�ϸu���}�{    =�9�C�|l8CB���Jv�k�mMwt�tb#�f,�������ғ�hɷ�Q���o�4��. ��J�0h�B�BHs�8n�TE��S���vZX�����b��ݨ_?�A�D�Q�f���K�� ��	wѓ����Xd���C���<o�09�>wq��^��쪇���t�3o
�P�x�Rsi�e�~�
:�1L�����a(�O[Tx�1'��R���w�W�`r}��������w���
���O�
0�h_p��ԣ��ݝ�s��fxZU��|���(�����+eR	.�
��!��}�;�8�� MT����/&� T� �)R��_�H��VI�����"��Y�Z����	�������dM�4�|�)�;P駊[�s�3_]���0&�zKx���T+�3��
�k����;��v6�Ĩ�ԁ?n������P���xCK��B��x��C-A���Afb��p�4A'�~n���g�W?�LF�/�2�ڝkI���XA�Y;��ٰ��Xn_O:�h�{�`����)�*�� z��Ma
��Ď��z2E�GK�jyM���?���svP������P�����CU�^���d.M�s=�F_�����uѴ֭���y�����rS +i�෍_l��Z��W_����v#��=�u�i���6��������i�ݣ�
Y� �v-�č�]��A���fG�@D^?ޠ�V|u��&���v��q������h̸����յ��4��Sgc�wt^, ���^�AS�����+�G!e���cB�mY;n�K��=����W��l'�ٜ��n�M���<�ڝm��݅�1�K8��lV�2a�$�Ӈ̣���f+wY�H`����Y���Z3�K����,;��%^dR���&8�, 'd5\UA�o%����Ȼ�~�b2 �o:���͆ias����9����K/J�j}?�mc��'�fVq]bpe�%_�a�ru��Æ���L=;RC�v4�'6g�c3X>b֙/_J�*I�51a��X2g��`���7:^�6�މ�<$�ޣa2T�W}�h�7f:��ê> a�]���FQ�<�Y\tSn�F]oM�$ �R������`�����8F��h%k� 3!DAC�@�_��^��֡O���x}\ (&��Ý������h��+�x��jVvQ;w�V�<F吰A#k� �ҍ�vIc�+��2;�|�:�������6�a,�*���U��^�v�v�[��~��.6Z$�'|D�AI.�{��vO�3(�*��tn������V����4='C��Q����W�=hw$0\��Z�CU�'�p���K�7I���g�;ͼB�0g##L�/��^Yǉ�䬿�}��i��/�o��z�m�e�!j��#��GEۺ�%i�j��j~r�)���Vjۺ��W�$M��%�%��7�at�_�M�vbf���U�����I�*(��n�����H��q�o�#�����!r-��7��S�lnp)q��`.ANt9������©����n���GC����KO����.(�V�$�q��Qpi���Ze�y[yB+-<�u�����MI'������;RySW
�_�QIв�>��	<{��%�c�p��`�Q.D�����	"�Vk��1�
����Wxqy�f�8�7��
a�=!Pu��Y�r���]�KP��{{eHא��s�=TU���������	춧ż/�[��|[��$�O�Zl���B^rȒ�Br-̗��K������˅��	�T]!�2����5
���%s%����~c-���V��u����ݦ�,�Pdi�5R�_({1L|u�u]PԣU2�&�a��m&S*�n�
T@Z�iòi��5�n��'���Q�o��\��L6�^+���Ukd@"_U�r�^���t^�#Uʒ� ��|)��F�f�˭��ZpaQ*��ʡz?��ڲ�]Wg�\<���D�I�)�:Ɲ��jl�u�T��&��20���I��n��}:�R[Л��KZ�̝gNׂ�B�EL/?����Qy���?�5����j.筇����+º�~�� ���������CR�	��sV����&�����C�q�������:;R�|���8@��,EW�ߜ>I�v��t��(>��@wRr���r��c�SR�9Z��/.|�#̅mk�x�Ak9x��=�*!o��?X���eH��'$i�@?<����o;�TDA����ib5�&@L�Cs-�0nF�*��TE�	�%w�^���w$o�������J/�Q��8��#x���"��1�s� ��։�^(e�t`*�KY��%��UA����'�#�N����B�K�+����W��/W��{T�Ib5���"U��H��1k5�1��T��`5���x��{7��r"�^b�U��ݠ&���&ۿO��𦅞Y���~�t���o�ڛ�0p;G������m�����G@ 4�}�:�vH�T=�D"����)��j�:�;� A'�>�^^F��qfr�j
�W�4�L�z��a=q)�����xħ��B�6eJ�EQTMm`1�	����$�~n5�ܬ+�����XY���h4wș��4�`�|�>N����d��} �*ۖ�G�6������f����>_�p	bCBt�92�tب��g���<�b�5��3ǡ&#Γ�t/��f,=��}�vkCr�w����Zlޘ�bv+L��Ny _Uro��XF���j��
���0-��$q�2��r�l�RɃ@`tfE�X��=��9J<p��§��Hy����3�O-�ӵ���uU8���V��ʦ��;w�F��V���`�
b����p���B��Do;�(s��3Q|SLd�4�4�P��,���_CL�,h�T��m�B��7H�=�+�!����A@��N'S8����h<پ5!"����[��t?��,���� kM������e�)�%�`Uv4�����$l�U�餋��<�u�_�u�Ǎ���c)�Bsܜ��5"�ޤ�Z�͙2ǯ��ҹ�\X��o'7>�vꄧi��U=�����ԤFI��7��$B����
h�Ӎ��Xsbz0R%���w���\�4�tz�G�?ʬ��z�������7���5�$K���ll�ΥP=�W2����x3��v!}�GV0��[k��~I�.��S��دT\_�+��Ʃ��s�|d��\֞�Y1�6�A���M�ƚ.ng�p.T~2X�}�Fn���OciR�2�����h����9�Ė��^��>V�"T�g�"�K��	���%�O�R�虶�R*Hc�Zپ�j�Qg��J8�^�𬈞a���C���ֽߢ{yD���A�b�z��+�{щQ�]J����1$��L�)���$s �j�N"�>Ͳ�I����n�+�7io�q^L�S��l�*�ཟ�B�\���L�wx?t�;�NPD����A�����Z�AB7{&�!w[A=�uT��+�Pb�����j�x�;�>Q�o����ׁ����b%�eQ�/^�Ôǟ�o����gvgf�x�	�i���a$��BZCn.f{�V�E�S[��FV0r��N��@��MJ�����?�~K׷q�kz2�Z��q�g�����Gũz��6����E�d�fir,v2�!γ���Y���k�Z^�����mԠȟ�8�)yT��U)K�e��'D�-��'*)�74��Y-�߂����u�W$��s�������Lr���[v�e	"���J�̌x���&�k�&¨՛Q-��;h���_�i���g��eB��d�>�.ͯ�3,
��j���t?QXg)� ���3�F0����b�5�%�h��2�|w�o��Ϗ�.t�9�,4?G(��}��r�wyd ��<H����~g�>9�AW���kH:s�������ʈ4��'
����y&`w
�H���z\��6���r��Zoh���s����N1Ƞ��g�IO;��~��lL,�Z@Y�ʶ��x%BԮ����˳f�x���4|{	���[�&�u�h�T��pn�"Z�8��<ׯ�>�l�N�9��f�    � 4���t���z�2��(���M;�h���~'� ��e�ff�?�#�X�9�L�	�� )�O�g]�bX�����6�.�Z��7�H�vY�wvdmi��?8��k�b��\��/�c
�K� |ɾ���Vn�4玕as�ZO�s��m�L����U{V��"K�`��T��[�	e��%�l���B-�ؚ�?�����&�$�j�~T���G��˫����[��ѯp+��B�� [����EI��o-v�϶ �������}�w����õ+퓐�k��Ϙ��I�W���u��j��ʇ���}�໦ϭ�k��|�>8���O|x~+%����4���ݱ�����LZ���6��oS�%Wפ֡tԌh��[4���~X������-}iMF��ĵ)6��&4�4�lDNŭ��-dy���X�P�ÙQ�͊n��u4�O{�jz���:!U�]�F:�����D9�aoW�B�,�]Z�>:�����B�8OOma?j���IP�vp0)�F�4��A��$�k�M#(y�O�of��z�f�v_��,G$���W��҅%G�J.���e���xo
�� �KU��E�g��`@����G�A���cӮ���i��B���Ք� L���$��	J�K�ACj�DI�sfP8j��_?җ)ߦ� Sw�����e�뵖��O�N��^�Q2��Q��ɚWuf��������稚�N��r�c���Xv����^��>*�d��������B��K�k�m���%V⌯���A��G�3�O��K��8$}˪�Vt���N&��E��ߜ{�N"�Wʄh��Dl�� �q/ �_o7Ҿ���J<V��t�m10e)t�s1�n��J���^j���Q6i��:P9=S����
��X%��~�A�gi�π�6�(k�ܹ^6�,� 傼C]A�(n�i}�#>���2�_����u��l��P~9�7�BK�/��H@�^ܦ{/	P�-z~C���_>�����ZK	�4)Z���-�F5a���ΰ~��R;A=�	����Q�*�n����*��&o�����::9�|�)�p����,&h�r�L�j�����K��s�@�h��~ʠ�ٚ�Z&(!� e��l�ⅨJ����u|(�	��'��xpr�$d3�2}���~���	�Y��$/���ol���@�?� �����}(���v?�D��m�w9	�;��%�c���j��)-,�Rq~�[����v;�f�Aɐ̺y��wc�P�xOq�M?���"3��?����=�~ׯ=젶�}~��@Z��4^c1*��OTSo�.��Y�N{�ZngRl��	����;6�t=�������cZ0���~4"���	p����a��������d�
����Ԉ�XŌ�t7>W�m���f�l�O������l_C+6�@���v�U�@X�㫪R&��If֣�8�Vp:�f�Rs��t�a1��;u��KY�i��@@�_��j�$U���:���u��Kk.g��lo$������P��UCMV6�#��6� 2~蠏H��о3�ƂE>�V:���0��m�zXn����<� �2�C�E�ìvF��8�p\+(^;��U[u�s���I���i��z?�'�Me~ݠEM<�2�W��_˸@׀���A{T��d�uG��{�ɠ���p�`�yu���F����<�٬�f7�����As%��'��b����%�_Msc
	X���*q�Hǁ�~����-�ꆚ��ËX���h]/U�����.N}^�h0���R\���&q�j+��'Uu3e`~x3�;�)�+ ���
z�����5�A o�#�d[.1��:�կ�J��1e��u
��9ck�كgN��� ��s�и�>p���Q�,c�G��H��?��ɼMQ 'ZB��*NohV=��t32q	6'u.]Py< �=/&����!�U��WT_|�{�?F�vO6��M����.�+I�J�ro�Jo�wP��f���V�V�ϛ�}�e�D=˱��Ii�fJ*�N�x z�������y%N�ߣ�
9�����\ȧ�"~�&/|5�'�~h�^!�A<�↟��ML���y#!;�ޠ���;�)*-}#�ړ�*�'�`�ݿ��T�F��O����7i��Ў�W)���IV�m+�oRjU
W)��C�Ɋls�Z ������X.��x%L �hK̛v~��q|�:�>�3���Д���o�|:a��=V��L H�PL8�d�z��썻��V,��J���d�/�~����1��BYD�Q�,|�&Êb�Sc����)pP�P���T�t����9���
��V�e�Bx�x*V|�G�v����NC"���P3��:�u!�e�gC��(��%	��?�U�V�o��d A�hRz-��(Ɖ��lO��<����؟'�cb�B���쵰��*jS4��f��뷜��b�R%�
�ӗ�%�>���aE�?k>��P�_/W��j����Y
c���~���K���RJe =pʟ��������`/��#Bm��`� _G8w����p:��3rB�~�,��¨a�%�2��uM���}Zo��ĭC�⯻h�b��fO&�QR]�j[�q��(��8�����X;�5W�(�>P�e��;3,�;O��wГ|�����T�4{3����O�
�.��6��00�ϻ
EE���R��
�0r�7V��������;�U�ˢ��T�s�5�6�����u�0�<��߈���2f�4����Ð�I�����)�R�",Z3��f�>a��6��]ft�w�~�������uXU� Dm�~L�Ω�����0�_b��f��۸�|�`��������
]ӎ�iޏ�8X�Q׺R��6*T�/+X��~9x�}f�=Þ�
x�}���m9�N��r�a��LH/BA�`M�?��!���U��ez-.Vd�I@�!�^���,3l�Sm�P�m������&��xe�C"{)�TB?3��(���R�Dl�a�@���6����?�@Ի́5ybG醸��s���[�ݤ��ތ6��"���x7�`!	s�dC��I��|�3�Z� �G�:T;`J_0G�s�1W�r�v?V���P,oQ������.:�oG�����8���9oٳ��?��?^�ہ��Y�X�?� �a-�Qz�e��K��p��f�:�?�r.��x��G����)��Zv\�������xμ��+�b$CP���*6��i*c,Z*�tJ'51�����&�zN!X��Mæ�h��N%������Ҩ��'p+���Pn d/C����j<{�|��sZ)/x8AZ��d:XV�A�}`��Q�^U��A䋑s�L�5��m��Rlw�Q�x�t��j�ͧվ��QƲI&
��Oi��B@W;uެݛ���)99�����1� ���-��"3��VP���� ��g�R@'P6�C��g$��7�ȥ���VNp�P����lf�r�R�"�(XZ��=/�w��I�*���ЧD;�E�֧T����s)�chC��Z�����-\�^��@�[}.����rӣ,|�h!�=짹M�b���m]�����VvCE�f�c�:$u�BӍ �%������6a��*�^�>����y����݃$Ը|ѿ�����w7�V��D~�ܼ0u�L�ծ��K���n��ڊJu�g5��y���)Bvg��r�k#:�ñ�e#�㨭-=N�� Q���0�D�Z�?8�_���w����Y���i�8�VU\��:Fn3z�sg_����['���u�g�fQw�7�XZOF����7�B1'O<T��f�z<�T�q������#;���an�4&�N�5�=�u��ox�)��ff��D(��ͯ�>��&�p���~�H�Ɏ�	2��k��n�4����b�+��W��8$�	�{#]<��*ʑ�� ��m¬�qm�uI��R���]K��3����)��d����58eΔ��n���Q`N����yI��zt��5�m�>��Ή!�C�޳I��R�d%    ev��ѷ���h���e�4Zb̸aI��O�̟تBF���U���"T�[g\j���x��V��-	��'��ȯcC������������Ewy2ɼ��u�V��5כ˛E}�Y��%�z�����+�������7�Q舨\R�!�.$�ͣ�٥׺�|��s9,t�yyI*hy[�"jd_�.�~���v�?�+��,S����7آ�V7�*:�J�$^�A1Ծ%B�2�qݬ��A���S�e�ʼ�� ��"��X �$�<(�	ʝ�k|��dbm)�t��X���T�c������g>�.#�لÜ�k沍���|P���.˔x�1��Ҥc�t��,IK/��/;�[y�t�ٖ0���E�5ϖc�k�.�����^p��=+U�:�.q�k-�Oi����뭛�\�{���	�?^��fc��:�9k���Q�����=���%1K@}�$����l��	�.�~�Q�T_�
���0��6�X��������S�)~O�N��9�%oF�ɩ�rD�j\�W�_�
�
N��R�u���ڝ+�	.O�0���:� w�7�B�d��_M&�e���[.�P���Vq�����qRe�VH��[���t���@u�v�_����F4�����]�X�2�B��p���R�&	с�uy��E
Ε��P��&)%|�[��+�$-0�o:F���<i�':�ĀL�U�An)��{��-����$�4W�Wzr��@�WCץ�j;���c�3%&e.�s~���DI:cG�q�>�:��q�(i���|��*Y��ڼ��젤@�̋0(.���%C%����<��d��1�7���-�0չ�}�7��P5��E�!��x�~ңz�U�:d�a���"5h����=I�QO�(�m��f��2��M�]�� ��;�G2��^�\�=p�W���ġ�^�6E�d�rK��4�r��m�����l/v;��V�l�Q#pU�>q��A>�Â+�G�E�V��E�%�x�7�|��uW�"���h^x�K^����gq,=�K7�;ȹA��K%V`�^�
����_h
�J:�^�7�z[�饰����?��x�gb�������t��EQ�����֭)����Tפ�]<��T����!�joן:*|I�M��'���ɼK����A���}�ؑ�=2Q�u��Ń DioVK��4�7�+����?:��Z�or�q��b6��|)}<��t���K��(Cn�N�1���&�D�d?�00����H�t���Ƿ#s@�6	"�����w9���#�	i��S������/�$nа`�?�S+��%�<��0�jW�)F��r."�0���
PE�-n6h��=�B���n�},�!>7 t�B�jXD"��C��8�ݺ�ʔ�3pN4Q��������|�[��ˠ��4W�������79ϰe݄.�=r��O�1�*Ҟ?7Yj��U%�"}�@?у:��{���q
��m��"Iٙ��]��4�2��>/���k��� �;	�{�����<7v_=+���ڊ���zʇ}]�Ё8B�=w�d�
�C;����;8l���M��ќs���?��8�,�UG�N�o�h�x��z�0p�C�B�5z��W��E�� ��e^Y����$`b"@��]�ov�N|ʓ��zx�*��A4\��WH�ѭɛ���	�ۢ��`J�:�$`G�r;i�]<x���(�>�V��+2o:c�@*h*���Z�c�T���,��dԮ�w��7�ˬ<���@D�_4�.�nw	A���w��;�����rf����TG�/���<ʡ:�t�W]��VJ�r�SB���`��+�R Ja+�%��h�2����=�
U	L]�{�p���hQ�MIn&�PBͨz�5 ���o��./�Ӯՙ���M)���K����mb-���(�q�-��w���Md�-9�d('��"���+b]�;@���zE�\#��3(��һI�ڭ�n�/��Ǘ��u�"���s�&��{�ο�o�a��,��7Լ>��v��RtM���ƫO�$A�?�[�C�k��Ϣ.�lJ+��ꕠ�?3���S��]�?��GPd%^�BRHc}���o���'\����Un@l����ΘC�1�Ű}�'��S���b�R.=�K���鵥~:��PN��$���B���
y�̓8o��L�RUX1)���<5=+f�&����j4$�ûl�Lrb��D}�I�x�2~��N�ǆ���T��ITvˏ��/TA�WHC��%������ى���cΜr߸}�t��	�Sٵ�`~קF�ka�"�'(И� y�xI�Cz�*�`X�#���Z��/	p��Eq��?�PO�I�CO.��湪L�����,J,����1��m�C�����0��4H*����R�fU}uC�3��I�C}_ʲ�޶����,�%w�V���vC�N��	�]����=����dq����z�/������6�7�G#�i�ۖ���O�8�s���ޡ:!!G�{5ۑV�P��2��<s7�Ѫ������R���'��GM����@��}�������YY��U�*�kf�8�z�ZN�y[%[�������ȫ�
g�p[���ug'�Lk��Y�V�V���s%ܑ��=}�IA3�x7k�bS�%��oc3/o2�&*��0p��&�U�.U��93����vG'���*��Yғ�L��]�`����ս��8��::���A���ēd�6p7r�GK7-�� ��>ӳ'�ʻۇ R����mD��u]w�'X�{�k�h��B�Plv�~��j�8������,�5�]�ƾTR�m_�e=$��(NX⩘�G_G��_�E�C���f�z(��u>gd-�)*�;��##	�4mr���)���ێ��T(r�k5�')Zd�a:ѕ鉯)ivlQz�j�O�*��p�b���^�أ%�#l�|����7U���5�\��9b��g%d�/�O���>G}!�۔�����e��̓)�D�Vʱ��(L�����%�7�qW`��J�Ij��ZUo�٬]$�Å|������Pn"��'[�-ɞ�61�߼w���B�%`m�Dt;`Ս�+�Mݵ�ҵƾ*���{$��MZ���������ӑ���t��x���ƹ	�4y��Q����|V0VNjF ��n����_���Doϻ��|�6�-w���W��mJ�e�N�Ļ@L��	^"��]ꑐ%��f(��:+x���ݺ|����kgZ߻Ԥ��oŷ�����a�dM-�V��y���-׀!���0���khv�x�o�����woi�v�̂���1��1B��u�����Ř����$�$�"�	i(	p�B?���ݲph�8LN8&���S]���~8+|��,<��faQ��/�/#�	}�>6���H�@��>��a=j�h��edi]#s&ш�
����5�_�}xS�O|��$��}�KP�4��?@�V��'�6H�����:in�.7��f�w����:K�pyވX����g�4��b�Ͱ�� ��S{3W���Ok�/wE|y���v�R`>)3���;Ħ-��	�\d1��Y�g�4�J5M��񖜅���Ɩ���� oF�T�?b�j[q`�G�<A�U[
�=5x�]�	o�u�=HZV�␴�eJQ���~K�=G����A�úW7r��nf Y�a���'gnҐpuˣq�����[� �$��bkw����]��2���d)U鯃���_������X�~���7��	L�!w`�ܸD�#�r�y�����|+%�W�K�Y���w�$	�m�ë�Uq0���8&�.��{_bh-8�"��.G�����䃀�MQX���oh�C�`�����_0��׶[�u������^��=h�Kނ<���%��[����w��|E�7N��Y��<UBM�|w�����#\�f5[�0��[Ǵis2ץ�>x�����}��n����y��<sb� �4[�|���ڍ�1���"���@I�y��X��
���,�V�=����D&�=��tp,��u��-��LI����o���"��ܶ�<���������    t-2_-�ʁ�#�́Oȼ��_���^%�c;:%�R�8:j��ߐx���l�^7#�Z��`����"w���MC))��4u��q�i��CտZp����)|�L�,Q�g�@�!ũŀ�9x�i;�e�{����>;��\�n$�%7m�%����+)I�������.�jh)}AgO�0�(�~���UE"S�������)�0��x\�a��^Mڽd�z��4#=��Ќ�T9�^�T��?n���%��iB:L�[�Y�k�����Jށ*EB����ʥÄ���Om+�:��oI������ؕ��mVr��%�e��;[x����1����[`���tuy��킒W�^���sN���=_bx*�f����f�a5�L�����K��������TY�k{vV�+.�}�	�7���>�3��~���O��\[Q�׵�F}(�T�	>D����~�(9�� �M�S&�	8Rp��m��~k�v��\h���]>N���� ��Xf"�����օ	X�8�ʗ����	�&fA�]��)����6sf��9�cz�c/'���@n�z��ô�ɏ�&sk$J�
w�����'<��C|.��fEP�<(�ʇ@��O�f8ŉ�6�Qo��	i��"Kp�X���>+������u��׸&���7�������q�f��з*���o>M	�������& �_���f*�/P"s[Y�%Xۜ(�G3p&�03u�ST�tT6Cr?Ew������� n~���I��4���m ��ܪB�3��L>滩;�:m9�tXT.�H��M�y���*�/���X������G�H_��rD��� �I#�+�|��~u��7Rm�g���K��l�(��i��)5S�0l �%�Q4�\��
��q��bZ΢����s��㙶��?[3�
y�"~�%Cf���?���gL�"�J�nk�s|h@���B	cL�	�ǡ~���nn�h����s緯���B�fAH_m�9A����A�h?�~�i��|ڸjΞ:� �TH��yD��ƞ���CS|�}����O4꛱��Q�;B�,���9NH�ℎ�aL�v
��B.I:j��XXU%nl�C���c�6�uBU��`B��Z�;^�~���Pc+��O�CJ�����V��̏��J��R�}���ߴY�B���^>�Y���v�*̬�:_%���8Z&�g_�dES���Q�m A�L����{�k���ۺ���h�~��r���o�s��E��?�su���l��$ۗ:mc�~�u�֠��U˳N|9�j��g�=$	��sW� �[qY#�©+��t�>���O���ݾ�o�0��]!U��P�Xܶ��#��.�N�ٕ���Y~ʨ���nS����['W�|K��S �)ۚ�]�N�Ҁ�Dc���i4���&43
��t������=���dx�[�/��j�ݫh|O� �[�`^���ȟIl#�$�[`��#���3��;�РE��'9�Yʝ0W"KP!��R�R��"]ɨ���~`31�E71-W���%��l���j�=��&κ��\�E���nE���s��z+K��a�ޗ-$Mґ`Pޣ٫�ut��ۼE��5�����&�u�y��NZ8����"�mM�C��,r��HuvwOZj������'�`n�40l���+�u�ro��`җMK���,X	-Z��*ֵ%�2��mD�%�`W�]�ܗ��V�}r��&%?{��p�Dy�,tj"a��$���&a��7-�����~)d:�A`�ڑ�[d�ZY�t�h@}��*�)vGx���Q�p��9�G������e�j�`˦�5)������ݕC:�E�e�b�ɟ���b�d�6l��ۨ��%�OL+�%v��P�l=i��+�ѝK�4_�f?��'Y���P�kF�W�eڻ���ϐ;�]�b�/��3�o�~���`���%G�pH�h,6�������w;lj��U0YA��`,��9M�i?�t]��i߹#��α�ߊ��*��b�T54�Is�v�{�����9�T�09y؂�[�K[Ğ	u���$��h���S��F� �"�x��ro�
�G���Xo䃲E��[a꿀7����Nuܪ�{�Ӹ�|q��ş�:��hRʯ�EE��,�`�x����`��:�w	^YZ��Z(	�آ#.N�0�u
��P�Y</v�* �x}'�l����m������ESL��߮�}j ?��i��m�KX��K�|�ِ��w!��ʧ���	a�0\�=��'��XX 5���t}�3�
�N3����oa�{4G����h�@t ���������Â �B���tɔzB�r���_��w4���ه��N���D�к!q��N��u���.��$=�=�0��DHfy �;��z����R�Ny��}�ĉZ�;Sx�����Ú�;w&���=*sC�_�Z�H>��5����=��P��.WL`;���O>S�~���g��HX�T�����Y���5q��u�(G)�ű�9�u���@�w�j��;:Ds�[.��rg��CU2����ft܃�~�P(�ITu�VH�*���s�� W�|�F���V��v0��禐,/�"��^��6E�����%=���F�m7�Ѡ��<��(L������4�q�b��*ѩ��C4���s�ȑ�Կ��a��@�=
z�y{�9�"+������X�'
�,~J��3ƍ�/�S���n��r@�5�^02e�|OF��c�淳��:��1�M͛�&}z��"������!�k���R���|IB��9�!Y�Kd��V�6iS����w�Q�zg(�c�۬P����g������ٿۭ�Q�q;X�+zA%:���s*%運4���յ�����
���1�tG�_^�H~�ނ>�՝�a]��p��Y
��nV�C�?�����g.�R�S���أG�R���n�Qܵ��(8�n^(���X�e��}�k�|@��V�����ª�}bO��8� �務�x[���IRB���I�h�c��`с����&����$x�RӢ}�mz���̻��t��g�g����YB��k_�P5ۃ!�.�$�U
j�Wӷ~�qs�E:����n
YlLa�c�N��`��lK:��2���]���.΢b
�s �e�G���'�#i駨�k5��Y�p�܇����8hӠ0]��.��a�,��kz���%v0^n�Rl�X?MĖ@H!�p������P�|�a7�+|kl_�̚�~�ܺ�h��B���\�>��Gqc�ڏ2ݭ��:~E� �\y1�#�;�6��0I�4�5\�a��j���d�"g����G���V*x��w�@�аs�Z�i����y"\��Ft��-�M�ـ��a��A�ےߨPt�
�Ւ����9'#�,/U�䔢�TA~��ɶÐ
��i��o�/�[%v��8���1����R+���ؽ�I}�t�k�2"իyY���/��� �z&A%�&s��0��LT����a@Dj��ԕ�
�1t:L�X��OmI�;��~ql*n��c7kN6 �B��v�Lp��>��qN*X	�=\� s���d.?��$�Y��P��|K��]���8��A�by>�[����|�a,Darh~�������.�`���G��9)��L�-@�e��֦W���&<#J�\$%p梨=��4�dA+\/sP�����VHRk�%s2KE�ׯ��#w�F����۸���JK��W�Jҧ��}����G&?�=;�'(��=�?� ��S�K~���\�����G��*s(GlD��z!���KRP���	7D��1i�CF�}*快�c���P��H����f2I�mz��9��X�z���6�����;�>#�U5����9y���yV��1�v2��A�8^���A�h�%o�:s�'>�XB��ʔ�C�5���#��m�c��E8F�(������e�tT_B\��掋+f���Ma�2�Q�Ĵ��Y�o)��)T_1����Ӯs��kv��0���۪E��ߙ�"ł��}���m��`�Vt x��<���p�~�ơ�&H�Ri�    �'�d�rN�zCP��|���nXTB�c���O���Y|�Q8�^&Շ��r���2���%���q�0-=꒘-�y[�w���n�m�|h3��g�b�4����/
B��Dm9y3 ��ǩ�$־J���o�����-�fwD��~i^W%m-��`��%� PZ���=��%���~X5I��կJ��vU��m�K9�C d�
������"6Fj��tS�a�����Po��������j�N���R����~����Lϓ�&A�-E�n�lBߑ�d�A,[�u��g4���r�d�H|0����ן�$�~{)�ě���	��|�{	���%�R����+@�iiXU��9�]1Ê]�{/�����b#B[qmȎ���kk����I|
X[�o__�U�\�VGy< �����p1b0��<'O�����I^N$�fcn2It��eW���䵇C��5^6)��vժzhnI�Wd�5`�z{�q0q��s����ǜ_�E���7�Dq���o<��&�7�
�dHL�k�r�ˑ~�
��7���I�F��s�l�0��9�-!8l��ς�����O�])��A)�+���iY��v��;�K��~|��+9PŞ�W���7��$:�h�3�~q����f7�F�:�w����r��)���՜�t�-=b�]h������
�v ����K���eJ�-#�B}����!PJ�M7e�gf��S�j�uH`�ĖX��r�z�-�L�#�<�aV�tX����y~�e�j��éd|�6�9�Q�ӄW���i���c�z1>hj�	������W��b��vZ �,�:��%����}�b��̏`�zT��P!Ì��a�C�dܧ�w�#[n�� ��@����!���[�o�L�/q��^��,���|�q��G�FcH~~8��W�2� a���5i����Rܟz,�hz�ݶ�+�KoM�~�� ���[ϳ��쌼[����^<:M{%�؂�`��_0Y�HD'��-���Sψ��tzaSx}H�s����?�ynj���hmo};<^B&7c�܊,�aAaw�/�hږi�ġuw2��G��xs�e�d��ߩ��|�ҷ�qg�H>�8�Z��c�Mw�#:�Vc�W +�Ʉ'gB�\��3?��-����=p$�@���lT����K�Y��j�vG����[��K��gc�z�!�6��dA�������+%Q��a)d���O���j�l��?�K3��y�Y�a�49E��L��~q�˃2�M<>�u�T]���JM!���~�����R3�F�+�|D!;�����o�������Ec5�J��rs/���b�	�y�w�Q8��L��߇&�c��d��w����cB.7��2���)�N��(���>2 .{��+�Y��Ә�b���P��	j@~ü6���ua���6�������\��9��xw.Ĵ뎣:�(�����b3�����]7�s�'�A���_X^Ytzr��+���:�8d&�0:���ិ�w}�O�)�"�4euL�F���hRY�t�|�]JQW�j�'zQR�1�U��y���ne��|��؅,�� ¹ؚ���r��^Rb�ͩ�=i�+��Ҟ۴1 �9LS>Sٸl�*�N�m�E8��b-Jǣ�)���}s�����M�P�K�	�f���� @@E@Iy�o�>w�|u�(>IjK=�w����/E������y��|�tS�?^�'���W'�A��e�! ���< �\{vc!���2QԳ��ʝ��ύ���t5�1.��2�f��*�՞�E\x��m�1,��Wy#��(?mQ`.�\�-$�[3�(�o�P%��d�l�XI�o�M���> ���̈]�x2é>5��	��֬���_�,qIr�z�w)tJ]�{�b�;I]�����Nz�=����r����u4�Z`��Q��O���6e�M�v��Q@�&@�����ؐ���	��7��}���QjQtIq��}�e )�G�t/�9��.h`i��Z~UG�Ȕ�������
���"W�D~3|yf�|�ټ��~�Ϟ hW>]W:uL�MN�*b�_𻱱1mj���*Ȼa
���c5mgB�:8�ͫt�M:��H��[+�-�J{�4�JCh����鼭ae�m��/cߘ�>���ؙ�"%���5-e<^�Dqߡs�8�Y�v���<�7o	�U%�޿����V�=�Ng�M��{t�:�Q�~��}��|�H>�������K��t�'Y�]���8�#!Whz�� q���ث�Zs�8�`J&��"����	��#��Os]=�&(T�S�l4�ƹ����r*\s�^	g�Oo�<DfN���>���6� S�����t�0��������-��Lʚ�5[�/���2�/�|jz}�&�����
���LV���]����Nr65>�VU`j���u�+2]Ku���J�$�#�J�	眿X?9*����l�7WP�z�e%�F����0y���Y]��D�٬l����lA�8�{�AW�L�(�8O�]]Q`D������l�9���9��CSQȟ2�����W��Пtb��L�\/����y�6�>�����A`}���]�������xi���d����$2��o���@��@m�As-���.��S�[�"�p��Kv���q �����8�S��~�{�|x.WP�cϖ�{�,:�;f�if�n5w%v၂�m��hT��t;����>�G*�6�~㗅B����ԯ��b)�~�i�F,D\�%H�m�U�����Q�lӯ�5�Ȍf2�`�rB,��X�ŗ��%�!υZ��V�������#o�;f%�c]u����E� ��
^���*D�TF`��<�\�cG��ś[��I��1�i�U�W�����6��y4]vʎ���,�|���!O4���x¯�Mt���F�s���!"�	�%��!\�|����57FN��;��H�����~�Z��K� >0m�'_���^�z��ZDo9�4��E�6Nbz�w�s�L
a������6���^��7թ� 2������[�@{X�Y��kJn����M�^p�g�%�����$Ҹ�sM��a�Jo9���
 ���rm���S�S0.{(,��5Br���]�.����f>��gӓV޳���O�_��P���QGl(�t��������>��E�s�*�Y��+���R�ژ�R;�b^�¸9}�3������&g���"�{v�{��u�U��z�^�xwޯ��Mw:q��>��Y7h>�L�`��,aoA/2�Ls},�L4��F@c(	߽#�1k�bP/��<۵���)�LO�&�2���/&!��5* �H~�N,�@P��>���'_���H;�,	�(�.�nC\����^B�4�C���HD8@��e}i�_C{�E[�q�4��1fH^]߿��~}F�T��~ro���b�y�V#a^��n�*A��v��%A�"�?��ę�P�}w����8&w�Q�k/���
�Hs��e���kjЅ�ݨ�����]�M��'��iv�;�r��^��)KW[������'�۪�����ݷ�AӇūxsMh|\k<��܅�|?#I+�ivkp-W�SE�s:�c�ݑD�)��л/�{�o�L�C`�j$��F[��{'ݶ�b�Gr0���=�U�k@��˕���"�9a�gb3+c�i�[G2���Y��߲�Le�D��uod��k��M��"�A�	������v��)�ĴR����r�6��m/���H:j�:��I1
���puA$����G�Us��i��@!�_]�⚽X ��ԾHQ �R���#�Peu(~�~b:��3����V������&��|��u�97 WЁ�t�{ii����B�x(��K�%~T*c!�8_�e�Y�H+�a-l�羦�0�Q�*���5�
Sy��h%9G����aZ�"2ue&"�-�5)�=J~�T>�AIGe���'-��8p>BV�LA�G�v�^���R��[TT�mʒ	UE��q5zܤ{���q>e���a�R�c�"��    �E� `�U��`Y�:�7ijV氲 W<��P6Y��Ѫ��f��Y�f���}�ߎ�<N����Z~�y��`��;�X ��۫JE#-��8��)��w�$���8HR�9M�
�`�y	^Gg11pӸ�5�IP,��ʻALci"�Qx��������6�J�\��A��蒣.L��U��g§����� +���U������ �L+���z���[@HJ���¢�Q!�`VH�a�o�Fv�޳C��Zݩ�Y�+gL�Ptv�e�(�TqY�Ւ���AH�n�xk+� r |�o�#��΄�t;1�c"�ٴ<��V	8S
J�V�:��foE�/z<�2ݫ�]Q�}���yca�.Z��3�|��۬���%m�.�����یߦ�y4@XR�R�D)��īȫA����-�\� ��zp"����_
����l*��N��
C=$j@F%�>����Ex�Ap���׵;��{W�D/<G���MnG�)�vxT{�%\�p&<�G:�����+��6w�iNS�R,��<�sɑ��:��ߢ��V�j� $��.�1���v.�]��`3P�=)���_Ǎ����z٢��8����u��r���b��
�7k}� E:����z��3�8��o���F��87GK��J�NB��+���ә�ޱL-���xe� �
�Y	�"»D��>%�|Y����k�WdL�A��Ր�Vs���ɱ��ʠ���` ̖���C��:�̦8�'�� ���M���>���\���Pw��3͋������i��p��!5	�q>^�11�b�T�h�����7y���G�y�-UԦT!�(�ˡ��g�+�^��˪�V��W\P�A(��*��L�p�K���J����}N����)��z�*\�����Ř�J5$�%�M�6�ws([��,�K�n�h�N�_�h�s�s
n�xzͭ�Q�VC޷E ѕ�d��$;�)�6Fd4d{S���C��:'�P練�Bq�v�P���vF8��yU7U-��y���I��u��s6���j'��f j�,B��F&��Qْ�0��Xz���䋦
�d � ��5J����̶���z�-����ou�Sa����xQ������3V����kJ4�W��%D�%o��-�(�������gxδ�aRe��+A�92�[�>)��B��R }�"�����,���o6e�7�'K�Yc{^j���������βe�:^���g\�̿���)7h�I`(�֟�EP�����GV
�M�f���E��Мěb�w�
���VW����T�����I�6=[�n97_�ْ|���bi�/�۱
B�NOri�č����ۊ�.F�_a^�#e�onl8�F�I��;��Cw�	ɚ��CP5]?ȮH�ft��uF�������ª��1j��c3�r�������X�oL���Н���a\:|G�=PJ���!�[Ѹ� �+e�Q���N=��1`���L8a�D�d-�o��i����؟u���mc��MI�U��~��<�J��~�|��ĵ�^���k�{{���w֫��al����ڄTu�����a�ͨ����R;��g���Q?�������S�������֟���3�_��)~���Ypv:,�S�����J�C~�}\��P�έ��mN5�ra�u3�I�'?+�J;Y ����iaL@̬�.0�:e ��O4������72-�6�T��,K�-h���VuFgO8}��O� �2Hs�MVd�,އo0���w#�ك݂郿����|Kh��ߺ[��]�x����'�^$5릍�mվ����e�<��z�Z��ċ����_ϜJ��]�	u������?_�2*i��Ɔ��3ai���.�d��6>ϛ��sF�<|�&g� �7��C�{!�n�ק���o1����#S����Y��0�P>L�9�[��,NgI��Ls/N��������YSg�qV��.hV���\��h��q1ߙ�G���:?�|%B��\�S��syW?9��ؾ4#�����oÿ���#�X���B�ms�ݨ�
�=l.��/���)~,,�ͤ��Z���nv�#�%�9n�F����Ƴ�ݹ��W柏��S���(���ծ@��U]�Fx��ð��ƭж7&@f�qhA�寢�����>"��eA(�{��
ì����޶��տ�̓���	Y�aEE`o�*c>x��d,��o7�ȃ	��m�l3��.�$G�*[�.Q ��zE�4a ���2y�>a���>�|[�HU�#.�[F�<��$�,lq��c4�|��o�9�ۊL`z ��^^��0#�̼s�Ȅ$�/Ga�@�k����DK�@����<���ʧۢ�Lq1l���5I�eǍ��w��W��ؔ��Ueg��>�q���/M�M1�<��p1�h�<�R����YBXKT$�vM�,?<��1�����#��H�~\ry;�\f�H@�2�� Tu@""4�X�)y����'�����6(.A��(QT�-wTo�'�f�����b��/`V�М��N�"hƙ�l:*+��t��{+�[����Ev�# NL#$�7�PY����ږ��c�g��e�D�{]2	�%v��޼,h����ͬ(�*���I�#�}���?G�R�jsw�}8UY�(�1�(ۋ\r'�|o̒�`���׶��
&���̓"?�x=�Γ�N\]�Bm5��PL�������_x�5��|̜�K��5�}E}]/w�,4���:v�d����\ỳȔ֤��J�2ޤ6����|:����e��b���gf����~��;�A���~vI9ڢ�	j��pX<=8��z��f���%�耯)`��:�d ���q��	�9_r��
�����É8g�4�7�]ژ�C���8O��FƝ���:���w�'�W.K�c�ŁU�\�o�\!�En���E��1�ԊB�T[�#)P#Ν�fz��%�tsL�"��o:Q�D�y��'z��q`qf6�Ya�S���t���;��L�葴4q\�G����У́b�$s����c
T�Nа�'s�*)�wOrH��ebDj�o�	Τ��K{*��޼Ǫ�Se0���p>g�C�t�s~Qu����DzLӱ�b[m����nI���
��g`z-?!� 1H���K�>}��܏���@E�&z�3����|���4I���U4�_9I��x�q���c"P#��\$��96�´��>����16�7�1��Ƌb̶]H�D�������!"H��f!��)*�Faʌ�XC�rtY�T���oʼY����Li}�� ���hg�6+.�T�Y��w
���`��$W$H����(KS�<���Q�E#��`���6m�M�f0��CiK)��� �99|��T	݈�V��e~L{%d�ß	˕K�5��|���ǖ�X9���#!�[v?�bgf��Nb��Q�G-��bx��U�/�N|��a~6"{�4I�/
$#�YO}���@lf�Ǳ��%������J���;&;�Tr�-N*�ؤ���ojz� �꣪�0b©���P�*\vh� M2h���"_�+�vf�CFQFS�2��m�߁�Q�{@�U���:/�	+����d.�ʛg��yz�c7���^m9У�Pt�t����u�y^��Ml.����\�u|6�!�#.�Y=?�`�vRh�� �,&V�\l�֥b�7,�U���k*�a��=S5}��U{����d:��@)8���^�(0�f�Qn�S������Qש j�itR���$umSh2�>|�`>��`�R%㡋�&����D�1�"<��)�}���K�"i��o������s����'i^��ZA._���D�w	.��%"�aIx�=��W��^�k1��FwH����S���G�*�g��Ћ/��D�\����$��	aO���`�3���,��bT��`��ZLx��y-�U!2�p�qI�w*���ǕL��Qb�9Z�uA���c-L��CU��g���ض�ڽ�L��r�o{��ӗ�����%c�������!GU=���*ꚷ�y��ߒ������Dbr�Xk��    6?��DDb�kIu��Ǟ�;�+X�"�����:c�j�b�/m�������Z��פp�qzd����q���<�1�����6��3�p���M���R��W�e��y'�����+��YA���it%�2�7_��^m�ڛ\��h|����]�$�͌L�����,��b�h)��t���~���A#` �W�=�����Z���	��o�'f�y�C�K	�V��w��;~�۝�K�A!3G�J�e��q�� �f�i���$��E���<V��_�Ҽr���0+)z���@y܊b훸V&yu�U`o	��`�dv�ne����̀䗅WpoPA?�C���c��X�X�aU��.���->D2�)=��+��Rʹƽ�c#Z*0%7y�/���<;|�8�:?"|7�&o=u�gL̄�d��Mtʸԭ��
�����kA~���Ƣ.;���Z��^A���Hhx�j ��W֭ }䡬�A�����~�,bw���VTb����=T�$!��L�a��0��=j�d�l^�]K�P��,;�J\��p��b��6 	Z����]����~>�o@e�%�]��s���+��1p���Ne8 ��ܶ�JEs��VH�j�(F�˟y����),�����E�W~�_7AP��7�q����Ij�C��Dh��y����ӍJ�i�^]�o�:cIYh�!7].��o���\�_M�C��.�,�Up#?��8��ˇ0�o�oGl��=�5a���X��Z�<~'S�"<���K�u����кJ�N��"��3A��@����ɑX��2z��^^;�7P�P���EF�[&\&K�b������hK`!�L�m�l�8��&��Y$�P� �[��͞���J�no���,�V���2NY��f^�7g�	��#Y��2����-'P�fn
͈a,vg�����c��Q��ʶw.����H�G�IpE&Zq��?ݾ�TѨ�Qa��[�&��rX4vP-��U`oR��Ba��~��[0_c����M��
��=0D)R�g����"���N»�m,�&�!'^�3�g;�R�U��M��GֆБ� �Bk��Ĵ��%�Α(�#36KA�1�W����ؿ�r�d+���w��eQ>��9����x����%�3�sO��b%����;9��Io�0����6�g(긹z&�Q���E���X�A�/U�bh���&�zU#5��׸��癝 �LzEe�N�}����ht�fdjm{3�id��L�'����'Lof���w�-d�_�]T3���
}��}�
�]�'K\ua6�r7ƕa�I��+�:n{��"4<�2�w�L�mV��� �X[�(�!��WT���ӄ2-�ideſX?��[�3҉�[����C^\[y���3RRmIʡ	��X~D�s4�%�f9��M\q���`�K�Y�M@V,�ڸ*쒔PU�v
l87�ˠk�}Wd�w�Р���"�NI-�0}s_�;��f���Vqɴ�%&U�HoM��%^O�M�[bЪTB���JT�#�{�Z�A�ow�����Ʃ��5Б����XL��C�i_���خ)�����z�R�y|v+j�R�d�?"�2_8����~�nӆ�����s=3��dHږ&��|�2��"aٍO���*=i���DBTGӊV-�i�ZB-o͠F���Â�:5�ol�Y���g�>����|���V֣�f���6t1Ĝ^��VP9��ퟷ�n�o�3Ls���{�����bNv0'���c���ŭZ���oIL���ˤ��t�Xj�2�r׼��jK�䬣��$1_�Tݿ4��l�qp^B9��D
�1^�<o��#yK��9��%��}u��G���'hrq� �m��Jn~�#��mB��w����'���h�IAKֽ�<����
�4;��-���	m��a��ݗ����0>����bSa�)R�z�vB�p����N����/�a��w��)��'�<�����6&����n����CE���*�@a�P�΋�/Q��r1lI��7OE�N�9����L�k`�e�>���9��CY�?���4�!��Ih����<�	���4�q��)�0���c��L�f�p7+�IU�g������ۛ��I�'%�����[�|�4�[��tҥ��������22B_��B���sj��"D��o_?��Fg��BC������فnI��-��BǱ�=����5��� Z+����тPW�g~C�<r�HI���a�d#��;J�SVW4�`�۞�г�X�{��b��	���w��A�E5	w����Iz�
�D�!f��OꂯvV*:������'MЧDf>��Řs7U�C@My�S�9/`�#�/����v�����4B�g�L/)[��7�R��k��!9]�}�p��'<}�\��/(���p��-G�)�ܭ�9��_��yV豎l!�uxi�}�JA>%f�1�W;�$��sh^�,E�9_���+8��r&�.�
�j�Pf�˵�(0�6!#?��G&+�����=��\j����he���QPf��\"�mQ����n�	��ܰ�KQt���v-�f��G;���V�K-�4X�63o����ۄO���55�h2�nR������t)K豵6���3@���V�	���?���0���C�C=;� ld��bN����i��-�T~�"6b)oR�F��b;BK�g"�a^�֥�k
��|�໼@!^i	2Ih"�-��m�o~�CZ�����b!��xS�T��0���)e.��*��8�6���Wٰ�]�k�$_���&v�-����^ם�1�޼Pt����v��Nt�-M�V��-�d$�n�����?���q,=�e˧�zsF"�ж�8?`׻ۭA�[�s+ǅ9�O#��Ҷc0k"|�T[�S��CX6M[9����������7����ߋ˽�nϯP��fQ�h5�I8���F��TR����e՜#E �0�#R�z�烔S�{˖�X�o���R!�A�8<�%z �;��$!@�h-e�O��:Wm�9 ��&2o�-�/���V��]���w�F���.h�BWu�KE9��L��c�#��^4`Q9H�&�T���06�QZ��6;��1A�|m�@i�D`%r��"��e��[,h����>Y��>F�_&d��Fǃ�Q�J�hk��@��KCw�3��.��o�?�>�P�%�72Hm�͊E��i|�ck	���K��O����]<�V�!V�&]��У�)KB4�DӤ`�˞���G���SZ�� 3�-m��I:RQ&R���E2b�6�K�Uw8�LJwL#
��4J�9����]P�X�)3j��Q��W[ �>�0����&eI��-��|��
SgKY�_���?�ğ�i�Q�1�
��b�k�"`�ϲc�
fY� ��rs�hz
iSw7Aa�����-���lK��#�=_F����hk��7��]G�{��˷f�ҹJ9�rs��6idS���2rwi[J�D������z�q���,�>�I��$ �x�_؊�5Ś$dos�x���d��+N,�VN���_�&{%���,�y�&�])�Xxщ���C3������nG��g&%D_�݀�TqJ�����s&24{L�p'#EY���2�.g�yarz_�"�3�}��5��ߒ�/�5�z�k�l��/b�ˑA�m�S̕@i���а���:l��IdBn�����t�|�׶�x)fn�͜ukl|�9k�9��S�4���)0*�'��ݛ�
q�>���|�$��Y�T�o����Q�Ӌ7%�~�`[F{���e�@ca�>:���씠LB$��E �dam���]�+ȗqdO�51�r�C�EY�춃��Ic	~�po��%��ܲ&JQ��|u2��y�e ���$���Z��	�G�C^�=�yWZ})�����+�|�nl-��c/TM1$�u���R�mM��i����C�۹�ե���KtaPH�NGe:�J6-��9�,A�ˠi}� #�$nr���m��R�4 4E�P�o�23    ��8��`"��Y�H���H��ƊW4�Y"�h�-*���g���E�@�<7�S&�20Ji��\��o{Q �p�����e�1P����ae�B~-{�:�3r��L`�hRmǭ�WpE��ꈷ�(�C���8��C��]y��r����=�lh�Jv������û�_�|�<��� ��r{����-3��;ak������.�njk�i/P2��oEy��H�m��a�CBk�~�|�^g�<��z׵W�]��ʂ����q����B�[m�&�H��:5>�!�є�
���'��,�>B����j+�����
��5r�-L)��uO��pZ�IM���6MyW ���C�C7���r��\^A�1�ߘaB_�&ma�o"_R~��U����f�x��Ff��E�Bf��	_�[�U�B�����7T՝H��į�󜾲�s�Ih�7X?ࢺy������oc��ZY��0�pg�����mn[1.�6�'N�-�q](��A߷���]L����od� ��5yhVd�e8���N�RU�R�  ��}�o�#a��ג��Cv_��e�C}V%?�-A�lތ�b%�b	K�]�S�$�ʒ����:X+Q�4�CumD{������Wi���H`ڬ�#�����\�O2�ޜ��]��E, �k�!���
��m��z�����;�Eō6�Ty��������8͟�mYu!���@*6���1.34��M�"�Gzt	��ZFTG�"�\�%Q`(���O��\�C���w�8��@y�$�w���g�2��Q��~c��`��kn�*��∄�����¶1R��A�3�,9Q��dEW��E{����߾��0�ԈHi	{X8]��w��"d�J�b����a�c��V�?�[q��D�\6#�i�~b�4F�n��Mf����1�qz>���X����P��f�����R��kU��u����c���C�9�R�l�p�|���~��?H�f�<����j�S±t:���Tk{06�Wv���S��"��m�5p���7����H�ϱ�(p���ܝj h}�F�����꺴,�Aq���3�䐭��EJ���U���x�WxS9�Bu5�c�o�q`�+��7�F��=����#���^�[7�@L[�à�;XaB.��a�����B�0ez����%��[�*De�a~a,/�.h4sI�%�N�<�q�f�Z���$E/X��p����u�������7I���TK��'|�W�]�A[���Ƈ�W��3��7{�9�>��Ls��m~�4q[��+ �?s���M{�����]��qj��/Q6�>�E����@���'��z���,�4�P�C���l�-$�:���Ͻ��	]w��p���%��	�v����n����¹��@u-.��|� P/%�i���������NQ0y����}U�G}/q�D�����ALRڭ	%�%�9�j��1�&��Fl�!�		�ϘwS�f���1���%�!8y���x,/��{=`��$&� @�%M��r�W�S��T{5�Y�_#���Z,⎵ �p�x液s:*ҦC�͍�"���	����\KL�v�;pP��2��gVi������ZU���k�c���J"P8ҙ�.cĭ�)�F� �r�pN\nH�>�!��������$��'`U4���x�P�<���4��n{X!� ��ڳ|���,)�M�|���5�Of*Lj�I��򩍥h-JQ�Zxu~	!��U�svm���%d3��z�'���	�2�z��Z�o�>�/��
?O��A���-iZ��H��+X�q��(k�<=�[>hh�����(�/Q��1*:�(�N]o�Ht�'�`4ޏ��g��~��>��X���s�/�`rZ�҅��_e�=�h�_�	�s�/�����͑<�1�I)a�^4���Gv�*��r*�\X�TU���R����]N{A@��ހ�J\��T�`:����X<Юh��P���@�&Q{E�-��}Ή�V*�=6PG�B�~�� ��\i}�-l�_�녗�$�G{�0a7 ���cV��;�C���0��_���{+�_H����r[j��_�$}�ߔ�!��ۄ �$5��ݙM���<�F?��A�0,�Q7�/����e��o�����$f-�Ńl��sZXi�h'Tˀ���t�q�4�d�
௬��U���O�Wm?%��r��%��vV����h�Җ�aNe��4�8�5�
d��f���p�ʂ�nO�lB�<>���7�y#��Q��F�)Q�di<M4�V�]��w0V#�#���<�hrs���7�5�������n�9��M��	�$��`_�)�t�
�loIcx��&�_�?��0ɷX�nSF�s�mB̰Q���l̥��Լ�PWF��s�Þ��^y�/f:J��#88D�����薑�����懆����L)�y@��!\��h�*�V3û2��܀׆l��V�bQ�x1�X�lNe����%��xc�`0��zmc�)��X\QK��
�{3��̵!��uE�ݨ��aJ�1	NG�k��y��� ���2UD��T\m[L����v2�'kg���S���c��8LN�y[�Kw݅�^^�aK�g�,����2�
8�
�}�P|�]j<���Ķ�1N��Y]��M�{���P����%}�,�����q_��5��D�V�M��C��ĺ��.K���{�;�|�����˛ ����o�4���Ze�&�6��|�5�_��W7��V��ވ�L���"T�&D���|f��w�zq˨u�`�����p����xA$n��ǜ��[s����+��G��!m�Κ��2�	���9��xJ� �S���,�k���K��uT֜���q���ڼ�+����fU�4���yQ˅~]w�$���UNR�m�AtG'��M�(�CC�EW�R�(e,�{C�8���b���WT��5┲]#i;ˇ�K���V����
��i�����+'�d������K��W�b��*ʖ��,��C��OQ��pn�]��v2��1��;SN�I(��������w����G^��%�gn���?�����^���V�\��n��ts�
�H����bZ�b^�a�k���ž���~��"�T���ݍ���&#��D�������5���Ę����\ڴ�7WO���T�ݟv-��ǁ�)��8��iȨv]�{�������rW)�����KD��&�+��T���P�rV ��L�� �2�D1�pX��8�W14�d�N^9=�x���b������:P�T�Ğ�	}�췛�y��)!��%*�T�~�>!��;�����Z@�d�`0�a�"�z������?�*nL��Uk.��������n�vD"����s�[�2���	�	&CT�NFΙ�EV*;������oq)c��04p��ʹ���m#h(Pv�� �sΌ��WQΞa�u�n���Œ�lr�s�Nc�r��	kX��t�ٛJh�����'8�����gjE��|y3�����F�JX�����Z��Ç�}�6Qe�(�]K(ֹM��	3}�
���*��X�l�Q��<��� ����ʌh�E�p��%��y��
�P��<?%b=��%8'�����er�K���1�t���e�E�$�5���$w�?��T����:~�@�Ǝ�M�����f{��ȶ��t�T����r��������w���?o/�~�km&�| ��1��.^��/�����#���R��e�Ů�.R�Y��y|j�Y��y��6%�ݳ�ԘѨ��/��ǲ&����Er�>$8o?�7����B��\�f���q���q�X�W`@�A�}Iz��MHF�R���?'�`��>����^6p���y5���h�đS*� +*�'�`ah9�(%qw߳7���{���<_Z����c~t^R�McV������$TK��l�p���h�����ADc灷��1�b��
Jm�� m��� g�4�:Y�ʔq3��1޷�C	ٯ����,橕#���u�}"A��]��z�s���Lz�#K ���i����H�i    �EN�"��A�T��Q`B&b�G�!�G��ʤB�6�$�1'�]�:u�!g'Y�lw��#��RNn|N��D�5]�͖�^��K|f 0=��2��y��62.,������{�#1���9-�c3��17s�_o�$��'�ذ��gX�f�{�!YEkS�EA��=� �O�Ø5��b&e�SJ��Z��EW�"o�D��F�-?$m5/*�L���1rz����z��-mAE� UT�tJ47J��f�Y����/��0��hgm}�?�򍁑в&|����k���"Ϩ��eC�a����O��MָyN��1��!>��m�T��ۙC9|�#%.�wA(�-�x/9o~���	��D镃K(<����N���ڐi����ܯD�%��]�=�wY��<2NJ+�Z߀�˨��橇�e�F�P�O$�	��/�T���A�-����B�GXxzB[��hKN���B�P*24��E���0�\svtv0Ϋfe*a׍�K��Ni��n;��@?t��S���[]u����[u$$w���abEnP�X�-s�4����CV�a��Am�T���7�ms&J/;i׮�������:LK�`�ʇ	�(@���j��mf	���⑬�]+u��=cM��m�@�a�䭸Q�E!��Dc,�l��ڹ�77!X���vs�֝H�@�<7��=�:N����n�����Gx��hgM�=�?wѤ!�"!?�W.�7�{K�� v|���T�������T(�Ę��1)�Z@�1sZ�z��x0�"A���,��u�[�$��'�h��V��o6������y�#Ҵ�%�R�/�+.�w��'U`"�r9���^QrU��z�Ũ�5ִ��r�������/~d�~��V0�!E]c��5q��n�v.��e|�<�\B��xfH�M%��k�EWV���4%6rV�K<�DZ ��a$ڭ�5HR��萴��R���K�������ru5{�bd/Ȓ�Z��Pmla�����'j�WٕP��cv���}{�����fc=��ۯrq�H�ڊy��̛���_;�?����KQ�X��"�wԊ4�4���ۡ�-��|���{ُR�o"�;�=�;D���@bX
��Ú�c!�8�wW����ȝ��܈y��c-&�E1nw$y��QD��Ue��vƥnE��YK��9���n�6���d�ua���,`�z�U#�d2�{�D�|�J��/����r�7.A�����uЅ�v!k�V�Qrl,߰�ݫg/�{��)me��%�wΘ�u�9쀸��i} C��:�[�@��RZ*s���Қ�D!��1����:����ݫñk�o~�q�8��Tq��4��-�4m�4�����)�9����ͤ���˜�]���<�{��,��W��ᷬ�v�gf+���v	D���a�����je��~[�,K ���?9_8@�c(4.�-���"�~jf�p�J	��vX�#�V��T�y��=Ba�([����W��,�"m���,0 ���M�����9c�)N�ל�P����
0mIH��{y������/�����ϧ����ū��Q d���^�!���P���#�'��N���!�ƿ��\������0LdTe��\�g�����a�}���R=γ&}
:[%�/��M� ��cc��������{�����'��e[��;	��HT8��n� V� Q߬o��Xo�Nh�Ih^ƺ�9a$d�+�HSʍ.���Ưq�3�|Z0��6�3�����=(Zg�V$�� Ë�zC\������r��D"/t/w $з��H�~���pKB���:H} �����Ź<E�բF���f�Q�D��'=r�U1 �v0Ї��{�nDN�)�⌌���Z4�_v�C���?$5n���4��j2*=y�{]L����z�W��a=%����R�&�lƒ�̑|��Ӆ`�sg��po�Pݻ���+d�R�/A��M�s�"�6�`��*ej�z_�8W�	�0��0��yw(S��l1s`��ř�'8[(��믒�?��6�6p�*��J�$��6�B��t@���"�C���n!�m�VT�)����L>�� ���z2跒�[�Q��SPa��#�%\�"�g�B�������\�N^��Wk�oh6��<�^i�C����/�ف^�=P��)��`�B5�-Ǒ����ONM�	���B��Pʞ����B�g�����^�u�F��C�O�k��������.]u�O)���.� Y���s��U� ԟp�֫����n	4��p2���Ǆ��^ǧo��ln��c��e��]2�Z���g`�g���.�U��c�[�m�ͺ ����p�po"��\K�q�8����훊��5��C�VL���_ 6���>l$i�Yb�|�V0Q(knaYsZ�D#�pM^`�^2��e�!B_ ���g��j��rM@_��\��z����B7��G�霝K��P1X��k;�g�x�.�Fv"���,2�'��r?T�u*�����HЇ��~��m�Y̮#�6�$Cy7������u�9�'�4~�J�6�\R�r�櫷��
is�;����]��u�]G2R�)m/;���j$㈿�Y�t{��:!�B���ri�m\
2J��$[��,�Z�M���i�HGf�j�h0P�x#*��mDA�_F$�DF�cEۇ�}ugI���һzr�.2�7��F���@�����S���H߮�*|�,%�����	T�EQ\�~���6[P
<Y�ˆ����_��@1��à�uw�L���5�tl9����*����I�7b�)
Zm���2Q�6�XsQ$�q������+L���mDŚi �`A����G���*�'P`�wr��O�|��+�ᎎ��%��M|��D�h��A v}ƪW���.``����Z_���u!j���A�lcM4�?Ҕ"�E0|���n����8P�P�P6g��������>��U@Q�hkts��y����ܥ�m�9D�����%�~���8�JE�Ab
��4�$_���!�ΦĪ ��	�C��1|q2\J �'8l�����!�:꣥'iK�	��!�&N�H����ߞ�z���� ����
9�i�����CF���Uq_���j�El-�o��"xa"e�<�u����&3O�@���5���^�a$s>��6�ű�eH`�(0��>r\s8j}���pJar���U�[�<�V�XU��46V�ʽ�c��=ѝ"��g�oZ��ŀ��"/K����B���i:���A����!�� l�U��l�-���H#�t�1d��Z���U�J�f��SX����Z�ȍ�4� ���@z��n{�N9��a:6� p�|�6�/��M� |_coE�X�3�3�AQ�w���}Gv�о�=��H�S�;�$��k>����^�ӨS�NYEv�?����F��=.�WS[��,�wM�%h3�4�� �U��*�Xqi�$	��&r��&�D�R������0�#ր�n�mǜ�lSy�g*o�w�y���fc&�a���A�Cj7�eFjL�e��go<�B��GRM ����$��H�������0 ��0������M�����(6���?FO��_���&<'���i�Ѿ�
 ������~��qu]�����F��1�;��]�-�/-�Hʷ�.���^�;�ТK32Y��8Bp؀��''D�9�T�e�Fzc����SaSo�GV��9,�y���yQE��
R)p� K�{���>z�5��b6�N	Om�Ȇ�3-�቟=|��>��H�i���O�����A����:�Nm���1�2���M����:����0tM�{`�fq�Z�&��i-�c��Z��cL�j���h=����h�	�m�!��ZnK_pf�o'[4z"����*�~^�F]"��� �`�ԝ. �]���c��D 
 5�˳��=��G
HU�3Eݖ5�X�g@e�[Ê�&����F�����J��� � :�a�ғ�
�o�	��a�_5h��L�����o�    �8�,~���y��KXM?/���m���pr�aiaQ��3+�l�&�=�����|lk�tofQ:'N���yǪ,������rA�Y0GU\�@�$Ծ���a�U:�d�Q�-����)��A���m��4�r_�VH��W�ߛ�p(���/�u]��.�t�
BB�r��C�]P������I��C����J��D�n!��c7���(�ʎ�۴�bs�c��}�ӗ���T^<Nb����b��8�M�p�Sp�|~.�!��+�&�"���H��ީ�l!��aH^�%#b�a�I�z艪���h k^g8i(®]2"ɴd��y����Ɔ�Uԃ�`�^yg�6<�Z�o��:	�^N~��Ý���g$��B��/V���Gt����Y�L��@HG���%_a�����8����
����(#���qK�Tܹ��,V�6�3!l&4o�œڻ�̓���+�V0�4�e��e'��T�n.��-2W���RΥ;ɺ�m����� 0�7��OҜ������-��b3�� �'���M�����޺� T��_�z5fW$�(�Tk��sFc�Ϫ�ܦ�;��R�zr�BVJ�a��\T!����D�X?/�D�_�9��1ŋ�����dl��2ٷ^���s%m�A��H��!����
�b����Vg�^�ٮ��R~��6��i��'��ƧT<����C�P�È��ʣ��q���q��mz�R���}q�Y�	iՏ�.� >$j?ZYnk��n,��wu��6�s7�䂊cx\�ȡ��9��E�����i∫��B:&�V�c��ǒp�Vj�Ryǻ�%T:�I�K��-�0!=�B���~�>�������؅� V��t= 9/�6������MIfG-ő��4�*�Ϧ�Y�mw�z�kv[&���tNX|���+���^�u���;�^zh)�__�к��o
�À��4��ɞS7"r��$�듦��s�K�K��E�re����ԙ_[�ㇹ�~�����_�BEi�C�9�C�X"�Й�[��,�"Tc�K.Li��$�W$���"8J�Ƒ�]c`Ed��)���Y#�~R98�!�8�E�J�᪞̉��cKO��{��JA�H
v�2�� 	�&Y�P
K�`�ՍW�k5>�]����#G-2늤��8�%}�@����1�������~�f);'f�ݽ�@P�0m���f%�*/|��T��ф�ר\!:p�t"��@?H�\���z�}�v��D^!������u=3N��]�Ý=?��O?�Wm���:�w�l�Jo��a�O�àD���m��w�����(�
�*�B{��0��-
pD��p��8#�>G6Ov�Jى�*��P�x?�����eA?��Q Ωa]��_��)����6F�K���d	��ƹy��'��H��~jY���$��|�b�?@���9)��Kg1�SPR1�$}�a��n��C@��P�0�N|F#��͊��|�?q��	�g
��& ��wO톷�QՅӜ��J�2Z��w���)�B�q�V���A��ՙ�i�J
�2?y���]�����J�U����I�\�n���
#-��Ż�$m"�:R O��Ju�3u�=G'��N�^
;K �iP�n�(d�[�s�N���$���}�RE����
!���T��Z����+͂�Xf�F�l�I�r��X\����am�Y��B}!���Ϸ�̌��e/] z7!,��n���` d:����K����Q-$�|��ig�g���̈�u�A��4>�,_%�4���м��{�@�>/��2N��H ��u=ٲSXx>9P�z�~P�1{T
Bɥ#6������n�"q~�Q�e�Z#�w�%�}c*��։a$(b������D���04X���}J��I��N�7�P��zJ8,J�`t�����������p��t�B��U�^�eF�>ȳ�T%�ǐ��D�+_�~��p�|Y���>~]���@�:x��	�WN���|N����)�rAƈK�iz�g9�qq M,�9-M���@;���e�/H&�@��ζ�B0U��օ�P0�+���r��[���[<��Q.(%t�Q^]��s�w�A<�������2 ��ȣ.��g�+����4>�j��u�]��R�F=���_���T$��6���:+����q�*dQ��f�/�5�ܬ������d�+�7���y�@�jXf;4�5e��mO?cw�u����b��K6/��}fx�sgJ��� |G~���A=Zd�Z���G~� 6���}V��
p�$x�~�W��\�_�&ؐ~j<@F���ʬfU0�J�� B��A:P�=�ਣ�9Ke�ǳ-�S�rQ@���hS�r���.�h�ro%�k[25�"�q�����Sp��t��T
`A�gkȥ}���$��W̱lPM�Jr��w����@i[�P�� eYp��b�p"x���ӘQ���8���((^N%��j���8c��8|F�˶���Z�ispcLR�&�&���.�"�?S�E3e�L��1 E4��cz��*k��7��$;�x��t>;��*��9��O��B�~���n���s��s���%�a8�[��y
-��.���� �������c�M�>/ׇ9��GY�y��PZ�Z0S���$�@�>ѿ���}ʚ�mD7�2�r�tyZT�&�X%�/��Ϧ�gط9>YJ�g
:�@�kƆ� \�.N�j�o�eRB� � w8!�r}�f �Y#k�o��������쓖$Oh��wJo�ue���yO�>R��j���U��ݖ��A\ƥ��������>������}pNmu7RJ�%g D*b��D��u_I�Ф ��H	x�˝d�_��$�rz��r�T��0��>���G5*M+3,`�����&��A惶W'���v���ɪi1��WYl"ѤC���7��G�ס1�0��j=�OI7� �!�����R�
ܔ/��IJ}�e��A�mј�7�N�a0�J��\F�9(�3�#t���z  �6�
��<�^��H�+2�i����~WEQ��w?� ��fw�B�%B6��>�7����Qp���)	��U�1��W�e9ťFd��g�+ן4Wi?��FR5�ڬ|�h=�krUR�'���%	��R��fC�r���u���zv�����V(0`O���G��o�Dq�~���1z��*��Z,S[��b�X<���{XGʅ��a>�h�֧������Q��2 G����%�E�ZwZ
�؛u��v-d(��?�W�G�����~��]|���UR�Ԧ�K�G�V�	�%�J��R����u	�\��6T��Y������pyѿ���b��I�d�݌ˑ.�B�5�Q�y���}�����܏�= �)9��Kf�W��m��/���=�[���K��؛vH};�^i��`]���|��E{f���֮N��ۜ9O�fT�>d��?�@&y.��y�^�n�G��7��@���!\y�p���%�
V��r��>�懾g����t��>�jm�g��%�A��A3�2��:s��v�J���	凃�����J#���.�\���D�/�d�^�D7V;1}�Y�M[Y�$�X{�]����`��iy�yd��'����e*0�l��}'��� ߱��(����z��tw�/Faf&M/t���4T��¿Ug��u�vr�����'��Vr'��+�g�p�ץXT�8���t��n��I�w�|�?��}��u� ��)/��zu�� 6o�����j�qb���[W]�Q˯��v�&Yꂌ	#�I$Ύ�d?��ac�	��k�u�`������I��)~=��'��^�K�V��U����֖��ϲ��n�y�ua3sQq�ݠ��7V<F� ���%�R�7?)��V�N�ܹ>����W}@A ���Yu���/� �#���0�,�5���")3�9�������"�h�3?�W�����<T��Q�s��b��x��og��R�X��`$�)IZ���c��/�I\d�����[������e    �o��h	�{d�W�疠�S�w/|��.���,�z����V��y�&٣)Ay�LY��kY��n{<�L�0�B�wb��shڋ�(��@g���r̂�n����p"�̗�ڈ�g���q���~9�Rw��ћ�>[q���z��5��h=��R�s�F���B �TW�KGpα�;�ryP�����v�z�K#�S��C% ��ݴjϖ8P0Z����T�J��%a� ��]u"�/#�G�j��MF����1�]ZTG�=7�a�=�I�۳9d2�!�`dVſ�8�V���.;'Í+s�'������P��}��Xp�����*oە<%�cq\�;d	11�,^�ƅ#��|�U�b�UKw�3�*)���c+�X�����~�gh���������1�[�*���%2Ȱ�� qV�d-H�K1F�P,��ض��-
���"/������OML&Ɉ���c�"�=�P�b�~�>������8r��Km�����u�`�Cp��W{[r�J�V\�xǵ��^B���:���P<�-���CJ�~�:�h�؍�T��AG�@�e�Y2��@�:��$^����P�9�;�	H+M �w�@��Ѐ�t<��}�%ɐa���$:��Q�������Ԧ�Pap}�_�u�yB-�2U�Q�c�uI��<�{)@��z�˙�\�e��H��i�c�As�%�n�ϠnEU�'��3���L�>'���>�kqv�AF�SR��R5)��E�
P�������Չb}��U�}7b�`M~UsT�,x�薝k�\�Y���"<�/��A�q҃V�Ϸ����b���=�ʞd�le���:�!4��JM �m��ɮډ@�~����ty��z����X|�i����� c�c�U��&����9-J�p;&0ʽ-&�fW{C�/
qzv���S;F���$C�q�^���ꦭ�d��~� vuF>�PkGſG�V��v��=��|S!���F�Wh�p�� �x�	��c�Z������.��I�)�����.1LJN0�������o�Z�7�'S�ZQ����~Qh��������A|e�����/_�ͱ�.�~S�WC��q��`S!���3o�&,T�c������n�S$�CA��L�n${iDWM��g5�	�����E1;]�/��\*IAT��]}z���[�dU�jE�:�8IN~&�,ќ{�O"6�\c _���h�|c�@��t��4��a���~�3�����.7�n�����[����5�)�"���D`O��吆X��`�N���N.�#In��e�ق�8.�m�K�3/�Ws�aw�Q�^�q�t���4$	k֔,[қ�����c)��,�K�g8�
�ec�<�?K`��F��=&��/ T�+n��3{B�����=���]�L��t�ccqҭ�%��X&�(����Y85�i:���w_��g�b+�7���Sk}X�0�#��k%)��(*%Mr�\J>Ŝ[���~��������H�����i�?dR�'��\3gmp߹�����ܐ��x��fpD�ި�oW����M��tʴm�R����z�DChnHn��S�b�w�f#�IF9���MS�Fк�
>s5�a��������-E��qI���+��H�>n�)JR�<�B�2��ꃗbi:v�j^󤟓����Ĥ��p�b��$�gt>ƀJ�T*1�0���5�ѹ�&w���oL���o��_B��]ˌ��$����T{$P5΂��3'R��nrC]& ��������vת�Q|�����B�|�,�,�va�XB���{U�gf����BVި���,o��?YJ��i}>��0�M�����ބ���^Kp�oD��c��f�Q[!tI�	�d����v��!3ǫ3�9
���~؄B�c�6�H�����#��$�I4��(_�Y0��y�X�hQxj_�{E��gi�-�	�D#���c$1#�(4y��b �~����.��� �M$1�2�6ݹ^F�.��Ӥ���s�F����ƽt��y���IU�gŘGLa+N:{��j��Zy�~+}s�������������i��aȋ;��Z Rt�����`��F�E��8�6O�\v4S� 1�P�\܎�9F@0�t"���<�t!'�\�yc�b��D��~B�}��Ǭ�6���!:߸���7��@�~y�b�[����B;���"�|<����/����C�U2�z�w��@�"%�t/uu?y	L���� �� ߆����1���<T��9��aΒ��ԋ��s����8N�jβ�ͧ�o�?��%�!*�̓�ͪ5zl�g�Dn���R�UWW����a�,ƏlJR�{o����Y\` ��<q��5n�K��ϭ[B���ܮ;�4��Rr>y;�n�f�TW�� ���H�r�%`�l�U+��d[����6.���ק|Pޔ�!|@5<��~��u�w��Έ�#[�gy^��N���W��x�$�����_��A^�=���������HgMϬH���$�W���Q�c��#D5�Hז��^���KN�ؒ�p�7ݲй?�����Y���C��4���⫅��(@K���t2�b\3��s����;քj)0-�c�cp�ț~�����ɲv���H�6���6瞏��"$CH���`Ly��c�~��H����0��}�����r�_�T`�Q�c9 -,`�QM����{�0����<ٿ�7��$���/�'��@6����
�?]�,���׵��Z��r�{TZq|��y�N���5�2��Z�z-I���w>&�?�b�0&<�ǀ;V�������p �z'}?øKa��oTΔ;�������Z�߉��&�]�LU�+~��R�l����-������d𛁮����h��#�{D?K9 �C��������vYW>�es;�[ds�>��ch�А�@�Ub�yx�b=kŮy0�{�U�	���먼��$�6C���˄k^(�U��a>e��m TF�Z7X-������P����<w�	�1�ޚ�U� �\W����G:���$ڌ:@����hf������A~���-�e�_+u�J��9�mP��������&+�= ����鍊�Tԡ;��ݍ����>@ޗ����ʆK������ȡk`�ŷÉ~Y^����ـ@�1�*9u��n��Of��G�P'��7%v?������D�jF�ζd�J�d���&R�L,�&�r<w���]�����\gk����r%�Q[�X�JW QU�g���C��Q�y4Zh�V_4�_���%}��Hz^-����/WTx�"�K;�+���)4��tF���e�k�P�G�
VQԎ�a��V�8Y�?�DD2sx�
��wd#���[k�Q��T����Nh��Mʝ�v�U4֜�M�=>��<t�S	��<`A���aO�:�+���&��vd�e#u��y�b��D
h��VΔ~��ݎ3'J�	?)ۛ|!&=�mN3`��K���(�"�\�[ۍ˅��]�o�b\��g2�z,��.��͈K�ð�.� �W�[A����|H��������t�R��`�0�j{�%k⧜f���ˍ��{d�H0r��� ���A�C��w�!���ڮY�愃M}gL�Ŗ�' �(2��wI;������K��Uq����h*[��_/nO�jr������DR��K��J�]�p�DAo+��"0!�є\0Q�/9�X���f65��[���C'r�0q��}p���Ͷ<��I�]X���� &�J"���rPC}����`�!�A�Fl?���-ݛ��	���X���j{e5N�^ݛC�E��ֿ�,��EP��)����q�����w�Ȫ~Nk�{݆	�9�P!=J8x��W/ʁ<��=S��B�¤W�(�����'��
�4	��q)��.O.��ؾ����yEu-%#ַZ[?�%�T3����]ߛ��OQA���X��B��ay;��+�ɨ@���W_��X�\���5�,;���(��-oV����2 y��Y�Y���i��6sd�1⊢E9P�ںͪ���d, �  <Xw���-W �N�Q1�TŨ�*ɕ��,�b��7�� (�SQ%G�������_~�G�y��f��H���Qq���:���z㮇��|N��e;�^�s2��|����7e!X�Ê�g�J�q�:H��7}�� ���5@�� �4*Rq���]cs��%a�@, #��1	ߐ<0=���\Xl
��¿���q�%cZ����kti�(�6��F_�m��[�T	�駽�[*Z��g���य़`�"`.;х�i�J���slz1�{�I��Q�Z��p/[hK~��ZP��p{~f���7��Cǖ��9A5�����_"I��bz9�S��Y��K�U��X�� TB��(c�^j��ǒ�~Y����Cȁ7d���Y���o4��dĜ�L��T& �P�fu�xDū;��_LS1��Zfx�ö��-�b����)Α��-q�I�H����JÁ��Ͱ�*){�l0�g���y����s�-�={�MHc���- %�ja#.߀�/P0&� >*�,����O�f��
+���s����®�؎���om���'s#X��U�Yp� 
B��=�ڴIZ�Ir?�5�Bǰ��ea�0��l$C/����B++p���]}v���R��-�
����1l@�"��]:�����-�
�a�S���@�Q�	g�ve��ڗ[��ʶ,��{gҚ��dނ�b�HD���J�p��I����y	wC��d���ӉxK^��#1=n��q0��4���*���\GN��B�΄����8�MQ��k�8��e�˰�.cX�<�~U����f����[��C6�qe����&������Yq�:ܩ�)-��mn���Y��%Nϴ�"����J��V�r������\�[ʄz�'`��)��m����h������{cb%P� �{~�i����ע�t밴(~seU����f��X�������繭8 ����� ���_��������Ex�@�o��;�PɃ��v��0b��͍�A���~�i�tms����w;*�u��Wx����Zo��s���!��	_o���Xz�7u�V���:U�7�a�r���Ţ6I�IDb?��?ȉ�0ܼ	Fx(p}�t}1M�����H.�XB<!��+ɜǐ��X��d?�N�S؎�3���q~�:�r&Z$o��?�+ac��j��C�tu��_a������k�"!�q�/@�'�a���S�-?]�`=�Y�M@a����k��d�k������0�|�X��� s����v�R���*I���I<V$yÔ��ƄT��c�?��7���`�����/(�'A��Q���(��"۳?�1�K���l+)�_��e{����=�凍���[}:^�9�'.@���	��2#1�ᧂ�8�b�֧r��΍��S/g����c>��z���gr�]�ٸ�*z���華g�0�������zh�y�����Wo�cly��kG@��VL�{�j_lt�#�G��Q!8P��F{L:��k�]i��{Hث�Q^��z��*�H��GT�D7����UR�vM)k�%>W��Ƌ�q%Tq� X�����a�l�U�r�\�x�8�6�d���m���,��L���T��7�;�L�"F�}���`��ո��Y߿����2�WK��ovGQ��5ײ���i+����^�C`���.k�{�����v�D�o�"�RK�����n����w���}%&`[�q搷Z-��q�Y�D�{ؤ�s��1�����L+:��d>������'�,��'�]Q�yq�
%s����?��]pCOo��i�:�><�0�m��hhA�/��bח^�~ԉcY�ۙ�����~�;>J��a��S7 ��2��G���v[���b���o�y�1�����5���/\��5�4.�����QXe𝈧]ƻ]�uQ�W/���* >�>����iB#��o�3�8���8+��"�ޒ����R�3C�~7[�ا��~26s�\W���¤o@�`��U=�$��g�o�~Y��*(�V~d�3q>'?�Z6�N~���?�5dJ[�m���&,+e?�]���*cs�󫎃�f�a!"��ik�R��ׯz3Yq ���@  ��I%�F�	�M�� 32u��SB��w�$��2P�Ua�YѪD�Dr-�Z�0�҅2��u7���2s�X�`��X����[8��aG����|
��Y=JӾ��w:!dA~����J�1=�#��:���u8��
�#���xt��S�������5o��1�7�����o��]iMc_��f��!�_!��D�D�]_"\�R'��;���mC6�u}5������[���Y
�ҏ��Nޣi7��Z$�q�͹�Q��a~!��袭�Lt�8�e�������s�Ku����T�霼�A� F�Ϫ�g �.
����r�BI����J��!���ڠ�F�X�0�O�7�+^�l�a�e\�#�g˴���I�cD���'˽���^I仓�旊0���kDl�ƹ���K` �}��[Ԩ�':*�V��\��Kw�:�쉯���jeC���q⠍ZTot�KG�wK��'?�d)��65Y���v  �����i5"� 0sY\d���E�KA\N&Ր9�뫮��茅�*C��_C�5|1��'Q�����
�}R���.(�Oce���LRD0��ds#�L{�F�+�������ސ`��x-z�Z)��(xzQ;��4���p�z�ǒ�,������I���O�����@e*�]�� �a���_PK1Ƞ�(<��a�4���ãKm�*zH	9��_T,W������A���x�t�����50�p�� �qB���6�{�L����!���V�G�Q��t�����}�WP�$�5���%�]��1Y��v�6�"�k��|Iz���z ��Zo̭J�Ni�~ìi�mqՆW�ПT��(���T���y�^օ��j{�%��F�|��n1���x|\?l̇��@%���(]Mf춍k��h��� �l�ͮ��BB��X��}�n �ǃ=���s��B`�_��M�+��F'G$��-;
O���;)�1��ޡ�5y�����	r�F˿����A8��;�c���TV�71eHF��zr�1����WC1�N{y*i�*���܂� �>ާ|�iE�*�a��k�z�[��bt��Ri�gQ)X�`�;�S�L�$uLR8~'��bX�t.��2 4��f}8�is�H"*�ȱR��[�p���6��^.�X-e~c�@11|B���]��
I���OĖk�`^�Q1���˖[D��`�#�Sd�[Ė��B�{�Ag��
dG!�'!S���0U�w<�����p�k@7U1씎��
_��e� �����	�~�o��Ka�#^)�[�K+6�a��+eY40�a�����h�
�����i^H�k��u�?c��o�����,�      x   �  x���Mn�6���)|�X��v���1Ҷ'A2l'@n�G���g�)i����c��U��ASv��ϻ{�~|~yx�{~��|��2��������g�/�_(n(OV'���Ck����ݮAS��d�"!s*vw޽��!x�)S$JS�`�vJ0���"�K����U�U�2��\�X��G�r~�����槧��o~��s���v��C
bM>�PZuzU�D:��y�8��Uj��͜�|��n �%�R��w�
��,����&��r���蜝=X�����k_U(���Ս�1`yY�p.�zt�]_S���%qId��:�'"G ����2��8�т�bo���8��"ʭ�1������ut�&�U;u� N|b��inD�:˅� 1����tYS�=���̳���{w����M��d�X���	V��Ճ�R�&V��b�����]��pHr�y��?lg���:""�FⲢZ{�ֱd��囫u@b�c�Z=f�ĵ�X]@-dI�-?�|�3#޲�C\��:��X��'����!JhJIdS�N�Z�8H��Ţ6]:]E�fW@lc����3�����:fTB*'�m�:!jɰ�����y��8W��{Ӥyj��1hYRckVdu�����%SL���$�i� v+IGc`��6`�uc�� �FC�:
h:���L*I�Q8 K�е�(�3g�~މ5����Zo�k�-��h�^�w���dY^Q�wF�ߑ�6W�@4s�Z�ykY-����d?���H��3n��N�p��w��V�����<�q-]�K�/�[�q�qUɜT��Bw�^�0iVܚ�cE��wL��Ƙa*�"�Q��#�����(pe��iî��Ԉy�0N����޹�����)�^�V�+"���r�w+U5"��P�ӯ[��Q�(�r>�T�I��y��NY�����0�Ű�J�YUɓ���Y�������UIV��E���z�v���X�E�_�뀌�k�S�m�d��|��@mn��{^��6���#.v����/�u@2-��oz�dqT/)λ�UB�4��M�GO*�=�nf).��r]oȒ��X��IvN�9�D���iax8�Ȇ���>�̯��R�Q�\�QN;�1/��������k2���Wy�}$�GQϋ�u�"L����퍳捊�y���*��A"�����;�������FU��n��;��1}���������1�1J���^��ԫ�}���D�5�nM�cd%7���D?bP��'�1�O�*@ҊT��=Q��
o��7`���"/�_�)��dP�0'��- ��C�1DK��8Ɯ kQr��q��aќ����������,;������΍����|U5u��������`�I�y�=u��H�ހ���Қ<&��Րz}��tj�}�%R$����a���O4��f���T�*�6Gؚ�s3�_�wŮ��=���:8�/��Z,7l]'�w.�!j蕈���r��#,n���1��?�F�      |   �   x���K
� EǺ
7`���$�2+��A[6��o2j�!���9 1d�C��,���6���҈9H.��vh�N��`(�/v��X�Xڻdv�)�ه|$���p�;�[�0�p��������:�>�=
MAK.�.S�U?��1�5�Q(t���l̾�ǟ� h�轣�~ l�m�      �   �   x���M�0F��Sp�t(֥[�f�Ƙ %m9�g�b�j"�見�}}�@���x�u�Q��$	���产s�B.aS�`Bn��Y@IR���j�ڦ�KF��l�T����&�=��4��-D[Zg�=�����Ct=%z7�e�y|�Շ7]�L1�I6�T���$���^��bQ�5�oF��g�8��7߻�      z   P  x���;n�0@g��@R$EY[��A��I���+'�S��4��'�D��6mzC�>�}?��4�V�Vj�A� >��ݘ�C��Pgƶk�A"�e^P2|F����Gd+�!�3�F.�8�'�9@@i6�}�{�Mc�6�C_��M��ڮ��cPЋ��|��YH�$� D�Xs�w�!Uz�E\D�/!j�
&�a
V(�\���K;N��fB�0�b9�xӥM�X,�G��F"-���/�.�<^K��6�lc��+�7lq�d� a1��3sP�L�$o�i-u��-���R���4��f�u,��"��=�N��Y�a�����@o      ~   �  x����n�H���S�"��|��9�h��n��^�X($���闒m�v,[�ݜ� �#���($�@�̪��׼\$���������}���k�������÷�ω5���YH��9�̒#�d�(��Gq��R����~�\ͫ��xW�b\]G�&qB�;_g�<��W��"}[��UZ.�eZ�,'����rpY.FE���݋����6`��Y qZ�p���ϵˎH�$\�3ǌ} �a��&>��fe�%q�ό9A���
�7��}�p(S����r�^(�$jc-�� n	'}�汋�v<���"�脚I;0Za����q,���ˤ����}�O��rLh�v9]΋q�����*�E�,k��W��}����N��:�a�J;������M��=�d������×����&�lnC��R�"A�b:���=��C��=����s=|d����3]����5P�u�����J�eZ�^Mf�o/��l��� ��s��E��U��Ev�x�2�2 �>�2u��g���W�bͧ;wS��8C��]�������,2��D�|QZd�D>3�0��"e��@���H���(^'똬��D�g5.I{.����Z(�ڠ4L�������J�DS�xI�ԫ�F���nϟ)���"(�Ūl�"t�;�c����T��0�6������y�٠B����΀�{Y7*�
��z�4�?Q�ʞ㠒�"�p����|3;� �+<����u�A�!�F*���$n1�S����֡����#�c�JgF�>��SS�Q�S��(>���f���hd�0�un��XS�8��8��k��k�n����Ǡn�z*�9/�����K�RFKs�D�y��o��O�f{>�@P�y�*D"��L�N1#R�#���)�=a�ӗ����-���=����[�	�\h�[��;w��1��� �R۔h������;ݩ�ʅ���ä5��s�g�����]v�`�� �I�~z����|��f2�,������z���h������uf�`��7�vC�L��So�S�})�,��Q�.�e�����Lק��Ӏ�dՈ�~.���%��Q��E	�Q>��b*��B�������Tj���EΜ�+���ϥ�RS^,iE���88��w��B�t�6�����m`��M���U�l�]�@CD��z?��h�?<��      v   @  x���Mj�0���)r�͟F�]��ޠ�@L	�uk;��8�8Qk���>��!���������N����ο揱�:L���Ļd��H�S�@X	�?�i�2��qؽ/���x�R0�@t��m=BL�Y=�ϹV�B��G�z6�9f @�+�f��+9��n�kR%
T*�f�c�X�펑m=��������k�/�"�xݞ5�ɏ-�s�����x]Hw���q�G/)
rF�NrCPc����J%���7�����[~=$��� �Vrm�?J3��az�Ao���yoV	6���A��m�E|���J��Ø���C�U�m      �     x���Kj�0�������!��΄!�tۍb+�`,c;��U�E[Hh@0�Fd ���e�\��%@�0�e������y��9RN������b�M�(ݞ����V����tf~DI�1ל!��jc#\+rOR]�~(�tU3&� 'F���J����� ()���U�Ĕ�zbC��u�#�T��m�Ƕ��pK������2����#��Rڿ!�S��񌅥�9T����n��n���g��y���8w�軘f�4���p�滇H�uQ�8��PJ}���J      X   �   x�m�A
�0����Sx��L&5mv��n\�)1`!��R��{����y���M��oX�;�Q�(l��ô�F���)�R'��)��cJy1�q����s~um�et��+�����l���6}��=�?O�El      A   o  x�m��n�0E���T? �K%kb��U��v�߯�? ��s��\o���l���qƕ6�0�^��6��2Qx���4�5{\����&2|�]��AY�Ѐ+�����=�EQwex��9���-8i4�BR�7-�����[{�K)���j)����}�K�+U�7�ѥl?�����vuz$M?��T���D"�
��ʍ���P8�9�>��m�A�U��EeW�2n��n���]���kX`^�/�c��t:�n�}�9ͯ��`�{q����TB�!�;���>���m���e*`2/M���m�Td_��!��_�w�(�ӿ>M����@�t4p~��cE���N��y����~:�� ��`      F      x������ � �      G   (   x�3�t,(����OI�)��	-N-�4�2�"j����� ���      M      x������ � �      C   H  x����r� �5>�/���KvS�,f�M��Q�XeK�vg���:�$��s�!b�%�m����E��t/��p��ί�?u�O� �o��&��(��01�y� +F�@#�M?0�|+��=���+�Pj�'B����95�Tjj�R����Ѓ�� 6��H��b���L� ,���0�*�տ�Ot��&nyn��օ,%��Y��m�a���\�zU�K�
�Z	7-R��nX��]!�=0/Am�3e���hૢ=	$��-og8���Rwv󍻋���x����h�����R�ץ+�A\hܔ-�{�e�6/
5m_�Nd��ǹy7%��D�G`r,e��<���?L}01�����8h��L��"f�C��-��s)�ՙ[��+⬡SHԴ0.�,���?�8@/t���V�'�ÙRٵ�����l�[aR<Kzdp$A'�*l(��ݢ�6/NME67�G^2[HS�M]0/_<=7��Z���Hg�N�Ύ؋��+�z>i���`5�*�1
�y'ን��"��;�B,7 ���+�����|S��~�ʥ�'Ƌ�/M]0/ޜ��4=��к���ɳp���K
��O�D?�������0>٦�c!��1�@�Zb��"������5��N;���Y|�O������bW�	l�d;�5���Ķ)ݎdz׵A�c���2J�E_�����3f���)z`b�Ds�nl�XS̢df�2W�~<����e!"�t����z|���`|$�9՟�+?^���E����Q�CO����r�����bV�DZi�a��q>ƯvDL̕h݅�Bѻ��M,������}�y�?n@�      N      x������ � �      P   ~   x�m�1
�0���>�/�b�
o�(d���.�(8[O�t�7�|�'ַa��
0�Ä9F��
a!:3�n��ۺ��D[�6�MDmm�j�}�pew��Ƈ�vp��H1AL�J�
�3�ϋ��P�-D      R   l   x�m�1�0g����R����ܥh�H`A��:Y3p�<B�6o1�M��ގi�B�`�#a�n��bJyŘ�D[���|?�q���|�w��\<��=�5��MUwL�%+      �   �  x��]oG��=�"�5���|�Q�
B��*׻D�Nm�TU�!�:ޑ�!al�͎�u�G�9s��O����㷷����9�=�w8���a<����h8/&_��a�n�>N��|����Y�׳��Y8�g�Y�T��NK�:���su�q4��N/?�j�����Y_��Q5���������v����K]W�o����x�i1�뼾����{1���dy��I�鬞H>:B��#XFD�%�gǯ�O�Ĕ��E*D��'#�/I���ٓ)cZ��5mN���1}�Nӱ�w"Ek�.:Q�mQ�E�b���(�i>�"8���E%9c����U,�;�&dC�L9���Ԓ\��no�l��S���B�"%��F�t^ͫ6�j�!�E��U�V�٧���o=z�w9�G4��aA�]���ڻ�~%om�[t��7�����.�J�����)!����T��;z�"���Jl��J�n5�(��,r�E6:!�CH#z�F!���0r�䃳
�0����V�(���&y�U�ij!5Ub�̚�"�#���}cע34�����i��|�;�)���
iGT�F�H���3c)���x�"�Y��-��pXB1��f�b@�W�!Ql4���Xa&R,n\)wF�ZŃ�fP�$��L-�ys`fB�R����ToZC��	�9Od�Q���l?�wsʽ�VV�M��-xE�g�����]�n��'Y�5s �aT���i������kKl (�d��5�rw׼U�"���3�����ռ9�z�F�L�ZZ1�uY�Fr�gE��������K��#lM��|E��U)cL�6`\3��nT��a�Ys��"�T�!{��a�j�c`h��el��076Yx��uva�����h3��"��aa��l�K1�+�$3eR�S�����6��v��gB�B��^6�\��6;��4[��J��#8Q      J      x������ � �      H   �  x�%�˕�0��(�}���Ǣ8��.�%��O����~v��s�ڽv���zf��yv���;�w~������g��Ο��;w����9^_�&��C|�B�P!t�!=Ć�CT�:2��#�\����|��#h��i��(�<�G�{��G�{��)7_Oi�'5HvI˾�%���e�}w?�B��.�N��*��eߩ���j�LR��/K:��45MG��&uN����I��wD錊�8��8��8��8��8��8���?��8���8��8��8��8��8��8��8��8��8��8��8��8��9��9��9��9��9��9��9��9����h���ސ{E8��9��9��9��9��9��9��9��9�c8�c8�c8�c8�c8�c8�c8�c8�c8�c8�c8�c�]�����{�9�c8�c8�c8�c8�c8�c8~�=����}      E   [   x�3��M,.I-rI-K���M�+�,OM�4202�54�50S02�20�24�&�e�阒��G�cΐ����|�t�pf楧�e���/F��� pp3P      h   �   x���A
�0EדS�)��4Jv�(J��u� �Ҕzк������y�T���4%��ʚ�50�gZb.3 �����nH�QH��$��q�1Ap]�����4*��r�_��k�����{9��?w�R�1�a,k $���8�t�N�&���pA      T   b   x�3�t���MM�L��4202�54�5�P04�21�20�&�e�霟[PZ�a�k`�k`�`hbelied�M�˘�73�(?)3?'?=3S��!61�=... �#�      j   B   x�3�t�+)JLI�4202�54�50S02�20�24�&�e����I�cΐ���Ĕ|����qqq ��      L   =  x���;��0��:�
[3I��w��7����р�.����ܱ�;�T�h'q��KQ^T}2Rg�:�1<�#9A*q�N��mzW��EzS��5)k�v���z�@V5(it��p\k�>r�GI��{���9�'s�?�GN��}W �̜�_�}s����4�fcY��UU�m�J?Sy��oS��Qke��c~�����]J�K����o�fң�;l�ܘ�q��᪥��҃�R�*f��Q�0��=��(8{	�����K���oޗ+�<m1;�Sw�	�9��� Z�эw&|G�.�ƵZ�'��     