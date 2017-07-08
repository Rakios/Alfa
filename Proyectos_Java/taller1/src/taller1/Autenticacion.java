/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package taller1;
import java.io.*; 

public class Autenticacion {
    String login;
    String clave;
    

  
    public boolean verificarLogin(String login){
    String loginreal="";
    String clavereal="";
    int con=0;
    
      File archivo = null;
      FileReader fr = null;
      BufferedReader br = null;
      
 
      try {

         archivo = new File ("C:\\login_claves.txt");
         fr = new FileReader (archivo);
         br = new BufferedReader(fr);
         String linea;
         while((linea=br.readLine())!=null){
         
         loginreal=linea;
         linea=br.readLine();
         clavereal=linea;

         
         if(loginreal.equalsIgnoreCase(login)){
         return true; 
         }
         
      }
      }catch(Exception e){
         e.printStackTrace();
      }finally{

         try{                    
            if( null != fr ){   
               fr.close();     
            }                  
         }catch (Exception e2){ 
            e2.printStackTrace();
         }
      }
   return false;
}



public boolean verificarClave(String login, String clave){
    String loginreal="";
    String clavereal="";

      File archivo = null;
      FileReader fr = null;
      BufferedReader br = null;
      
 
      try {

         archivo = new File ("C:\\login_claves.txt");
         fr = new FileReader (archivo);
         br = new BufferedReader(fr);
         String linea;
         while((linea=br.readLine())!=null){
         
         loginreal=linea;
         linea=br.readLine();
         clavereal=linea;
         
         if(loginreal.equalsIgnoreCase(login)){
             if(clavereal.equalsIgnoreCase(clave)){
             return true; 
         }
      }
         }
      }catch(Exception e){
         e.printStackTrace();
      }finally{

         try{                    
            if( null != fr ){   
               fr.close();     
            }                  
         }catch (Exception e2){ 
            e2.printStackTrace();
         }
      }
   return false;
}
}