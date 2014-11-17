
//   from here:
//  http://arxiv.org/pdf/astro--ph/9710043.pdf
//  http://arxiv.org/abs/astro-ph/9710043

final static double dtfmax = 0.03;

class VerletHS extends OrbitIntegrator{
  
  VerletHS(double x,double y, double vx,double vy){super(x,y,vx,vy); getForce(); }
  
  void moveSimple(double dt){      
     x += 0.5d*vx*dt;   y += 0.5d*vy*dt;   // r(n+1/2)
     getForce();
    vx += fx*dt;       vy += fy*dt;        // v(n+1)
     x += 0.5d*vx*dt;   y += 0.5d*vy*dt;   // r(n+1)
     t += dt;
  }

  void move(double dt){  
  x += 0.5d*vx*dt;   y += 0.5d*vy*dt;   // drift 
  if( dt > dtfmax *( x*x+y*y ) ){ 
      x -= 0.5d*vx*dt;   y -= 0.5d*vy*dt;   // drift 
      move(dt*0.5d);
      //vx += fx*dt;       vy += fy*dt;        // v(n+1)
      move(dt*0.5d);
    }else{
      getForce();
      vx += fx*dt;       vy += fy*dt;        // v(n+1)
      x += 0.5d*vx*dt;   y += 0.5d*vy*dt;   // r(n+1)
    }  
  } 
  
}
