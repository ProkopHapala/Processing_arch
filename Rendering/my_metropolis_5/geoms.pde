//---------------------------------------------------------------------------------------
//Ray-Geometry Intersections  -----------------------------------------------------------
//---------------------------------------------------------------------------------------

void raySphere(int idx, float[] r, float[] o) //Ray-Sphere Intersection: r=Ray Direction, o=Ray Origin
{ 
  float[] s = sub3(spheres[idx],o);  //s=Sphere Center Translated into Coordinate Frame of Ray Origin
  float radius = spheres[idx][3];    //radius=Sphere Radius
  
  //Intersection of Sphere and Line     =       Quadratic Function of Distance
  float A = dot3(r,r);                       // Remember This From High School? :
  float B = -2.0 * dot3(s,r);                //    A x^2 +     B x +               C  = 0
  float C = dot3(s,s) - sq(radius);          // (r'r)x^2 - (2s'r)x + (s's - radius^2) = 0
  float D = B*B - 4*A*C;                     // Precompute Discriminant
  
  if (D > 0.0){                              //Solution Exists only if sqrt(D) is Real (not Imaginary)
    float sign = (C < -0.00001) ? 1 : -1;    //Ray Originates Inside Sphere If C < 0
    float lDist = (-B + sign*sqrt(D))/(2*A); //Solve Quadratic Equation for Distance to Intersection
    checkDistance(lDist,0,idx);}             //Is This Closest Intersection So Far?
}

// First intersection
void checkDistance(float lDist, int p, int i){
  if (lDist < gDist && lDist > 0.0){ //Closest Intersection So Far in Forward Direction of Ray?
  gIndex = i; gDist = lDist; gIntersect = true;} //Save Intersection in Global State
}

float[] surfaceNormal(int idx, float[] P, float[] Inside){
return normalize3(sub3(P,spheres[idx]));
}


