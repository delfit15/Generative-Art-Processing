
//TP1 ARTE GENERATIVO
//INFORMÁTICA GENERAL 2
//CÁTEDRA CAUSA
//DELFINA CAVALLARO 2020

import oscP5.*; // -->Importan la librería oscP5.

//DECLARO SONIDO
OscP5 osc; //--> define el objeto OscP5 para que Processing pueda interpretarlo.
int puerto; //--> Se define un puerto de entrada para la comunicación osc

//gestores de señal-> amplificación general y pitch de cada etapa.
GestorSenial gestorAmp;
GestorSenial gestorPitch_estructura;
GestorSenial gestorPitch_capas;
GestorSenial gestorPitch_colores;
GestorSenial gestorPitch_fondo;

float amp; // guardo amplitud
float pitch; //guardo registro

//----CALIBRACION
float minimoAmp=75;
float maximoAmp=95;
float minimoPitch=57;
float maximoPitch=78;
float amor=0.9;

//APLAUSO 
float UMBRAL_TIEMPO = 1000;
 long marcaTiempo;
 
//DECLARO CIRCULOS
Circulos fondo1; //fondo
Circulos []c1= new Circulos [4];//estructura 1
Circulos [] c2= new Circulos [4];//estructura 2
Circulos b1,b2,b3,b4;//estructura 3
Circulos [] c4= new Circulos [9];//estructura 4

//coordenadas x,y
int cirY;
int cirX;

PImage img; //declaro imagen textura

//ETAPAS
int et; // nº de etapa
boolean[] etapas = new boolean[6]; 
boolean actualizarcapas;
boolean actualizarfondo;
boolean actualizarestructura;
boolean actualizarcolores;
boolean cambiar; //paso de una etapa a otra

//GUARDADO DE OBRA EN CARPETA OBRAS GUARDADAS
int numObra=1;
boolean guardado;
String titulo;

void setup() {

  size (600, 630); //creo lienzo cuadrado.
  img= loadImage("lapiz.jpg"); //cargo imagen
  
  marcaTiempo = millis(); 
   
  puerto = 11111; //mismo puerto que en PD
  osc = new OscP5(this, puerto); // Le indica a Processing que OSC recibirá los mensajes que lleguen a traves del puerto especificado.

gestorAmp = new GestorSenial (minimoAmp,maximoAmp, amor );
gestorPitch_fondo= new GestorSenial (minimoPitch,maximoPitch,amor);
gestorPitch_estructura= new GestorSenial (minimoPitch,maximoPitch,amor);
gestorPitch_capas= new GestorSenial (minimoPitch,maximoPitch,amor);
gestorPitch_colores= new GestorSenial (minimoPitch,maximoPitch,amor);

   // circulo fondo
  fondo1= new Circulos(300,300,#2e4274,#798496,1000 ); 
  
   //circulos estructura 1 
  c1[0]= new Circulos (150,450,#3B0643,#e32f3b,300); //abajo izq
  c1[1]= new Circulos (450,150,#3B0643,#e32f3b,300); //arriba der
  c1[2]= new Circulos (150,150,#e32f3b,#3B0643,300); //arriba izq
  c1[3]= new Circulos (450,450,#e32f3b,#3B0643,300); //abajo der
  
   //circulos estructura 2 
  c2[0]= new Circulos (300,0,#301e14,#556a31,425);
  c2[1]= new Circulos (0,300,#556a31,#301e14,425);
  c2[2]= new Circulos (300,600,#301e14,#556a31,425);
  c2[3]= new Circulos (600,300,#556a31,#301e14,425);
  
  // circulos estructura 3 , semicirculos
  b1= new Circulos (300,150,#4d4473,#fe7153,300);
  b2= new Circulos (300,450,#4d4473,#fe7153,300);
  b3= new Circulos (150,300,#4d4473,#fe7153,300);
  b4= new Circulos (450,300,#4d4473,#fe7153,300);
  
 // circulos estructura 4 
 c4[0]= new Circulos(100,100,#ffc857,#643414,200);
 c4[1]= new Circulos(100,300,#643414,#ffc857,200);
 c4[2]= new Circulos(100,500,#ffc857,#643414,200);
 c4[3]= new Circulos(300,100,#643414,#ffc857,200);
 c4[4]= new Circulos(300,300,#ffc857,#643414,200);
 c4[5]= new Circulos(300,500,#643414,#ffc857,200);
 c4[6]= new Circulos(500,100,#ffc857,#643414,200);
 c4[7]= new Circulos(500,300,#643414,#ffc857,200);
 c4[8]= new Circulos(500,500,#ffc857,#643414,200);
 
//ETAPAS A PARTIR DE APLAUSO
et=0;
etapas[0]=true;
etapas[1]=false;
etapas[2]=false;
etapas[3]=false;
etapas[4]=false;
etapas[5]=false;

guardado=false;

}

//-------------------------
void draw() {
 //dependiendo la etapa, actualizo valores en el tiempo
 gestorAmp.actualizar(amp);  
  
if (actualizarcapas){
gestorPitch_capas.actualizar(pitch);
}

if(actualizarfondo){
gestorPitch_fondo.actualizar(pitch);
};

if(actualizarestructura){
gestorPitch_estructura.actualizar(pitch);
};

if (actualizarcolores){
 gestorPitch_colores.actualizar(pitch);  
}

  if ( amp >90 && amp < 95 && millis() < millis()+UMBRAL_TIEMPO){//si aplaudo, cambio de etapa 
        if(et<5){
        if (etapas[et]==true){
        etapas[et]=!etapas[et];
           et=et+1;
             }

          }
       }
        else {etapas[et]=true;} 

//dependiendo de que etapa es true, se dibuja (sino false)
//cambio de estructura según pitch

fondo1.fondo(); //dibujo circulo fondo
if (etapas[0]==true){ // cambio capas fondo.
actualizarfondo=true;} 
else{actualizarfondo=false;};

 if (etapas[1]==true){ //  color fondo
  fondo1.colores_fondo();
 actualizarcolores=true; }
 else{actualizarcolores=false;}

      
 if (etapas[2]==true){ //  estructura circulos
 actualizarestructura=true;   
 dibujo();
 }       
 else{actualizarestructura=false; }
      
 if (etapas[3]==true){ //capas circulos
  dibujo();
  actualizarcapas=true; }
  else{actualizarcapas=false;};
   
 if(etapas[4]==true){ //colores 
   dibujo();
   actualizarcolores=true;
 }
 
  if(etapas[5]==true){ //obra finalizada, guardado
   dibujo();}
 
  blend(img, 0, 0, 600, 600, 0, 0, 600, 600,OVERLAY); //textura lapiz de imagen
  
  //rectángulo inferior NEGRO
  pushStyle();
  fill(0);
  rect(0,600,600,630);
  popStyle();
  
  //INSTRUCCIONES
  if(etapas[5]==true){
    pushStyle();
    textSize(13);
    fill(255);
   text("Apretá 'S' para Guardar o 'R' para Reiniciar", 325, 620);
  popStyle();
  }
  else{
  pushStyle();
    textSize(10);
    fill(255);
   text("Cambiá el registro de tu voz para interactuar", 375, 612);
  popStyle();
   pushStyle();
   fill(211,210,210,98);
   text(" Si te gusta el resultado, aplaudí para pasar a la próxima etapa",290,625);
   popStyle();
  }
  
  if (guardado==true){ //mensaje para afirmar que se guardo la obra
    pushStyle();
    textSize(13);
    fill(214,214,214);
    text("Obra guardada!",9 ,620);
    popStyle();
 
  }
     }

 //----------------------------------------------------------------------------------- 
  
  void keyPressed() // en la última etapa, si presiono r reinicio.
{
   //Si apreto 'r', reiniciar (solo si terminó, osea está en la 5ta etapa)
   if(key == 'r' && etapas[5]==true) 
     {
     setup();
     }
    
    if (guardado==false){
    if(key == 's' && etapas[5]==true)  // si apreto s, guardo obra en carpeta "obras guardadas"
     {
    PImage temp = get(0,0,600,600);
    titulo="ObrasGuardadas/Obra"+numObra+".jpg";
    temp.save(titulo);
    numObra++; 
    guardado=true;
     }  
  }
     }    

void semicirculos() { //estructura 3 realizada con semicirculos 
    b3.semicirculo_horizontal_2();
    b1.semicirculo_vertical_2();
    b4.semicirculo_horizontal_2(); 
    b1.semicirculo_vertical_1(); 
    b2.semicirculo_vertical_1();
    b3.semicirculo_horizontal_1();
    b4.semicirculo_horizontal_1();
    b2.semicirculo_vertical_2();
    
    if (etapas[4]==true){ //colores 
    b3.colores();
    b1.colores();
    b4.colores(); 
    b1.colores(); 
    b2.colores();
    b3.colores();
    b4.colores();
    b2.colores();
      
    }
   
}

void dibujo(){ //cambios estructura y color segun pitch
if (gestorPitch_estructura.filtradoNorm()<0.20){  //estructura 1 
      for (int i=0; i<4; i++){
         c1[i].dibujar_circulo();
         
         if (etapas[4]==true){
           c1[0].colores();
           c1[1].colores();
           c1[2].colores2();
           c1[3].colores2();
         }
      }
     }
 else if (gestorPitch_estructura.filtradoNorm()>0.20 && gestorPitch_estructura.filtradoNorm()<0.50){ //estructura 2 
      for (int i=0; i<4; i++){
         c2[i].dibujar_circulo();
         
         if (etapas[4]==true){
            c2[0].colores();
            c2[1].colores2();
            c2[2].colores();
            c2[3].colores2();
           
           
         }
      }
         
      }
  else if (gestorPitch_estructura.filtradoNorm()>0.50 && gestorPitch_estructura.filtradoNorm()<0.80){  //estructura 3 
  
    semicirculos();   
  }  
 else if (gestorPitch_estructura.filtradoNorm()>0.80){ //estructura 4 
   for (int i=0; i<9; i++){
         c4[i].dibujar_circulo();
         
         if (etapas[4]==true){
          c4[0].colores();
          c4[1].colores2();
          c4[2].colores();
          c4[3].colores2();
          c4[4].colores();
          c4[5].colores2();
          c4[6].colores();
          c4[7].colores2();
          c4[8].colores();
           
         }
    
   }
      }     
}   
