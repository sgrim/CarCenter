CREATE SEQUENCE departamentos_seq
       MINVALUE 1
       START WITH 1
       INCREMENT BY 1;


CREATE TABLE departamentos( 
 departamento_id number(10) NOT NULL,
 nombre varchar2(50) NOT NULL,
 CONSTRAINT departamentos_pk PRIMARY KEY (departamento_id)
);
--ALTER TABLE departamentos ADD CONSTRAINT pk_departamentos PRIMARY KEY (departamento_id);

CREATE SEQUENCE ciudades_seq
       MINVALUE 1
       START WITH 1
       INCREMENT BY 1;
   

CREATE TABLE ciudades( 
 ciudad_id number(10) NOT NULL,
 nombre varchar2(50)  NOT NULL,
 departamento_id number(10) NOT NULL,

 CONSTRAINT ciudades_pk PRIMARY KEY (ciudad_id),
 CONSTRAINT fk_departamentos FOREIGN KEY (departamento_id) REFERENCES departamentos(departamento_id)
);

CREATE SEQUENCE tiendas_seq
       MINVALUE 1
       START WITH 1
       INCREMENT BY 1;

CREATE TABLE tiendas( 
 tienda_id number(10) NOT NULL,
 nombre varchar2(50) NOT NULL,
 direccion varchar2(50) NOT NULL,
 ciudad_id number(10) NOT NULL,

 CONSTRAINT tiendas_pk PRIMARY KEY (tienda_id),
 CONSTRAINT fk_ciudades FOREIGN KEY (ciudade_id) REFERENCES ciudades(ciudad_id)
);

CREATE SEQUENCE documentos_seq
       MINVALUE 1
       START WITH 1
       INCREMENT BY 1;

CREATE TABLE documentos ( 
documento_id number(10) NOT NULL,
nombre     varchar2(25) NOT NULL,
CONSTRAINT documentos_pk PRIMARY KEY (documento_id)
);
 
CREATE SEQUENCE personas_seq
       MINVALUE 1
       START WITH 1
       INCREMENT BY 1;

CREATE TABLE personas( 
persona_id           number(10)   NOT NULL,
primer_nombre        varchar2(10) NOT NULL,
segundo_nombre       varchar2(10) NOT NULL,
primer_apellido      varchar2(15) NOT NULL,
segundo_apellido     varchar2(15) NOT NULL,

celular              number(10)   NOT NULL,
dirección            varchar2(30) NOT NULL,
correo_electrónico   varchar2(40) NOT NULL,
documento_id         number(10)   NOT NULL,
ciudad_id            number(10)   NOT NULL, --estado

CONSTRAINT personas_pk PRIMARY KEY  (persona_id),
CONSTRAINT fk_documentos FOREIGN KEY (documento_id) REFERENCES documentos(documento_id),
CONSTRAINT fk_ciudades FOREIGN KEY (ciudad_id) REFERENCES ciudades(ciudad_id)
);

CREATE SEQUENCE repuestos_seq
       MINVALUE 1
       START WITH 1
       INCREMENT BY 1;

CREATE TABLE repuestos ( 
repuesto_id            number(10) NOT NULL,
codigo                 varchar2(10) NOT NULL,
nombre_producto        varchar2(25) NOT NULL,
unidad                 varchar2(10) NOT NULL,
precio                 number(10) NOT NULL,
descuento              number(2) NOT NULL,

CONSTRAINT repuestos_pk PRIMARY KEY (repuesto_id)
);

CREATE SEQUENCE inventarios_seq
       MINVALUE 1
       START WITH 1
       INCREMENT BY 1;

CREATE TABLE inventarios (
inventario_id            number(10)   NOT NULL,
repuesto_id              number(10)   NOT NULL,
tienda_id                number(10) NOT NULL,
cantidad                 number(5)    NOT NULL,

CONSTRAINT inventarios_pk PRIMARY KEY (inventario_id),
CONSTRAINT fk_repuestos FOREIGN KEY (repuesto_id) REFERENCES repuestos(repuesto_id),
CONSTRAINT fk_tiendas FOREIGN KEY (tienda_id) REFERENCES tiendas(tienda_id)
);

ALTER TABLE inventarios ADD CONSTRAINT inventarios_amt_ck CHECK (cantidad > 0);
ALTER TABLE inventarios ENABLE CONSTRAINT inventarios_amt_ck;

CREATE SEQUENCE presupuestos_seq
       MINVALUE 1
       START WITH 1
       INCREMENT BY 1;

CREATE TABLE presupuestos( 
presupuesto_id                     number(10)   NOT NULL,
persona_id                         number(10)   NOT NULL,
valor_presupuesto                  number(10)   NOT NULL,
CONSTRAINT presupuestos_pk PRIMARY KEY (presupuesto_id)
);

CREATE SEQUENCE servicios_seq
       MINVALUE 1
       START WITH 1
       INCREMENT BY 1;

CREATE TABLE servicios(
servicio_id             number(10)    NOT NULL,
descripcion_servicio    varchar2(200) NOT NULL,
valor_minimo            number(10)    NOT NULL,
valor_maximo            number(10)    NOT NULL,

CONSTRAINT servicios_pk PRIMARY KEY (mantenimiento_id),
);

CREATE SEQUENCE mantenimientos_seq
       MINVALUE 1
       START WITH 1
       INCREMENT BY 1;

CREATE TABLE mantenimientos(
mantenimiento_id           number(10)   NOT NULL,
cliente_id                 number(10)   NOT NULL,
mecanico_id                number(10)   NOT NULL,
repuesto_id                number(10)   NOT NULL,
cantidad                   number(3)    NOT NULL,
presupuesto_id             number(10)   NOT NULL,
servicio_id                number(10)   NOT NULL,
descuento_porcenataje      number(2)    NOT NULL, --hasta 50% a mano obra(servicio), cuando repuestos sea mayor a 3.000.000
valor_mantenimiento        number(10)   NOT NULL,
tienda_id                  number(10)   NOT NULL,
fecha                      TIMESTAMP    NOT NULL,

CONSTRAINT mantenimientos_pk PRIMARY KEY (mantenimiento_id),
CONSTRAINT fk_personas FOREIGN KEY (cliente_id)  REFERENCES personas(persona_id),
CONSTRAINT fk_personas FOREIGN KEY (mecanico_id) REFERENCES personas(persona_id),
CONSTRAINT fk_repuestos FOREIGN KEY (repuesto_id) REFERENCES repuestos(repuesto_id),
CONSTRAINT fk_presupuestos FOREIGN KEY (presupuesto_id) REFERENCES presupuestos(presupuesto_id),
CONSTRAINT fk_tiendas FOREIGN KEY (tienda_id) REFERENCES tiendas(tienda_id),
CONSTRAINT fk_servicios FOREIGN KEY (servicio_id) REFERENCES servicios(servicio_id)
);

CREATE SEQUENCE facturas_seq
       MINVALUE 1
       START WITH 1
       INCREMENT BY 1;

CREATE TABLE facturas(
 factura_id                      number(10)   NOT NULL,
 mantenimiento_id                number(10)   NOT NULL, 
 valor_factura                   number(10)   NOT NULL, 
 fecha                           TIMESTAMP    NOT NULL, 
 iva_porcentaje                  number(2)    NOT NULL, --19%

 CONSTRAINT fk_mantenimientos FOREIGN KEY (mantenimiento_id) REFERENCES mantenimientos(mantenimiento_id),
);
