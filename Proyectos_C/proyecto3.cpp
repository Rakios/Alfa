#include <iostream>
#include <string.h>
using namespace std;

void reconstruir_arbol (string kk, char caracter) { // kk es la cadena en binario
   nodo *pru;
   int tam, i=-1, val=0; //tam es el tamño del binario
   std::string str (kk);
   tam=str.size();   // sacar el tamaño del binario para saber cuantos paso son
   while (tam>=0 ){
       if(pri==NULL){
       pri=new nodo(); // si no existe la raiz crearla
	   }
	   pru=pri;
       if(kk[tam]=='0'){
	   		if(pru->IZQ==NULL){
			   
			   pru->IZQ= new nodo();}
	   		pru=pru->IZQ;
	   }else{
			if(pru->DER==NULL){pru->DER= new nodo();}
	   		pru=pru->DER;
		}
	if(tam==0){ pru->letra=caracter;}
	tam--;
	}
	
	 }
  
bool recorrer_encontrar (string kk) { // kk es la cadena en binario
   nodo *pru,*pru2,*nue=NULL;
   int tam, i=-1, val=0; //tam es el tamño del binario
   std::string str (kk);
   tam=str.size();   // sacar el tamaño del binario para saber cuantos paso son
   while (tam>=0 ){
	   pru=pri; //raiz
       if(kk[tam]=='0'){
	   		pru=pru->IZQ;
	   }else{
	   		pru=pru->DER;
		}
	if(pru->letra!=NULL){ return false; }else{ return true;
	}
	tam--;//resto el tamaño ya que hize un paso, 0101 -> me muevo a la derecha por el 1, luego resto y queda 010
	}
	
	 }   

string recorrer_por_letra (string kk) { // kk es la cadena en binario
   nodo *pru,*pru2,*nue=NULL;
   int tam, i=-1, val=0; //tam es el tamño del binario
   std::string str (kk);
   tam=str.size();   // sacar el tamaño del binario para saber cuantos paso son
   while (tam>=0 ){
	   pru=pri; //raiz
       if(kk[tam]=='0'){
	   		pru=pru->IZQ;
	   }else{
	   		pru=pru->DER;
		}
	if(tam==0){ return pru->letra; }
	}
	tam--;//resto el tamaño ya que hize un paso, 0101 -> me muevo a la derecha por el 1, luego resto y queda 010
	}
	 }  



string binario_letra(string bin, int i){ //pasa un binario a un caracter ASCII 
int sum=1, val=0;
	while(i>=0){
		if(bin[i]=='1'){
		cout<<val<<" "<<sum<<endl;
		val=val+sum;
		}
	sum=sum*2;
	i--;
	}
string cod, cod2;
cout<<endl;
cout<<bin<<" valor binario "<<val;
val=val+32;
cout<<" + 32 = "<<val<<endl;
cod=val;
cout<<cod<<endl;
cout<<endl;	
return cod;	
}

void Codificacion(string texto){ // toma un String binario 
string  codificacion, bin;
int tam, i=-1, val=0;
std::string str (texto);
tam=str.size();
cout<<"el tamaño es "<<tam<<endl;
while(tam>=6){
	while(i<7){
	bin=texto[tam] + bin;
	i++;
	tam--;
	}
codificacion+=binario_letra(bin,6);
i=0;
bin.clear();
}
	if(tam>0 && tam<7){
	i=tam;
		while(tam>=0){
		bin=texto[tam] + bin;
		tam--;
		}
	codificacion+=binario_letra(bin,i);
	}
cout<<codificacion;	
}

string letra_binario(char bin){ //pasa un  caracter ASCII a un binario
int sum=1, val=0, b, i;
string s;
val= bin;
cout<<bin<<" "<<val<<endl;
val=val-32;

for(i=0; i<=6; i++)
{
b=val%2;
if(b==0){ s='0'+s; } else{s='1'+s;  }
val=val/2;
}
cout<<s<<endl;
return s;
}


void DECodificacion(string texto){ // toma un String y pasarlo a binario 
string  DEcodificacion, DEbin;
int tam, i=-1, val=0;
std::string str (texto);
tam=str.size();
tam--;
while(tam>=0){
	DEbin=texto[tam];
	tam--;
DEcodificacion+=letra_binario(DEbin[0]); //pasa una letra y la convierte en binario
DEbin.clear();
}

cout<<DEcodificacion;	
}


int main(){
string texto, texto1;
texto="1111010011111111001100010100111000111101010101111100011110010100000101001110010111010110";
texto1="GQt¨¨ss";
Codificacion(texto);

return 0;}
