INSERT INTO serie VALUES('1','TWO AND A HALF MEN','comica',10,'CHARLIE CONSUME COCA-COLA',3.0);
INSERT INTO serie VALUES('2','FRIENDS','comica',10,'VIDA DE UN GRUPO DE AMIGOS',6.0);
INSERT INTO serie VALUES('3','BOB NO ES ESPONJA','comica',10,'VIDA DE UNA MAMA Y SU HIJA',4.0);
INSERT INTO serie VALUES('4','GOSSIP GIRL','suspenso',10,'VIDA DE UN GRUPO DE CHICOS',5.0);
INSERT INTO serie VALUES('5','SUPERNATURAL','suspenso',10,'CAZA FANTASMAS',3.0);
INSERT INTO serie VALUES('6','GOT','suspenso',10,'TODOS MUEREN',3.0);
INSERT INTO serie VALUES('7','OUTCAST','suspenso',10,'CAZA DEMONIOS',3.0);

INSERT INTO cadena VALUES('1','TLC','CALIFORNIA','ELVIS');
INSERT INTO cadena VALUES('2','ABC','ESPAÑA','DANIEL');
INSERT INTO cadena VALUES('3','MTV','MIAMI','JEAN');
INSERT INTO cadena VALUES('4','HTV','ATLANTA','ELIAS');
INSERT INTO cadena VALUES('5','NICK','CALIFORNIA','JUAN');
INSERT INTO cadena VALUES('6','TNT','MIAMI','JORGE');
INSERT INTO cadena VALUES('7','AMC','ALEMANIA','KELLYN');
INSERT INTO cadena VALUES('8','RAY','ITALIA','GIAN');

INSERT INTO personaje VALUES('1', 'Harry potter', 'Principal');
INSERT INTO personaje VALUES('2', 'Reina Dalila', 'Principal');
INSERT INTO personaje VALUES('3', 'La reina', 'Secundario');
INSERT INTO personaje VALUES('4','Roberta','Extra');
INSERT INTO personaje VALUES('5','Mejias','Extra');

INSERT INTO artista VALUES('1','Jean Akchar','soltero','JA');
INSERT INTO artista VALUES('2','Gabriela Braccia','casado','GB');
INSERT INTO artista VALUES('3','Gabriela Ponceleon','soltero','GP');
INSERT INTO artista VALUES('4','Reynaldo Trujillo','soltero','RT');
INSERT INTO artista VALUES('5','Elias Akchar','soltero','EK');
INSERT INTO artista VALUES('6','Edwin Alvarado','casado','EA');
INSERT INTO artista VALUES('7','Leen Zea','soltero','LZ');
INSERT INTO artista VALUES('8','Rudy Thereze','soltero','RT');
INSERT INTO artista VALUES('9','Adrian Montes de Oca','soltero','AM');

CREATE OR REPLACE TRIGGER artista_estado_civil_cambio
before update on artista
FOR EACH ROW
BEGIN
	if(:new.estado_civil!='soltero' and :new.estado_civil!='casado' and :new.estado_civil!='divorciado' and :new.estado_civil!='viudo') then 
		RAISE_APPLICATION_ERROR(-20000, 'estado civil ingresado invalido');
	end if;
END;
/

INSERT INTO pelicula VALUES ('1','Las reinas','xxxxx',10,10000);
INSERT INTO pelicula VALUES ('2','Computistas','yyyyyy',10,20000);
INSERT INTO pelicula VALUES ('3','YULY','wwwww',10,30000);
INSERT INTO pelicula VALUES ('4','La casa loca','zzzzzz',10,4000);
INSERT INTO pelicula VALUES ('5','Ricardo arjona','kkkkk',10,10000);

INSERT INTO semana VALUES (1,2,1992,'Mucho exito','Romanticas');
INSERT INTO semana VALUES (1,3,1992,'Mucho exito','Comedia');
INSERT INTO semana VALUES (1,7,1992,'Poco exito','Suspenso');
INSERT INTO semana VALUES (1,10,1992,'Mucho exito','Terror');
INSERT INTO semana VALUES (1,11,1992,'Nadie la vio','Independiente');

INSERT INTO horario VALUES ('1','09:00:00','11:00:00','Todo publico');
INSERT INTO horario VALUES ('2','11:00:00','13:00:00','Todo publico');
INSERT INTO horario VALUES ('3','13:00:00','15:00:00','Todo publico');
INSERT INTO horario VALUES ('4','20:00:00','23:00:00','Adultos');
INSERT INTO horario VALUES ('5','23:00:00','01:00:00','Adultos');

INSERT INTO interpreta VALUES ('1','1','1','01/02/2014','Buena','Recurrente',50);
INSERT INTO interpreta VALUES ('1','2','2','01/03/2014','Media','Recurrente',30);
INSERT INTO interpreta VALUES ('1','3','3','01/04/2014','Excelente','Especial',10);
INSERT INTO interpreta VALUES ('2','4','4','01/05/2014','Excelente','Especial',5);
INSERT INTO interpreta VALUES ('3','4','5','07/10/1992','Mala','Recurrente',30);

INSERT INTO lanzar VALUES ('1','1','01/10/2000','Buena',NULL);
INSERT INTO lanzar VALUES ('2','2','01/10/2011','Sin critica',NULL);
INSERT INTO lanzar VALUES ('3','3','01/10/2014','Excelente',NULL);
INSERT INTO lanzar VALUES ('4','4','01/10/1992','Poca audiencia','01/11/1992');
INSERT INTO lanzar VALUES ('5','5','01/10/2007','Poca audiencia','01/11/2007');

INSERT INTO venta VALUES ('1','1','2','01/10/1992','si');
INSERT INTO venta VALUES ('2','2','3','01/10/1993','no');
INSERT INTO venta VALUES ('3','3','4','01/10/1994','si');
INSERT INTO venta VALUES ('4','4','5','01/10/1995','no');
INSERT INTO venta VALUES ('5','5','1','01/10/1996','si');

INSERT INTO participa VALUES ('1','1','si','Buena','si');
INSERT INTO participa VALUES ('2','2','no','Sin critica','no');
INSERT INTO participa VALUES ('3','3','si','Mediana','si');
INSERT INTO participa VALUES ('4','4','no','Excelente','si');
INSERT INTO participa VALUES ('5','5','si','Mala','si');

INSERT INTO transmite VALUES ('1','1','5');
INSERT INTO transmite VALUES ('2','2','4');
INSERT INTO transmite VALUES ('3','3','3');
INSERT INTO transmite VALUES ('4','4','2');
INSERT INTO transmite VALUES ('5','5','1');

INSERT INTO involucrada VALUES (1,2,1992,'1');
INSERT INTO involucrada VALUES (1,2,1992,'2');
INSERT INTO involucrada VALUES (1,2,1992,'3');
INSERT INTO involucrada VALUES (1,2,1992,'4');
INSERT INTO involucrada VALUES (1,7,1992,'5');


COMMIT;




