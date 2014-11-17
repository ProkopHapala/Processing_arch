
final int n = 350;
float [][] ps; 
float zoom = 100.0;

float pr=3.0, dp=0.03;

float A,B,C,D;

void genElipseParam(){
  A=0;B=0;C=0;D=0;
  for (int i=0; i<n; i++){ 
    float x = ps[i][0]; float y = ps[i][1];
    A=max(A,sq(x)); B=max(B,sq(y)); C=max(C,sq(x+y)); D=max(D,sq(x-y));
  }
}

void setup(){
  size(400,400);
  colorMode(RGB,1.0);
  strokeWeight(3);
  ps = new float[n][2];
  float ax = random(-1.0,1.0);  float ay = random(-1.0,1.0);  float r = sqrt(sq(ax)+sq(ay)); ax/=r; ay/=r;
  //float c = random(1.0); 
  float c = 0.3;
  float bx=c*ay; float by=-c*ax; 
  for (int i=0; i<n; i++){   
      float c1=random(-1.0,1.0); float c2=random(-1.0,1.0); r = sqrt(sq(c1)+sq(c2)); // if(r>1.0) {c1/=r; c2/=r;}
      ps[i][0] = c1*ax+c2*bx;   ps[i][1]=c1*ay+c2*by;    point(   ps[i][0]*zoom+200,  ps[i][1]*zoom+200 );  
  } 

  genElipseParam();
  
  println( A+" "+B+" "+C+" "+D);
   
   stroke( 255,0,0, 0.2  );
   for (float x=-pr; x<pr; x+=dp){ 
     for (float y=-pr; y<pr; y+=dp){
       float f = (x*x/A +  y*y/B  + sq(x+y)/C + sq(x-y)/D)*0.25; 
       //float f = x*x +  y*y; 
       if (f<1.0) point( x*zoom+200, y*zoom+200 );
     }
   }
   strokeWeight(5); point (200,200);    
       
 }
