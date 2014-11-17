
final int sz = 400;
final int sz2 = 2*sz;
final float pixsz = 1.0/(float)sz;

void arrow(float x1,float y1,float x2,float y2,float r){
line ( x1,y1,x2,y2 );
float dx = x2-x1; float dy = y2-y1;
float rr = sqrt(dx*dx+dy*dy); r/=rr;  dx*=r; dy*=r;
triangle(  x2,y2,    x2-2*dx-dy,   y2-2*dy+dx,   x2-2*dx+dy,   y2-2*dy-dx );

}

