CREATE TABLE universidad(
	cod_uni varchar (50),
	nombre_uni varchar (510) NOT NULL,
	descrip_uni varchar (510),
	fecha_creacion date,
	acronimo varchar (50)
) TABLESPACE repositorio_tablas;
ALTER TABLE universidad ADD CONSTRAINT cod_uni_pk PRIMARY KEY (cod_uni);
CREATE UNIQUE INDEX cod_uni_indx ON universidad(cod_uni) TABLESPACE repositorio_indices;
CREATE INDEX nombre_uni_indx ON universidad(nombre_uni) TABLESPACE repositorio_indices;


CREATE TABLE usuario(
	cod_user varchar (50),
	nombre_usuario varchar (510) NOT NULL,
	apellido varchar (510),
	correo varchar (510),
	password varchar (32),
	tipo_usuario varchar (50) check (tipo_usuario in ('participante','expositor')),
	direccion_usuario varchar (510),
	telefono_usuario varchar (20),
) TABLESPACE repositorio_tablas;
ALTER TABLE usuario ADD CONSTRAINT cod_user_pk PRIMARY KEY (cod_user);
CREATE UNIQUE INDEX cod_user_indx ON usuario(cod_user) TABLESPACE repositorio_indices;
CREATE INDEX nombre_usuario_indx ON usuario(nombre_usuario) TABLESPACE repositorio_indices;



CREATE TABLE evento(
	cod_evento varchar (50),
	nombre_evento varchar (510) NOT NULL,
	fecha_ini date,
	fecha_fin date,
) TABLESPACE repositorio_tablas;
ALTER TABLE evento ADD CONSTRAINT cod_evento_pk PRIMARY KEY (cod_evento);
CREATE UNIQUE INDEX cod_evento_indx ON evento(cod_evento) TABLESPACE repositorio_indices;
CREATE INDEX nombre_evento_indx ON evento(nombre_evento) TABLESPACE repositorio_indices;

CREATE TABLE empresa(
	cod_empresa varchar (50),
	nombre_empresa varchar (510) NOT NULL,
	direccion_empresa varchar (510),
	telefono_empresa varchar (20),
	tipo_empresa varchar(50) check (tipo_empresa in ('publica', 'privada'))
) TABLESPACE repositorio_tablas;
ALTER TABLE empresa ADD CONSTRAINT cod_empresa_pk PRIMARY KEY (cod_empresa);
CREATE UNIQUE INDEX cod_empresa_indx ON empresa(cod_empresa) TABLESPACE repositorio_indices;
CREATE INDEX nombre_empresa_indx ON empresa(nombre_empresa) TABLESPACE repositorio_indices;


CREATE TABLE patrocinado(
	cod_evento varchar (50);
	cod_empresa varchar (50);
	monto_patrocinado number check (monto >= 0),
	fecha_patrocinio date
	constraint patrocinado_evento_fk foreign key (cod_evento) references evento(cod_evento),
	constraint patrocinado_empresa_fk foreign key (cod_empresa) references empresa(cod_empresa),
) TABLESPACE repositorio_tablas;
ALTER TABLE patrocinado ADD CONSTRAINT cod_patrocinado_pk PRIMARY KEY (cod_evento,cod_empresa);
CREATE UNIQUE INDEX cod_patrocinado_indx ON patrocinado(cod_evento,cod_empresa) TABLESPACE repositorio_indices;


CREATE TABLE pertenece(
	cod_uni varchar (50),
	cod_user varchar (50),
	fecha_ingreso date,
	constraint pertenece_cod_uni_fk foreign key (cod_uni) references universidad(cod_uni),
	constraint pertenece_cod_user_fk foreign key (cod_user) references usuario(cod_user)
) TABLESPACE repositorio_tablas;
ALTER TABLE pertenece ADD CONSTRAINT cod_pertenece_pk PRIMARY KEY (cod_uni, cod_user);
CREATE UNIQUE INDEX cod_pertenece_indx ON pertenece(cod_uni,cod_user) TABLESPACE repositorio_indices;



CREATE TABLE participa(
	cod_user varchar (50),
	cod_evento varchar (50),
	constraint participa_cod_user_fk foreign key (cod_user) references usuario(cod_user);
	constraint participa_cod_evento_fk foreign key (cod_evento) references evento(cod_evento);
) TABLESPACE repositorio_tablas;
ALTER TABLE participa ADD CONSTRAINT cod_participa_pk PRIMARY KEY (cod_user, cod_evento);
CREATE UNIQUE INDEX cod_participa_indx ON participa(cod_user, cod_evento) TABLESPACE repositorio_indices;




CREATE TABLE dicta(
	cod_user varchar (50),
	cod_evento varchar (50),
	nombre_charla varchar (510),
	valoracion_ponencia number check (valoracion>=1 and valoracion <=5),
	valoracion_charla number check (valoracion>=1 and valoracion <=5),
	constraint dicta_cod_user_fk foreign key (cod_user) references usuario(cod_user);
	constraint dicta_cod_evento_fk foreign key (cod_evento) references evento(cod_evento);
) TABLESPACE repositorio_tablas;
ALTER TABLE dicta ADD CONSTRAINT cod_dicta_pk PRIMARY KEY (cod_user, cod_evento);
CREATE UNIQUE INDEX cod_dicta_indx ON dicta(cod_user, cod_evento) TABLESPACE repositorio_indices;



CREATE TABLE asociado(
	cod_uni varchar (50),
	cod_evento varchar (50),
	constraint asociado_cod_uni_fk foreign key (cod_uni) references universidad(cod_uni);
	constraint asociado_cod_evento_fk foreign key (cod_evento) references evento(cod_evento);
) TABLESPACE repositorio_tablas;
ALTER TABLE asociado ADD CONSTRAINT cod_asociado_pk PRIMARY KEY (cod_uni, cod_evento);
CREATE UNIQUE INDEX cod_asociado_indx ON asociado(cod_uni, cod_evento) TABLESPACE repositorio_indices;




CREATE USER admin IDENTIFIED BY 1234;
CREATE USER organd IDENTIFIED BY 5678;

CREATE ROLE organizador;
 GRANT select,insert,update,delete ON usuario, evento, participa, dicta TO organizador;

CREATE ROLE administrador;
 GRANT select,insert,update,delete ON universidad, empresa, patrocinado TO organizador;
 
 GRANT organizador TO organd;
 GRANT administrador TO admin;
 
 