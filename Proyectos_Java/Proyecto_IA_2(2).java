package proyecto_ia;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Scanner;
import java.util.Stack;



public class proyecto_ia {
 static Stack tributos = new Stack(); 
    static final int MAX = 999; //máximo número de filas y columnas del laberinto
    static char matriz2[][] = new char[ MAX ][ MAX ];    //laberinto
       
   
    
    
    private static boolean Verificar_atentado(char[][] matriz, int nx, int ny, int fila, int colu) {
        if ( ((nx+1<fila)&&(ny+1<colu)&&(matriz[nx+1][ny+1]=='T')) || ((nx-1>=0)&&(ny-1>=0)&&(matriz[nx-1][ny-1]=='T')) || ((nx-1>=0)&&(ny+1<colu)&&(matriz[nx-1][ny+1]=='T'))|| ((nx+1<fila)&&(ny-1>=0)&&(matriz[nx+1][ny-1]=='T')) ){
            return true;
        } else {
            return false;
        }
    }
    
    static class Estado{
        int x , y , d;   // Fila, columna y distancie del estado
        
        public Estado( int x1, int y1 , int d1){
            this.x = x1;
            this.y = y1;
            this.d = d1;
        }
        }
    

    public static void main (String[] args) throws IOException {
        
         //crear un ArrayList bidimensional de enteros vacío
        //Realmente se crea un ArrayList de ArrayLists de enteros
        ArrayList<ArrayList<Character>> matriz = new ArrayList<ArrayList<Character>>();
        
        Scanner lector = new Scanner(System.in);
        
        int fila, colu;
        fila = lector.nextInt();
        colu = lector.nextInt();
        
        //System.out.println("Mi fila y columna es: " + fila + " " + colu);
        
        //char matriz [] [] = new char [fila] [colu];
        String aux2;
        char aux;
        int posfilak = 0, poscoluk = 0 ;
        
        for (int j=0; j<fila; j++){
            aux2 = lector.next();
            matriz.add(new ArrayList<Character>());
            for (int i=0; i<colu; i++){
                aux = aux2.charAt(i);
                if(aux != '\n'){
                matriz.get(i).add(aux);
                }
                if (aux == 'K'){
                    poscoluk = i;
                    posfilak = j;
                }
                
                if (aux == 'T'){
                    tributos.push('T');
                }
                
            }
        }
        
      /*  for (int j2=0; j2<fila; j2++){
            for (int i2=0; i2<colu; i2++){
                System.out.print(matriz[j2][i2]+ " ");
                
            }
            System.out.println();
        }
        
        System.out.println("K está en la posición:"+posfilak+" "+poscoluk);
        */
        boolean muerto = false;
        boolean muerta = false;
        boolean esquinas_y_rodeados = false;
        
        muerta = Verificar_katniss(matriz, posfilak, poscoluk, fila, colu);
        muerto = Verificar_vecinos(matriz, posfilak, poscoluk, fila, colu);
        esquinas_y_rodeados = esquinas_y_rodeados(matriz,fila,colu);
        
        if (muerto == true || muerta==true  || esquinas_y_rodeados==true ) {
            System.out.println("Simulation Success. Katniss is Doomed");
        } else {
            
            //SI EN EL INICIO NO TENGO TRIBUTOS Y NO ESTOY ATRAPADO EN OBSTACULOS, REALIZO EL BFS
            Verificar_tributo(matriz, posfilak, poscoluk, fila, colu);
            
            int min = BFS( posfilak , poscoluk , fila , colu );
            
            //si no existe un camino, desde Katniss a un tributo, entonces muere... :(
            if (min== -1) {
                System.out.println("Simulation Success. Katniss is Doomed");
            } else {
                System.out.println("Simulation Failed. Katniss Won");
            }
            
        }
        
    }
    
             private static boolean esquinas_y_rodeados(ArrayList<ArrayList<Character>> matriz, int fila, int colu) {
                 if(matriz.get(0).get(0) == 'T' && matriz.get(0).get(1)] == '*' && matriz.get(1).get(0) == '*'){return true;}
                 if(matriz.get(fila).get(colu) == 'T' && matriz.get(fila-2).get(colu) == '*' && matriz[fila][colu-1] == '*'){return true;}
                 if(matriz[0][colu] == 'T' && matriz[0][colu-2] == '*' && matriz[1][colu] == '*'){return true;}
                 if(matriz[fila][0] == 'T' && matriz[fila][1] == '*' && matriz[fila-2][0] == '*'){return true;}
                 
                 
                 return false;
             } 
    
    

    private static boolean Verificar_vecinos(char[][] matriz, int posfilak, int poscoluk, int fila, int colu) {
       if ((((posfilak+1<fila) && (matriz[posfilak+1][poscoluk] == 'T'))) || ((posfilak-1 > -1) && (matriz[posfilak-1][poscoluk] == 'T')) || ((poscoluk+1<colu) && (matriz[posfilak][poscoluk+1] == 'T')) || ((poscoluk-1 > -1) && (matriz[posfilak][poscoluk-1] == 'T'))){
           return true;
       } else {
           return false;
       }
       
    }
         private static void disparar(char[][] matriz, int posfilak, int poscoluk, int fila, int colu) {
      
            for (int i=posfilak ; i<fila; i++){
            if(matriz[i+1][poscoluk] == '*' ){ break; } 
            if(matriz[i+1][poscoluk] == 'T' ){tributos.pop(); matriz[i+1][poscoluk] = '.'; } 
            }
            for (int i=posfilak ; i>0; i--){
            if(matriz[i-1][poscoluk] == '*' ){ break; } 
            if(matriz[i-1][poscoluk] == 'T' ){ tributos.pop(); matriz[i-1][poscoluk] = '.'; } 
            }    
            for (int j=poscoluk; j<colu; j++){
            if(matriz[posfilak][j+1] == '*' ){ break; } 
            if(matriz[posfilak][j+1] == 'T' ){ tributos.pop();matriz[posfilak][j+1] = '.'; } 
            }
            for (int j=poscoluk; j>0; j--){
            if(matriz[posfilak][j-1] == '*' ){ break; } 
            if(matriz[posfilak][j-1] == 'T' ){ tributos.pop(); matriz[posfilak][j-1] = '.'; } 
            }
            }   
    

    private static void Verificar_tributo(char[][] matriz, int posfilak, int poscoluk, int fila, int colu) {
        
        
        //---------------PARA LAS FILAS----------------------------------------------------
            Stack pila = new Stack();
        
            boolean estado=false;
        
            //int p1 = posfilak-1, p2 = poscoluk-1;
            int p1 = -1;    
        
            for (int iter=0; iter<colu; iter++){
                char auxi = matriz [posfilak] [iter];
                
                //estado falso implica desde Katniss hacia la izquierda
                if (estado==false){
                    if (auxi=='*'){
                        pila.push('*');
                        p1 = p1+1;
                        //p2 = p2+1;
                    } else if (auxi=='.') {
                        pila.push('.');
                        p1 = p1+1;
                        //p2 = p2+1;
                    } else if (auxi=='T') {
                        pila.push('T');
                        p1 = p1+1;
                        //p2 = p2+1;
                    } else {
                        
                        pila.push('K');
                        p1 = p1+1;
                        
                        while (!pila.isEmpty()){
                            char tope = (char) pila.pop();
                            
                            if (tope=='.'){
                                p1 = p1-1;
                                
                            } else if (tope=='T'){
                                matriz[posfilak][p1] = '.';
                                tributos.pop();
                                p1 = p1-1;
                                
                            } else if (tope=='K'){
                                p1 = p1-1;
                            } else {
                                pila.clear();
                            }
                                        
                        }
                        pila.clear(); //Limpio la pila y voy al otro estado
                        estado = true;
                    }
                    
                } else {
                    // estado verdadero indica desde Katniss hacia la derecha
                    
                    if (iter<colu-1){
                        
                        pila.push(auxi);
                        
                    } else {
                        
                        pila.push(auxi);
                        //p2 = p2+1;
                        
                        int p2 = poscoluk+1;
                        //int p2 = colu-1;
                        Stack pilaux = new Stack();

                        while(!pila.isEmpty() ) {
                            pilaux.push(pila.pop());
                        }
                        
                        while (!pilaux.isEmpty()){
                            char tope = (char) pilaux.pop();
                            
                            if (tope=='.'){
                                p2 = p2+1;
                                
                            } else if (tope=='T'){
                                
                                matriz[posfilak][p2] = '.';
                                tributos.pop();
                                p2 = p2+1;
                                
                                
                            } else {
                                pilaux.clear();
                            }
                                        
                        }
                    }
                    
                    
                    
                    estado = true;
                    
                }
                
            }
            //---------------PARA LAS FILAS----------------------------------------------------
            
            
            
            //---------------PARA LAS COLUMNAS----------------------------------------------------
            Stack pila2 = new Stack();
        
            boolean estado2=false;
        
            //int p1 = posfilak-1, p2 = poscoluk-1;
            int pc1 = -1;    
        
            for (int iterc=0; iterc<fila; iterc++){
                char auxi2 = matriz [iterc] [poscoluk];
                
                //estado falso implica desde Katniss hacia la izquierda
                if (estado2==false){
                    if (auxi2=='*'){
                        pila2.push('*');
                        pc1 = pc1+1;
                        //p2 = p2+1;
                    } else if (auxi2=='.') {
                        pila2.push('.');
                        pc1 = pc1+1;
                        //p2 = p2+1;
                    } else if (auxi2=='T') {
                        pila2.push('T');
                        pc1 = pc1+1;
                        //p2 = p2+1;
                    } else {
                        
                        pila2.push('K');
                        pc1 = pc1+1;
                        
                        while (!pila2.isEmpty()){
                            char tope2 = (char) pila2.pop();
                            
                            if (tope2=='.'){
                                pc1 = pc1-1;
                                
                            } else if (tope2=='T'){
                                matriz[pc1][poscoluk] = '.';
                                tributos.pop();
                                pc1 = pc1-1;
                                
                            } else if (tope2=='K'){
                                pc1 = pc1-1;
                            } else {
                                pila2.clear();
                            }
                                        
                        }
                        pila2.clear(); //Limpio la pila y voy al otro estado
                        estado2 = true;
                    }
                    
                } else {
                    // estado verdadero indica desde Katniss hacia la derecha
                    
                    if (iterc<fila-1){
                        
                        pila2.push(auxi2);
                        
                    } else {
                        
                        pila2.push(auxi2);
                        //p2 = p2+1;
                        
                        int pc2 = posfilak+1;
                        //int p2 = colu-1;
                        Stack pilaux2 = new Stack();

                        while(!pila2.isEmpty() ) {
                            pilaux2.push(pila2.pop());
                        }
                        
                        while (!pilaux2.isEmpty()){
                            char tope2 = (char) pilaux2.pop();
                            
                            if (tope2=='.'){
                                pc2 = pc2+1;
                                
                            } else if (tope2=='T'){
                                
                                matriz[pc2][poscoluk] = '.';
                                tributos.pop();
                                pc2 = pc2+1;
                                
                                
                            } else {
                                pilaux2.clear();
                            }
                                        
                        }
                    }
                    
                    
                    
                    estado2 = true;
                    
                }
                
            }
            //---------------PARA LAS COLUMNAS----------------------------------------------------
            
            
            
            /*
            //---------IMPRIMO EL ESTADO FINAL DE LA MATRIZ-----------------------------------------------
            
            for (int m=0; m<fila; m++){
                for (int n=0; n<colu; n++){
                    System.out.print(matriz[m][n]+" ");
                }
                System.out.println();
            }
            //---------IMPRIMO EL ESTADO FINAL DE LA MATRIZ-----------------------------------------------
            */
            
    }

    private static boolean Verificar_katniss(char[][] matriz, int posfilak, int poscoluk, int fila, int colu) {
         if ((((posfilak+1<fila) && (matriz[posfilak+1][poscoluk] == '*'))) && ((posfilak-1 > -1) && (matriz[posfilak-1][poscoluk] == '*')) && ((poscoluk+1<colu) && (matriz[posfilak][poscoluk+1] == '*')) && ((poscoluk-1 > -1) && (matriz[posfilak][poscoluk-1] == '*'))){
           return true;
       } else {
           return false;
       }
    }

    private static int BFS(int posfilak, int poscoluk, int fila, int colu) {
        
        boolean visitado[][] = new boolean[ MAX ][ MAX ];   //arreglo de estados visitados
        
        //INICIALIZO MI MATRIZ DE VISITADOS
        for (int u1=0; u1<MAX; u1++){
            for (int u2=0; u2<MAX; u2++){
                visitado[u1][u2] = false;
            }
        }
        
        
        Queue <Estado> Q = new LinkedList <Estado>();   //Cola de todos los posibles Estados por los que se pase para llegar al destino
        Q.add( new Estado( posfilak , poscoluk , 0 ) ); //Insertamos el estado inicial en la Cola con distnacia 0.
                int dx[  ] = { 0 ,  0 , 1 , -1 };       //incremento en coordenada x
        int dy[  ] = { 1 , -1 , 0 ,  0 };       //incremento en coordenada y
        int nx, ny;
   
                if (tributos.isEmpty()){
                    return 1; // SI AL LLAMAR A TRIBUTO, TODOS MURIERON, ENTONCES RETORNO 1
                }
                
        while( !Q.isEmpty()){               //Mientras cola no este vacia
            Estado actual = Q.remove();     //Obtengo de la cola el estado actual, en un comienzo será el inicial
                        disparar(matriz, actual.x,  actual.y, fila, colu);
                        Verificar_tributo(matriz, actual.x,  actual.y, fila, colu);
                        
                        if (tributos.isEmpty()){
                            return 1; // SI AL LLAMAR A TRIBUTO, TODOS MURIERON, ENTONCES RETORNO 1
                        }
                        
                        
            visitado[ actual.x ][ actual.y ] = true;//Marco como visitado dicho estado para no volver a recorrerlo
            int nxaux, nyaux;
                        nxaux = actual.x; nyaux=actual.y;
            for( int i = 0 ; i < 4 ; i++ ){     //Recorremos hasta 4 porque tenemos 4 posibles adyacentes
                                nx = dx[ i ] + actual.x;    //nx y ny tendran la coordenada adyacente
                ny = dy[ i ] + actual.y;    //ejemplo en i=0 y actual (3,4) -> 3+dx[0]=3+0=3, 4+dy[0]=4+1=5, nueva coordenada (3,5)
                //aqui comprobamos que la coordenada adyacente no sobrepase las dimensiones del laberinto
                //ademas comprobamos que no sea pared "#" y no este visitado
                
                if( nx >= 0 && nx < fila && ny >= 0 && ny < colu && (visitado[nx][ny]==false) && matriz[ nx ][ ny ] != '*' && matriz[ nx ][ ny ] == '.' && !Verificar_atentado(matriz, nx, ny, fila, colu) && !Verificar_vecinos(matriz, nx, ny, fila,colu)){
                     disparar(matriz, nx,  ny, fila, colu);
                    Verificar_tributo(matriz, nx,  ny, fila, colu);    
                                       // System.out.println("Me muevo a la posición: "+nx+" "+ny);
                                        Q.add( new Estado( nx , ny , actual.d + 1 ) ); //agregamos estado adyacente aumento en 1 la distancia recorrida
                                       visitado[ nx ][ ny ] = true;
                }
            }
        }
                
                return -1;
    }

    
    

}
