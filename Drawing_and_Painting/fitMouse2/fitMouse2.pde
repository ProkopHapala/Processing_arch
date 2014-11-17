
final int n=10; 
final int d=4;

float zoom=400;

int inod=0;

double [] base = new double[n]; 
double [] vx = new double[n]; 
double [] vy = new double[n]; 

double [] polyx = new double [d];
double [] polyy = new double [d];


float vx0;
float vxN;







void setup(){
size(800,800,P2D); 

for(int i=0; i<base.length; i++){
base[i]=map(i,0,base.length-1,-1,1);
}

println("base");
  vector.write(base); 
}







void draw (){

if(mousePressed){  
if(inod==0){vx[inod]=mouseX;vy[inod]=mouseY; ellipse((float)vx[inod],(float)vy[inod],5,5); inod++;}
float dx = mouseX - (float)vx[inod-1];
float dy = mouseY - (float)vy[inod-1];
float dr=sqrt(dx*dx+dy*dy);
if(dr>30){
vx[inod]=mouseX;
vy[inod]=mouseY;
//  println (inod+" x "+vx[inod]+" y "+vy[inod]);
  ellipse((float)vx[inod],(float)vy[inod],5,5);
inod++;  


if(inod==base.length){
  noLoop();

println("vx");
  vector.write(vx);
println("vy");  
  vector.write(vy);  

  PolynomRegression(base,vx,polyx);
  PolynomRegression(base,vy,polyy);
  
println("poly x");
  vector.write(polyx);
println("poly y");  
  vector.write(polyy);
  
// paint fitted
for(int i=-400; i<400; i++){
float x=(float)polyx[0];
float y=(float)polyy[0];
float bas=1.0;
for(int j=1; j<polyx.length; j++){
 bas*=i/zoom;
 x+=bas*(float)polyx[j];
 y+=bas*(float)polyy[j];
}
point(x,y);
}
  

}
}
}
}
