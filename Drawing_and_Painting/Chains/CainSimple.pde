//=========================================================//
//                      CHAIN                              //
//=========================================================//

class Chain{
float[] x = new float[nchain ];
float[] y = new float[nchain ];
float[] ox = new float[nchain ];
float[] oy = new float[nchain ];

void update(){
 for(int i=1;i<nchain ;i++){
 float dx=x[i]-x[i-1];
 float dy=y[i]-y[i-1];
 float r = sqrt(dx*dx+dy*dy);
// println(x[i]+" "+y[i]);
// println(dx+" "+dy);
 dx/=(r+0.001);dy/=(r+0.001);
 // ideal
 x[i] = x[i-1] + dx*sl;
 y[i] = y[i-1] + dy*sl;

 }

}

void paint(){
x[0]=mouseX;y[0]=mouseY;
//println(mouseX+" "+mouseY);
update();

point(x[0],y[0]);
for(int i=1;i<nchain ;i++){     line(x[i],y[i],x[i-1],y[i-1]);   }
for(int i=0;i<nchain ;i++){     ox[i] = x[i];oy[i] = y[i];       }
}

}

Chain chainSimple = new Chain(); 
