

// fast check if two PVector are in range 
float distSq( PVector A, PVector B ){
  float dx = A.x-B.x;   float dy = A.y-B.y;
  return (dx*dx)+(dy*dy);
}
boolean inRange(PVector A, PVector B, float range){
  float dx = A.x-B.x;   float dy = A.y-B.y;
  return ((range*range)<((dx*dx)+(dy*dy)));  
}

// line intersection  return ta (=position on A1-A2 line), if  0.0 < ta < 1.0  thant intersection point is inside the line-segment A1-A2
// b_segment = true, it is checked if intersection point is on B1-B2 segment
// for any reason ther is no intersection point whith required propreties function return NaN and also OUT is set to NaN
// otherweis OUT contains the poit of intersection and return value the parameter "ta" intersection position of segment A1-A2 

float lineIntersection( PVector A1 , PVector A2, PVector B1, PVector B2,  PVector OUT, boolean b_segment){
  float ax = A2.x - A1.x;      float ay = A2.y - A1.y;
  float bx = B2.x - B1.x;      float by = B2.y - B1.y;
  float b_dot_d_perp = ax*by - ay*bx;
  if(b_dot_d_perp == 0) {   // colinear
    OUT.x=Float.NaN; OUT.y=Float.NaN; return Float.NaN; 
  } else {                  // not colinear
    float cx = B1.x-A1.x; 
    float cy = B1.y-A1.y;
    float ta = (cx*by - cy*bx) / b_dot_d_perp;      // evaluate position on a-segment 
    if (b_segment){      
      float tb = (cx*ay - cy*ax) / b_dot_d_perp;    // evaluate position on b-segment
      if (tb < 0 || tb > 1) { OUT.x = Float.NaN; OUT.y=Float.NaN;   return Float.NaN;  }  
    } 
    OUT.x = A1.x+ta*ax; OUT.y = A1.y+ta*ay; return ta; 
  }  
}

float segmentIntersection ( PVector A1 , PVector A2, PVector B1, PVector B2,  PVector OUT, boolean a_segment, boolean b_segment){
  float ta = lineIntersection( A1 , A2, B1, B2, OUT, b_segment);
  if ( !Float.isNaN(ta) ){  if (ta < 0 || ta > 1) { OUT.x = Float.NaN; OUT.y=Float.NaN;   return Float.NaN;  } }
  return ta;
}
