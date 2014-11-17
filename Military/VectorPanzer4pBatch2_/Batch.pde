

void traceLine( int n, float L, float fireAngle ){
  float d=L/(float)n;
  float nx=sin(fireAngle);      float ny=cos(fireAngle); 
  float dx=nx*d;            float dy=ny*d; 
for (int i=-n;i<n;i++){
  CutA.x = (-2*nx + dy*i)*100;     CutA.y = (-2*ny - dx*i)*100;
  CutB.x = (+2*nx + dy*i)*100;     CutB.y = (+2*ny - dx*i)*100;
  stroke(0,20);
  line( CutA.x, CutA.y,   CutB.x, CutB.y );
  
angle = Sec(outer, isecOut); // println(isecOut); 
angleEffect = 1.0/sin(angle);
if(angle > HALF_PI){angle-=HALF_PI;}
Sec(inner, isecIn);
thickness = PVector.dist(isecIn,isecOut);
effectiveThickness = angleEffect*thickness;
//println(" "+isecIn);
if(isecIn.x > -1000){ 
 stroke(0,0,255);  line(isecIn.x,isecIn.y,isecOut.x,isecOut.y); 
 stroke(255,0,255); line( CutA.x, CutA.y,  CutA.x -nx*effectiveThickness, CutA.y - ny*effectiveThickness );
 stroke(0,0,255);   line( CutA.x, CutA.y,  CutA.x -nx*thickness, CutA.y - ny*thickness );
 stroke(255,0,255); line( d*i*100, 400,  d*i*100, 400-effectiveThickness );
 stroke(0,0,255);   line( d*i*100, 400,  d*i*100, 400-thickness );

}
if(thickness > 10000){thickness = 0.0;};
}

Axes();

}
