
double ddiff = 0.0001;
double3 pos, grad, posd, dp;

double rho=0;
double t  =0;

double  [][] coefsPix;
double3 []   atomsPix;

boolean ray(double x, double y, double zmin){
  t = zmin;  
  pos.set(  x,y, t );
  double ot; double orho;
  for ( int ir=0;ir<100;ir++ ){    // ray march
    ot = t; orho = rho; 
    t += dpos; if( t > zmax )return false;
    pos.z = t; rho = sampleAtoms( pos );
    if ( Math.abs(rho) > isolevel ){
      // root finding
      int iters = 0;
      double of = Math.abs(orho) - isolevel;
      double  f = Math.abs( rho) - isolevel;
      double newt = t - f*( t - ot )/( f - of); ot = t; t=newt; 
      while ( Math.abs(t-ot)> accuracy ){
        iters++;
        of = f; pos.z = t; rho = sampleAtoms( pos ); f=Math.abs(rho)-isolevel;
        newt = t - f*( t - ot )/( f - of); ot = t; t=newt; 
      }
      pos.z = t; rho = sampleAtoms( pos );
      // gradient evaluation 
      grad.set(0);
      posd.set(pos); posd.x+=ddiff; grad.x = sampleAtoms( posd );
      posd.set(pos); posd.y+=ddiff; grad.y = sampleAtoms( posd );
      posd.set(pos); posd.z+=ddiff; grad.z = sampleAtoms( posd );
      grad.add(-rho);
      return true;
    }
  }
  return false;
}

final double sampleAtoms( double3 pos ){
    double rho = 0; 
    for (int i=0;i<nbuff;i++){
      rho += evalAtom( pos, atomsPix[i], coefsPix[i] );  
    }
    //float px = x2sx(pos.z);
    //float py = rho2sy(rho);
    //println( pos.z + "  " + rho + "     "+px+" "+py  );
    //point(px,py);
    return rho;
}

final double evalAtom( double3 pos, double3 atompos, double [] coef ){
  atomEvals++;
  dp.sub(atompos, pos);
  double r2     = dp.dot();
  double radial = radialFunc( r2 );
  //double radial = radialFunc_fast( r2 );
  return radial * (  coef[0] +  dp.x*coef[1] +  dp.y*coef[2]  +  dp.z*coef[3] );  
}

final static double radialFunc( double r2  ){
  return Math.exp ( -Math.sqrt(r2)/decay );
} 

final static double radialFunc_fast( double r2  ){
  return 0.01/(r2/4+0.01);
} 



