
/*

This is an interactive probram to model Tank Turret armor, set agle of fire,   and interactively compute.

effective thicknes under given angle;
Angle of incidence
Volume of armor, and volume of inner space.

Controls:

Keybord:

 [i] / [o] - switch edit mode between inner and outer controlpoints
  
 [+] / [-] - zoom in and out

Mouse:
Left Click & drag - any controlpoint on left side of turret to change its shape (use [i]/[o] to switch between inner and outer)

Right Click & drag  - Draw line segment under particular angle of attack, to meassure incidence angle and thickenss.

*/


import java.util.*;

float zoom=1.0;

LinkedList outer,inner, myList;
Iterator iouter;
PVector chosen;
PVector CutA,CutB, isecIn, isecOut, secTemp, mirrorA,mirrorB;

PVector front, side, centre;

float angle,fireAngle;
float thickness, angleEffect, effectiveThickness;
float ArmorVolume, InnerVolume;

boolean interactive = true;

float myAngle = 0;
  
void setup(){
size (800,850);
frameRate(1);
textFont(loadFont("TheSans-Plain-12.vlw")); 
//smooth();
outer = new LinkedList();
outer.add(new PVector(   0, 100));
outer.add(new PVector(-100,  80));
outer.add(new PVector(-100,- 80));
outer.add(new PVector(   0,-150));
inner = new LinkedList();
inner.add(new PVector(   0,  95));
inner.add(new PVector( -90,  75));
inner.add(new PVector( -90, -50));
inner.add(new PVector(   0,-120));
strokeWeight(1);
myList = outer;
CutA = new PVector(0,0);
CutB = new PVector(0,0);
isecIn = new PVector();
isecOut = new PVector();
secTemp = new PVector();

front= new PVector(0,1);
side= new PVector(0,1);
centre= new PVector(0,0);

mirrorA = new PVector(); mirrorB = new PVector();

InnerVolume  = 2*getVolume(inner) / 100;
ArmorVolume = 2*getVolume(outer) / 100 - InnerVolume;
println( " inner volume = "+InnerVolume );
println( " armor volume = "+ArmorVolume );
}

void draw(){

  myAngle = 1*(frameCount-1)* 3.14159265 / 180;
  
  if (interactive){
background(255);
translate(400,400);
scale(zoom);

stroke(0);
fill(128);
PaintPolyline(outer);
fill(255);
PaintPolyline(inner);

/*
stroke(0,255,0);
line(CutA.x,CutA.y, CutB.x,CutB.y);
*/

stroke(255,0,0); ellipse(isecIn.x,  isecIn.y,5,5);
stroke(  0,0,255); ellipse(isecOut.x, isecOut.y,5,5);

paintGrid();

stroke(0);

fill(0);
//text(" fire angle                 "+nfc(fireAngle*180/PI,3)+"°"    , 150,150);
//text(" incidence angle       "+nfc(angle*180/PI,3)+"°"        , 150,160); 
//text(" effective thickness  "+nfc(thickness*10,3)+" mm"        , 150,170); 

text(" fire angle                 "+nfc(myAngle*180/PI,3)+"°"    , 150,150);

text(" inner volume    "+nfc(InnerVolume/100,3) +" m^2" , 150,190); 
text(" armor volume  "+nfc(ArmorVolume/100,3)+" m^2"  , 150,200); 
text(" armor / inner   "+nfc(ArmorVolume/InnerVolume,3) , 150,210);
text(" inner / armor    "+nfc(InnerVolume/ArmorVolume,3) , 150,220);

//noLoop();
  }
  
traceLine( 100, 2.0, myAngle );
save( "angle"+nf((frameCount-1)*1,3,0)+".jpg" );
}


void keyPressed(){
if(key=='i'){ myList = inner;  }
if(key=='o'){ myList = outer;  }
if(key=='+'){ zoom*=2.0;  }
if(key=='-'){ zoom/=2.0;  }
if(key==' '){ if (interactive){interactive=false; traceLine( 100, 2.0, fireAngle ); }else{ interactive=true; } }
}

void mousePressed(){
if(mouseButton == LEFT){  
int iBest = getClose(myList,(mouseX-400)/zoom,(mouseY-400)/zoom);
chosen = (PVector)myList.get(iBest);
}
if(mouseButton == RIGHT){  CutA.x = (mouseX-400)/zoom; CutA.y = (mouseY-400)/zoom; CutB.x = CutA.x ; CutB.y = CutA.y; };
};

void mouseDragged(){
if(mouseButton == LEFT){  
chosen.x = (mouseX -400)/zoom;
chosen.y = (mouseY -400)/zoom;
((PVector)myList.getFirst()).x = 0.0;
((PVector)myList.getLast ()).x = 0.0;
chosen.y = max( chosen.y, ((PVector)myList.getLast()).y );
chosen.y = min( chosen.y, ((PVector)myList.getFirst()).y );
InnerVolume  = 2*getVolume(inner) / 100;
ArmorVolume = 2*getVolume(outer) / 100 - InnerVolume;
println( " inner volume = "+InnerVolume );
println( " armor volume = "+ArmorVolume );
}
if(mouseButton == RIGHT){   CutB.x = (mouseX-400)/zoom; CutB.y = (mouseY-400)/zoom; 
//lineIntersection( CutA,CutB,   (PVector)myList.getLast(), (PVector)myList.getFirst(), isecIn);
};  

};


void mouseReleased(){
  println();
fireAngle = getAngle( CutA, CutB, centre, front);  
println(" fire angle = "+(fireAngle*180/PI)+"°");
angle = Sec(outer, isecOut); // println(isecOut); 
if(angle > HALF_PI){angle-=HALF_PI;}
println(" angle of incidence = "+(angle*180/PI)+"°"); 
Sec(inner, isecIn); 
thickness = PVector.dist(isecIn,isecOut);
if(thickness > 10000){thickness = 0.0;}
println(" thickness  = "+thickness*10+" mm"); 
}


