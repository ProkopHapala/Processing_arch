
static double ca2max = 0.0;


class Edge{
  int id;
  
    // parameters
  // 2D strain
  double r0;
  double k;
  Vertex a,b;  
  // bending
  double  kBend;
  double  alfa0; 
  Vertex c,d;
  double fr;
  
  // supplementary state variables
  double dx,dy,dz;
  double xhat,yhat,zhat;
  double r,ir;
  double cfx,cfy,cfz, dfx,dfy,dfz;
  
  void assertStrainForce(){
    dx = b.x - a.x;
    dy = b.y - a.y;
    dz = b.z - a.z;
    r = Math.sqrt( dx*dx + dy*dy + dz*dz );
    ir = 1/r;
    xhat = dx*ir; yhat = dy*ir; zhat = dz*ir; 
    fr = k*(r - r0);
    double fx = fr*xhat;
    double fy = fr*yhat;
    double fz = fr*zhat;
    a.acumForce(  fx, fy, fz );
    b.acumForce( -fx,-fy,-fz );
  }
  
  void assertBendForce( boolean update ){
    if((c!=null)&&(d!=null)){
      if( update ){
        // perpendicular compoent to point "c"
        double cx  = c.x-a.x; double cy = c.y-a.y; double cz = c.z-a.z; // (cx,cy,cz) vector A_to_C 
        double pc  = cx*xhat + cy*yhat + cz*zhat;                       // projection of A_to_C onto vector A_to_B 
        double cTx = cx - pc*xhat;                                      // (cTx,cTy,cTz) component of A_to_C perpendicular to A_to_B
        double cTy = cy - pc*yhat;
        double cTz = cz - pc*zhat;
        double rc  = Math.sqrt( cTx*cTx + cTy*cTy + cTz*cTz );
        double irc = 1/rc;
        double chx = cTx *irc;                                          // (chx,chy,chz) unitary vector in direction of (cTx,cTy,cTz)
        double chy = cTy *irc;
        double chz = cTz *irc;
        // perpendicular compoent to point "d"
        double dx  = d.x-a.x; double dy = d.y-a.y; double dz = d.z-a.z; // (dx,dy,dz) vector A_to_D
        double pd  = dx*xhat + dy*yhat + dz*zhat;                       // projection of A_to_D onto vector A_to_B
        double dTx = dx - pd*xhat;                                      // (dTx,dTy,dTz) component of A_to_D perpendicular to A_to_B
        double dTy = dy - pd*yhat;
        double dTz = dz - pd*zhat;
        double rd = Math.sqrt( dTx*dTx + dTy*dTy + dTz*dTz );
        double ird = 1/rd;
        double dhx = dTx *irc;                                          // (dhx,dhy,dhz) unitary vector in direction of (dTx,dTy,dTz)
        double dhy = dTy *irc;
        double dhz = dTz *irc; 
        // difference of orientaion 
        double ux  = chx + dhx;                                         // (dhx,dhy,dhz) unitary vector in direction of (dTx,dTy,dTz)
        double uy  = chy + dhy;
        double uz  = chz + dhz;
        double ca2 = ux*ux + uy*uy + uz*uz; 
       // if( (ca2<ca2max) && (alfa0==0) ){
          // for small bending of flat surface approximation may be used
          // (ux,uy,uz) is almost parallel to the normals and its length is almost equal to bending angle alpha 
          double cf  = -kBend*irc; 
          cfx = cf*ux;
          cfy = cf*uy;
          cfz = cf*uz;
          double df  = -kBend*ird;
          dfx = df*ux;
          dfy = df*uy;
          dfz = df*uz;
          //println( cfx +" "+ cfy +" "+ cfz +" "+ dfx +" "+ dfy +" "+ dfz  );
        /*  
        }else{
          // For larger bending angles and pre-bend surface 
          // is necessary to evaluate normals and bending angle explicitly  
          //double alfa  = Math.PI-Math.acos( 0.5*ca2-1 );
          double alfa  = Math.acos( Math.sqrt(ca2/4) );
          double dalfa = alfa - alfa0;  
          double tq    = kBend*dalfa;
          // bending force
          double cnx = yhat * chz - zhat * chy;
          double cny = zhat * chx - xhat * chz;
          double cnz = xhat * chy - yhat * chx;
          double dnx = yhat * dhz - zhat * dhy; 
          double dny = zhat * dhx - xhat * dhz;
          double dnz = xhat * dhy - yhat * dhx;
          double cf  = tq*irc; 
          cfx = cf*cnx;
          cfy = cf*cny;
          cfz = cf*cnz;
          double df  = tq*ird;
          dfx = df*dnx;
          dfy = df*dny;
          dfz = df*dnz;
        }
        */
      }
      //println( cfx +" "+ cfy +" "+ cfz +" "+ dfx +" "+ dfy +" "+ dfz  );
      c.acumForce( cfx, cfy, cfz );
      d.acumForce( dfx, dfy, dfz  );
      double recoilx = -0.5d*(cfx+dfx);
      double recoily = -0.5d*(cfy+dfy);
      double recoilz = -0.5d*(cfz+dfz);
      a.acumForce( recoilx,recoily,recoilz );
      b.acumForce( recoilx,recoily,recoilz );
    }
  }
  
    
  Edge( int id, Vertex a, Vertex b, Vertex c, Vertex d, double k, double kBend, double alfa0 ){
    this.id=id;
    this.k  = k;
    this.kBend  = kBend;
    this.a  = a;  this.b  = b; this.c  = c; this.d  = d;
    // evaluate r0
    dx = b.x - a.x;
    dy = b.y - a.y;
    dz = b.z - a.z;
    r0 = Math.sqrt( dx*dx + dy*dy + dz*dz );
    if(alfa0>=0){
      this.alfa0=alfa0;
    }else{
     // compute alfa for initial configuration
    }
  }
  
  void paint(){
    stroke(0,0,0);
    if( fr>0 ){ float f =(float)(fr/fbreak);  stroke( 1,0,0,f ); }else{ float f =(float)(-fr/fbreak); stroke( 0,0,1,f); }
    line( (float)a.x, (float)a.y, (float)a.z,   (float)b.x, (float)b.y, (float)b.z  );
    //if( c!=null ){ stroke(1,0,0); line( (float)(0.5*(a.x+b.x)), (float)(0.5*(a.y+b.y)), (float)(0.5*(a.z+b.z)),   (float)c.x, (float)c.y, (float)c.z  ); }
    //if( d!=null ){ stroke(0,0,1); line( (float)(0.5*(a.x+b.x)), (float)(0.5*(a.y+b.y)), (float)(0.5*(a.z+b.z)),   (float)d.x, (float)d.y, (float)d.z  ); }
  };
  
  
  
}
