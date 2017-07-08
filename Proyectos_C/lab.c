#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
int pid, inicio = 1;
void dunk(){
	kill(pid, SIGKILL);
}

int main(){
char c;
while(1){
	(void) signal(SIGINT, dunk);
	scanf("%c", &c);
	switch(c){
		case 'G':
			if(inicio){

			}else{
				kill(pid, SIGCONT);
			}
		break;
		case 'S':
			if(inicio){

			}else{
				kill(pid, SIGSTOP);
			}
			
		break;
		case 'F':
			if(inicio){

			}else{
				kill(getppid(), SIGKILL);
			}
			
		break;
		case 'C':
			inicio = 0;
			pid = fork();
			switch(pid){
				case -1:
					perror("falla");
					exit(1);
				break;
				case 0:
					execl("./interface", "Hijo", NULL);
				break;
				default:

				break;
			}
		break;
		default:
			printf("entrada invalida");
		break;
	}
}
}

