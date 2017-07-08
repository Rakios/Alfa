package algoritmos_geneticos;

import java.awt.BorderLayout;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

class Maestro {
    //Atributos
    //ArrayList <Float> Efectividad = new ArrayList();
    //ArrayList <Float> Stamina = new ArrayList();
    float Efectividad, Stamina;
    //Métodos
    public void Cargar_Efectividad(float e){
        //Efectividad.add(e);
        Efectividad = e;
    }
    
    public void Cargar_Stamina(float s){
        //Stamina.add(s);
        Stamina = s;
    }
    
    public float Consultar_Efectividad(){
        //Efectividad.add(e);
        float e;
        e = Efectividad;
        return e;
    }
    
    public float Consultar_Stamina(){
        //Stamina.add(s);
        float s;
        s = Stamina;
        return s;
    }
}

class Equipo{

    Maestro agua, tierra, fuego;
    
    public void Cargar_equipo(Maestro i1, Maestro i2, Maestro i3 ){
    agua=i1;
    tierra=i2;
    fuego=i3;
    }
    
    public Maestro Obtener_Mfuego(){
    
        return fuego;
    }
    
    public Maestro Obtener_Magua(){
    
        return agua;
    }
    
    public Maestro Obtener_Mtierra(){
    
        return tierra;
    }

}


public class Algoritmos_Geneticos {
    
    private static void Procesar_Archivo(String narchi, String aux, ArrayList <Maestro> Fuego, ArrayList <Maestro> Agua, ArrayList <Maestro> Tierra) throws FileNotFoundException, IOException {
        
        float n, n1, n2;
        String nombre = "C:\\Users\\LENOVO\\Desktop\\" + narchi;
        File archivo = new File (nombre);
        
        FileReader fr = new FileReader (archivo);
        BufferedReader br = new BufferedReader(fr);
        String linea = br.readLine();
        n = Integer.parseInt(linea);
        
       
        if (aux.equals("Fuego")) {
            for (int i=0; i<n; i++) {
            Maestro individuo = new Maestro();
            linea = br.readLine();
            String[] lineas = linea.split(" ");
            
            String part1 = lineas[0]; 
            n1 = Float.parseFloat(part1);
            String part2 = lineas[1];
            n2 = Float.parseFloat(part2);
            individuo.Cargar_Stamina(n2);
            individuo.Cargar_Efectividad(n1);
            Fuego.add(individuo);
            }
            
        } else if ((aux.equals("Agua")) ) {
            for (int i=0; i<n; i++) {
            Maestro individuo = new Maestro();
            linea = br.readLine();
            String[] lineas = linea.split(" ");
            
            String part1 = lineas[0]; 
            n1 = Float.parseFloat(part1);
            String part2 = lineas[1];
            n2 = Float.parseFloat(part2);
            individuo.Cargar_Stamina(n2);
            individuo.Cargar_Efectividad(n1);
            Agua.add(individuo);
            }
        } else {
            for (int i=0; i<n; i++) {
            Maestro individuo = new Maestro();
            linea = br.readLine();
            String[] lineas = linea.split(" ");
            
            String part1 = lineas[0]; 
            n1 = Float.parseFloat(part1);
            String part2 = lineas[1];
            n2 = Float.parseFloat(part2);
            individuo.Cargar_Stamina(n2);
            individuo.Cargar_Efectividad(n1);
            Tierra.add(individuo);
            }
        }
    
    
}
   
    private static Equipo Select_Torneo(Equipo favor, Equipo contra, ArrayList Equipos) {
        int indice1 = 0 , indice2 = 0;
        Equipo elduro = new Equipo();
        float x1, y1, z1, x2, y2, z2;
        
        x1 = Faptitud(favor.Obtener_Magua());
        y1 = Faptitud(favor.Obtener_Mfuego());
        z1 = Faptitud(favor.Obtener_Mtierra());
        
        x2 = Faptitud(contra.Obtener_Magua());
        y2 = Faptitud(contra.Obtener_Mfuego());
        z2 = Faptitud(contra.Obtener_Mtierra());
        
        if (x1>=x2){
            indice1++;
        } else {
            indice2++;
        }
        
        if (y1>=y2){
            indice1++;
        } else {
            indice2++;
        }
        
        if (z1>=z2){
            indice1++;
        } else {
            indice2++;
        }
        
        if (indice1>indice2){
            elduro.Cargar_equipo(favor.Obtener_Magua(), favor.Obtener_Mtierra(), favor.Obtener_Mfuego());
        } else if (indice1<indice2){
            elduro.Cargar_equipo(contra.Obtener_Magua(), contra.Obtener_Mtierra(), contra.Obtener_Mfuego());
        } else {
            int select1 = (int) (Math.random()*Equipos.size());
            elduro = Select_Torneo(favor, (Equipo) Equipos.get(select1), Equipos);
        }
        
        return elduro;
    }
     
    private static float Faptitud(Maestro master){
        
        float x, y, aux;
        x = master.Consultar_Efectividad();
        y = master.Consultar_Stamina();
        
        aux = 3*y-5*x;
        
        return aux;
    }
    
    
    public static void main(String[] args) throws IOException {
   
        ArrayList <Maestro> MFuego = new ArrayList();
        ArrayList <Maestro> MTierra = new ArrayList();
        ArrayList <Maestro> MAgua = new ArrayList();
        
        //Almacenar datos de los archivos
        
        //System.out.println(aux);
        Procesar_Archivo("Agua.txt", "Agua", MFuego, MAgua, MTierra);
        
        
        //System.out.println(aux);
        Procesar_Archivo("Tierra.txt", "Tierra", MFuego, MAgua, MTierra);
        
        
        //System.out.println(aux);
        Procesar_Archivo("Fuego.txt", "Fuego", MFuego, MAgua, MTierra);
        
        ArrayList <Maestro> CFuego = new ArrayList();
        ArrayList <Maestro> CAgua = new ArrayList();
        ArrayList <Maestro> CTierra = new ArrayList();
        
        
        //En CFuego almaceno los mejores de fuego
        Maestro individuo1;
            individuo1 = MFuego.get(0);
            MFuego.remove(0);
            float max;
            max = Faptitud(individuo1);
            CFuego.add(individuo1);
        
        for (int k=0; k<MFuego.size(); k++){
            Maestro individuo;
            individuo = MFuego.get(k);
             
            float ref;
            ref = Faptitud(individuo);
            
            if (ref>=max){
                CFuego.add(0, individuo);
            } else {
                CFuego.add(individuo);
            }
            
        }
        
        //En CAgua almaceno los mejores de agua
        Maestro individuo3;
            individuo3 = MAgua.get(0);
            MAgua.remove(0);
            float max2;
            max2 = Faptitud(individuo3);
            CAgua.add(individuo3);
        
        for (int k2=0; k2<MAgua.size(); k2++){
            Maestro individuo2;
            individuo2 = MAgua.get(k2);
           
            float ref2;
            ref2 = Faptitud(individuo2);
            
            if (ref2>=max2){
                CAgua.add(0, individuo2);
            } else {
                CAgua.add(individuo2);
            } 
        }
        
        //En CTierra almaceno los mejores de tierra
        Maestro individuo5;
            individuo5 = MTierra.get(0);
            MTierra.remove(0);
            float max3;
            max3 = Faptitud(individuo5);
            CTierra.add(individuo5);
        
        for (int k3=0; k3<MTierra.size(); k3++){
            Maestro individuo4;
            individuo4 = MTierra.get(k3);
            
            
            float ref3;
            ref3 = Faptitud(individuo4);
            
            if (ref3>=max3){
                CTierra.add(0, individuo4);
            } else {
                CTierra.add(individuo4);
            }
            
        }
        
        ArrayList <Integer> pesos;
        pesos = new ArrayList();
        
        pesos.add(CAgua.size());
        pesos.add(CFuego.size());
        pesos.add(CTierra.size());
        
        ArrayList <Integer> cpesos;
        cpesos = new ArrayList();
        
        for (int q=0; q<pesos.size(); q++){
            cpesos.add(pesos.get(q));
        }
        
        cpesos.sort(null);
        
        int maximo;
        
        maximo = cpesos.get(2);
        
        if (pesos.get(0)<maximo){
            int conteo = 0;
            for (int w=pesos.get(0); w<=maximo; w++){
                Maestro copia;
                copia = CAgua.get(conteo);
                CAgua.add(copia);
                conteo++;
            }
        }
        
        if (pesos.get(1)<maximo){
            int conteo2 = 0;
            for (int w2=pesos.get(1); w2<=maximo; w2++){
                Maestro copia2;
                copia2 = CFuego.get(conteo2);
                CFuego.add(copia2);
                conteo2++;
            }
        }
        
        if (pesos.get(2)<maximo){
            int conteo3 = 0;
            for (int w3=pesos.get(2); w3<=maximo; w3++){
                Maestro copia3;
                copia3 = CTierra.get(conteo3);
                CTierra.add(copia3);
                conteo3++;
            }
        }
        
        ArrayList <Equipo> Lequipo;
        Lequipo = new ArrayList();
        
        ArrayList <Equipo> CLequipo;
        CLequipo = new ArrayList();
        
        //************CREO MI LISTA DE EQUIPOS**********************************
        while (!CTierra.isEmpty() && !CAgua.isEmpty() && !CFuego.isEmpty()){
            
            Maestro tipo1, tipo2, tipo3;
            tipo1 = CAgua.get(0);
            CAgua.remove(0);
            tipo2 = CTierra.get(0);
            CTierra.remove(0);
            tipo3 = CFuego.get(0);
            CFuego.remove(0);
            
            Equipo miequipo = new Equipo();
            miequipo.Cargar_equipo(tipo1, tipo2, tipo3);
            Lequipo.add(miequipo);
            CLequipo.add(miequipo);
        }
        
        int tam = Lequipo.size();
        
        
        int cuenta = 0;
        ArrayList <Equipo> eaux;
        eaux = new ArrayList();
        
        while (cuenta<500){
            for (int itera=0; itera<tam; itera++){
                int select1, select2;
                select1 = (int) (Math.random()*tam);
                select2 =  (int) (Math.random()*tam);
                Equipo favor, contra, ganador;
                
                favor = CLequipo.get(select1);
                contra = CLequipo.get(select2);
               
                ganador = Select_Torneo(favor, contra, Lequipo);
                eaux.add(ganador);
                //maux2.add(ganador);
            }
            
            CLequipo.clear();
            
            for (int a=0; a<eaux.size(); a++){
                CLequipo.add(eaux.get(a));
            }
            eaux.clear();
            cuenta++;
        }
        
        for (int t=0; t<CLequipo.size(); t++){
            Equipo visor;
            
            visor = CLequipo.get(t);
            
            Maestro desc1, desc2, desc3;
            
            desc1 = visor.Obtener_Magua();
            desc2 = visor.Obtener_Mfuego();
            desc3 = visor.Obtener_Mtierra();
            
            System.out.print((int) desc1.Consultar_Efectividad()+ " "+ (int) desc1.Consultar_Stamina());
            System.out.print(" ");
            System.out.print((int) desc2.Consultar_Efectividad()+ " "+ (int) desc2.Consultar_Stamina());
            System.out.print(" ");
            System.out.print((int) desc3.Consultar_Efectividad()+ " "+ (int) desc3.Consultar_Stamina());
            System.out.println();
            
            
        }
        Object [] fila = new Object[3];
        fila[0] = "Agua";
        fila[1] = (int) CLequipo.get(0).Obtener_Magua().Consultar_Stamina();
        fila[2] = (int) CLequipo.get(0).Obtener_Magua().Consultar_Efectividad();
        
        Object [] fila2 = new Object[3];
        fila2[0] = "Fuego";
        fila2[1] = (int) CLequipo.get(0).Obtener_Mfuego().Consultar_Stamina();
        fila2[2] = (int) CLequipo.get(0).Obtener_Mfuego().Consultar_Efectividad();
        
        Object [] fila3 = new Object[3];
        fila3[0] = "Tierra";
        fila3[1] = (int) CLequipo.get(0).Obtener_Mtierra().Consultar_Stamina();
        fila3[2] = (int) CLequipo.get(0).Obtener_Mtierra().Consultar_Efectividad();

        DefaultTableModel modelo;
        modelo = new DefaultTableModel();
        JFrame frame = new JFrame();
        JTable tabla = new JTable();// creamos la instancia de la tabla
        tabla.setModel(modelo);
        modelo.addColumn("Maestro");
        modelo.addColumn("Stamina");
        modelo.addColumn("Efectividad");
        modelo.addRow(fila);
        modelo.addRow(fila2);
        modelo.addRow(fila3);
        
        //tabla.setName("Un excelente equipo");
        JScrollPane scroll = new JScrollPane(tabla);
        frame.setTitle("Uno de los mejores equipos");
        frame.add(scroll, BorderLayout.CENTER);
        frame.setSize(500, 300);
        frame.setLocationRelativeTo(null);
        
        JLabel etiqueta = new JLabel();
        etiqueta.setText("Estimado usuario. Este es el mejor equipo que mi algoritmo ha generado.");
        frame.add(etiqueta, BorderLayout.PAGE_END);
        
        frame.setVisible(true);
        
        frame.addWindowListener( new WindowAdapter() {
            @Override
            public void windowClosing( WindowEvent evt ) {
                System.exit( 0 );
            }
        } ); 
        
        
        }
   
}
