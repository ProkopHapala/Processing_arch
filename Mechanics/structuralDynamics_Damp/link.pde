
class StructuralMatrial{
  double density;
  double YTens,YComp;  // stiffness per area in tension and compression
  double STens,SComp;  // strength per area in compression
  StructuralMatrial( double density, double YTens, double YComp, double STens, double SComp ){
     this.density=density;this.YTens=YTens;this.YComp=YComp;this.STens=STens;this.SComp=SComp;
  }
}

class Link{
  double m;    // mass of link itselfs
  double r0;
  double kTens,kComp;
  double fTens,fComp; 
  double dampTens,dampComp; 
  double3 f;
  BasicBody a,b;   // end nods
  
  void addMass(){ a.m+=m/2; b.m+=m/2; };  // Link is not threated as massive body itselfs, it mass is added to mass of end nods
  
  void assertForce(){
    f.sub( b.x, a.x);                    // force vector used to store possition difference
    double r   = Math.sqrt( f.dot() );   // distance 
    double fMax,ff, damp;
    double dr = (r-r0);
    if(r>r0){  // tension   
      fMax=fTens;  ff = kTens*dr; damp = dampTens;
    }else{     // compression
      fMax=fComp;  ff= kComp*dr; damp = dampComp;
    }
    /*
    if (damp>0){
      double3tmp.sub(a.v , b.v );  // contraction speed
      double v_dot_dir = f.dot( double3tmp );  
      ff -= damp*v_dot_dir;
    }
    */
    
    double3tmp.sub(b.v , a.v );  // contraction speed
    double v_dot_dir = double3tmp.dot(f);
    if ( v_dot_dir*dr < 0 ){ ff *= 0.9;   }
    
    
    /*
    double dx = 
    double dy = 
    double dvx = a.v.x - b.v.x;
    double dvy = a.v.y - b.v.y;
    double dvx*fx -  
    */
    
    
    
    //double3tmp.sub(a.v , b.v );  // contraction speed
    //double3tmp.mult();
    
    f.mul( -ff/r );
    a.f.sub(f); b.f.add(f);   // apply force to nods
  }
  
  Link( BasicBody a, BasicBody b, StructuralMatrial mat, double area, double r0, double dampTens, double dampComp ){
    this.a=a; this.b=b;
    f = new double3();
    if ( r0 < 0 ){
      f.sub( b.x, a.x);
      this.r0 = Math.sqrt( f.dot() ); 
    }else{
      this.r0 = r0;
    }
    kTens=mat.YTens*area/this.r0; kComp=mat.YComp*area/this.r0;
    fTens=mat.STens*area;    fComp=mat.SComp*area;
    println( " r0 "+this.r0+" kTens "+ kTens+" kComp "+kComp+" fTens "+fTens+" fComp "+fComp );
    m = area*this.r0*mat.density;
    addMass();
    this.dampTens=dampTens; this.dampComp=dampComp;
  }
  
  void paint(){
    line( (float)a.x.x, (float)a.x.y, (float)a.x.z,   (float)b.x.x, (float)b.x.y, (float)b.x.z  );
    //line( );
  };
  
}
