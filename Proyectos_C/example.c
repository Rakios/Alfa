#include <stdio.h>
#include <stdlib.h>
#include <semaphore.h>
#include <pthread.h>
#include <time.h>
#define MAX_CAPBANO 5
#define NUM_PERSONAS 15

enum estados_signo{VACIO,MUJERES,HOMBRES};
enum estados_signo signo = VACIO;
enum generos{MUJER,HOMBRE};
sem_t capbano_sem, espmujeres_sem, esphombres_sem;
pthread_mutex_t mujespc_mutex, homespc_mutex, persc_mutex,signo_mutex;
int mujespc,homespc,persc;

void *persona(void* args);

int main(){
	
int i,*num;
srand(time(NULL));

sem_init(&capbano_sem,0,MAX_CAPBANO);
sem_init(&espmujeres_sem,0,0);
sem_init(&esphombres_sem,0,0);

pthread_mutex_init(&mujespc_mutex,0);
pthread_mutex_init(&homespc_mutex,0);
pthread_mutex_init(&persc_mutex,0);
pthread_mutex_init(&signo_mutex,0);

mujespc = 0;
homespc = 0;
persc = 0;

pthread_t personas[NUM_PERSONAS];

for(i = 0;i < NUM_PERSONAS;i++){
	num = (int*)malloc(sizeof(int));
	*num = i;
	pthread_create(&personas[i],NULL,persona,(void*)num);
}

for(i = 0;i < NUM_PERSONAS;i++){
	pthread_join(personas[i],NULL);
}

	return 0;
}


void *persona(void* args){

sleep(rand()%5);
int i;
enum generos genero = rand()%2;

while(1){
	pthread_mutex_lock(&signo_mutex);
	if((signo == VACIO) || (signo == genero+1)){ //Si el bano esta vacio o hay personas del mismo genero
		signo = genero+1; //Se cambia el letrero
		pthread_mutex_unlock(&signo_mutex);
		sem_wait(&capbano_sem); //Se entra al bano
		pthread_mutex_lock(&persc_mutex);
		persc++; //Contador de personas en el bano
		pthread_mutex_unlock(&persc_mutex);
		switch(genero){
			case MUJER:
				printf("MUJER EN EL BANO\n");
			break;
			case HOMBRE:
				printf("HOMBRE EN EL BANO\n");
			break;
		}
		
		sleep(rand()%10+1); //Se usa el bano
		sem_post(&capbano_sem); //Se sale del bano
		pthread_mutex_lock(&persc_mutex);
		persc--;

		if(!persc){ //Si es la ultima persona en salir
			pthread_mutex_unlock(&persc_mutex);
			pthread_mutex_lock(&signo_mutex);
			signo = VACIO; //Coloca el letrero en vacio
			pthread_mutex_unlock(&signo_mutex);
			switch(genero){ //Se desbloquean todos los que esperan del otro genero
				case MUJER:
					printf("ULTIMA MUJER EN EL BANO\n");
					pthread_mutex_lock(&homespc_mutex);
				for(i = 0;i < homespc;i++) sem_post(&esphombres_sem);
					pthread_mutex_unlock(&homespc_mutex);
				break;
				case HOMBRE:
					printf("ULTIMO HOMBRE EN EL BANO\n");
					pthread_mutex_lock(&mujespc_mutex);
					for(i = 0;i < mujespc;i++) sem_post(&espmujeres_sem);
						pthread_mutex_unlock(&mujespc_mutex);
				break;
			}
		}else{
			pthread_mutex_unlock(&persc_mutex);
		}
		printf("Me voy!\n");
		pthread_exit(0);
	}else{ //Si el bano esta ocupado y el letrero no coincide con el genero
		
		pthread_mutex_unlock(&signo_mutex);
		switch(genero){ //Se espera en el semaforo respectivo
			case MUJER:
				//printf("MUJER\n");
				pthread_mutex_lock(&mujespc_mutex);
				mujespc++;
				pthread_mutex_unlock(&mujespc_mutex);
				sem_wait(&espmujeres_sem);
				pthread_mutex_lock(&mujespc_mutex);
				mujespc--;
				pthread_mutex_unlock(&mujespc_mutex);
				break;
			case HOMBRE:
				//printf("HOMBRE\n");
				pthread_mutex_lock(&homespc_mutex);
				homespc++;
				pthread_mutex_unlock(&homespc_mutex);
				sem_wait(&esphombres_sem);
				pthread_mutex_lock(&homespc_mutex);
				homespc--;
				pthread_mutex_unlock(&homespc_mutex);
				break;
		}
	
	}
}

}
