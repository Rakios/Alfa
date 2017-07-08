CREATE TABLE universidad(
nombre_uni varchar (510) NOT NULL,
descrip_uni varchar (510),
fecha_creacion date,
acronimo varchar (50),
fecha_ingreso date,
nombre_usuario varchar (510),
constraint nombre_usuario_fk foreign key (nombre_usuario) references participante(nombre_usuario)
) TABLESPACE repositorio_tablas;
ALTER TABLE universidad ADD CONSTRAINT _pk PRIMARY KEY ();
CREATE UNIQUE INDEX  ON  TABLESPACE repositorio_indices;
//CREATE INDEX nombre_usuario_indx ON participante (nombre_usuario) TABLESPACE repositorio_indices;


CREATE TABLE participante(
nombre_usuario varchar (510) NOT NULL,
apellido varchar (510),
correo varchar (510),
password varchar (32),
direccion_usuario varchar (510),
telefono_usuario varchar (20),
evento_participado varchar (510)
) TABLESPACE repositorio_tablas;
ALTER TABLE participante ADD CONSTRAINT _pk PRIMARY KEY ();
CREATE UNIQUE INDEX  ON  TABLESPACE repositorio_indices;



CREATE TABLE expositor(
nombre_usuario varchar (510) NOT NULL,
apellido varchar (510),
correo varchar (510),
password varchar (32),
direccion_usuario varchar (510),
telefono_usuario varchar (20),
nombre_charla varchar (510),
valoracion number check (valoracion>=1 and valoracion <=5)
) TABLESPACE repositorio_tablas;
ALTER TABLE expositor ADD CONSTRAINT _pk PRIMARY KEY ();
CREATE UNIQUE INDEX  ON  TABLESPACE repositorio_indices;



CREATE TABLE evento(
nombre_evento varchar (510) NOT NULL,
fecha_ini date,
fecha_fin date,
nombre_uni varchar (510)

) TABLESPACE repositorio_tablas;
ALTER TABLE evento ADD CONSTRAINT _pk PRIMARY KEY ();
CREATE UNIQUE INDEX  ON  TABLESPACE repositorio_indices;




CREATE TABLE empresa(
nombre_empresa varchar (510) NOT NULL,
direccion_empresa varchar (510),
telefono_empresa varchar (20),
tipo_empresa varchar(50) check (tipo_empresa in ('publica', 'privada'))

) TABLESPACE repositorio_tablas;
ALTER TABLE empresa ADD CONSTRAINT _pk PRIMARY KEY ();
CREATE UNIQUE INDEX  ON  TABLESPACE repositorio_indices;



CREATE TABLE patrocinado(
nombre_evento varchar (510) NOT NULL,
nombre_empresa varchar (510) NOT NULL,
monto number check (monto >= 0),
fecha_patrocinio date

) TABLESPACE repositorio_tablas;
ALTER TABLE patrocinado ADD CONSTRAINT _pk PRIMARY KEY ();
CREATE UNIQUE INDEX  ON  TABLESPACE repositorio_indices;
