CREATE TABLE serie(
cod_serie varchar(50),
nombre_serie varchar (510) NOT NULL,
tipo_serie varchar(50) check (tipo_serie in ('dramatica', 'suspenso', 'comica')),
cant_actores number check (cant_actores > 0),
desc_serie varchar2(510),
raiting number (2,1) check (raiting >= 0 and raiting <= 10)
) TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX ind_cod_serie_pk ON serie(cod_serie) TABLESPACE repositorio_indices;
CREATE INDEX ind_nombre_serie ON serie (nombre_serie) TABLESPACE repositorio_indices;
ALTER TABLE serie ADD CONSTRAINT cod_serie_pk PRIMARY KEY (cod_serie);
ALTER TABLE serie initrans 8;
ALTER TABLE serie maxtrans 20;


CREATE TABLE cadena(
	cod_cadena varchar(50),
	nombre_cadena varchar(510) NOT NULL,
	direccion_cadena varchar(510),
	presidente varchar(510) NOT NULL
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX ind_cod_cadena_pk ON cadena(cod_cadena) TABLESPACE repositorio_indices;
CREATE INDEX ind_nombre_cadena ON cadena (nombre_cadena) TABLESPACE repositorio_indices;
ALTER TABLE cadena ADD CONSTRAINT cod_cadena_pk PRIMARY KEY (cod_cadena);

CREATE TABLE personaje(
	cod_personaje varchar(50),
	nombre_personaje varchar(510) NOT NULL,
	tipo_personaje varchar(50)
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX ind_cod_personaje_pk ON personaje(cod_personaje) TABLESPACE repositorio_indices;
CREATE INDEX ind_nombre_personaje ON personaje (nombre_personaje) TABLESPACE repositorio_indices;
ALTER TABLE personaje ADD CONSTRAINT cod_personaje_pk PRIMARY KEY (cod_personaje);

CREATE TABLE artista(
	cod_artista varchar(50),
	nombre_real varchar(510) not null,
	estado_civil varchar(50) check (estado_civil in ('soltero','casado','divorciado','viudo')),
	nombre_artistico varchar(510)
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX ind_cod_artista_pk ON artista(cod_artista) TABLESPACE repositorio_indices;
CREATE INDEX ind_nombre_real ON artista (nombre_real) TABLESPACE repositorio_indices;
CREATE INDEX ind_nombre_artistico ON artista (nombre_artistico) TABLESPACE repositorio_indices;
ALTER TABLE artista ADD CONSTRAINT cod_artista_pk PRIMARY KEY (cod_artista);
ALTER TABLE artista initrans 8;
ALTER TABLE artista maxtrans 20;

CREATE TABLE pelicula(
	cod_pelicula varchar(50),
	nombre_promocion varchar(510) NOT NULL,
	resena varchar(510),
	cant_actores number check(cant_actores >0),
	monto number check(monto >=0)
) TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX ind_cod_pelicula_pk ON pelicula(cod_pelicula) TABLESPACE repositorio_indices;
CREATE INDEX ind_nombre_promocion ON pelicula (nombre_promocion) TABLESPACE repositorio_indices;
ALTER TABLE pelicula ADD CONSTRAINT cod_pelicula_pk PRIMARY KEY (cod_pelicula);
ALTER TABLE pelicula initrans 8;
ALTER TABLE pelicula maxtrans 20;

CREATE TABLE semana(
	numero_semana number check(numero_semana >0),
	mes number check (mes>=1 and mes<=12),
	anio number check(anio >= 1990),
	exito varchar(50) check (exito in ('Mucho exito', 'Poco exito', 'Nadie la vio')),
	tematica varchar(500) check (tematica in ('Romanticas', 'Comedia', 'Suspenso', 'Terror', 'Independiente'))
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX ind_cod_semana_pk ON semana(numero_semana, mes, anio) TABLESPACE repositorio_indices;
ALTER TABLE semana ADD CONSTRAINT cod_semana_pk PRIMARY KEY (numero_semana, mes, anio);

CREATE TABLE horario(
	cod_horario varchar(50),
	hora_comienzo varchar(10) not null CHECK(regexp_like(hora_comienzo, '^([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$')),
	hora_fin varchar(10) not null CHECK(regexp_like(hora_fin, '^([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$')),
	tipo_horario varchar(50) not null check (tipo_horario in ('Todo publico', 'Adultos'))
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX ind_cod_horario_pk ON horario(cod_horario) TABLESPACE repositorio_indices;
ALTER TABLE horario ADD CONSTRAINT cod_horario_pk PRIMARY KEY (cod_horario);

CREATE TABLE lanzar (
	cod_cadena varchar(50),
	cod_serie varchar(50),
	fecha_lanzamiento date,
	critica varchar(510) not null,
	fecha_cancelacion date,
	constraint lanzar_cadena_fk foreign key (cod_cadena) references cadena(cod_cadena),
	constraint lanzar_serie_fk foreign key (cod_serie) references serie(cod_serie)
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX ind_lanzar_pk ON lanzar(cod_cadena,cod_serie,fecha_lanzamiento) TABLESPACE repositorio_indices;
ALTER TABLE lanzar ADD CONSTRAINT cod_lanzar_pk PRIMARY KEY (cod_cadena,cod_serie,fecha_lanzamiento);

CREATE TABLE venta(
	cod_serie varchar(50),
	cod_cadena_vendedora varchar(50),
	cod_cadena_compradora varchar(50),
	fecha_venta date,
	cambios varchar(2) check (cambios in ('si','no')),
	constraint vendedor_cadena_fk foreign key (cod_cadena_vendedora) references cadena(cod_cadena),
	constraint comprador_cadena_fk foreign key (cod_cadena_compradora) references cadena(cod_cadena),
	constraint venta_serie_fk foreign key (cod_serie) references serie(cod_serie)
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX ind_venta_pk ON venta(cod_serie,cod_cadena_vendedora,cod_cadena_compradora,fecha_venta) TABLESPACE repositorio_indices;
ALTER TABLE venta ADD CONSTRAINT cod_venta_pk PRIMARY KEY (cod_serie,cod_cadena_vendedora,cod_cadena_compradora,fecha_venta);

CREATE TABLE interpreta(
	cod_serie varchar(50),
	cod_personaje varchar(50),
	cod_artista varchar(50),
	fecha_interpretacion date,
	critica varchar(510),
	aparicion varchar(50) check (aparicion in ('Recurrente', 'Especial')),
	cant_episodios number check (cant_episodios >=1),
	constraint interpreta_serie_fk foreign key (cod_serie) references serie(cod_serie),
	constraint interpreta_personaje_fk foreign key (cod_personaje) references personaje(cod_personaje),
	constraint interpreta_artista_fk foreign key (cod_artista) references artista(cod_artista)
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX ind_interpreta_pk ON interpreta(cod_serie, cod_personaje, cod_artista, fecha_interpretacion) TABLESPACE repositorio_indices;
ALTER TABLE interpreta ADD CONSTRAINT cod_interpreta_pk PRIMARY KEY (cod_serie, cod_personaje, cod_artista, fecha_interpretacion);

CREATE TABLE participa(
	cod_pelicula varchar(50),
	cod_artista varchar(50),
	principal varchar(2) check (principal in ('si','no')),
	critica varchar(510),
	merece_premio varchar(2) check (merece_premio in ('si','no')),
	constraint participa_pelicula_fk foreign key (cod_pelicula) references pelicula(cod_pelicula),
	constraint participa_artista_fk foreign key (cod_artista) references artista(cod_artista)
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX ind_PARTICIPA_pk ON participa(cod_pelicula, cod_artista) TABLESPACE repositorio_indices;
ALTER TABLE participa ADD CONSTRAINT cod_participa_pk PRIMARY KEY (cod_pelicula, cod_artista);

CREATE TABLE transmite(
	cod_horario varchar(50),
	cod_serie varchar(50),
	cod_serie_sustituta varchar(50),
	constraint transmite_horario_fk foreign key (cod_horario) references horario(cod_horario),
	constraint transmite_serie_fk foreign key (cod_serie) references serie(cod_serie),
	constraint transmite_serie_sust_fk foreign key (cod_serie_sustituta) references serie(cod_serie)
)TABLESPACE repositorio_tablas;
CREATE UNIQUE INDEX ind_transmite_pk ON transmite(cod_horario, cod_serie, cod_serie_sustituta) TABLESPACE repositorio_indices;
ALTER TABLE transmite ADD CONSTRAINT cod_transmite_pk PRIMARY KEY (cod_horario, cod_serie, cod_serie_sustituta);

CREATE TABLE involucrada(
	numero_semana number check(numero_semana >0),
	mes number check (mes>=1 and mes<=12),
	anio number check(anio >= 1990),
	cod_pelicula varchar(50),
	constraint involu_nsemana_fk foreign key (numero_semana, mes, anio) references semana(numero_semana, mes, anio),
	constraint involu_cod_pelicula_fk foreign key (cod_pelicula) references pelicula(cod_pelicula)
)TABLESPACE repositorio_tablas;

CREATE UNIQUE INDEX ind_involucradas_pk ON involucrada(numero_semana, mes, anio, cod_pelicula) TABLESPACE repositorio_indices;
ALTER TABLE involucrada ADD CONSTRAINT cod_involucrada_pk PRIMARY KEY (numero_semana, mes, anio, cod_pelicula);