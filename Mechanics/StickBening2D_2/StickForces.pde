
final static double histeresis_func( double c ){
  return 1.0d/(1.0d + c*c );
  //return Math.max( 0,  1.0d -  Math.abs(c) );
  //double tmp = Math.max( 0 , 1.0d -  Math.abs(c) );
  //return tmp*tmp;
  //return 0.7;
}



void getForceStick1D( double [][] pos, double [][] vs, double [][] fs,  double [] l0s, double [] c0s, double [] kls, double [] kcs, double hist_l, double hist_a,  boolean plot ){
  double [] xs  = pos[0];
  double [] ys  = pos[1];
  double [] vxs =  vs[0];
  double [] vys =  vs[1];
  double [] fxs =  fs[0];
  double [] fys =  fs[1];
  
  int n = xs.length;
  // first stick  
  double ox    = xs[1];
  double oy    = ys[1];
  double dx_   = xs[0]-ox;
  double dy_   = ys[0]-oy;
  double l_    = Math.sqrt( dx_*dx_ + dy_*dy_ );
  double oil   = 1.0d/l_;
  double ohx   = dx_*oil;
  double ohy   = dy_*oil;
  
  // velocity for radial histeresis
  double ovx   = vxs[1]; 
  double ovy   = vys[1];
  double odvx  = vxs[0] - ovx;
  double odvy  = vys[0] - ovy;
  
  // first stick : radial force 
  double fl_   = ( l_ - l0s[0] )*kl[0];
  //double cvl_  = hist_l * (ohx*odvx + ohy*odvy);
  //if( (fl_*cvl_)<0 ){ fl_*= histeresis_func( cvl_ ); }       // histeresis paralle       to sticks
  double cvl_  = hist_l * (ohx*odvx + ohy*odvy);
  if( (fl_*cvl_)<0 ){ fl_*= hist_l; } 
  double ofx   = ohx*fl_;
  double ofy   = ohy*fl_;
  double oofx  = -ofx;  
  double oofy  = -ofy;

  double ovtq = (ohy*odvx - ohx*odvy)*oil;
    
  for(int i=2; i<n; i++){    
    // evaluate new stick length and direction
    double x   = xs[i];
    double y   = ys[i];    
    double dx  = ox-x;
    double dy  = oy-y;
    double l   = Math.sqrt( dx*dx + dy*dy );
    double il  = 1.0d/l;
    double hx = dx*il; // unit vector in direction of stick
    double hy = dy*il; 
    
    // velocity for radial histeresis
    double vx   = vxs[i]; 
    double vy   = vys[i];
    double dvx  = ovx - vx;
    double dvy  = ovy - vy;
             
            
    // radial force
    double fl = ( l - l0s[i-1] )*kls[i-1];
    //double cvl = hist_l * (hx*dvx + hy*dvy);
    //if( (fl*cvl)<0 ){ fl*= histeresis_func( cvl ); }       // histeresis paralle       to sticks
    double cvl = hx*dvx + hy*dvy;
    if( (fl*cvl)<0 ){ fl*=hist_l; } 
    double fx = hx*fl;
    double fy = hy*fl;
    ofx -= fx;  ofy -= fy;
    
    // angular force
    double sa   = hy*ohx - hx*ohy;
    double tq   = (sa - c0s[i-2])*kcs[i-2];   // torque 
    double vtq = (hy*dvx - hx*dvy)*il;
    //double cva = hist_a * ( vtq  -  ovtq );
    //if( (tq*cva)>0 ){ tq*= histeresis_func( cva ); }       // histeresis paralle       to sticks  
    double cva = vtq  -  ovtq;
    if( (tq*cva)>0 ){ tq*=hist_a; }       // histeresis paralle       to sticks  
    double fcx1 = + tq*ohy*oil;
    double fcy1 = - tq*ohx*oil;
    double fcx2 = + tq* hy* il;
    double fcy2 = - tq* hx* il;
    oofx -= fcx1     ;   oofy -= fcy1     ;
     ofx += fcx1+fcx2;    ofy += fcy1+fcy2;
      fx -=      fcx2;     fy -=      fcy2;
    
     
    if(plot){
    // ellipse(  );
    }  
    
    // save and shufle
    fxs[i-2] = oofx; fys[i-2] = oofy;
    oofx    =  ofx;  oofy   =  ofy;
     ofx    =   fx;   ofy   =   fy;
     ohx    =   hx;   ohy   =   hy;
      ox    =    x;    oy   =    y;
     ovx    =   vx;   ovy   =   vy;
     oil    =   il;
   // ovtq    =  vtq; 
  }
  
  fxs[n-2] = oofx; fys[n-2] = oofy;
  fxs[n-1] =  ofx; fys[n-1] =  ofy;

}
