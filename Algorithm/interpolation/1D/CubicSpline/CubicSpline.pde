
/*

We have C2 continuous besier curve defined by

position y(t)
t  t2 t3 t4
-------------
Y0  +1 -3 +3 -1
Y1  +4    -6 +3
Y2  +1 +3 +3 -3
Y3           +1 

first derivative y(t)
t  t2 t3 t4
-------------
Y0  -3  +6 -3
Y1     -12 +9
Y2  +3  +6 -9
Y3         +3
       
second derivative y(t)
t  t2 t3 t4
-------------
Y0    6  -6
Y1  -12  18
Y2   +6 -18
Y3       +6

We want to find such controlpoints to set specific position and derivative at endpoints
     
END POINT FIT

Y0: Y2 - 2*dy0 
Y1: -Y2/2 + dy0/2 + 3*y0/2
Y3: Y1 + 2*dy1 
Y2: -Y1/2 - dy1/2 + 3*y1/2

*/


// ========= END POINTS
//float y0=0.3,dy0=0.7;
//float y1=0.4,dy1=-0.6;

int ndata = 20;
int sz    = 400; 
int supersample = 5;
float [] data;








float cubicC2  (float A, float B, float C, float D, float t ){ return P3( A+4*B+C,  -3*A+3*C,  3*A-6*B+3*C,   -A+3*B-3*C+1*D,  t)/6; }
float dCubicC2 (float A, float B, float C, float D, float t ){ return P2( -3*A+3*C,  6*A-12*B+6*C,   -3*A+9*B-9*C+3*D,  t)/6;        }
float ddCubicC2(float A, float B, float C, float D, float t ){ return P1(  6*A-12*B+6*C,   -6*A+18*B-18*C+6*D,  t)/6;        }

float P3( float C0, float C1, float C2, float C3, float t ){ return ((C3*t + C2)*t + C1)*t+C0; }
float P2( float C0, float C1, float C2, float t )          { return (C2*t + C1)*t+C0; }
float P1( float C0, float C1, float t )                    { return C1*t+C0; }

void initData(float [] data){ for (int i=0;i<data.length;i++){ data[i]=random(1);  }  }
void plotData(float [] data){ for (int i=0;i<data.length;i++){ ellipse( i*sz*2.0/(data.length-1),  10+data[i]*(sz-20), 5,5   ); }  }

void plotHandle( float x,float y, float dy ){
  float d = 0.5;
  float xx  =     x*sz*2.0/(data.length-1);
  float xx2 = (x+d)*sz*2.0/(data.length-1);
  ellipse( xx,  10+y*(sz-20), 6,6   );
  float y2 = y + dy*d;
  line(xx,10+y*(sz-20), xx2,   10+y2*(sz-20) );
}

void setup(){
  size(sz*2,sz);
  data=new float[ndata];
  initData(data);
  float y0 = random(1);
  float dy0= random(1)-0.5;
  float y1 = random(1);
  float dy1= random(1)-0.5;
  data[0] =   data[2] - 2*dy0;
  data[1] =  (-data[2] + dy0 + 3*y0)/2;
  data[ndata-1] =  data[ndata-3] + 2*dy1; 
  data[ndata-2] = (-data[ndata-3] - dy1 + 3*y1)/2;
  plotData(data);
  plotInerp(data);
  fill(0,255,0); stroke(255,0,255);
  plotHandle( 1      ,y0, dy0 );
  plotHandle( ndata-2,y1, dy1 );
}

void plotInerp(float [] data){
  int n=supersample*sz*2;
  float dpix = (data.length-1)/((float)n);
  float oof = 0,of=0,f=0;
  for (int i= 0;i<n;i++){
     float fid = dpix*i;
     int    id = ((int)fid);
     if ((id>0)&&(id<(data.length-2))){
       float  dt = fid - id;
       //float   f = lerp_cub(data[id],data[id+1],dt);
       oof=of;
       of=f;
       //f = curvePoint(data[id-1],data[id],data[id+1],data[id+2],dt);
       f = cubicC2(data[id-1],data[id],data[id+1],data[id+2],dt);
       float df   =  dCubicC2(data[id-1],data[id],data[id+1],data[id+2],dt) / 3;
       float ddf  = ddCubicC2(data[id-1],data[id],data[id+1],data[id+2],dt) / 3;
       float dfn  =  f-of; dfn /= 3*dpix;
       float ddfn =  f+oof-2*of; ddfn /= 3*dpix*dpix;
       float x = i/( (float) supersample);
       stroke(0); point( x,10+f*(sz-20));
       stroke(255,0,0); point( x,200+df*(sz-20));
       stroke(0,0,255); point( x,200+ddf*(sz-20));
       stroke(128,128,0); point( x,200+dfn*(sz-20));
       stroke(0,128,128); point( x,200+ddfn*(sz-20));
       //println(  x +" "+dt +" "+f+" "+df+" "+ddf+" "+of+" "+oof);
     }
  }
}

