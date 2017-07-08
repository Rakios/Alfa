DROP TABLESPACE repositorio_tablas INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE repositorio_indices INCLUDING CONTENTS AND DATAFILES;
CREATE TABLESPACE repositorio_tablas DATAFILE 'df_tablas.DBF' SIZE 500M;
CREATE TABLESPACE repositorio_indices DATAFILE 'df_indices.DBF' SIZE 500M;


DROP USER repositorio CASCADE;
CREATE USER repositorio IDENTIFIED BY dj007;
grant create session, create table, alter session, create trigger to repositorio;
ALTER USER repositorio QUOTA UNLIMITED ON repositorio_tablas;
ALTER USER repositorio QUOTA UNLIMITED ON repositorio_indices;

connect repositorio/dj007;
@ C:\Users\alberto\Downloads\create_tables.sql
@ C:\Users\alberto\Downloads\insert_tables.sql





