

final float []   X0  = {   0.5,0.5,0,0,0   };

final float []   Ks  = {   50,1,90,90,90 };

//final float []   Ks  = {   1,1,1,1,1 };
final float [][] bas = {
{ 2, 1, 0, 0, 0},
{ 1,-2, 0, 0, 0},
{ 0, 0, 1, 1, 0},
{ 0, 0, 1,-1, 0},
{ 0, 0, 0, 0, 1}
};


float getE( float [] X){
 nEvals++;
 return E_harmonic( X, bas , Ks );
}


float E_harmonic( float [] X, float [][] bas, float [] Ks ){
  float E = 0;   for (int i=0; i<X.length; i++){   E += Ks[i]*sq( dotAB( X, bas[i] ) );   }
  return 0.5*E;
}



