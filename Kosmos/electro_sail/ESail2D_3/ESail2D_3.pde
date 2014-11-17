
final float expo = 1.0;

final float dt    = 5.0; 
final float ke    = 10000.0;
final float vmin =1.0;
//final float vmax =15.0;
final float vmax =vmin+20.0;
final float vdisp = vmax-vmin;
final   int degree = 85;
final float angle  = degree*PI/180.0; 

float [][] F,Fm;

final float soft = 0.00001;
final int  sz = 256; 
final int sz2 = sz*2; 
final float zoom = 0.5*sz/10000.0;
final int nwire=10;

Particle p,p2;

Particle [] wires;


void setup(){
  size(sz2,sz2);
  F  = new float[sz*2][sz*2];
  Fm = new float[sz*2][sz*2];
  wires = new Particle[nwire];
  float ca = cos(angle);
  float sa = sin(angle);
  for (int i=0;i<nwire;i++){
    float t = 2000*i-10000;
    wires[i]=new Particle( sa*t, ca*t,0,0,1);
    //wires[i].paint( #FF0000 );
  } 
}

void draw(){
  for (int k=0;k<100;k++){
    p  = new Particle(-20000,random(-15000,15000), random(vmin,vmax),0, 1);
    p2 = new Particle(-20000,random(-15000,15000), random(vmin,vmax),0, 1);
    for (int i=0;i<2000;i++){
      for (int j=0;j<nwire;j++){ force(p, wires[j]);  force2(p2, wires[j]);    }
        p.move();  p2.move();
        //if((i%50)==0)p.paint(#000000); 
        p.paint(F,#000000);  p2.paint(Fm,#000000);   
    }
  }
  float fmax = findMax(F);
  paint(F, Fm,expo*255/fmax);
  stroke(0,0,0);
  strokeWeight(2);
  Particle w0 = wires[0];
  fmax = (float)Math.sqrt( w0.fx*w0.fx+ w0.fy*w0.fy);
  for (int i=0;i<nwire;i++){
   wires[i].paintForce(100/fmax);
  }
}

void keyPressed(){
if (key=='s') save( degree+"_"+int(vmin)+"_"+int(vmax)+".png"  );

//save( year()+" "+month()+"_"+day()+"_"+hour()+" "+minute()+" "+second()+".png"  );
}

