
final int    nPhi     = 30;
final int    nPhiHalf = nPhi/2;
final double dPhi = 0.05; 
final double idPhi = 1.0d/dPhi; 
double [] tempRay;

class Cell{
  double x,z;
  double [] mask;   // this determine material
  int nmask;
  int nscatter;
  double mask_renorm;
  double [] rayIn, rayOut;
  
  // debugging stuff
  double totalIn,totalOut;
  
  Cell( double x, double z, int nscatter, double [] mask ){
    this.x=x; this.z=z; this.mask = mask;
    rayIn  = new double[nPhi];
    rayOut = new double[nPhi];
    nmask = mask.length/2;
    this.nscatter=nscatter;
    double sum=0;
    for (int i=0;i<mask.length;i++){ sum+=mask[i]; }
    mask_renorm = 1.0d/sum;
  }
  
  void scatter(){
    for (int iter=0;iter<nscatter;iter++){
      if(iter==0){    for (int i=0; i<rayOut.length; i++){ tempRay[i]=rayIn[i];  rayOut[i]=0; } } 
      else       {    for (int i=0; i<rayOut.length; i++){ tempRay[i]=rayOut[i]; rayOut[i]=0; } } 
      for (int i=0; i<tempRay.length; i++){
        int jmin = max( i-nmask, 0 );
        int jmax = min( i+nmask, tempRay.length-1 );
        double sum=0;
        for (int j=jmin;j<=jmax;j++){
          //println( " i "+i+" j "+j+" j-i "+(j-i) );
          sum+=tempRay[j]*mask[j-i+nmask];
        }
        rayOut[i]+=sum*mask_renorm;
      }
    }
    for (int i=0; i<rayOut.length; i++){ 
      totalOut+=rayOut[i];
    };
  }
  
  void getRay( Cell source ){
    double dz = z - source.z;
    double dx = x - source.x;
    double tg = dx / dz;
    int itg  = ((int)(tg*idPhi))+nPhiHalf;
    //int itgS = nPhi-itg-1;
    int itgS = nPhi-itg;
    //println( "dx,dz,tg,itg,itgS: "+dx+" "+dz+" "+tg+" "+itg+" "+itgS );
    //println( " dz "+dz+" dx "+dx+" tg "+tg+" itg "+itg+" itgS "+itgS  );
    double dray = source.rayOut[itgS];
    totalIn    += dray;
    rayIn[itg] += dray;
  }
  
  void plot(){ ellipse( (float)x,(float)z, pointScale, pointScale ); }
  
  void plotRayArray( boolean byPoint, double [] rayArr){
    for (int i=0;i<rayArr.length;i++){
      double tg = (i-nPhiHalf)*dPhi ; 
      double r  =  rayScale * rayArr[i]   ;
      if (byPoint) { point(                    (float)(x+tg*r), (float)(z+r) ); }
      else         { line ( (float)x,(float)z, (float)(x+tg*r), (float)(z+r) ); }
    }
  }
  
  void plotRayOut( boolean byPoint ){ plotRayArray( byPoint,rayOut);  }
  void plotRayIn ( boolean byPoint ){ plotRayArray( byPoint,rayIn );  }
  
}
