package proyecto_ia;

import java.io.IOException;
import java.util.Scanner;
import java.util.Stack;


public class Proyecto_IA {

    public static void main(String[] args) throws IOException {
        
        Scanner lector = new Scanner(System.in);
        
        Integer fila, colu;
        fila = lector.nextInt();
        colu = lector.nextInt();
        
        System.out.println("Mi fila y columna es: " + fila + " " + colu);
        
        String matriz [] [] = new String [fila] [colu];
        String aux;
        Integer posfilak = null, poscoluk = null;
        
        for (int j=0; j<fila; j++){
            for (int i=0; i<colu; i++){
                aux = lector.next();
                matriz[j][i] = aux;
                
                if (aux.equals("K")){
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

    private static boolean Verificar_vecinos(String[][] matriz, Integer posfilak, Integer poscoluk, Integer fila, Integer colu) {
       //if ((((matriz[posfilak+1][poscoluk]!= null) && matriz[posfilak+1][poscoluk].equals("T"))) || ((matriz[posfilak-1][poscoluk] != null) && matriz[posfilak-1][poscoluk].equals("T")) || ((matriz[posfilak][poscoluk+1]!= null) && matriz[posfilak][poscoluk+1].equals("T")) || ((matriz[posfilak][poscoluk-1]!=null) && matriz[posfilak][poscoluk-1].equals("T"))){
       if ((((posfilak+1<fila) && matriz[posfilak+1][poscoluk].equals("T"))) || ((posfilak-1 > -1) && matriz[posfilak-1][poscoluk].equals("T")) || ((poscoluk+1<colu) && matriz[posfilak][poscoluk+1].equals("T")) || ((poscoluk-1 > -1) && matriz[posfilak][poscoluk-1].equals("T"))){
           return true;
       } else {
           return false;
       }
    
    }

    private static void Verificar_tributo(String[][] matriz, Integer posfilak, Integer poscoluk, Integer fila, Integer colu) {
        
        Stack pila = new Stack();
        boolean estado=false;
        
            //Integer p1 = posfilak-1, p2 = poscoluk-1;
            Integer p1 = -1;    
        
            for (int iter=0; iter<colu; iter++){
                String auxi = matriz [posfilak] [iter];
                
                //estado falso implica desde Katniss hacia la izquierda
                if (estado==false){
                    if (auxi.equals("*")){
                        pila.push("*");
                        p1 = p1+1;
                        //p2 = p2+1;
                    } else if (auxi.equals(".")) {
                        pila.push(".");
                        p1 = p1+1;
                        //p2 = p2+1;
                    } else if (auxi.equals("T")) {
                        pila.push("T");
                        p1 = p1+1;
                        //p2 = p2+1;
                    } else {
                        
                        pila.push("K");
                        p1 = p1+1;
                        
                        while (!pila.isEmpty()){
                            String tope = (String) pila.pop();
                            
                            if (tope.equals(".")){
                                p1 = p1-1;
                                
                            } else if (tope.equals("T")){
                                matriz[posfilak][p1] = ".";
                                p1 = p1-1;
                                
                            } else if (tope.equals("K")){
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
                        
                        Integer p2 = poscoluk+1;
                        //Integer p2 = colu-1;
                        Stack pilaux = new Stack();

                        while(!pila.isEmpty() ) {
                            pilaux.push(pila.pop());
                        }
                        
                        while (!pilaux.isEmpty()){
                            String tope = (String) pilaux.pop();
                            
                            if (tope.equals(".")){
                                p2 = p2+1;
                                
                            } else if (tope.equals("T")){
                                
                                matriz[posfilak][p2] = ".";
                                p2 = p2+1;
                                
                                
                            } else {
                                pilaux.clear();
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
