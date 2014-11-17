//---------------------------------------------------------------------------------------
// Raytracing ---------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

int reflmax = 10;
int refl;

void raytrace(float[] ray, float[] origin) // ray - ray direction; origin - ray origin
{
  gIntersect = false; //No Intersections Along This Ray Yet
  gDist = 999999.9;   //Maximum Distance to Any Object
  
  //ray over all objects
  for (int t = 0; t < nrTypes; t++)
    for (int i = 0; i < nrObjects[t]; i++)
      rayObject(t,i,ray,origin);
}

float[] computePixelColor(float x, float y){
  float[] rgb = {0.0,0.0,0.0};
  float[] ray = {x/szImg-0.5,   -(y/szImg-0.5)   , 1.0}; 
  
  raytrace(ray, gOrigin);                //Raytrace!!! - Intersected Objects are Stored in Global State

  if (gIntersect){                       //Intersection                    
    gPoint = mul3c(ray,gDist);           //3D Point of Intersection
        
    //Reflection? - just first order   
    refl = 0; 
    while (
    (gType == 0 && gIndex == 1)||
    (gType == 1 && gIndex == 1)
    &&(refl<reflmax)
    )
    {      //Mirror Surface on This Specific Object
      ray = reflect(ray,gOrigin);        //Reflect Ray Off the Surface
      raytrace(ray, gPoint);             //Follow the Reflected Ray
      if (gIntersect) gPoint = add3( mul3c(ray,gDist), gPoint); //3D Point of Intersection
      refl++;
    } 
    
    //for all
    rgb = gatherPhotons(gPoint,gType,gIndex);
   }
   
return rgb;
}
