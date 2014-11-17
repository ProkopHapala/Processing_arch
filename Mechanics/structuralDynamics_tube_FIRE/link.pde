
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
  double ff;
  double r0;
  double kTens,kComp;
  double fTens,fComp; 
  double3 f;
  BasicBody a,b;   // end nods
  
  void addMass(){ a.m+=m/2; b.m+=m/2; };  // Link is not threated as massive body itselfs, it mass is added to mass of end nods
  
  void assertForce(){
    f.sub( b.x, a.x);                    // force vector used to store possition difference
    double r   = Math.sqrt( f.dot() );   // distance 
    double fMax;
    if(r>r0){  // tension   
      fMax=fTens;  
      ff = kTens*(r-r0);
    }else{     // compression
      fMax=fComp;  
      ff = kComp*(r-r0);
    }
    //if (ff>fMax){ print("break"); } // link broken
    f.mul( -ff/r );           // set force vector
    a.f.sub(f); b.f.add(f);   // apply force to nods
  }
  
  Link( BasicBody a, BasicBody b, StructuralMatrial mat, double area, double r0 ){
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
    //println( " r0 "+this.r0+" kTens "+ kTens+" kComp "+kComp+" fTens "+fTens+" fComp "+fComp );
    m = area*this.r0*mat.density;
    addMass();
  }
  
  void paint(){
    //if( ff>0 ){ float f =(float)(ff/fTens);  stroke( 0.5,1-f,1-f ); }else{ float f =(float)(-ff/fComp); stroke( 1-f,1-f,0.5); }
    if( ff>0 ){ float f =(float)(ff/fTens);  stroke( 1,0,0,f ); }else{ float f =(float)(-ff/fComp); stroke( 0,0,1,f); }
    line( (float)a.x.x, (float)a.x.y, (float)a.x.z,   (float)b.x.x, (float)b.x.y, (float)b.x.z  );
    //line( );
  };
  
}
