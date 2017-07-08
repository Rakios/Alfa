#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <pthread.h>
#define size 10 
#define cant 4
int matriz[size][size], suma[cant];
void *work( void *ptr )
{
	int  i = *((int*)ptr), j, k;
	printf("Trabajo que realiza el thread %d \n",i);
	switch(i){
		case 0:	for(j=0;j<size/2;j++)
				for(k=0;k<size/2;k++)
					suma[i] += matriz[j][k];
			break;
		case 1: for(j=0;j<size/2;j++)
				for(k=size/2;k<size;k++)
					suma[i] += matriz[j][k];
			break;
		case 2:	for(j=size/2;j<size;j++)
				for(k=0;k<size/2;k++)
					suma[i] += matriz[j][k];
			break;
		case 3: for(j=size/2;j<size;j++)
				for(k=size/2;k<size;k++)
					suma[i] += matriz[j][k];
			break;
	}	

	pthread_exit(0);
}
int main(int argc, char *argv[])
{
	//creando muchos threads
		pthread_t threads [cant];
		int i, *index,j;
		
		for(i=0;i<size;i++)
				for(j=0;j<size;j++)
					matriz[i][j] = rand()%5;
		

		for(i=0;i<cant;i++)
		{
			index = (int*)malloc(sizeof(int));
			*index = i;
			pthread_create( &threads[i], NULL, work, (void *)index);
		}
		
		for(i=0;i<cant;i++)
		{
			pthread_join(threads[i],NULL);
		}
		
	printf("La Suma es: %d",(suma[0]+suma[1]+suma[2]+suma[3]));
	return 0;
}

