package proyecto_ia;
import java.io.IOException;
import java.util.Scanner;
import java.util.Stack;


public class proyecto_ia {

    public static void main (String[] args) throws IOException {
        
        Scanner lector = new Scanner(System.in);
        
        Integer fila, colu;
        fila = lector.nextInt();
        colu = lector.nextInt();
        
        System.out.println("Mi fila y columna es: " + fila + " " + colu);
        
        char matriz [] [] = new char [fila] [colu];
        String aux2;
        char aux;
        Integer posfilak = null, poscoluk = null;
        
        for (int j=0; j<fila; j++){
            aux2 = lector.next();
            for (int i=0; i<colu; i++){
                aux = aux2.charAt(i);
                if(aux != '\n'){
                matriz[j][i] = aux;
                }
                if (aux == 'K'){
                    poscoluk = i;
                    posfilak = j;
                }
                
            }
        }
        
        for (int j2=0; j2<fila; j2++){
            for (int i2=0; i2<colu; i2++){
                System.out.print(matriz[j2][i2]+ " ");
                
            }
            System.out.println();
        }
        
        System.out.println("K está en la posición:"+posfilak+" "+poscoluk);
        
        boolean muerto;
        
        muerto = Verificar_vecinos(matriz, posfilak, poscoluk, fila, colu);
        
        if (muerto == true){
            System.out.println("Simulation Success. Katniss is Doomed");
        } else {
            
            Verificar_tributo(matriz, posfilak, poscoluk, fila, colu);
            
        }
        
    }

    private static boolean Verificar_vecinos(char[][] matriz, Integer posfilak, Integer poscoluk, Integer fila, Integer colu) {
       //if ((((matriz[posfilak+1][poscoluk]!= null) && matriz[posfilak+1][poscoluk] == 'T')) || ((matriz[posfilak-1][poscoluk] != null) && matriz[posfilak-1][poscoluk] == 'T') || ((matriz[posfilak][poscoluk+1]!= null) && matriz[posfilak][poscoluk+1] == 'T') || ((matriz[posfilak][poscoluk-1]!=null) && matriz[posfilak][poscoluk-1] == 'T')){
       if ((((posfilak+1<fila) && (matriz[posfilak+1][poscoluk] == 'T'))) || ((posfilak-1 > -1) && (matriz[posfilak-1][poscoluk] == 'T')) || ((poscoluk+1<colu) && (matriz[posfilak][poscoluk+1] == 'T')) || ((poscoluk-1 > -1) && (matriz[posfilak][poscoluk-1] == 'T'))){
           return true;
       } else {
           return false;
       }
    
    }

    private static void Verificar_tributo(char[][] matriz, Integer posfilak, Integer poscoluk, Integer fila, Integer colu) {
        
        Stack pila = new Stack();
        boolean estado=false;
        
            //Integer p1 = posfilak-1, p2 = poscoluk-1;
            Integer p1 = -1;    
        
            for (int iter=0; iter<colu; iter++){
                char auxi = matriz [posfilak] [iter];
                
                //estado falso implica desde Katniss hacia la izquierda
                if (estado==false){
                    switch (auxi) {
                        case '*':
                            pila.push('*');
                            p1 = p1+1;
                            //p2 = p2+1;
                            break;
                        case '.':
                            pila.push('.');
                            p1 = p1+1;
                            //p2 = p2+1;
                            break;
                        case 'T':
                            pila.push('T');
                            p1 = p1+1;
                            //p2 = p2+1;
                            break;
                        default:
                            pila.push('K');
                            p1 = p1+1;
                            while (!pila.isEmpty()){
                                char tope = (char) pila.pop();
                                
                        switch (tope) {
                            case '.':
                                p1 = p1-1;
                                break;
                            case 'T':
                                matriz[posfilak][p1] = '.';
                                p1 = p1-1;
                                break;
                            case 'K':
                                p1 = p1-1;
                                break;
                            default:
                                pila.clear();
                                break;
                        }
                                
                            }   pila.clear(); //Limpio la pila y voy al otro estado
                            estado = true;
                            break;
                    }
                    
                } else {
                    // estado verdadero indica desde Katniss hacia la derecha
                    
                    if (iter<colu-1){
                        
                        pila.push(auxi);
                        
                    } else {
                        
                        pila.push(auxi);
                        //p2 = p2+1;
                        
                        Integer p2 = poscoluk+1;
                        //Integer p2 = colu-1;
                        Stack pilaux = new Stack();

                        while(!pila.isEmpty() ) {
                            pilaux.push(pila.pop());
                        }
                        
                        while (!pilaux.isEmpty()){
                            char tope = (char) pilaux.pop();
                            
                            switch (tope) {
                                case '.':
                                    p2 = p2+1;
                                    break;
                                case 'T':
                                    matriz[posfilak][p2] = '.';
                                    p2 = p2+1;
                                    break;
                                default:
                                    pilaux.clear();
                                    break;
                            }
                                        
                        }
                    }
                    
                    
                    
                    estado = true;
                    
                }
                
            }
            
            
            for (int m=0; m<fila; m++){
                for (int n=0; n<colu; n++){
                    System.out.print(matriz[m][n]+" ");
                }
                System.out.println();
            }
            
            
            
    }
    

}
