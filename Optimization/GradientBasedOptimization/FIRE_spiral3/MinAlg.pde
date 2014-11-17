
float [] FF  = new float[2];

////////////////////////////
/// Steepest Descent
///////////////////////////

void Move_SD(){  
//BoundA(F,fmax);
adAcB(R,F,dt);
}

////////////////////////////
///   damped MD
///////////////////////////

void Move_MD(){
toAcB(V,V,damp); // damp
adAcB(V,F,dt);   // apply force
//BoundA(V,vmax,n);
adAcB(R,V,dt);   // move 
}

////////////////////////////
///   damped MD project
///////////////////////////

float [] Vo= new float[2];
float [] Vp= new float[2];

void Move_MDp(){
float c = cosAB( V, F);
  stroke(0,0,255);  line(R[0]*sz+sz,R[1]*sz+sz,R[0]*sz+sz+F[0]*20, R[1]*sz+sz+F[1]*20);
if (c<-0.1){
  stroke(255,0,255);  line(R[0]*sz+sz,R[1]*sz+sz,R[0]*sz+sz+V[0]*100, R[1]*sz+sz+V[1]*100);
  AcpB( Vp, V);  
  AparaB( Vp, F  );
  AortoB( V, F  );
  adAcB( V, Vp, 0.5  );  
  stroke(0,255,255);  line(R[0]*sz+sz,R[1]*sz+sz,R[0]*sz+sz + V[0]*100, R[1]*sz+sz+V[1]*100);
};

float dE = E - oE; float odE=oE-ooE;
if( (dE >0.0) && ( dE > abs (odE) ) ){ multAf( V, 0.5 );  }
//adAcB( V, V, 0.000000001*sqrt(dE)/sAB(V,V)  );

adAcB(V,F,dt);   // apply force
//BoundA(V,vmax,n);
adAcB(R,V,dt);   // move 
}



////////////////////////////
///   Orthogonal MD
///////////////////////////

void Move_OMD(){
//toAcB(V,V,damp,n); // damp
AortoB(V,F);    // orthogonalize velocity
adAcB(V,F,dt);   // apply force
//BoundA(V,vmax,n);
adAcB(R,V,dt);   // move 
}

