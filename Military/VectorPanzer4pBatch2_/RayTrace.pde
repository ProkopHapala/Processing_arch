

float getAngle (PVector A1 , PVector A2, PVector B1, PVector B2){
PVector A = PVector.sub(A2,A1);
PVector B = PVector.sub(B2,B1);
return PVector.angleBetween(A,B);
}



float lineIntersection( PVector A1 , PVector A2, PVector B1, PVector B2,  PVector OUT)
{
  float ax = A2.x - A1.x;      float ay = A2.y - A1.y;
  float bx = B2.x - B1.x;      float by = B2.y - B1.y;
  float b_dot_d_perp = ax*by - ay*bx;
  if(b_dot_d_perp == 0) { OUT.x=-2000; OUT.y=-2000; return 1000000; } else {  // colinear  
  float cx = B1.x-A1.x; 
  float cy = B1.y-A1.y;
  float t = (cx*by - cy*bx) / b_dot_d_perp; 
  float u = (cx*ay - cy*ax) / b_dot_d_perp;
 if(t < 0 || t > 1) { OUT.x=-2000; OUT.y=-2000; return 1000000; } else     
 if(u < 0 || u > 1) { OUT.x=-2000; OUT.y=-2000; return 1000000; } else 
                    {   OUT.x = A1.x+t*ax;     OUT.y = A1.y+t*ay; 
                         return t;  } }
}
