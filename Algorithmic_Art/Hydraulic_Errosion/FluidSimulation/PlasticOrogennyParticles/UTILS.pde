
void paintParticles(){
    color c = color(0);
    for (int i = 0; i < nps*4; i+=4) {
       //line ( ps[i]*sz, ps[i+1]*sz, ps[i+2]*sz, ps[i+3]*sz );
       //point(ps[i]*sz, ps[i+1]*sz);
       //point(ps[i+2]*sz, ps[i+3]*sz);
       set( int(ps[i]*sz  ),   int(ps[i+1]*sz) , c);
       set( int(ps[i+2]*sz),   int(ps[i+3]*sz) , c);
       //println ( i+" "+ ps[i]+" "+ ps[i+1]+" "+ ps[i+2]+" "+ ps[i+3]  );
    }
}



void moveWarp(){
    for (int i = 0; i < nps*4; i+=2) {
       float x = ps[i  ];
       float y = ps[i+1];
       fluidSolver.interpolatedMove( x, y);
       //println(i+" "+fluidSolver.dx+" "+fluidSolver.dy);
       x+=(float)fluidSolver.dx*0.05;
       y+=(float)fluidSolver.dy*0.05;
       if(x<0){ x=1.0; }else if (x>1) { x=0.0; } 
       if(y<0){ y=1.0; }else if (y>1) { y=0.0; } 
       ps[i  ]=x;
       ps[i+1]=y;
    }
}



void noiseMap(double d, double  [][] F ){
  noiseDetail(1);
    for (int i = 0; i < F.length; i++) {    for (int j = 0; j < F[0].length; j++) {
        //F[i][j]= ( noise((float)(i/d),(float)(j/d)) );
        F[i][j]*=0.98;
        F[i][j]+=0.02*( noise((float)(i/d),(float)(j/d)) );
    }}
}


void paintMap( double [][] F ){
    for (int i = 0; i < F.length; i++) {      for (int j = 0; j < F[0].length; j++) {
       color c= color( (float)F[i][j] ); 
       set( i, j , c);
    }}
}
