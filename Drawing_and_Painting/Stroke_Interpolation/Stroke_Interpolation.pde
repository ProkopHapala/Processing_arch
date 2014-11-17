
float rmin = 10;
float [][] r= new float[4][2];

void setup(){
size(800,800,P2D);
}

void draw(){
float dx = r[0][0] - mouseX; float dy = r[0][1] - mouseY;
float dr = sqrt(dx*dx+dy*dy);
if(dr>rmin){  
r[3][0]=r[2][0];r[3][1]=r[2][1];  
r[2][0]=r[1][0];r[2][1]=r[1][1];  
r[1][0]=r[0][0];r[1][1]=r[0][1];
r[0][0]=mouseX; r[0][1]=mouseY;


if(mousePressed){
/*  
quad(
r[0][0],r[0][1],
r[1][0],r[1][1],
r[2][0],r[2][1],
r[3][0],r[3][1]
);
*/

curve(
r[0][0],r[0][1],
r[1][0],r[1][1],
r[2][0],r[2][1],
r[3][0],r[3][1]
);


}
}
}
