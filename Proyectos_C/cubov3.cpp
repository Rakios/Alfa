#include <iostream>
#include <fstream>
using namespace std;
class Tcubo{
private:

class cubo{
private:
char R[3][3]; //FRONTAL
char B[3][3];  //DERECHA
char G[3][3];  //IZQUIERDA
char Y[3][3];   //INFERIOR
char W[3][3];   //SUPERIOR
char O[3][3];   //TRASERA}
friend class Tcubo;
};

cubo T;
cubo in;
int a;
char mov[100][2];
int cont_mov_mejor;
public:


//////////////////////////////////////////////////////////////////////////
void Tcubo::getdatos(){ // OBTENER DATOS DE ENTRADA
int i,j;

for (i=0;i<=2;i++){
  for (j=0;j<=2;j++){   
    cin>>in.R[i][j];
    }}

for (i=0;i<=2;i++){
  for (j=0;j<=2;j++){   
    cin>>in.B[i][j];
    }}

for (i=0;i<=2;i++){
  for (j=0;j<=2;j++){   
    cin>>in.G[i][j];
    }}

for (i=0;i<=2;i++){
  for (j=0;j<=2;j++){   
    cin>>in.W[i][j];
    }}

for (i=0;i<=2;i++){
  for (j=0;j<=2;j++){   
    cin>>in.O[i][j];
    }}

for (i=0;i<=2;i++){
  for (j=0;j<=2;j++){   
    cin>>in.Y[i][j];
    }}
}
//////////////////////////////////////////////////////////////////////////
void Tcubo::copiar(){ // GUARDAR ESTADO ANTERIOR DEL CUBO EN UN AUXILIAR
int i,j;
for (i=0;i<=2;i++){
  for (j=0;j<=2;j++){   
    T.R[i][j]=in.R[i][j];
    }}
for (i=0;i<=2;i++){
  for (j=0;j<=2;j++){   
    T.B[i][j]=in.B[i][j];
    }}
for (i=0;i<=2;i++){
   for (j=0;j<=2;j++){   
    T.G[i][j]=in.G[i][j];
    }}
for (i=0;i<=2;i++){
  for (j=0;j<=2;j++){   
    T.Y[i][j]=in.Y[i][j];
    }}
for (i=0;i<=2;i++){
 for (j=0;j<=2;j++){   
    T.W[i][j]=in.W[i][j];
    }}
for (i=0;i<=2;i++){
 for (j=0;j<=2;j++){   
    T.O[i][j]=in.O[i][j];
    }}     
}

void Tcubo::anterior(){ // VOLVER A ESTADO ANTERIOR DEL CUBO
int i,j;
for (i=0;i<=2;i++){
  for (j=0;j<=2;j++){   
    in.R[i][j]=T.R[i][j];
    }}
for (i=0;i<=2;i++){
  for (j=0;j<=2;j++){   
    in.B[i][j]=T.B[i][j];
    }}
for (i=0;i<=2;i++){
   for (j=0;j<=2;j++){   
    in.G[i][j]=T.G[i][j];
    }}
for (i=0;i<=2;i++){
  for (j=0;j<=2;j++){   
    in.Y[i][j]=T.Y[i][j];
    }}
for (i=0;i<=2;i++){
 for (j=0;j<=2;j++){   
    in.W[i][j]=T.W[i][j];
    }}
for (i=0;i<=2;i++){
 for (j=0;j<=2;j++){   
    in.O[i][j]=T.O[i][j];
    }}     
}

///////////////////////////////////////////////

void Tcubo::rotar_cara_interna(int op, int count, int cara){ //ROTAR ALREDEDOR DEL CENTRO DE LA CARA
int auxi=2, auxj=0, i, j;
char aux[3][3];
if(cara==1){
if(op==0){////////RED
// SENTIDO AGUJAS DEL RELOJ ROJA
    mov[count][0]='R';
    mov[count][1]='0';
      for (j=0;j<=2;j++){
      for (i=0;i<=2;i++){  
    aux[i][j]=in.R[auxi][auxj];
    auxj++;
    }
     auxi--; auxj=0;
    }

 for (i=0;i<=2;i++){
      for (j=0;j<=2;j++){   
    in.R[i][j]=aux[i][j];
}}
//SENTIDO CONTRARIO AGUJAS DEL RELOJ 
}else{
    mov[count][0]='R';
    mov[count][1]='1';
      auxj=2; auxi=0;
      for (j=0;j<=2;j++){
      for (i=0;i<=2;i++){  
    aux[i][j]=in.R[auxi][auxj];
    auxj--;
    }
     auxi++; auxj=2;
    }
 for (i=0;i<=2;i++){
      for (j=0;j<=2;j++){   
    in.R[i][j]=aux[i][j];
}}      
      
      }  
//////////////////////////////////////////  
}else if(cara==2){////////////////////////BLUE
if(op==0){
//SENTIDO AGUJAS DEL RELOJ AZUL
    mov[count][0]='B';
    mov[count][1]='0';
      for (j=0;j<=2;j++){
      for (i=0;i<=2;i++){  
    aux[i][j]=in.B[auxi][auxj];
    auxj++;
    }
     auxi--; auxj=0;
    }
 for (i=0;i<=2;i++){
      for (j=0;j<=2;j++){   
    in.B[i][j]=aux[i][j];
}}
//SENTIDO CONTRARIO AGUJAS DEL RELOJ 
}else{
    mov[count][0]='B';
    mov[count][1]='1';
      auxj=2; auxi=0;
      for (j=0;j<=2;j++){
      for (i=0;i<=2;i++){  
    aux[i][j]=in.B[auxi][auxj];
    auxj--;
    }
     auxi++; auxj=2;
    }
 for (i=0;i<=2;i++){
      for (j=0;j<=2;j++){   
    in.B[i][j]=aux[i][j];
}}      
      
      }  
///////////////////////////////
}else if(cara==3){////////////////////////GREEN
if(op==0){
//SENTIDO AGUJAS DEL RELOJ VERDE
    mov[count][0]='G';
    mov[count][1]='0';
      for (j=0;j<=2;j++){
      for (i=0;i<=2;i++){  
    aux[i][j]=in.G[auxi][auxj];
    auxj++;
    }
     auxi--; auxj=0;
    }
 for (i=0;i<=2;i++){
      for (j=0;j<=2;j++){   
    in.G[i][j]=aux[i][j];
}}
//SENTIDO CONTRARIO AGUJAS DEL RELOJ 
}else{
    mov[count][0]='G';
    mov[count][1]='1';
      auxj=2; auxi=0;
      for (j=0;j<=2;j++){
      for (i=0;i<=2;i++){  
    aux[i][j]=in.G[auxi][auxj];
    auxj--;
    }
     auxi++; auxj=2;
    }
 for (i=0;i<=2;i++){
      for (j=0;j<=2;j++){   
    in.G[i][j]=aux[i][j];
}}      
      
      }  
///////////////////////////////
}else if(cara==4){//////////////WHITE
if(op==0){
// SENTIDO AGUJAS DEL RELOJ BLANCO
    mov[count][0]='W';
    mov[count][1]='0';
      for (j=0;j<=2;j++){
      for (i=0;i<=2;i++){  
    aux[i][j]=in.W[auxi][auxj];
    auxj++;
    }
     auxi--; auxj=0;
    }
 for (i=0;i<=2;i++){
      for (j=0;j<=2;j++){   
    in.W[i][j]=aux[i][j];
}}
// SENTIDO CONTRARIO AGUJAS DEL RELOJ 
}else{
    mov[count][0]='W';
    mov[count][1]='1';
      auxj=2; auxi=0;  
      for (j=0;j<=2;j++){
      for (i=0;i<=2;i++){  
    aux[i][j]=in.W[auxi][auxj];
    auxj--;
    }
     auxi++; auxj=2;
    }

 for (i=0;i<=2;i++){
      for (j=0;j<=2;j++){   
    in.W[i][j]=aux[i][j];
}}      
      
      }  
////////////////////////////////////////////////////
}else if(cara==5){//////////////ORANGE
if(op==0){
// SENTIDO AGUJAS DEL RELOJ ANARANJADO
    mov[count][0]='O';
    mov[count][1]='0';
      for (j=0;j<=2;j++){
      for (i=0;i<=2;i++){  
    aux[i][j]=in.O[auxi][auxj];
    auxj++;
    }
     auxi--; auxj=0;
    }
 for (i=0;i<=2;i++){
      for (j=0;j<=2;j++){   
    in.O[i][j]=aux[i][j];
}}
// SENTIDO CONTRARIO AGUJAS DEL RELOJ 
}else{
    mov[count][0]='O';
    mov[count][1]='1';
      auxj=2; auxi=0;  
      for (j=0;j<=2;j++){
      for (i=0;i<=2;i++){  
    aux[i][j]=in.O[auxi][auxj];
    auxj--;
    }
     auxi++; auxj=2;
    }
 for (i=0;i<=2;i++){
      for (j=0;j<=2;j++){   
    in.O[i][j]=aux[i][j];
}}      
      }  
////////////////////////////////////////////////////
}else if(cara==6){//////////////YELOOW
if(op==0){
// SENTIDO AGUJAS DEL RELOJ AMARILLO
    mov[count][0]='Y';
    mov[count][1]='0';
      for (j=0;j<=2;j++){
      for (i=0;i<=2;i++){  
    aux[i][j]=in.Y[auxi][auxj];
    auxj++;
    }
     auxi--; auxj=0;
    }
 for (i=0;i<=2;i++){
      for (j=0;j<=2;j++){   
    in.Y[i][j]=aux[i][j];
}}
// SENTIDO CONTRARIO AGUJAS DEL RELOJ 
}else{
    mov[count][0]='Y';
    mov[count][1]='1';
      auxj=2; auxi=0;  
      for (j=0;j<=2;j++){
      for (i=0;i<=2;i++){  
    aux[i][j]=in.Y[auxi][auxj];
    auxj--;
    }
     auxi++; auxj=2;
    }
 for (i=0;i<=2;i++){
      for (j=0;j<=2;j++){   
    in.Y[i][j]=aux[i][j];
}}      
      
      }  
////////////////////////////////////////////////////
}
          }
void Tcubo::rotar_caras_externas(int op, int cara){ // ROTAR LADOS DE LA CARA
int i, j=2;
char aux[3][3];
if(cara==1){    
/////////////////////////////////////BACKUP EXTREMOS CARA ROJA
for (i=0;i<=2;i++){
aux[0][i]=in.W[2][i]; ///CARA SUPERIOR
aux[1][i]=in.B[i][0]; ///CARA DERECHA
aux[2][i]=in.Y[0][j]; ///CARA INFERIOR
aux[3][i]=in.G[j][2]; ///CARA IZQUIERDA
j--;
}
j=2;        
/////////////////////////////////////ROTAR EXTREMOS DE LA CARA ROJA
if (op==0){
for (i=0;i<=2;i++){
in.W[2][i]=aux[3][i]; ///CARA SUPERIOR
in.B[i][0]=aux[0][i]; ///CARA DERECHA
in.Y[0][j]=aux[1][i]; ///CARA INFERIOR
in.G[j][2]=aux[2][i]; ///CARA IZQUIERDA
j--;
}
j=2;
}else{ /////SENTIDO CONTRARIO
for (i=0;i<=2;i++){
in.W[2][i]=aux[1][i]; ///CARA SUPERIOR
in.B[i][0]=aux[2][i]; ///CARA DERECHA
in.Y[0][j]=aux[3][i]; ///CARA INFERIOR
in.G[j][2]=aux[0][i]; ///CARA IZQUIERDA
j--;
}
j=2;
} 
///////////////////////////////////////////////////        
}else if (cara==2){ 
/////////////////////////////////////BACKUP EXTREMOS CARA AZUL
for (i=0;i<=2;i++){
aux[0][i]=in.W[j][2]; ///CARA SUPERIOR
aux[1][i]=in.O[i][0]; ///CARA DERECHA
aux[2][i]=in.Y[j][2]; ///CARA INFERIOR
aux[3][i]=in.R[j][2]; ///CARA IZQUIERDA
j--;
}
j=2;        
/////////////////////////////////////ROTAR EXTREMOS DE LA CARA AZUL
if (op==0){
for (i=0;i<=2;i++){
in.W[j][2]=aux[3][i]; ///CARA SUPERIOR
in.O[i][0]=aux[0][i]; ///CARA DERECHA
in.Y[j][2]=aux[1][i]; ///CARA INFERIOR
in.R[j][2]=aux[2][i]; ///CARA IZQUIERDA
j--;
}
j=2;
}else{ /////SENTIDO CONTRARIO
for (i=0;i<=2;i++){
in.W[j][2]=aux[1][i]; ///CARA SUPERIOR
in.O[i][0]=aux[2][i]; ///CARA DERECHA
in.Y[j][2]=aux[3][i]; ///CARA INFERIOR
in.R[j][2]=aux[0][i]; ///CARA IZQUIERDA
j--;
}
j=2;
} 
///////////////////////////////////////////////////
}else if (cara==3){ 
/////////////////////////////////////BACKUP EXTREMOS CARA VERDE
for (i=0;i<=2;i++){
aux[0][i]=in.W[i][0]; ///CARA SUPERIOR
aux[1][i]=in.R[i][0]; ///CARA DERECHA
aux[2][i]=in.Y[j][0]; ///CARA INFERIOR
aux[3][i]=in.O[j][2]; ///CARA IZQUIERDA
j--;
}
j=2;        
/////////////////////////////////////ROTAR EXTREMOS DE LA CARA VERDE
if (op==0){
for (i=0;i<=2;i++){
in.W[i][0]=aux[3][i]; ///CARA SUPERIOR
in.R[i][0]=aux[0][i]; ///CARA DERECHA
in.Y[j][0]=aux[1][i]; ///CARA INFERIOR
in.O[j][2]=aux[2][i]; ///CARA IZQUIERDA
j--;
}
j=2;
}else{ /////SENTIDO CONTRARIO
for (i=0;i<=2;i++){
in.W[i][0]=aux[1][i]; ///CARA SUPERIOR
in.R[i][0]=aux[2][i]; ///CARA DERECHA
in.Y[j][0]=aux[3][i]; ///CARA INFERIOR
in.O[j][2]=aux[0][i]; ///CARA IZQUIERDA
j--;
}
j=2;
} 
///////////////////////////////////////////////////  
}else if (cara==4){ 
/////////////////////////////////////BACKUP EXTREMOS CARA BLANCO
    for (i=0;i<=2;i++){
    aux[0][i]=in.O[0][j]; ///CARA SUPERIOR
    aux[1][i]=in.B[0][j]; ///CARA DERECHA
    aux[2][i]=in.R[0][j]; ///CARA INFERIOR
    aux[3][i]=in.G[0][j]; ///CARA IZQUIERDA
    j--;
    }
    j=2;        
/////////////////////////////////////ROTAR EXTREMOS DE LA CARA BLANCO
if (op==0){
   for (i=0;i<=2;i++){
   in.O[0][j]=aux[3][i]; ///CARA SUPERIOR
   in.B[0][j]=aux[0][i]; ///CARA DERECHA
   in.R[0][j]=aux[1][i]; ///CARA INFERIOR
    in.G[0][j]=aux[2][i]; ///CARA IZQUIERDA
    j--;
    }
    j=2;
    }else{ /////SENTIDO CONTRARIO
           for (i=0;i<=2;i++){
           in.O[0][j]=aux[1][i]; ///CARA SUPERIOR
           in.B[0][j]=aux[2][i]; ///CARA DERECHA
           in.R[0][j]=aux[3][i]; ///CARA INFERIOR
           in.G[0][j]=aux[0][i]; ///CARA IZQUIERDA
           j--;
           }
           j=2;
           }
////////////////////////////////////////////////////////////////
}else if (cara==5){ 
/////////////////////////////////////BACKUP EXTREMOS CARA ANARANJADO
  for (i=0;i<=2;i++){
  aux[0][i]=in.W[0][j]; ///CARA SUPERIOR
  aux[1][i]=in.G[i][0]; ///CARA DERECHA
  aux[2][i]=in.Y[2][j]; ///CARA INFERIOR
  aux[3][i]=in.B[j][2]; ///CARA IZQUIERDA
  j--;
  }
  j=2;        
/////////////////////////////////////ROTAR EXTREMOS DE LA CARA ANARANJADO
if (op==0){
   for (i=0;i<=2;i++){
   in.W[0][j]=aux[3][i]; ///CARA SUPERIOR
   in.G[i][0]=aux[0][i]; ///CARA DERECHA
   in.Y[2][j]=aux[1][i]; ///CARA INFERIOR
   in.B[j][2]=aux[2][i]; ///CARA IZQUIERDA
   j--;
   }
    j=2;
    }else{ /////SENTIDO CONTRARIO
       for (i=0;i<=2;i++){
       in.W[0][j]=aux[1][i]; ///CARA SUPERIOR
       in.G[i][0]=aux[2][i]; ///CARA DERECHA
       in.Y[2][j]=aux[3][i]; ///CARA INFERIOR
       in.B[j][2]=aux[0][i]; ///CARA IZQUIERDA
       j--;
       }
j      =2;
       }
////////////////////////////////////////////////////////////////
}else if (cara==6){ 
/////////////////////////////////////BACKUP EXTREMOS CARA AMARILLO
    for (i=0;i<=2;i++){
    aux[0][i]=in.R[2][i]; ///CARA SUPERIOR
    aux[1][i]=in.B[2][i]; ///CARA DERECHA
    aux[2][i]=in.O[0][j]; ///CARA INFERIOR
    aux[3][i]=in.G[2][j]; ///CARA IZQUIERDA
    j--;
    }
j=2;        
/////////////////////////////////////ROTAR EXTREMOS DE LA CARA AMARILLO
if (op==0){
   for (i=0;i<=2;i++){
   in.R[2][i]=aux[3][i]; ///CARA SUPERIOR
   in.B[2][i]=aux[0][i]; ///CARA DERECHA
   in.O[0][j]=aux[1][i]; ///CARA INFERIOR
   in.G[2][j]=aux[2][i]; ///CARA IZQUIERDA
   j--;
   }
j=2;
    }else{ /////SENTIDO CONTRARIO
       for (i=0;i<=2;i++){
       in.R[2][i]=aux[1][i]; ///CARA SUPERIOR
       in.B[2][i]=aux[2][i]; ///CARA DERECHA
       in.O[0][j]=aux[3][i]; ///CARA INFERIOR
       in.G[2][j]=aux[0][i]; ///CARA IZQUIERDA
j--;
}
j=2;
}
////////////////////////////////////////////////////////////////
}
     }
     
bool Tcubo::comprobar(){ //VER SI ES SOLUCION
int i,j;
a++;
for (i=0;i<=2;i++){
   for (j=0;j<=2;j++){   
    if (in.R[i][j]!='r'){return false;}
    }}
for (i=0;i<=2;i++){
  for (j=0;j<=2;j++){   
    if (in.B[i][j]!='b'){return false;}
    }}
for (i=0;i<=2;i++){
  for (j=0;j<=2;j++){   
    if (in.G[i][j]!='g'){return false;}
    }}
for (i=0;i<=2;i++){
     for (j=0;j<=2;j++){   
      if (in.Y[i][j]!='y'){return false;}
    }}
for (i=0;i<=2;i++){
   for (j=0;j<=2;j++){   
       if (in.W[i][j]!='w'){return false;}
    }}

return true;
     }

char Tcubo::getmov(int i, int j){char a; a=mov[i][j]; return a;}
int Tcubo::getcont_mov_mejor(){ return cont_mov_mejor; }     
void Tcubo::setcont_mov_mejor(int cont){ cont_mov_mejor=cont; }      
};
/////////////////////////////////////////////////////

char mov_mejor[100][2];
int Mpasos=20;
void  guardar(Tcubo cube,int cont){
int i,j;
 for (i=0;i<=cont;i++){  
  for (j=0;j<2;j++){      
    mov_mejor[i][j]=cube.getmov(i,j);

    }
    }    

}
/////////////////////////////////////////////////////////
void mejor_solucion(){
int i;
cout<<endl;
cout<<"Movimientos";
cout<<endl;
 for (i=0;i<=Mpasos;i++){  
    cout<<mov_mejor[i][0];
    cout<<mov_mejor[i][1];
    cout<<endl;
    }
    }
//////////////////////////////////////////////////////////////k


void resolver(int op, int count, int cara, Tcubo cube, int &Mpasos){

for(int j=0;j<=1;j++){ 
for(int i=1;i<=6;i++){     
op=j; cara=i; 
cube.copiar();
cube.rotar_cara_interna(op,count,cara);
cube.rotar_caras_externas(op,cara);
if (cube.comprobar()==true){
if(count<Mpasos){
Mpasos=count;                
guardar(cube,count);
}}
count++;
if (count<Mpasos){
cout<<count;    
resolver(op,count,cara,cube,Mpasos);}
count--;
cube.anterior();
}
}

}

int main(){
Tcubo cube;
int op, count=0, cara, prueba=0;
int datos[3][3];

cube.getdatos(); // Obtener Datos de entrada 


cube.copiar();

resolver(op,count,cara,cube,Mpasos);
mejor_solucion();
  system("PAUSE");
return EXIT_SUCCESS;
}

