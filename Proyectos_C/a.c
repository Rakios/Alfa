#include <stdio.h>      
#include <stdlib.h>          
#include <string.h>          
#include <pthread.h>	

char *array;
int asd=0;


void * buscar (void *c){
	char *ch = (char*)c;
	int op  = 0, i = 0;
	while(array[i] != '\n'){
		if(&array[i] == c){
			op++;
		}
		i++;
	}

if(op == 1){
		printf("Hilo %d: %d %c vez \n", asd, op, c);
	}else{
		printf("Hilo %d: %d %c veces \n", asd, op, c);
	}
	asd++;
}


int main(){

int index=0, n, m=0;
char c, *array2;  


scanf("%d",&n);
array2 = (char*)malloc(n*sizeof(char));

while(m<n){

scanf("%s",&c);
array2[m] = c;

m++;
}

array = (char*)malloc(1*sizeof(char));
scanf("%s",&c);
while(c != '0'){
				   array = (char*)realloc(array,(index+1)*sizeof(char));
				   array[index] = c;
				   index++;
scanf("%s",&c);
}


m=0;
pthread_t * threads=(pthread_t*)malloc(n*sizeof(pthread_t));

while(m<n){
		pthread_create(&threads[m],NULL, buscar , &array2[m]);
		m+=1;

	}

return 0;
 }