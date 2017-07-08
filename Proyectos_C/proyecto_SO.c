#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <dirent.h>
#include <syslog.h>

#include <errno.h>
#include <signal.h>
#include <fcntl.h>
#include <unistd.h>

int Comprobar_Carpeta ( int opc ){ //Funcion que comprueba si existe la carpeta en /etc/ para empezar el programa
     DIR *carpeta;
     char *nombc1, *nombc2;
     int bool=0;

     switch(opc){

     	case 1:
     	nombc1= "/etc"; nombc2= "proyecto_so_1";
     	break; 

     	case 2:
     	nombc1= "/var/log"; nombc2= "PROYECTO_SO_1";
     	break; 


     }


    struct dirent *ent;
                    if ((carpeta = opendir ( nombc1)) != NULL) {
                        /* Sacar todos los archivos que nos interesa */
                        while ((ent = readdir (carpeta)) != NULL) {
                        if(ent->d_type==4){
                            if((strcmp(ent->d_name, nombc2))==0){
                                bool=1;
                            }
                        }
                        }
                        closedir(carpeta);
                    }
    return bool;
}



int main () {
int opc=1;

        pid_t pid, sid; // creamos los id del padre y el hijo

        pid = fork();
        if (pid < 0) {
                exit(EXIT_FAILURE);
        }
        if (pid > 0) {
            exit(EXIT_SUCCESS);
        }

        umask(0); // Cambia los permisos de los archivos a abrirse a superUsuario

        sid = setsid(); // creando id para el hijo
        if (sid < 0) {// verifico que la id se creo correctamente
                exit(EXIT_FAILURE); // si no se creo exitosamente Cierro
        }


        if ((chdir("/")) < 0) { // Cambio directorio a "/" con chdir , si se cambio de forma exitosa devuelve 0
                exit(EXIT_FAILURE); // si no se cambio Cierro el programa
        }

 

        /* Cambiar la direccion en la que se encuentra */
        if ((chdir("/")) < 0) {
                /* Log the failure */
                exit(EXIT_FAILURE);
        }


// Como es un demonio se cierran descriptores , comentador para poder usar printf 
        close(STDIN_FILENO);
        close(STDOUT_FILENO); 
        close(STDERR_FILENO);

/// Verificamos que la carpeta Existe //////

       if(Comprobar_Carpeta(1)==0){//Si no existe la carpeta 
        openlog("ERROR",LOG_PID,LOG_DAEMON);
        syslog(LOG_INFO,"Carpeta proyecto_so_1 no encontrada");
        exit(EXIT_SUCCESS); // Salgo del programa
		}else{
/// Si la Caerpeta Existe Verificamos que el archivo.ini exista //////

        char letra,tag[100], CONF[6];
//int i=0;
        char intervalo[7];
        FILE *entrada;
        entrada=fopen("/etc/proyecto_so_1/proy1.ini", "r");
        	if(entrada==NULL){ //Si no existe el archivo 
            	openlog("ERROR",LOG_PID,LOG_DAEMON);
            	syslog(LOG_INFO,"Archivo proy1.ini no encontrado");
            	exit(EXIT_SUCCESS); // Salgo del programa
        		}
        }else{
            //Agarro el log_tag y el intervalo del archivo
                fscanf(entrada,"%s",CONF); //Leer [CONF] 
                    while(letra!='='){  //ciclo para leer letra por letra hasta llegar al primer = del archivo
                        fscanf(entrada,"%c",&letra);
                    }
                fscanf(entrada,"%s",tag); //guardamos el log_tag
                openlog(tag,LOG_PID,LOG_DAEMON);
                syslog(LOG_INFO,"Iniciando programa..."); //Mensaje de inicio de programa
                letter='0';
                    while(letter!='='){ //ciclo para leer letra por letra hasta llegar al Segundo = del archivo
                        fscanf(entrada,"%c",&letra);
                    }
                    fscanf(entrada,"%s",intervalo); //guardamos el intervalo
        }


}