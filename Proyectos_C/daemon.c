#include <sys/types.h>
#include <string.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <syslog.h>
#include <string.h>
#include <dirent.h>
#include <unistd.h>
#include <time.h>

#define file_patch_size 200

int checkpak=0; //Variable para chequear que se cree un .pak en cada iteracion
//IMPLEMENTACION LISTA//
struct nodo {
    struct nodo *sig;
    char *name;
    char *info;
};

typedef struct nodo* Nodos;

Nodos pri=NULL;

Nodos Create(Nodos new){ //Inicializa los pointer a stuct nodo o Nodos
new=malloc(1*sizeof(Nodos));
new->info=malloc(32*sizeof(char));
new->name=malloc(100*sizeof(char));
new->sig=NULL;
return new;
}

int Search(char n[100]){        //Busca el nombre del archivo en la lista, retorna 0 si se encontro, 1 en caso contrario
    int bool=0;
    if(pri==NULL){
        return bool;
    }else{
        Nodos aux=NULL;
        aux=Create(aux);
        aux=pri;
        while(aux!=NULL){
            if((strcmp(aux->name,n))==0){
                return 1;
            }
            aux=aux->sig;
        }
        return bool;
    }
}

int Compare(char m[32],char n[100]){     //Busca y compara el md5sum del nodo requerido y lo compara con el nuevo
    Nodos aux=NULL;                     //Si los md5sum son diferentes se modifica en la lista y se retorna 1
    aux=Create(aux);                    //Si los md5sum son iguales, se retorna 0
    aux=pri;
    while(aux!=NULL){
        if((strcmp(aux->name,n))==0){
            if((strcmp(aux->info,m))!=0){
                strcpy(aux->info,m);
                return 1;
            }else{

                return 0;
            }
        }
        aux=aux->sig;
    }
}

void Insert(char s[32], char n[100]){ //Inserta en la lista un nodo que contiene un nombre de archivo y su md5
    Nodos nuevo=NULL;
    nuevo=Create(nuevo);
    strcpy(nuevo->name,n);
    strcpy(nuevo->info,s);
    if (pri==NULL){
        pri=nuevo;
    }else{
        Nodos aux=NULL;
        aux=Create(aux);
        aux=pri;
        while(aux->sig!=NULL){
                aux=aux->sig;
        }
        aux->sig=nuevo;
        aux=NULL;
    }
}
void Imprimir(){ //Imprime la lista, usada para propositos practicos 
    Nodos aux=NULL;
    aux=Create(aux);
    aux=pri;
        while(aux!=NULL){
            syslog(LOG_INFO, "%s", aux->info);
            aux=aux->sig;
        }
}
//FIN IMPLEMENTACION LISTA//

//Funcion que retorna el md5
char *FuncionGod(char name[]){
    char *md5 = malloc(sizeof(char)*33);
    int link[2];
    pid_t pid;
    pipe(link);
    pid = fork();
    if(pid==0){
        dup2(link[1],STDOUT_FILENO);
        close(link[0]);
        close(link[1]);
        execlp("md5sum", "md5sum", name, NULL); //Escribo en la tuberia (previamente cerradas)
        exit(EXIT_FAILURE);
    }else{
        close(link[1]);
        read(link[0], md5, sizeof(char)*33); //Luego de cerrar el lado de escritura leo el md5 del lado de lectura
        wait(NULL);
        md5[32] = '\0';
    }
    return md5;
}

//Funcion de compresion de archivo
void FuncionComp(char name[]){
    pid_t pid;
    pid = fork();
    if(pid==0){
        execlp("gzip", "gzip", name, NULL); //usando el comando gzip para comprimir
        exit(EXIT_FAILURE);
    }else{
        wait(NULL);
    }
}


int Cantidad_Digitos(int Num){ //cuenta la cantidad de digitos de un numero dado (sz)
    int x=0;
    while(Num!=0) { 
        Num=Num/10; 
        x=x+1; 
    }    
    return x;
} 

int Ver(){ //Funcion que comprueba si existe la carpeta en /etc/ para emepezar el programa
     DIR *dir;
     int bool=0;
    struct dirent *ent;
                    if ((dir = opendir ("/etc")) != NULL) {
                        /* Sacar todos los archivos que nos interesa */
                        while ((ent = readdir (dir)) != NULL) {
                        if(ent->d_type==4){
                            if((strcmp(ent->d_name,"proyecto_so_1"))==0){
                                bool=1;
                            }
                        }
                        }
                        closedir(dir);
                    }
    return bool;
}

int Ver2(){ //funcion que comprueba si existe la carpeta en var/log/ para escribir el .pak
     DIR *dir;
     int bool=0;
    struct dirent *ent;
                    if ((dir = opendir ("/var/log")) != NULL) {
                        /* Sacar todos los archivos que nos interesa */
                        while ((ent = readdir (dir)) != NULL) {
                        if(ent->d_type==4){
                            if((strcmp(ent->d_name,"PROYECTO_SO_1"))==0){
                                bool=1;
                            }
                        }
                        }
                        closedir(dir);
                    }
    return bool;
}


 const char *extension(const char *filename) {

    const char *dot = strrchr(filename, '.');
    if(!dot || dot == filename) return "";
    return dot + 1; //Obtener la extension de un archivo (para el .gz)
}

int main(void) {

        /* ID del proceso y de sesion */
        pid_t pid, sid;

        /* El padre */
        pid = fork();
        if (pid < 0) {
                exit(EXIT_FAILURE);
        }
        /* Si tenemos un buen ID podemos dejar el padre */

        if (pid > 0) {
            exit(EXIT_SUCCESS);
        }

        /* Cambiando el modo mask del archivo*/
        umask(0);

        /* Creando un nuevo ID para el hijo */
        sid = setsid();
        if (sid < 0) {
                /* Log the failure */
                exit(EXIT_FAILURE);
        }



        /* Cambiar la direccion en la que se encuentra */
        if ((chdir("/")) < 0) {
                /* Log the failure */
                exit(EXIT_FAILURE);
        }

        /* Cerrando las descripciones basicas*/
        close(STDIN_FILENO);
        close(STDOUT_FILENO);
        close(STDERR_FILENO);

        /* Inicializacion del Daemon */

       if(Ver()==0){//Si no hay carpeta cierro el programa
        openlog("ERROR",LOG_PID,LOG_DAEMON);
        syslog(LOG_INFO,"Carpeta proyecto_so_1 no encontrada");
        exit(EXIT_SUCCESS);

       }else{
        char letter,w[100], aux[6];
        int i=0;
        char interval[7];
        FILE *entrada;
        entrada=fopen("/etc/proyecto_so_1/proy1.ini", "r");
        if(entrada==NULL){ //Si no hay archivo no hago nada y cierro el programa
            openlog("ERROR",LOG_PID,LOG_DAEMON);
            syslog(LOG_INFO,"Archivo proy1.ini no encontrado");
            exit(EXIT_SUCCESS);
        }else{
            //Agarro el LOG ID y el interval del archivo
                fscanf(entrada,"%s",aux);
                    while(letter!='='){
                        fscanf(entrada,"%c",&letter);
                    }
                fscanf(entrada,"%s",w);
                openlog(w,LOG_PID,LOG_DAEMON);
                syslog(LOG_INFO,"Iniciando programa..."); //Mensaje de inicio de programa
                letter='0';
                    while(letter!='='){
                        fscanf(entrada,"%c",&letter);
                    }
                    fscanf(entrada,"%s",interval);
        }
        int realinterval=0;
        sscanf(interval, "%d", &realinterval );
        fclose(entrada);
        //El llamado Big Loop del daemon
        while (1) {
            if (Ver2()==0) { //Si no existe la carpeta PROYECTO_SO_1 la creo
                mkdir("/var/log/PROYECTO_SO_1/", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
            }
            FILE *fp,*pak;  int sz=0;
            char e_pak[4]={"\0"};
            strcat(e_pak, ".pak");  
            int auxiliar=0;                                  
            char route[100]={"\0"};
            strcat(route, "/var/log/");  
            char route2[100]={"\0"};
            strcat(route2, "/var/log/PROYECTO_SO_1/");  //La ruta de escritura del .pak
            char buffer[100]={"\0"};            
            char name[100];
            char md5[32];
            memset(name, '\0', 100);
            memset(md5, '\0', 32);
                    DIR *dir;
                    struct dirent *ent;
                    if ((dir = opendir ("/var/log")) != NULL) {
                        /* Sacar todos los archivos que nos interesa */
                        while ((ent = readdir (dir)) != NULL) {
                            if(ent->d_type==4) { //Si el archivo es una carpeta (directorio) lo omito
                            }else{
                        if((strncmp(extension(ent->d_name),"gz", 2))==0){ //Comparando si la extension es .gz para omitirla
                            //No se hace nada

                            }else{
                            strcpy(name,ent->d_name);
                            char fullName[1000] = {'\0'};
                            strcat(fullName, "/var/log"); //Cocateno toda la ruta a usar con el nombre
                            strcat(fullName, "/");
                            strcat(fullName, name);
                            if(Search(name)==0){        //Si el archivo no esta en la lista, se inserta con md5sum=0
                                Insert("0", name);
                            }
                           //De lo contrario se compara el md5sum anterior con el actual
                                if(Compare(FuncionGod(fullName),name)==1){
                                	char letra='\0';
                                    //EMPAQUETADO//
                                    strcat(route,name); // Concateno la ruta con el nombre del archivo
                                    if(checkpak==0){ //Chequeo si es la primera iteracion (para solo crear un .pak)
                                    time_t tim=time(NULL);
                                    struct tm *tm = localtime(&tim);
                                    sprintf(buffer,"logs_%d:%d:%d_%d:%d:%d",tm->tm_mday,tm->tm_mon+1,tm->tm_year+1900,tm->tm_hour,tm->tm_min,tm->tm_sec);
                                    checkpak=1;
                                    strcat(route2,buffer); //Luego de asignar el tiempo y el nombre del archivo lo concateno con la ruta1
                                    strcat(route2,e_pak);
                                    }   
                                    fp=fopen(route,"r"); //Abro los Archivos
                                    pak=fopen(route2,"a");
                                    fprintf(pak,"%c", '\n');
                                    auxiliar=1;
                                    fprintf(pak,"%s",name); //Imprimo el nombre y dejo espacios hasta que sean 32 caracteres
                                    for(i=0;i<32-strlen(name);i++){
                                        fprintf(pak,"%s"," ");
                                    }
                                    i=0;
                                    fseek(fp, 0L, SEEK_END);
                                    sz = ftell(fp);
                                    for(i=0;i<64-Cantidad_Digitos(sz);i++){ //Imprimo ceros hasta 64-Ndigitos del peso
                                        fprintf(pak,"%d",0);
                                    }
                                    fprintf(pak,"%d""%c",sz,'\n'); //Imprimo el peso
                                    fseek(fp, 0, SEEK_SET);
                                    char linea[300]={'\0'};
									while(fread(linea,300*sizeof(char),1 ,fp)){ //Hasta que exista lineas en el archivo, escribe su contenido en el .pak
									fprintf(pak,"%s",linea);
									}
									fprintf(pak,"\n\n");
                                    strcpy(route,"/var/log/"); //vuelvo a "inicializar la ruta 1"
                            		fclose(fp);                                    
                                    //FuncionComp(route2);
                                }
                                fprintf(pak,"\n"); 
                                sz=0; // Inicializo el peso de nuevo
                        }
                        }
                    }
                            checkpak=0;
                            if(auxiliar==1){ //Si hubo un empaquetamiento entonces hay que poner FIN 0 al final
                                fprintf(pak,"%s","FIN");
                            for(i=0;i<32-strlen("FIN");i++){
                                fprintf(pak,"%s"," ");
                            }
                            for(i=0;i<64;i++){
                                fprintf(pak,"%d",0);
                            }    
                            fclose(pak);
                            FuncionComp(route2);                            
                        }
                            closedir (dir);
                        /* no se pudo abrir el directorio*/
                    }
           sleep(realinterval); /* esperar el intervalo dado en segundos */
        }
    }
   exit(EXIT_SUCCESS);
}
