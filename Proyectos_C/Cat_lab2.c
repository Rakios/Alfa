#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>


int main(int argc, char *argv[])
{

char string[1024];
int tamaño;

if (argc==1)
	{
	
		while (1) {
       			 tamaño = read(0, &string, sizeof(string)
				 write(1, &string, tamaño);
	
	}			 
				 
	}else if (argc==2){
	
		int archivo1 = open(argv[1], O_RDONLY);

		while((tamaño = read(archivo1, string, 1024)) > 0)
		{
    			write(1, string, tamaño);
		}
		close(archivo1);
	}
	else if (argc==3)
	{
		int archivo1 = open(argv[1], O_RDONLY);
		int archivo2 = open(argv[2], O_RDONLY);

		while((tamaño = read(archivo1, string, 1024)) > 0)
		{
    			write(1, string, tamaño);
		}
		
		while((tamaño = read(archivo2, string, 1024)) > 0)
		{
    			write(1, string, tamaño);
		}


		close(archivo1);
		close(archivo2);








}