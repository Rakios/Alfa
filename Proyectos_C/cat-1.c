/* Johanna Rojas CI: 22.908.075
   Rafael Linares CI: 19.208.073
   Lab. Lunes (1-3pm)
*/
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>


int main(int argc, char *argv[])
{

	if (argc==1)
	{
		int whileInf=1;
		char cadena[1024];
		int n;
	
		while ((n = read(0, &cadena, sizeof(cadena))) > 0)
       			 write(1, &cadena, n);
	}	
	else if (argc==2)
	{
		int entrada = open(argv[1], O_RDONLY);
		char cadena[1024];
		int n;
		while((n = read(entrada, cadena, 1024)) > 0)
		{
    			write(1, cadena, n);
		}
		close(entrada);
	}
	else if (argc==3)
	{
		int entrada = open(argv[1], O_RDONLY);
		int salida = open(argv[2], O_WRONLY | O_APPEND);
		char cadena[1024];
		int n;
		while((n = read(entrada, cadena, 1024)) > 0)
		{
    			write(salida, cadena, n);
		}

		close(entrada);
		close(salida);
	}
}
