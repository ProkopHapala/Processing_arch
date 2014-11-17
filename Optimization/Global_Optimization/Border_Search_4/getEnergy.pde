
float Efreq = 4;

final float getEnergy(float x, float y){
nEvaluations++;


// krizici se parabolicke brazdy
float a =  x+y*y;
float b = -x+y*y;
float cx =cos(3.14159265*a*Efreq);
float cy =cos(3.14159265*b*Efreq);
float valey = 3* ( x*x + y*y);
cx*=cx; cy*=cy;
return valey - cx*cx - cy*cy;


/*
// Sklonany koncentricky sinus
float R2 = (x*x + y*y);
return R2+cos(R2*20)+5*x+1;
*/

/*
// Sklonany koncentricky sinus
float R2 = (x*x + y*y);
float cs = cos(R2*10);
return R2+(1-cs*cs*cs*cs)+2*x+1;
*/

/*
float cx = cos((x*x+y*y)*10);
float cy = cos((y-x)*10);
return (1-cx*cx*cx*cx) +  (1-cy*cy*cy*cy) + x+y;
//return cos(x*20)+cos(y*20) + x*x+y*y + 2*x;
*/


/*
// Sklonany koncentricky sinus
float R2 = (x*x + y*y);
float cs = cos(sqrt(R2)*10);
float angular = atan2(x,y);
return R2+2*(1-cs*cs*cs*cs)-x+y  + cos(angular*5);
*/

//return 0.0;

// parabola
//return (x*x + y*y);

};







//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

//float [][] Emap = new float [2*sz][2*sz];
PImage Emap;
final void initEmap(){
for (int ix=-sz;ix<sz;ix++){
  for (int iy=-sz;iy<sz;iy++){
    
    int cint = int(128+60*getEnergy( ix*pixsz,iy*pixsz));
    color c = color(cint, cint, cint);
    set(ix+sz,iy+sz, c);
  } 
}   
    Emap=get(0, 0, width, height);
}

final void paintEmap(){
tint(255,255,255,50);
image(Emap, 0, 0);
}


