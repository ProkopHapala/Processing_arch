
class StructuralMatrial{
  double density;
  double YTens,YComp;  // stiffness per area in tension and compression
  double STens,SComp;  // strength per area in compression
  StructuralMatrial( double density, double YTens, double YComp, double STens, double SComp ){
     this.density=density;this.YTens=YTens;this.YComp=YComp;this.STens=STens;this.SComp=SComp;
  }
}

class Link{
  boolean broken;
  double m;    // mass of link itselfs
  double r0;
  double kTens,kComp;
  double fTens,fComp; 
  double restitution; 
  double2 f;
  BasicBody2D a,b;   // end nods
  
  void addMass(){ a.m+=m/2; b.m+=m/2; };  // Link is not threated as massive body itselfs, it mass is added to mass of end nods
  
  void assertForce(){
    f.sub( b.x, a.x);                    // force vector used to store possition difference
    double r   = Math.sqrt( f.dot() );   // distance 
    double fMax,ff;
    double dr = (r-r0);
    if(dr>0){  // tension   
      fMax=fTens;  ff = kTens*dr;
    }else{     // compression
      fMax=fComp;  ff= kComp*dr;
    }
    
    if( ff>fMax ) { 
      broken=true; 
      println( " broken: dr= "+dr+" ff= "+ff+" fMax= "+fMax+" a.fg= " +a.m*Gaccel+" b.fg= "+b.m*Gaccel );
      noLoop();
    }
    
    if (restitution>0.0){
      double2tmp.sub(b.v , a.v );  // contraction speed
      double v_dot_dir = double2tmp.dot(f);
      if ( v_dot_dir*dr < 0 ){  
        ff *= restitution;
      }
    }
    f.mul( -ff/r );
    a.f.sub(f); b.f.add(f);   // apply force to nods
  }
  
  Link( BasicBody2D a, BasicBody2D b, StructuralMatrial mat, double area, double r0, double restitution ){
    this.a=a; this.b=b;
    f = new double2();
    if ( r0 < 0 ){
      f.sub( b.x, a.x);
      this.r0 = Math.sqrt( f.dot() ); 
    }else{
      this.r0 = r0;
    }
    kTens=mat.YTens*area/this.r0; kComp=mat.YComp*area/this.r0;
    fTens=mat.STens*area;    fComp=mat.SComp*area;
    println( " r0 "+this.r0+" kTens "+ kTens+" kComp "+kComp+" fTens "+fTens+" fComp "+fComp+" restitution "+restitution );
    m = area*this.r0*mat.density;
    //addMass();
    this.restitution=restitution;
  }
  
  void paint(){
    line( (float)a.x.x, (float)a.x.y,    (float)b.x.x, (float)b.x.y  );
    //line( );
  };
  
}
