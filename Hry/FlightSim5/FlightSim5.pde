/**
 * Move Eye. 
 * by Simon Greenwold.
 * 
 * The camera lifts up (controlled by mouseY) while looking at the same point.
 */

float x0,y0;
PMatrix MyMatrix = new PMatrix3D();
PMatrix MyMatrix_ = new PMatrix3D();
float[] Fs = new float[16];
float[] iFs = new float[16];
float velocity;


int shotc;
int shots=300;

class shot{
float v[] = new float[3];
float r[] = new float[3];

void move(){
r[0]+=v[0]*100;
r[1]+=v[1]*100;
r[2]+=v[2]*100;
}
}

shot[] s = new shot[shots];

float[][][][] boxes = new float[5][5][5][3];

void setup() {
size(800, 800, P3D);

  camera(0.0, 0.0, 1, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 1.0, 0); // upX, upY, upZ

  MyMatrix = getMatrix();
  MyMatrix.get(Fs);
  for(int i = 0;i<4; i++){
  println(Fs[4*i]+" "+Fs[4*i+1]+" "+Fs[4*i+2]+" "+Fs[4*i+3]);
  }
  //MyMatrix.set(Fs);
  setMatrix(MyMatrix);
  pushMatrix();
  
  for(int ix=0;ix<5;ix++){
  for(int iy=0;iy<5;iy++){
  for(int iz=0;iz<5;iz++){
  for(int i=0;i<3;i++) {
  boxes[ix][iy][iz][i]=random(-1000,1000);
  }  }  }  }
  
  for(int i=0;i<shots;i++){
  s[i]=new shot();
  }
}



void draw() {
  lights();
  background(0);
  
  MyMatrix.rotateZ((mouseX-(width/2))*0.00005);
  MyMatrix.rotateX((mouseY-(height/2))*0.00005);


  MyMatrix.translate(0,0,-velocity);
  
  MyMatrix_.set(MyMatrix);
  MyMatrix_.invert();
  setMatrix(MyMatrix_);
  
  
  MyMatrix.get(Fs); 
  MyMatrix_.get(iFs); 
  
  
  stroke(255,255,255);
  line(0, 0, 0, Fs[3]*1000+10, Fs[7]*1000,Fs[11]*1000);
  
 //this box move with player
  pushMatrix();
  fill(128,0);
  translate(Fs[3], Fs[7],Fs[11]);
  box(50);
  popMatrix();
  
  for(int i=0;i<shots;i++){
  s[i].move();
  pushMatrix();
  fill(200,100,0,255);
  translate(s[i].r[0],s[i].r[1],s[i].r[2]);
  box(10);
  popMatrix();
  }
  
  //this are axis of the scene
  strokeWeight(3);
  stroke(255,0,0);
  line(0, 0, 0, 0, 0, -100);
  stroke(0,255,0);
  line(0, 0, 0, 0, -100, 0);
  stroke(0,0,255);
  line(0, 0, 0, -100, 0, 0);
  strokeWeight(1);
  stroke(255,0,0);
  line(0, 0, 0, 0, 0, +100);
  stroke(0,255,0);
  line(0, 0, 0, 0, +100, 0);
  stroke(0,0,255);
  line(0, 0, 0, +100, 0, 0);

    
  noStroke();
  pushMatrix();
  fill(128,128);
  sphere(50);
  popMatrix();
  
  for(int ix=0;ix<5;ix++){
  for(int iy=0;iy<5;iy++){
  for(int iz=0;iz<5;iz++){
   pushMatrix();
   translate(boxes[ix][iy][iz][0],boxes[ix][iy][iz][1],boxes[ix][iy][iz][2]);
   box(50);
   popMatrix();
  }
  }
  }

}

void keyPressed(){
if (key=='a'){MyMatrix.rotateZ(0.1);}
if (key=='d'){MyMatrix.rotateZ(-0.1);}
if (key=='w'){MyMatrix.rotateX(0.1);}
if (key=='s'){MyMatrix.rotateX(-0.1);}

if (key=='+'){velocity++;}
if (key=='-'){velocity--;}
if (key=='0'){velocity=0;}

if (key==' '){
shotc++;
int i=shotc%shots;
s[i].r[0]=Fs[3];s[i].r[1]=Fs[7];s[i].r[2]=Fs[11];
s[i].v[0]=-iFs[8];s[i].v[1]=-iFs[9];s[i].v[2]=-iFs[10];
}


}
