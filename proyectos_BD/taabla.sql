DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS tiempo;
DROP TABLE IF EXISTS transaccion;
DROP TABLE IF EXISTS sucursal;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS categoria;


CREATE TABLE cliente(
   id_cliente 	CHAR(40) PRIMARY KEY NOT NULL,
   cedula 	INT NOT NULL,
   nombre_completo CHAR(50) NOT NULL,
   email 	CHAR(50) NOT NULL,
   telefono	CHAR(50) NOT NULL,
   direccion 	CHAR(50) NOT NULL,
   tipo_cliente CHAR(50) NOT NULL
);

CREATE TABLE tiempo(
   id_tiempo 	CHAR(40) PRIMARY KEY NOT NULL,
   anio 	INT NOT NULL,
   mes_num 	INT NOT NULL,
   mes_nombre 	INT NOT NULL,
   dia 		INT NOT NULL
);

CREATE TABLE transaccion(
   id_transaccion 	CHAR(40) PRIMARY KEY NOT NULL,
   descripcion 		CHAR(50) NOT NULL
);

CREATE TABLE sucursal(
   id_sucursal 	CHAR(40) PRIMARY KEY NOT NULL,
   region 		CHAR(50) NOT NULL,
   estado		CHAR(50) NOT NULL,
   nombre 		CHAR(50) NOT NULL
);

CREATE TABLE producto(
   id_producto 	CHAR(40) PRIMARY KEY NOT NULL,
   codigo_producto 	INT NOT NULL,
   nombre 		CHAR(50) NOT NULL,
   peso			REAL NOT NULL,
   precio		REAL NOT NULL
);
CREATE TABLE categoria(
   id_categoria 	CHAR(40) PRIMARY KEY NOT NULL,
   cod_categoria 	INT NOT NULL,
   descripcion 	CHAR(50) NOT NULL
);



CREATE TABLE tabla_hechos(
   id_categoria  INT NOT NULL,
   id_producto INT NOT NULL,
   id_categoria INT NOT NULL,
   id_cliente INT NOT NULL,
   id_transaccion INT NOT NULL,
   id_fecha_orden INT NOT NULL,
   id_fecha_envio INT NOT NULL,
   id_fecha_facturacion INT NOT NULL,
   id_fecha_cancelacion INT NOT NULL,
   monto_total REAL NOT NULL,
   cantidad_productos INT NOT NULL,

   
);
