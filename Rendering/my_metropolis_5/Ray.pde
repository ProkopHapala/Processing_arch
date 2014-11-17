//---------------------------------------------------------------------------------------
// Raytracing ---------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

void raytrace(float[] ray, float[] origin) // ray - ray direction; origin - ray origin
{
  gIntersect = false; //No Intersections Along This Ray Yet
  gDist = 999999.9;   //Maximum Distance to Any Object
  
  //ray over all objects
   for (int i = 0; i < nrObjects; i++) raySphere(i,ray,origin);
}

float[] reflect(float[] ray, float[] fromPoint){                //Reflect Ray
  float[] N = surfaceNormal(gIndex, gPoint, fromPoint);  //Surface Normal
  return normalize3(sub3(ray, mul3c(N,(2 * dot3(ray,N)))));     //Approximation to Reflection
}

float[] diffuse(float[] ray, float[] fromPoint){                //Reflect Ray
  float[] N = surfaceNormal(gIndex, gPoint, fromPoint);  //Surface Normal
  
  float[] V = normalize3(sub3(ray, mul3c(N,(2 * dot3(ray,N))))); //reflected ray  
  //float[] V = {0,0,0};
  //V = mul3c(V,0);
  //V[0]=0;V[1]=0;V[2]=0;
  //c*=abs(dot3(ray,N))/dot3(N,N);
  //print(gType+" "+gIndex);
  //print(" N "+N[0]+" "+N[1]+" "+N[2]);
  //println(" V "+V[0]+" "+V[1]+" "+V[2]);
  return normalize3(add3(V,rand3(3.0)));
}
