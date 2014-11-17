

float ichain2sy (int ichain){  return ichain*10 + 50; }
float x2sx( double x )      {  return (float)(10*x) + 50;        }

void plotLinks(){
  stroke( 0,0,0 );
  for (int ichain = 0; ichain<Xs.length; ichain++){ 
    double [] xs = Xs[ichain];
    double [] fs = Fs[ichain];
    float y = ichain2sy( ichain );
   // for (int i = 1; i<xs.length; i++){  line   ( x2sx(xs[i-1]), y, x2sx(xs[i]), y);    }
    for (int i = 0; i<xs.length; i++){  line   ( x2sx(xs[i]), y, x2sx(xs[i]+50*fs[i]), y);    }
    for (int i = 0; i<xs.length; i++){  ellipse( x2sx(xs[i]), y, 3,3 );               }
  }
  stroke( 128,0,255 );
  for (int ilink = 0; ilink<crosslinks.length; ilink+=4){ 
    int ichain = crosslinks[ilink     ]; 
    int i      = crosslinks[ilink + 1 ]; 
    int jchain = crosslinks[ilink + 2 ]; 
    int j      = crosslinks[ilink + 3 ];  
    //println( ilink+" "+crosslinks[ilink     ]+" "+crosslinks[ilink+1     ]+" "+crosslinks[ilink + 2 ]+" "+crosslinks[ilink + 3 ] ); 
    line( x2sx(Xs[ichain][i]), ichain2sy(ichain), x2sx(Xs[jchain][j]), ichain2sy(jchain) );
  }
}
