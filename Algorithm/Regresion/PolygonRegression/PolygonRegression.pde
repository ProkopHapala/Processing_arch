
float zoom=400;


double [] vx = {1,2,3,4,5,6,7,8,9,10}; 

//double [] vy = {10,10,10,10,10,10,10,10,10,10};   // const
double [] vy = {1,2,3,4,5,6,7,8,9,10};            // linear
//double [] vy = {1,4,9,16,25,36,49,64,81,100};     // quadratic
//double [] vy = {1,8,27,64,125,216,343,512,729,1000};     // quadratic



double [] poly = new double [5];
double [] sourcepoly = new double [5];

void setup(){

for(int j=0; j<poly.length; j++){ 
 sourcepoly[j] = random(-1,1); }
 
/* 
for(int i=0; i<vx.length; i++){
vx[i]=random(0,1);
vy[i]=sourcepoly[0];
double x=1.0;
for(int j=1; j<sourcepoly.length; j++){
 x = x*vx[i]; 
 vy[i]+= sourcepoly[j]*x; 
}}
*/


for(int i=0; i<vx.length; i++){
vx[i]=random(-1,1);

vy[i]= 0.1      *1.0+
       -0.5      *vx[i]+
       -0.5      *vx[i]*vx[i]+
       -0.50      *vx[i]*vx[i]*vx[i]+
       1.0      *vx[i]*vx[i]*vx[i]*vx[i];
};

  PolynomRegression(vx,vy,poly);
  
  vector.write(poly);
  vector.write(sourcepoly);

//print ((float) poly[0]);

size(800,800,P2D);


// paint inut points

for(int i=0; i<vx.length; i++){

  ellipse((float)vx[i]*zoom+400,(float)vy[i]*zoom+400,5,5);
  
}

// paint fitted
for(int i=-400; i<400; i++){
float y=(float)poly[0];
float x=1.0;
for(int j=1; j<poly.length; j++){
 x*=i/zoom;
 y+=x*(float)poly[j];
}
//println (i+" "+y);
point(i+400,y*zoom*0.5+400);
}

  
}
