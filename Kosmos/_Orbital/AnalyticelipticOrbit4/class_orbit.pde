


class Analytic_Orbit {
  PVector uX,uA,uB;
  float e,p,vu,a,b, thetaP, theta0;
  
  void fromStatePoint( PVector P0, PVector V0 ){
    strokeWeight(0.1);
    stroke(0  ,0,255);  line(  P0.x, P0.y, P0.z, 0,0,0 );
    stroke(255,0,0);  line(  P0.x, P0.y, P0.z, P0.x+V0.x, P0.y+V0.y, P0.z+V0.z  );
    strokeWeight(1);
          thetaP = -atan2( P0.y, P0.x );
    float r0 = P0.mag();
    float v0 = V0.mag();
          a = 1 /( 2/r0 - v0*v0/GM );   // semimajor axis by vis-viva equation, if negative=> hyperbola
    println( " r0: "+ r0 +" v0: "+ v0 +" a: "+ a  );
    PVector uR0 = PVector.div(P0, r0);
    PVector uV0 = PVector.div(V0, v0);
            uX  = uR0.cross(uV0); uX.normalize();
    PVector uT0 = uR0.cross(uX);  uT0.normalize();
    println ("uR0"+uR0);
    println ("uV0"+uV0);
    println ("uX" +uX );
    println ("uT0"+uT0);
    float vt =-uT0.dot(V0);
    float vr = uR0.dot(V0);
    fromV0(vt,vr);
  }
  
  void fromV0( float vt, float vr ){
    println( " vt: "+ vt +" vr: "+ vr );
    float vr2 = vr*vr;
    float vt2 = vt*vt;
    //float avr2vt2 = a*( vr2 + vt2 );
    //float e  = sqrt(  ( GM*GM + 2*GM*a*(vr2 - vt2)  + avr2vt2*avr2vt2 )  / sq( GM +  avr2vt2 )   ); 
    float avr2vt2 = a*( vr2 + vt2 );
    println("avr2vt2: "+avr2vt2+" sq( GM +  avr2vt2 ): "+sq( GM +  avr2vt2 ) );
          e  = sqrt(  ( GM*GM + 2*GM*a*(vr2 - vt2)  + avr2vt2*avr2vt2 )  / sq( GM +  avr2vt2 )   ); 
          p  = a*(1-e*e);
          vu = sqrt( GM/p ); 
          theta0 = atan2( vr , vt - vu ) + thetaP;
    println( " e: "+ e + " p: "+ p +" vu: "+ vu +" theta0: "+ theta0 );
  }

  void plot(int n){
    //noStroke(); ellipse(0,0,0.05,0.05);
    float di = TWO_PI/n;
    for (int i=0; i<n; i++){
       float theta = (di*i);
       float st = sin(theta);
       float ct = cos(theta);
       float cn = cos(theta+theta0);
       //println(theta+" "+ct+" "+st);
       float r = p / ( 1 + e * cn ); 
       point( ct *r, st*r); 
       //stroke(0);  point( ct*r0, st*r0);
    }
  }
  
  void plot_fast(int n){
    //noStroke(); ellipse(0,0,0.05,0.05);
    float di = 4.0/n;
    float theta0_f = theta0*4.0/TWO_PI; 
    for (int i=0; i<n; i++){
       float theta = (di*i);
       float st = fastSin_x4(theta);
       float ct = fastCos_x4(theta);
       float cn = fastCos_x4(theta+theta0_f);
       //println(theta+" "+ct+" "+st);
       float r = p / ( 1 + e * cn );
       point( ct *r, st*r); 
       //stroke(0);  point( ct*r0, st*r0);
    }
  }
  
}
