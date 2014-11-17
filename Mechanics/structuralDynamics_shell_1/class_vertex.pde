
class Vertex{
  int id;
  // state variables
  double x,y,z;
  double vx,vy,vz; 
  // supplementary state variables
  double fx,fy,fz;
  // parameters
  double   mass;     // mass of body
  double imass;
  
  ArrayList<Vertex> neighbors;
  
  void move( double dt ){
     // leap frog , damped
     
     //vx = vx * damp + imass*fx*dt;
     //vy = vy * damp + imass*fy*dt;
     //vz = vz * damp + imass*fz*dt;
     vx = vx + imass*fx*dt;
     vy = vy + imass*fy*dt;
     vz = vz + imass*fz*dt;
     
     x+=vx*dt;
     y+=vy*dt;
     z+=vz*dt;
     //println( " mass, imass "+mass+" "+imass+" fx,fy,fz "+fx+" "+fy+" "+fz+" x,y,z "+   x+" "+y+" "+z );
  }
  
  void cleanForce(){
    //fx=0;fy=0; fz=0;
    //fx=Gaccel_x*mass; fy=Gaccel_y*mass; fz=Gaccel_z*mass;
    fx=Gaccel[0]*mass; fy=Gaccel[1]*mass; fz=Gaccel[2]*mass;
  };
  
  Vertex(){};
  Vertex( int id, double mass, double x, double y, double z ){
    this.id=id;
    this.x=x; this.y=y; this.z=z; this.mass = mass; 
    init();
  }
  void init(){    imass = 1/mass;  }
  
  void acumForce( double fx, double fy, double fz ){    this.fx+=fx; this.fy+=fy; this.fz+=fz;  }
    
  void paint(){
    stroke(0,  0,0); strokeWeight(3.0); point( (float)x, (float)y, (float)z );
    stroke(0,0.5,0); strokeWeight(0.01); line( (float)x, (float)y, (float)z, (float)(x+fx*fscale), (float)(y+fy*fscale), (float)(z+fz*fscale)    );
  }
  
}

