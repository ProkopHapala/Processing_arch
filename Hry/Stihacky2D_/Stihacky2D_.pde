Aircraft A1,A2;
Projectiles P1,P2;

void setup(){
size(800,800,P2D);
frameRate(60);
rectMode(CORNERS);
A1 = new Aircraft(300,400,0,-100);
P1 = new Projectiles();
A2 = new Aircraft(500,400,0,-200);
P2 = new Projectiles();
}

void draw(){
background(200);
A1.paint(); A2.paint();
A1.move(); A2.move();

if(A1.fire)P1.fire(A1);
if(A2.fire)P2.fire(A2);
P1.move(); P2.move();
P1.paint(); P2.paint();

P1.hit(A2);  P1.hit(A2);

rect(30,30,30+A1.life,35);
rect(30,60,30+A2.life,65);
}

void keyPressed(){
 if (key=='4')A1.left =true;
 if (key=='6')A1.right=true;
 if (key=='0')A1.fire=true;
 
 if (key=='a')A2.left =true;
 if (key=='d')A2.right=true;
 if (key==' ')A2.fire=true;
}

void keyReleased(){
 if (key=='4')A1.left =false;
 if (key=='6')A1.right=false;
 if (key=='0')A1.fire=false;
 
 if (key=='a')A2.left =false;
 if (key=='d')A2.right=false;
 if (key==' ')A2.fire=false;
}

