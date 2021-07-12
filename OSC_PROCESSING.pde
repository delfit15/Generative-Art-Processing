//El siguiente algoritmo vinculará los datos recibidos de PD a través del protocolo OSC, para que Processing los interprete 
void oscEvent(OscMessage m) {
  if (m.checkAddrPattern("/amp")==true) { // si la dirección es "amp"
    if (m.checkTypetag("f")) {          // si el dato que trae el mensaje es un float
      amp = m.get(0).floatValue();        // extraemos el primer dato (0) y se lo asignamos a amp
     
     //println("pd--> amp: "+ amp);
      return;
    }
  }
  
    if (m.checkAddrPattern("/pitch")==true) { // si la dirección es "pitch"
    if (m.checkTypetag("f")) {          // si el dato que trae el mensaje es un float
      pitch = m.get(0).floatValue();        // extraemos el primer dato (0) y se lo asignamos a pitch 
     
      //println("pd--> pitch: "+ pitch);
      return;
    }
     }
    
   }
