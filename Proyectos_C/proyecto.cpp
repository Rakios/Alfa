#include <iostream>
#include <string.h>
using namespace std;
class Colap{
      private: // DECLARACION DE LA CLASSE LISTA
              class Nodo{
                    char caracter;
                    int frecuencia;
                    Nodo *prox,*ant;
                    friend class Colap;
     };
       
    typedef Nodo* pos;
   	pos prim,ult;
    int n;
   
    public:
    Colap() {prim=NULL; ult=NULL; n=0;} //CONSTRUCTOR
}

class Arbol{
      private: // DECLARACION DE LA CLASSE LISTA
              class rama{
                    char caracter;
                    int frecuencia;
                    rama *prox,*ant;
                    friend class Arbol;
     };
       
    typedef Nodo* pos;
   	pos prim,ult;
    int n;
   
    public:
    Arbol() {prim=NULL; ult=NULL; n=0;} //CONSTRUCTOR
}

return 0;}
