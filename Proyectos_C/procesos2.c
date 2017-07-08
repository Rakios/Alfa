#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <dirent.h>
#include <unistd.h>
#include <sys/shm.h>

unsigned char relleno;
char **nombres_archivos;
char **celda;
struct stat st;

typedef struct {
	int reg;
	char *archivo;
}array_celda;

key_t *Clave;
int *Id_Memoria;

unsigned int convertir_little_a_big(unsigned char *size){

	//Desplazo de 8 en 8 para obtener el peso real, partiendo de 0
	unsigned int aux2=0, aux=0;
	int eso=0, i=0;

		while ( i < 7){
            aux = size[i];
            aux = aux<<(eso);
            aux2 = aux2 | aux;
            eso+=8;
			i++;
        }
	return aux2;
}

int verificar( char *cadena, char *subcadena )
{
//Vemos si son archivos "correctos"

   char *tmp = cadena, *pdest;
  
   pdest = strstr( tmp, subcadena );
   if( pdest ) return 1;

   return 0;
}

char *quitar_relleno(char relleno, char* file_n) {
int i;

		if(relleno!='\0'){ //Si existe un relleno lo quito
			i=31;
			while(i>0){
				if(file_n[i]==relleno){
					file_n[i]='\0';
				}else {	
						break;
					 }
				i--;
			}
		}

	return file_n;		
}

void Desempaquetar(array_celda ch){
	
	int fd,i=0,j=0,f=0;
	int reg=ch.reg;
	
	do{
		//Declaracion de variables Nombre de Archivo y de tamano de cada archivo
		unsigned char *file_n=(char*)malloc(32*sizeof(char)), *size=(char*)malloc(8*sizeof(char));
		unsigned int aux2=0, aux=0; //Peso de archivo en Little

		i=0;
		while(i<32){ //Asigno el nombre de cada archivo dentro del punto pak
			file_n[i]=celda[reg][j];
			++i;
			++j;
		}

		i=0;

		while(i<7){ //Asigno el tamano de cada archivo dentro del .pak
			size[i]=celda[reg][j];
			++i;
			++j;
		}

		file_n=quitar_relleno(relleno, file_n); //Quitar relleno

		//Transformo el tamano a Little desplazando de 8 en 8
		aux2=convertir_little_a_big(size);

		//Si el archivo es FIN y no pesa nada termino
		if(strcmp(file_n,"FIN")!=0 || aux2!=0){

		//Escribo toda la info de cada archivo con su nombre correspondiente
			char *buffer=(char*)malloc(aux2*sizeof(char));
			++j;
			i=0;
			while(i<aux2){
				buffer[i]=celda[reg][j];
				++i;
				j++;
			}
			
			fd = open(file_n, O_WRONLY | O_CREAT | O_TRUNC, 0644);
			write(fd,buffer,aux2);
			close(fd);
			
			aux2=0;
			
		}else{
			f=1;
		}
	}while(f!=1);
}

void llenar_celdas(int aux2){
	//Colocamos la informacion de cada .pak dentro de la celda que seran accedidas por los hilos

	int i,pd,size;
	celda=(char**)malloc(aux2*sizeof(char*));
	
	Id_Memoria=(int*)malloc(aux2*sizeof(int));
	Clave=(key_t*)malloc(aux2*sizeof(key_t));
	
	i=0;
	while(i<aux2){
		if(stat(nombres_archivos[i],&st)==-1){
			perror(nombres_archivos[i]);
			exit(1);
		}
		
		Clave[i] = ftok (nombres_archivos[i], 33);

		size=st.st_size;
		Id_Memoria[i] = shmget (Clave[i], sizeof(char*)*size, 0777 | IPC_CREAT);
		char *buffer=(char*)malloc(size*sizeof(char));
		pd=open(nombres_archivos[i], O_RDONLY);
		read(pd,buffer,size);
		close(pd);
		
		celda[i]=(char*)malloc(size*sizeof(char));
		celda[i]=buffer;
		++i;
	}
}


int main(int argc, char *argv[]){
	
	unsigned char *aux;
	int err,i=0,cant_archivos,hex;
	struct timeval start, end;

  	gettimeofday(&start, NULL);

    if(argc<=1){
  	printf("%s \n","ERROR");
  	printf("%s \n","USO: <NOMBRE DEL EJECUTABLE> ARCHIVO DE ENTRADA [ARCHIVOS DE ENTRADA] [RELLENO].");
  	exit(-1);
  	}

	if(verificar(argv[argc-1],".pak")!=1){
		cant_archivos=argc-2;
		aux=atoi(argv[argc-1]);
		relleno=aux;
			}else{
				cant_archivos=argc-1;
				relleno='\0';
			}
    //Relleno con la cantidad de archivos en los .pak
    
    nombres_archivos = (char**)malloc(cant_archivos*sizeof(char*));
    i=0;
	while(i<cant_archivos) {
        nombres_archivos[i] = (char*)malloc(32*sizeof(char));
		++i;
    }
	i=0;
    while(i<cant_archivos) {
        nombres_archivos[i] = argv[i+1];
		++i;
    }   

	pid_t pID;

	llenar_celdas(cant_archivos);
   	array_celda childs[cant_archivos];
    i=0;			
    while(i<cant_archivos){
		childs[i].archivo=(char*)malloc(32*sizeof(char));
		childs[i].archivo=nombres_archivos[i];
		childs[i].reg=i;
		++i;
	}
	i=0;
	while( i<cant_archivos){
		pID = fork();
   		if (pID == 0) {            // child
   		
			Desempaquetar(childs[i]); 	// Code only executed by child process
			exit(1);			
    	}
    	else if (pID < 0)            // failed to fork
    	{
        	printf("Error fork()\n");
        	exit(1);
        	// Throw exception
    	}
    	else                                   // parent
    	{
      	// Code only executed by parent process
    		wait();
    	}
		++i;
	}
	  gettimeofday(&end, NULL);

  printf("%ld", ((end.tv_sec * 1000000 + end.tv_usec)-(start.tv_sec * 1000000 + start.tv_usec)));
  printf("%s \n"," microsegundos");

    	return 0;

 }
