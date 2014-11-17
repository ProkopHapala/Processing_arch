

void PaintPolyline(LinkedList myList){
Iterator itr = myList.iterator();
stroke(0);
beginShape();
while(itr.hasNext()){
PVector B = (PVector)itr.next();
vertex (B.x,B.y);
ellipse (B.x,B.y,5,5);
}
endShape();
noStroke();
itr = myList.iterator();
beginShape();
while(itr.hasNext()){
PVector B = (PVector)itr.next();
vertex (-B.x,B.y);
//ellipse (-B.x,B.y,5,5);
}
endShape();
}

int  getClose(LinkedList myList, float x,float y){
PVector A = null; int i = 0; int ibest=0; float r; float rmin=10000000;
Iterator itr = myList.iterator();
while(itr.hasNext()){
A = (PVector)itr.next();
float dx=A.x-x; float dy=A.y-y; r=sqrt(dx*dx+dy*dy);
if(r<rmin){rmin=r;ibest=i;} i++; }
return (ibest);
}


float Sec(LinkedList myList, PVector secMin){
Iterator itr = myList.iterator();
PVector A = null; PVector B = null; int i = 0; float tmin=10000000;
float anglemin = 0;
while(itr.hasNext()){
B = A;   A = (PVector)itr.next();
if(B!=null){
float t = lineIntersection( CutA,CutB, A, B, secTemp);
if(t<tmin){ tmin = t; secMin.x = secTemp.x; secMin.y = secTemp.y;     anglemin = getAngle( CutA,CutB, A, B); }
}}
//println(secMin);
return(anglemin);
}











