
class OrbitIntegrator{
  // state variables
  double x,y,vx,vy;  
  // supplementary variables
  int eval_per_turn;
  int neval=0;
  double t,ot,oot;
  double or,oor;
  int nturns;
  double otperiod; double period,rperiod;
  double fx,fy;      // temporary to store force
  double ox,oy;      // just for plotting
  OrbitIntegrator(double x,double y, double vx,double vy){
    this.x=x;this.y=y;this.vx=vx; this.vy=vy;
    ox=x;oy=y;
  }
  void move(double dt){  }; 
  void getForce(){
    neval++;
    double r  = Math.sqrt(x*x+y*y);
    phaseLock(r);
    double ir = 1/r; 
    double fr = -ir*ir*ir; 
    fx = x*fr;
    fy = y*fr;
  }
  void plot(){
    line(x2s(ox),x2s(oy),x2s(x),x2s(y));
    ox=x;oy=y;
  }
  void phaseLock(double r ){
    if( (or>r)&&(or>oor) ){ // pass aphelium ( aphelium is more precisse than perihelium )
      eval_per_turn = neval;
      neval = 0;
      // naieve not precise way
      //double tperiod  = t;
      //double rperiod_ = r;
      //println( t+" "+r+" "+or+" "+oor );
      
      // fit parabola - much more preccise way to get aphelium
      double x1=oot; double x2=ot; double x3=t;
      double y1=oor; double y2=or; double y3=r;
      double x12   = (x1 - x2);  double  x13  = (x1 - x3); double x23   = (x2 - x3);
      double y12   = (y1 - y2);  double  y13  = (y1 - y3); double y23   = (y2 - y3);
      double x3y12 = x3 * y12;   double x2y13 = x2 * y13;  double x1y23 = x1 * y23;
      double denom = x12*x13*x23;
      double a = ( -x3y12 + x2y13  - x1y23 ) / denom;
      double b = ( x3*x3y12 - x2*x2y13 + x1*x1y23 ) / denom;
      double c = ( x3*(x2 * x23 * y1 - x1 * x13 * y2 ) + x1 * x2 * x12 * y3 ) / denom;
      // find vertex of parabola
      double tperiod  = -b/(2*a);
      double rperiod_ =  a*tperiod*tperiod + b*tperiod + c;
      
      
      // plot and save
      double period_ = tperiod - otperiod;
      //println( nturns+" "+period+" "+T );
      //line( nturns*turnscale, sz-rscale*(float)period, turnscale*(nturns+1), sz-rscale*(float)rperiod_ );
      //line( nturns*turnscale, sz-Tscale*(float)period, turnscale*(nturns+1), sz-Tscale*(float)period_ );
      //line( nturns*turnscale, sz-logTscale*(float)Math.log( (period-T) ), turnscale*(nturns+1), sz-logTscale*(float)( period_-T) );
      //line( nturns*turnscale, sz-logTscale*(float)Math.log( Math.abs(period-T) ), turnscale*(nturns+1), sz-logTscale*(float)Math.log( Math.abs(period_-T)) );
      //line( nturns*turnscale, sz-tscale*(float)otperiod, turnscale*(nturns+1), sz-tscale*(float)tperiod );
      
      point( turnscale*(nturns+1), sz-logTscale*(float)Math.log( Math.abs(period_-T)) );
      otperiod  =  tperiod;
      period    =  period_;
      rperiod   =  rperiod_;
      nturns++;
    }
    oor=or; or=r;
    oot=ot; ot=t;
  }
}

// Euler 

class Euler extends OrbitIntegrator{
  Euler(double x,double y, double vx,double vy){super(x,y,vx,vy);}
  void move(double dt){  
    getForce();
    x  += vx*dt;    y  += vy*dt;
    vx += fx*dt;    vy += fy*dt;
    t += dt;
  }; 
}

// 1st order verlet

class LeapFrog extends OrbitIntegrator{
  LeapFrog(double x,double y, double vx,double vy){super(x,y,vx,vy);}
  void move(double dt){  
    getForce();
    vx += fx*dt;    vy += fy*dt;
    x  += vx*dt;    y  += vy*dt;
    t += dt;
  }; 
}

// 2nd order verlet

class Verlet extends OrbitIntegrator{
  Verlet(double x,double y, double vx,double vy){super(x,y,vx,vy); getForce(); }
  void move(double dt){  
    double ofx=fx; double ofy=fy;
     x += vx*dt + 0.5d*fx*dt*dt;   y += vy*dt + 0.5d*fy*dt*dt;
     getForce();
    vx += 0.5d*(fx+ofx)*dt;       vy += 0.5d*(fy+ofy)*dt;
     t += dt;
  }; 
}


// ========= point to screen
final static float x2s( double x){ return ((float)x)*zoom+sz;  }
