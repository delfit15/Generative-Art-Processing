class GestorSenial {
 
  float valorIn, filtrado;
  float minimo;
  float maximo;
  
  float derivada;
  
  int tamanioMuestra;
  float factorAmortiguacion;
  float amplitudMaxDerivada;
  
  
  
//------------------------------
GestorSenial (){
 this(0,100,200,0.1,0.5); 
}
GestorSenial (float minimo_, float maximo_){
 this(minimo_,maximo_,200,0.1,0.5); 
}
 
GestorSenial (float minimo_,float maximo_, float factorAmortiguacion_) {
  this(minimo_,maximo_,200,factorAmortiguacion_,0.5);  
   minimo = minimo_;
  maximo = maximo_;
}


GestorSenial (float minimo_, float maximo_, int tamanioMuestra_,
float factorAmortiguacion_, float amplitudMaxDerivada_){
 
  factorAmortiguacion=factorAmortiguacion_;
  amplitudMaxDerivada = amplitudMaxDerivada_;
  minimo = minimo_;
  maximo = maximo_;
  tamanioMuestra = tamanioMuestra_;
  
}

float filtradoNorm(){
 return constrain(map(filtrado,minimo,maximo,0,1),0,1); 
  
}

float derivadaNorm(){
 return constrain(map(derivada,-amplitudMaxDerivada,amplitudMaxDerivada,-1,1),-1,1); 
}


void actualizar (float valorIn_){
  
 valorIn=valorIn_;
 float anterior=filtrado;
 filtrado = valorIn * (1-factorAmortiguacion) + filtrado* factorAmortiguacion;
 derivada=filtrado-anterior;
  
}
}


  
