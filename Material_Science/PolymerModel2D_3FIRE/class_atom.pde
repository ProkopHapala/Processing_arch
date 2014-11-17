
final static int randFunc( int r ){
  r = 1664525*r ^ 1013904223;
  r = 1664525*r ^ 1013904223;
  return r; 
}



class Atom{
  int id;
  
  // state variables
  double x,y;
  double vx,vy; 
  // supplementary state variables
  double fx,fy;
  double fxweak,fyweak;
  // parameters
  double charge;
  double   mass;     // mass of body
  double  imass;
  boolean fixed;
  
  // implementing grid accelration
  int ibin;
  Atom prev,next;
  
  Atom(){};
  Atom( double x, double y, double mass, double charge  ){    this.x=x; this.y=y; this.mass=mass; this.charge=charge; init();  }
  
  final void friction( double cdamp){
    vx*=cdamp; vy*=cdamp;
  }
  
  final void move(){
    if(!fixed){
       //println(fx+" "+fy+" "+vx+" "+vy+" "+x+" "+y);
       vx += imass*fx*dt;    vy += imass*fy*dt;
       x  +=vx*dt;            y += vy*dt;
       checkBin();
    }
  }
  
  final void checkWalls(){
    if      ( x < wall_left  ){ fx-=kWall*( x - wall_left  ); }
    else if ( x > wall_right ){ fx-=kWall*( x - wall_right ); }
    if      ( y < wall_down  ){ fy-=kWall*( y - wall_down  ); }
    else if ( y > wall_up    ){ fy-=kWall*( y - wall_up    ); }
  }
  
  final void checkBin(){
    int ix = (int)(float)( ( x - binsx0 )* iBinSize ); 
    int iy = (int)(float)( ( y - binsy0 )* iBinSize );
    int ibin_ = mbin*iy + ix;
    if( ibin_!=ibin ){
      // remove from current bin 
      if(prev==null) { bins[ibin]= next; }else{ prev.next = next; }
      if(next!=null) next.prev = prev;
      // put to other bin
      next = bins[ibin_]; prev = null;
      if(next!=null) next.prev = this;
      bins[ibin_] = this;
      // update ibin
      ibin = ibin_;
    } 
  }
  
  
  void cleanForce ()                      {    fx=0; fy=0;               }
  void acumForce  ( double fx, double fy ){ this.fx+=fx; this.fy+=fy;    }
  void init       ()                      { imass = 1/mass;              }
  
  void plot (){
    if(fixed){stroke(0);}else{noStroke();}
    if (charge>0){ fill(255,100,0); }else{ fill(0,100,255); } 
    /*
    int red  = (randFunc(ibin     )>>24) + 128;
    int blue = (randFunc(ibin+1544)>>24) + 128;
    int green = 255-red-blue;
    fill( red,green,blue  );
    */
    ellipse( x2s(x), x2s(y), 1.1*zoom, 1.1*zoom); 
    // line( x2s(x), x2s(y),  x2s( x+fscale*fx ), x2s( y+fscale*fy )  ); 
  }
  
  final void getWeakForce(){
    //for(Atom b : atoms){ if( b!=this ){ interact(b); } }
    
    interact_bin( bins[ ibin -1 - mbin ] );
    interact_bin( bins[ ibin    - mbin ] );
    interact_bin( bins[ ibin +1 - mbin ] );
    interact_bin( bins[ ibin -1        ] );
    interact_bin( bins[ ibin           ] );
    interact_bin( bins[ ibin +1        ] );
    interact_bin( bins[ ibin -1 + mbin ] );
    interact_bin( bins[ ibin    + mbin ] );
    interact_bin( bins[ ibin +1 + mbin ] );
    
  }
  
  final void interact_bin( Atom b ){ 
    while( b != null ){ 
      if(b!=this){        interact( b );      } 
      b = b.next; 
    } 
  }
  
  final void interact( Atom b ){
    //line( x2s(x), x2s(y), x2s(b.x), x2s(b.y) );
    double dx  = b.x - x;
    double dy  = b.y - y;
    double r2 = dx*dx + dy*dy;
    //if( r2 < 4 ){ fr =  1/ r2 + r2 -5 ; } // very fast L-J like forcefield with   f=0 at r=1 and r=2  
    if( r2 < 4 ){ 
      double mr2 = 4-r2; 
      double fr  = -( 1/r2 + b.charge*charge - 0.1 )*mr2*mr2; 
      fx += fr*dx;
      fy += fr*dy;
    }
  }
  
  final void forceToTarget( double k, double x0, double y0){
    double dx  = x - x0;
    double dy  = y - y0;
    fx -= k*dx; fy -= k*dy;
  }
  
  final double dist2(double x0, double y0){
    double dx  = x - x0;
    double dy  = y - y0;
    double r2 = dx*dx + dy*dy;
    return r2;
  }
  
}
