
final float expo = 1.0;

final float dt    = 5.0; 
final float ke    = 1.0;
final float vmin =2.0;
//final float vmax =15.0;
final float vmax =vmin+5.0;
final float vdisp = vmax-vmin;
final   int degree = 85;
final float angle  = degree*PI/180.0; 

float [][] F,Fm;

final float soft = 1.0;
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
  wires = new Particle[3]; 
  wires[0]=new Particle( -2000, +1000,0,0,1.0, +5000.0 );
  wires[1]=new Particle( 1000, -500,0,0,1.0, -20000.0  );
  wires[2]=new Particle( 3000, +2000,0,0,1.0, +15000.0  );
}

void draw(){
  for (int k=0;k<100;k++){
    p  = new Particle(-20000,random(-15000,15000), random(vmin,vmax),0, 1, +1.0 );
    p2 = new Particle(-20000,random(-15000,15000), random(vmin,vmax),0, 1, -1.0 );
    for (int i=0;i<2000;i++){
      for (int j=0;j<wires.length;j++){ 
             force(p, wires[j]); 
             force2(p2, wires[j]);   
         }
        p.move();  p2.move();
        //if((i%50)==0)p.paint(#000000); 
        p.paint(F,#000000);  
        //p2.paint(Fm,#000000);   
        if ((p.x>18000)||(Math.abs(p.y)>15000)) break;
    }
  }
  float fmax = findMax(F);
  paint(F, Fm,expo*255/fmax);
  stroke(0,0,0);
  strokeWeight(2);
  Particle w0 = wires[0];
  fmax = (float)Math.sqrt( w0.fx*w0.fx+ w0.fy*w0.fy);
  for (int i=0;i< wires.length;i++){
   wires[i].paintForce(50/fmax);
  }
}

void mousePressed(){
 for (int iy=0;iy<F.length;iy++){ for (int ix=0;ix<F.length;ix++){  F[ix][iy]=0; Fm[ix][iy]=0;    }}
 for (int j=0;j<wires.length;j++){ wires[j].fx=0; wires[j].fy=0; }
 wires[1].x = (mouseX-sz)/zoom +sz;
 wires[1].y = (mouseY-sz)/zoom +sz;
};

void keyPressed(){
//if (key=='s') save( degree+"_"+int(vmin)+"_"+int(vmax)+".png"  );
if (key=='s') { println("image saved"); save( year()+" "+month()+"_"+day()+"_"+hour()+" "+minute()+" "+second()+".png"  ); }
}

