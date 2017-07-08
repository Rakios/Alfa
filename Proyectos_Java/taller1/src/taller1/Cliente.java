package taller1;

import java.util.*;

public class Cliente {

    public static void main(String[] args) {
    String inlogin;
    String inclave;
    
    Autenticacion Auten = new Autenticacion();
        boolean b;
        Scanner rd= new Scanner(System.in);
        System.out.println("Login: ");
        Scanner in= new Scanner(System.in);
         inlogin = in.nextLine();
         b=Auten.verificarLogin(inlogin);
            if(b==true){
            System.out.println("Clave: ");
            inclave = in.nextLine();
            b=Auten.verificarClave(inlogin,inclave);
               if(b==true){
                System.out.println("autenticación exitosa");    
                }else{
                System.out.println("Clave Invalida");    
               }
              
    }else{
                System.out.println("Login Invalido");
            }
    
}
}
