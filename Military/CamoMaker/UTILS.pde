

void spot(float r){
//ellipse(x,y,r,r);
//rect(x,y,r,r);


float dx = random(-1.0,1.0);   float dy = random(-1.0, 1.0);
float rr = r/sqrt(dx*dx+dy*dy);
dx*=rr; dy*=rr*aspectRatio;
rect(x,y*aspectRatio,dx,dy);
//ellipse(x,y*aspectRatio,dx,dy);


/*
float dx1 = random(-1.0,1.0);   float dy1 = random(-1.0, 1.0);
float rr = r/sqrt(dx1*dx1+dy1*dy1);
dx1*=rr; dy1*=rr;

float dx2 = random(-1.0,1.0);   float dy2 = random(-1.0, 1.0);
rr = r/sqrt(dx2*dx2+dy2*dy2);
dx2*=rr; dy2*=rr;

triangle( x ,      y*aspectRatio ,
          x+dx1 , (y+dy1)*aspectRatio  , 
          x+dx2 , (y+dy2)*aspectRatio  );
*/

}

void newPos(){
x=random(width); y=random(height)/aspectRatio;
};

void mutatePos(float r){
 float dx = random(-1.0,1.0);   float dy = random(-1.0, 1.0);
 float rr = r/sqrt(dx*dx+dy*dy);
 x+=rr*dx;    y+=rr*dy;
};

boolean inScreen(){
 return ((x>0)&&(x<width)&&(y>0)&&(y<height));
};
