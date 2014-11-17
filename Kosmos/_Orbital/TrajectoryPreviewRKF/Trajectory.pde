class Trajectory{
  double [][] Xs;
  double []   ts;
  PShape mesh;
  color c;

  Trajectory( int N, color c ){
    ts = new double[N]; Xs = new double[N][6]; this.c = c;
  }
  Trajectory( int N, double T, Body_RKF B, color c  ){
    ts = new double[N]; Xs = new double[N][6]; this.c = c;
    genLinearTime( T, B );
  }

  void genLinearTime( double T, Body_RKF B ){
    cpVec( B.X, Xs[0] );
    double dt = T/ts.length; 
    for (int i=1; i<ts.length; i++){   
      double t=dt*i;   ts[i]=t;
      B.move(t);       cpVec( B.Xinterp, Xs[i] ); 
      //println(  i+" "+ ts[i]+" "+Xs[i][0]+" "+Xs[i][1]+" "+Xs[i][2] );
      //println(  i+" "+ ts[i]+" "+B.Xinterp[0]+" "+B.Xinterp[1]+" "+B.Xinterp[2] );
    }
  }
  
  void genShape( double sc,  int kind){
      if(kind==0){      mesh = createShape();
      } else {          mesh = createShape(kind);   }
      mesh.beginShape();
      for (int i=0; i<ts.length; i++){   
        //println ( " plot: " +  (float)(Xs[i][0]/sc) +"  "+ (float)(Xs[i][1]/sc) +"  "+ (float)(Xs[i][2]/sc)   );
        mesh.vertex((float)(Xs[i][0]/sc), (float)(Xs[i][1]/sc), (float)(Xs[i][2]/sc));        
      }
      mesh.stroke(Tr1.c);
      mesh.strokeWeight(1);
      mesh.endShape();
  }
  
}
