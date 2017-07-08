#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <dirent.h>
#include <unistd.h>
#include <pthread.h>

unsigned char relleno;
char **f_names;
char **Data;
struct stat st;

typedef struct {
	int registro;
	char *file;
}Global_Data;

int verificar( char *cadena, char *subcadena )
{
	//Vemos si el archivo es "correcto"
   char *tmp = cadena;
   char *pdest;
  
   pdest = strstr( tmp, subcadena );
   if( pdest ) return 1;

   return 0;
}

char *remove_all_chars(char relleno, char* file_n) {
int i=0;

		if(relleno!='\0'){ //Si existe un relleno lo quito
			for(i=31; i>0; i--){
				if(file_n[i]==relleno){
					file_n[i]='\0';
				}	
				else {	

						break;
					 }

			}
		}

	return file_n;		
}

unsigned int Little_to_Big(unsigned char *size){
	//Desplazo de 8 en 8 para obetener el peso real, partiendo de 0

	unsigned int N=0;
	unsigned int aux=0;
	int eso=0;
	int i=0;

		for (i = 0; i < 7; i++){
            aux = size[i];
            aux = aux<<(eso);
            N = N | aux;
            eso+=8;
        }
	return N;
}

void Fill_Data(int N){
	//Colocamos la informacion de cada .pak dentro de la memoria a ser compartida
	
	int i,pd,size;
	Data=(char**)malloc(N*sizeof(char*));
	
	for(i=0;i<N;++i){
		if(stat(f_names[i],&st)==-1){
			perror(f_names[i]);
			exit(1);
	}
		
		size=st.st_size;
		char *buffer=(char*)malloc(size*sizeof(char));
		pd=open(f_names[i], O_RDONLY);
		read(pd,buffer,size);
		close(pd);
		
		Data[i]=(char*)malloc(size*sizeof(char));
		Data[i]=buffer;	
	}
}

void *Desempaquetar(void *t){
	int fd,i,j=0,f=0;
	Global_Data th=*((Global_Data *)t);		
	int registro=th.registro;
	do{
		//Declaracion de variables Nombre de Archivo y de tamano de cada archivo
		unsigned char *file_n=(char*)malloc(32*sizeof(char));
		unsigned char *size=(char*)malloc(8*sizeof(char));
		
		unsigned int N=0; //Peso de archivo en Little
		unsigned int aux=0;

		for(i=0;i<32;++i){ //Asigno el nombre de cada archivo dentro del punto pak
			file_n[i]=Data[registro][j];
			++j;
		}

		file_n=remove_all_chars(relleno, file_n);

		i=0;

		for(i=0;i<7;++i){ //Asigno el tamano de cada archivo dentro del .pak
			size[i]=Data[registro][j];
			++j;
		}
		//Transformo el tamano a Little desplazando de 8 en 8
		N=Little_to_Big(size);

		//Si el archivo es FIN y no pesa nada termino
		if(strcmp(file_n,"FIN")!=0 || N!=0){

		//Escribo toda la info de cada archivo con su nombre correspondiente
			char *buffer=(char*)malloc(N*sizeof(char));
			++j;
			
			for(i=0; i<N; ++i){
				buffer[i]=Data[registro][j];
				j++;
			}
			
			fd = open(file_n, O_WRONLY | O_CREAT | O_TRUNC, 0644);
			write(fd,buffer,N);
			close(fd);
			
			N=0;
			
		}else{
			f=1;
		}
	}while(f!=1);
}

int main(int argc, char *argv[]){
	
	int err,i,n_paks;
	int hex;
	unsigned char *aux;
	if(verificar(argv[argc-1],".pak")!=1){
		n_paks=argc-2;
		aux=atoi(argv[argc-1]);
		relleno=aux;
	}else{
		n_paks=argc-1;
		relleno='\0';
	}

    f_names = (char**)malloc(n_paks*sizeof(char*));
    for(i=0;i<n_paks;++i) {
        f_names[i] = (char*)malloc(32*sizeof(char));
    }
    for(i=0;i<n_paks;++i) {
        f_names[i] = argv[i+1];
    }
    
    Fill_Data(n_paks);

    //Creacion de hilos
    Global_Data threads[n_paks];
    for(i=0;i<n_paks;++i){
		threads[i].file=(char*)malloc(32*sizeof(char));
		threads[i].file=f_names[i];
		threads[i].registro=i;
	}
    
	pthread_t Archivadores[n_paks];
	
	for(i=0;i<n_paks;++i){
		err=pthread_create(&Archivadores[i],NULL,(void*)Desempaquetar,(void*)&threads[i]);
			
		if(err){
			//printf("Error Archivadores pthread_create() = %d\n", err);
			exit(-1);
		}
	}
	
	for(i=0;i<n_paks;++i){
			pthread_join(Archivadores[i],NULL);}
			
	pthread_exit(NULL);
	
	return 0;
}
