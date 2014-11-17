void Move_MDp2(){
//toAcB(V,V,damp,n); // damp

 float normF = sqrt(sAB( F, F));
 float normV = sqrt(sAB( V, V));
 dt =  min( dtmax,  1.0/normF );  
 print ("  dt= "+ dt);

float c = cosAB( V, F);
  stroke(0,0,255);  line(R[0]*sz+sz,R[1]*sz+sz,R[0]*sz+sz+F[0]*20, R[1]*sz+sz+F[1]*20);
if (c<-0.0){
  stroke(255,0,255);  line(R[0]*sz+sz,R[1]*sz+sz,R[0]*sz+sz+V[0]*100, R[1]*sz+sz+V[1]*100);
  AcpB( Vp, V);  
  AparaB( Vp, F  );
  AortoB( V, F  );
  //adAcB( V, Vp, 0.5  );  
  //if(c<-0.1){
  //  multAf ( V, 1.1+c );
  //}
  //multAf ( V, 1.0+c );
  multAf ( V, 1.0-sqrt(abs(c)) );
  //multAf ( V, min( 1.0,1.2+c) );
  //multAf ( V, 1.+c*0.7 );
  //multAf ( V, 1.0+c*0.7 );
  //adAcB( V, Vp, 0.5 );  
  stroke(0,255,255);  line(R[0]*sz+sz,R[1]*sz+sz,R[0]*sz+sz + V[0]*100, R[1]*sz+sz+V[1]*100);
};

float dE = E - oE; float odE=oE-ooE;
if( (dE >0.0) && ( dE > abs (odE) ) ){ multAf( V, 0.5 );  }
//adAcB( V, V, 0.000000001*sqrt(dE)/sAB(V,V)  );

adAcB(V,F,dt);   // apply force
//BoundA(V,vmax,n);
adAcB(R,V,dt);   // move 
}
