
class Circulos{
//caracterícas
float x= 300; //tamaño del circulo. 
float posx;
float posy;
 
float lado;

int capas;
float interpola;

//COLOR
 color col1,col2;
 color resultado;
 
//ARRAYS COLORES
 int colores1[] = {0,1,2,3,4}; 
 int colores2[] = {0,1,2,3,4};
 int coloresfondo1[]={0,1,2,3};
int coloresfondo2[]={0,1,2,3};


Circulos ( float posx, float posy,color col1, color col2, float x){ //CONSTRUCTOR DE CIRCULOS
  
  this.posx=posx;
  this.posy=posy;
  this.col1=col1;
  this.col2=col2;
  this.x=x;

//valores colores
  colores1[0] =#fe7153; //rosa y violeta
  colores2[0] = #4d4473;
  
  colores1[1] =#301e14; //verde costado
  colores2[1] =#556a31;
  
  colores1[2] =#312614; //verde arrib
  colores2[2] =#38a285;
  
  colores1[3] =#e32f3b; //fucsia#E06A84
  colores2[3] =#3B0643;
  
  colores1[4] =#ffc857;
  colores2[4] =#643414;   //amarillos
  

  coloresfondo1[0]=#870803; //rojo
  coloresfondo1[1]=#ec3f53; //fucsia
  coloresfondo1[2]=#2a8b9c;//azul
  coloresfondo1[3]=#2e4274;//lila
  
  coloresfondo2[0]=#f93a31; //rojo
  coloresfondo2[1]=#67293e; //fucsia
  coloresfondo2[2]=#003965;//azul
  coloresfondo2[3]=#798496;//lila
 }
 
 
 Circulos ( float posx, float posy, float x){ //CONSTRUCTOR DE CIRCULOS
  
  this.posx=posx;
  this.posy=posy;
  this.x=x;
  
 }
 
//funciones

void dibujar_circulo() { 
  pushMatrix();
  
     fill( col1 );
     ellipse(posx,posy,3,3);
     
      for( int i=0 ; i <9 ; i++ ){
     lado = map( i , 0 ,9 , x , 2);
    interpola = map( gestorPitch_capas.filtradoNorm() , 1 , 0, i, 0);
     resultado = lerpColor( col1 , col2 , interpola );
     noStroke();
    fill( resultado );
    ellipse ( posx, posy , lado , lado ); 
  }
  
 fill( col2 );
 ellipse(posx,posy,70,70);  
 
popMatrix();
 
}  

void fondo() { 

  pushStyle();
     fill( col1 );
     ellipse(posx,posy,3,3);
     
      for( capas=0 ; capas <9 ; capas++ ){
     lado = map( capas , 0 ,9 , x , 2);
    interpola = map(  gestorPitch_fondo.filtradoNorm(), 1 , 0, capas, 0);
     resultado = lerpColor( col1 , col2 , interpola );   
     noStroke();  
    fill( resultado );    
    ellipse ( posx, posy , lado , lado ); 
      } 
 fill( col2 );
 ellipse(posx,posy,70,70);  
 popStyle();
      }
      
void semicirculo_horizontal_1 (){ 
   fill( col1 );
     arc(posx, posy, 3, 3, 0, PI);
      for( int i=0 ; i < 9 ; i++ ){
    lado = map( i , 0 , 9 , x , 2);
    interpola = map( gestorPitch_capas.filtradoNorm() , 1 , 0, i, 0);
     resultado = lerpColor( col1 , col2 , interpola );
     noStroke();
    fill( resultado );
  arc(posx, posy, lado, lado, 0, PI);
      } 
       fill( col2 );
arc(posx, posy, 100, 100, 0, PI);  


}

void semicirculo_horizontal_2(){
  
     fill( col1 );
     arc(posx, posy, 3, 3, PI, radians(360));
      for( int i=0 ; i < 9 ; i++ ){
    lado = map( i , 0 , 9 , x , 2);
    interpola = map( gestorPitch_capas.filtradoNorm() , 1 , 0, i, 0);
   resultado = lerpColor( col1 , col2 , interpola );
     noStroke();
    fill( resultado );
  arc(posx, posy, lado, lado, PI, radians(360));
      }
       fill( col2 );
       arc(posx, posy, 100,  100, PI, radians(360));
       
  
}

void semicirculo_vertical_1(){
     fill( col1 );
     arc(posx, posy, 3, 3, radians(270),radians(90));
      for( int i=0 ; i < 9 ; i++ ){
   lado = map( i , 0 , 9 , x , 1);
   
    interpola = map( gestorPitch_capas.filtradoNorm() , 1 , 0, i, 0);
     
   resultado = lerpColor( col1 , col2 , interpola );
     noStroke();
    fill( resultado );
  arc(posx, posy, lado, lado, radians(90),radians(270));
      }
       fill( col2 );
       arc(posx, posy, 100,  100, radians(90),radians(270));
       
   
}

void semicirculo_vertical_2(){  
     fill( col1 );
     arc(posx, posy, 3, 3, radians(270),radians(450));
      for( int i=0 ; i < 9 ; i++ ){
     lado = map( i , 0 , 9 , x , 2);
     
    interpola = map( gestorPitch_capas.filtradoNorm() , 1 , 0, i, 0);
  
    resultado = lerpColor( col1 , col2 , interpola );
     noStroke();
    fill( resultado );
  arc(posx, posy, lado, lado, radians(270),radians(450));
      }
       fill( col2 );
       arc(posx, posy, 100,  100, radians(270),radians(450));
 
} 

void colores(){ //CAMBIO COLOR SEGUN PITCH
   if (gestorPitch_colores.filtradoNorm()<0.20){  
   
   col1= colores1[1];
   col2=colores2[1];
     }
 else if (gestorPitch_colores.filtradoNorm()>0.20 && gestorPitch_colores.filtradoNorm()<0.50){ 
  col1= colores1[2];
  col2=colores2[2];
         
      }
  else if (gestorPitch_colores.filtradoNorm()>0.50 && gestorPitch_colores.filtradoNorm()<0.76){  
  
   col1= colores1[3];
   col2=colores2[3];
  }  
 else if (gestorPitch_colores.filtradoNorm()>0.76 && gestorPitch_colores.filtradoNorm()<0.85){ 
 col1= colores1[0];
 col2=colores2[0];
 }
  else if (gestorPitch_colores.filtradoNorm()>0.85){ 
 col1= colores1[4];
 col2=colores2[4];
      }  
     
 }
 
 void colores2(){
   if (gestorPitch_colores.filtradoNorm()<0.20){  
   
   col1= colores2[1];
   col2=colores1[1];
     }
 else if (gestorPitch_colores.filtradoNorm()>0.20 && gestorPitch_colores.filtradoNorm()<0.50){ 
  col1= colores2[2];
  col2=colores1[2];
         
      }
  else if (gestorPitch_colores.filtradoNorm()>0.50 && gestorPitch_colores.filtradoNorm()<0.76){  
  
   col1= colores2[3];
   col2=colores1[3];
  }  
 else if (gestorPitch_colores.filtradoNorm()>0.76 && gestorPitch_colores.filtradoNorm()<0.85){ 
 col1= colores2[0];
 col2=colores1[0];
      }  

 else if (gestorPitch_colores.filtradoNorm()>0.85){ 
 col1= colores2[4];
 col2=colores1[4];
      }  
   
 }
  
  
  

 void colores_fondo(){ //COLORES FONDO

 
 if (gestorPitch_colores.filtradoNorm()<0.20){  //rojo
   
   col1= coloresfondo1[0];
   col2=coloresfondo2[0];
     }
 else if (gestorPitch_colores.filtradoNorm()>0.20 && gestorPitch_colores.filtradoNorm()<0.50){ //fucsia
  col1= coloresfondo1[1];
  col2=coloresfondo2[1];
         
      }
  else if (gestorPitch_colores.filtradoNorm()>0.50 && gestorPitch_colores.filtradoNorm()<0.80){  //azul
  
   col1= coloresfondo1[2];
   col2=coloresfondo2[2];
  }  
 else if (gestorPitch_colores.filtradoNorm()>0.80){ //lila
 col1= coloresfondo1[3];
 col2=coloresfondo2[3];
      }  
      

      
 }
 
 
 
 
 } //
   
